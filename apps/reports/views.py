from io import BytesIO

from django.contrib.auth.decorators import login_required
from django.db.models import Count, Sum
from django.http import HttpResponse
from django.shortcuts import render
from django.utils import timezone

from apps.accounts.decorators import admin_required, staff_or_admin_required
from apps.buildings.models import Apartment
from apps.fees.models import Invoice, Payment
from apps.maintenance.models import MaintenanceRequest
from apps.reports.overdue_risk import build_overdue_risk_features


@login_required
@admin_required
def report_finance(request):
    totals = Payment.objects.aggregate(total_paid=Sum("amount_paid"))
    invoice_totals = Invoice.objects.aggregate(total_invoices=Count("id"), total_amount=Sum("amount"))
    by_status = Invoice.objects.values("status").annotate(total=Count("id")).order_by("status")

    status_labels = [row["status"] for row in by_status]
    status_values = [row["total"] for row in by_status]

    context = {
        "total_paid": totals["total_paid"] or 0,
        "total_invoices": invoice_totals["total_invoices"] or 0,
        "total_amount": invoice_totals["total_amount"] or 0,
        "by_status": by_status,
        "status_labels": status_labels,
        "status_values": status_values,
    }
    return render(request, "reports/report_finance.html", context)


@login_required
@admin_required
def report_debt(request):
    today = timezone.localdate()
    if request.GET.get("download") == "ml_dataset":
        import csv
        import json
        from io import StringIO

        qs = (
            Invoice.objects.exclude(status=Invoice.Status.CANCELLED)
            .filter(due_date__lt=today)
            .select_related("apartment__floor", "resident", "fee_type")
            .prefetch_related("payments")
            .order_by("due_date", "pk")[:8000]
        )
        invoices = list(qs)
        rows = build_overdue_risk_features(invoices, today=today)
        labeled = [(inv, feat, y) for (inv, feat, y) in rows if y is not None]

        keys = set()
        for _, feat, _ in labeled:
            keys.update(feat.keys())
        keys_sorted = sorted(keys)

        if request.GET.get("view") == "1":
            buff = StringIO()
            writer = csv.writer(buff)
            writer.writerow(["invoice_id", "due_date", "label_overdue"] + keys_sorted)
            for inv, feat, y in labeled:
                writer.writerow(
                    [inv.pk, inv.due_date.isoformat(), y]
                    + [json.dumps(feat.get(k), ensure_ascii=False) for k in keys_sorted]
                )
            return render(
                request,
                "reports/overdue_risk_dataset.html",
                {"csv_text": buff.getvalue(), "row_count": len(labeled), "col_count": 3 + len(keys_sorted)},
            )

        resp = HttpResponse(content_type="text/csv; charset=utf-8")
        inline = request.GET.get("inline") == "1"
        disp = "inline" if inline else "attachment"
        resp["Content-Disposition"] = f'{disp}; filename="overdue_risk_dataset.csv"'

        buff = StringIO()
        writer = csv.writer(buff)
        writer.writerow(["invoice_id", "due_date", "label_overdue"] + keys_sorted)
        for inv, feat, y in labeled:
            writer.writerow(
                [inv.pk, inv.due_date.isoformat(), y]
                + [json.dumps(feat.get(k), ensure_ascii=False) for k in keys_sorted]
            )
        resp.write(buff.getvalue())
        return resp

    overdue = (
        Invoice.objects.filter(status=Invoice.Status.OVERDUE)
        .select_related("apartment__floor", "resident", "fee_type")
        .prefetch_related("payments")
        .order_by("-due_date")[:200]
    )
    totals = Invoice.objects.filter(status=Invoice.Status.OVERDUE).aggregate(total_debt=Sum("amount"))

    open_invoices = (
        Invoice.objects.filter(status__in=[Invoice.Status.PENDING, Invoice.Status.PARTIAL], due_date__gte=today)
        .select_related("apartment__floor", "resident", "fee_type")
        .prefetch_related("payments")
        .order_by("due_date")[:200]
    )

    model = None
    model_error = ""
    model_meta = None
    try:
        from pathlib import Path

        from django.conf import settings

        import joblib
        import json

        model_path = Path(settings.BASE_DIR) / "ml_models" / "overdue_risk.joblib"
        if model_path.exists():
            model = joblib.load(model_path)
            meta_path = model_path.with_suffix(".json")
            if meta_path.exists():
                model_meta = json.loads(meta_path.read_text(encoding="utf-8"))
    except Exception as e:
        model_error = str(e)

    open_rows = []
    if model:
        history = (
            Invoice.objects.exclude(status=Invoice.Status.CANCELLED)
            .filter(apartment_id__in=[inv.apartment_id for inv in open_invoices])
            .filter(resident_id__in=[inv.resident_id for inv in open_invoices])
            .filter(due_date__lt=today)
            .select_related("apartment__floor", "resident", "fee_type")
            .prefetch_related("payments")
            .order_by("due_date", "pk")[:4000]
        )

        all_invoices = list(history) + list(open_invoices)
        rows = build_overdue_risk_features(all_invoices, today=today)
        open_ids = {inv.pk for inv in open_invoices}

        feats = [(inv, feat) for (inv, feat, y) in rows if inv.pk in open_ids and y is None]
        if feats:
            probs = model.predict_proba([f for (_, f) in feats])[:, 1]
            for (inv, _), p in zip(feats, probs, strict=False):
                inv.risk_score = int(round(float(p) * 100))
                open_rows.append(inv)

        open_rows.sort(key=lambda inv: getattr(inv, "risk_score", 0), reverse=True)

    context = {
        "overdue_invoices": list(overdue),
        "total_debt": totals["total_debt"] or 0,
        "open_invoices": open_rows,
        "model_available": bool(model),
        "model_error": model_error,
        "model_meta": model_meta,
    }

    if open_rows:
        bins = [(0, 19), (20, 39), (40, 59), (60, 79), (80, 100)]
        labels = [f"{a}-{b}" for a, b in bins]
        values = [0 for _ in bins]
        for inv in open_rows:
            s = int(getattr(inv, "risk_score", 0) or 0)
            for i, (a, b) in enumerate(bins):
                if a <= s <= b:
                    values[i] += 1
                    break
        context["risk_hist_labels"] = labels
        context["risk_hist_values"] = values

    return render(request, "reports/report_debt.html", context)


