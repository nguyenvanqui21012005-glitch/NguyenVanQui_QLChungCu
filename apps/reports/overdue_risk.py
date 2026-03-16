from collections import defaultdict


def _to_float(value):
    if value is None:
        return 0.0
    try:
        return float(value)
    except Exception:
        return 0.0


def _invoice_paid_by_due(invoice):
    due = invoice.due_date
    total = 0.0
    for p in getattr(invoice, "payments", []).all():
        try:
            if p.paid_at.date() <= due:
                total += _to_float(p.amount_paid)
        except Exception:
            continue
    return total


def _invoice_last_paid_date(invoice):
    dates = []
    for p in getattr(invoice, "payments", []).all():
        try:
            dates.append(p.paid_at.date())
        except Exception:
            continue
    return max(dates) if dates else None


def build_overdue_risk_features(invoices, today):
    invoices_sorted = sorted(
        invoices,
        key=lambda inv: (
            getattr(inv, "due_date", None),
            getattr(inv, "year", 0),
            getattr(inv, "month", 0),
            getattr(inv, "pk", 0),
        ),
    )

    resident_stats = defaultdict(
        lambda: {
            "total": 0,
            "late": 0,
            "delay_sum": 0.0,
            "delay_count": 0,
            "on_time_streak": 0,
        }
    )
    apartment_stats = defaultdict(
        lambda: {
            "total": 0,
            "late": 0,
            "delay_sum": 0.0,
            "delay_count": 0,
            "on_time_streak": 0,
        }
    )
    fee_type_stats = defaultdict(lambda: {"total": 0, "late": 0})

    rows = []
    for inv in invoices_sorted:
        if inv.status == inv.Status.CANCELLED:
            continue

        rid = inv.resident_id
        aid = inv.apartment_id
        fid = inv.fee_type_id

        rs = resident_stats[rid]
        aps = apartment_stats[aid]
        fs = fee_type_stats[fid]

        features = {
            "amount": _to_float(inv.amount),
            "month": int(inv.month),
            "year": int(inv.year),
            "due_day": int(inv.due_date.day),
            "fee_type_id": str(inv.fee_type_id),
            "fee_unit": str(getattr(inv.fee_type, "unit", "") or ""),
            "fee_is_mandatory": bool(getattr(inv.fee_type, "is_mandatory", False)),
            "apartment_id": str(inv.apartment_id),
            "apartment_area": _to_float(getattr(inv.apartment, "area", 0)),
            "building_id": str(getattr(getattr(inv.apartment, "floor", None), "building_id", "") or ""),
            "resident_id": str(inv.resident_id),
            "resident_prev_invoices": rs["total"],
            "resident_prev_late_rate": (rs["late"] / rs["total"]) if rs["total"] else 0.0,
            "resident_prev_avg_delay": (rs["delay_sum"] / rs["delay_count"]) if rs["delay_count"] else 0.0,
            "resident_on_time_streak": rs["on_time_streak"],
            "apartment_prev_invoices": aps["total"],
            "apartment_prev_late_rate": (aps["late"] / aps["total"]) if aps["total"] else 0.0,
            "apartment_prev_avg_delay": (aps["delay_sum"] / aps["delay_count"]) if aps["delay_count"] else 0.0,
            "apartment_on_time_streak": aps["on_time_streak"],
            "fee_prev_invoices": fs["total"],
            "fee_prev_late_rate": (fs["late"] / fs["total"]) if fs["total"] else 0.0,
        }

        if getattr(inv, "risk_score", None) is not None:
            features["risk_score"] = _to_float(inv.risk_score)

        if inv.due_date >= today:
            rows.append((inv, features, None))
            continue

        paid_by_due = _invoice_paid_by_due(inv)
        in_full_by_due = paid_by_due >= _to_float(inv.amount)
        label = 0 if in_full_by_due else 1

        rows.append((inv, features, label))

        last_paid = _invoice_last_paid_date(inv)
        if label == 1:
            rs["late"] += 1
            aps["late"] += 1
            fs["late"] += 1

            delay = float((today - inv.due_date).days) if not last_paid else float(max(0, (last_paid - inv.due_date).days))
            rs["delay_sum"] += delay
            rs["delay_count"] += 1
            aps["delay_sum"] += delay
            aps["delay_count"] += 1
            rs["on_time_streak"] = 0
            aps["on_time_streak"] = 0
        else:
            rs["on_time_streak"] += 1
            aps["on_time_streak"] += 1

        rs["total"] += 1
        aps["total"] += 1
        fs["total"] += 1

    return rows