@login_required
@staff_or_admin_required
def report_occupancy(request):
    total = Apartment.objects.count()
    occupied = Apartment.objects.filter(status=Apartment.Status.OCCUPIED).count()
    available = Apartment.objects.filter(status=Apartment.Status.AVAILABLE).count()
    maintenance = Apartment.objects.filter(status=Apartment.Status.MAINTENANCE).count()

    context = {
        "total_apartments": total,
        "occupied": occupied,
        "available": available,
        "maintenance": maintenance,
        "occupancy_labels": ["OCCUPIED", "AVAILABLE", "MAINTENANCE"],
        "occupancy_values": [occupied, available, maintenance],
    }
    return render(request, "reports/report_occupancy.html", context)


@login_required
@staff_or_admin_required
def report_maintenance(request):
    by_status = (
        MaintenanceRequest.objects.values("status").annotate(total=Count("id")).order_by("status")
    )
    by_priority = (
        MaintenanceRequest.objects.values("priority").annotate(total=Count("id")).order_by("priority")
    )
    status_labels = [row["status"] for row in by_status]
    status_values = [row["total"] for row in by_status]
    priority_labels = [row["priority"] for row in by_priority]
    priority_values = [row["total"] for row in by_priority]
    return render(
        request,
        "reports/report_maintenance.html",
        {
            "by_status": by_status,
            "by_priority": by_priority,
            "status_labels": status_labels,
            "status_values": status_values,
            "priority_labels": priority_labels,
            "priority_values": priority_values,
        },
    )


@login_required
@admin_required
def report_export(request):
    from openpyxl import Workbook

    wb = Workbook()
    ws = wb.active
    ws.title = "Invoices"

    ws.append(
        [
            "ID",
            "FeeType",
            "Apartment",
            "Resident",
            "Month",
            "Year",
            "Amount",
            "DueDate",
            "Status",
        ]
    )

    invoices = Invoice.objects.select_related("fee_type", "apartment", "resident").order_by("-year", "-month")[:2000]
    for inv in invoices:
        ws.append(
            [
                inv.pk,
                inv.fee_type.name,
                inv.apartment.apartment_number,
                inv.resident.full_name,
                inv.month,
                inv.year,
                int(inv.amount),
                inv.due_date.isoformat(),
                inv.status,
            ]
        )

    output = BytesIO()
    wb.save(output)
    output.seek(0)

    resp = HttpResponse(
        output.getvalue(),
        content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    )
    resp["Content-Disposition"] = 'attachment; filename="apartmentms_export.xlsx"'
    return resp
