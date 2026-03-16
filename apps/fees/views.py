from datetime import date

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db import transaction
from django.db.models import Q
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone

from apps.accounts.decorators import admin_required
from apps.buildings.models import Apartment
from apps.residents.models import Contract

from .forms import FeeTypeForm, InvoiceForm, PaymentForm
from .models import FeeType, Invoice, Payment


@login_required
@admin_required
def fee_type_list(request):
    fee_types = FeeType.objects.order_by("name")
    return render(request, "fees/fee_type_list.html", {"fee_types": fee_types})


@login_required
@admin_required
def fee_type_create(request):
    if request.method == "POST":
        form = FeeTypeForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Đã tạo loại phí.")
            return redirect("fee_type_list")
    else:
        form = FeeTypeForm()
    return render(request, "fees/fee_type_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def fee_type_edit(request, pk):
    fee_type = get_object_or_404(FeeType, pk=pk)
    if request.method == "POST":
        form = FeeTypeForm(request.POST, instance=fee_type)
        if form.is_valid():
            form.save()
            messages.success(request, "Đã cập nhật loại phí.")
            return redirect("fee_type_list")
    else:
        form = FeeTypeForm(instance=fee_type)
    return render(request, "fees/fee_type_form.html", {"form": form, "mode": "edit", "fee_type": fee_type})


@login_required
def invoice_list(request):
    invoices = Invoice.objects.select_related("fee_type", "apartment", "resident").order_by("-year", "-month", "-created_at")
    q = request.GET.get("q", "")
    status = request.GET.get("status", "")
    if q:
        invoices = invoices.filter(
            Q(resident__full_name__icontains=q)
            | Q(apartment__apartment_number__icontains=q)
            | Q(fee_type__name__icontains=q)
        )
    if status:
        invoices = invoices.filter(status=status)
    paginator = Paginator(invoices, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(
        request,
        "fees/invoice_list.html",
        {"page_obj": page_obj, "q": q, "status": status, "status_choices": Invoice.Status.choices},
    )


@login_required
@admin_required
def invoice_create(request):
    if request.method == "POST":
        form = InvoiceForm(request.POST)
        if form.is_valid():
            invoice = form.save(commit=False)
            invoice.created_by = request.user
            invoice.save()
            messages.success(request, "Đã tạo hóa đơn.")
            return redirect("invoice_list")
    else:
        form = InvoiceForm()
    return render(request, "fees/invoice_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def invoice_bulk_create(request):
    if request.method == "POST":
        month = int(request.POST.get("month", date.today().month))
        year = int(request.POST.get("year", date.today().year))
        fee_type_ids = request.POST.getlist("fee_types")

        fee_types = FeeType.objects.filter(pk__in=fee_type_ids)
        active_contracts = Contract.objects.filter(status="ACTIVE").select_related("apartment", "resident")

        created = 0
        skipped = 0

        for contract in active_contracts:
            for ft in fee_types:
                if ft.unit == FeeType.Unit.M2:
                    amount = int(contract.apartment.area * ft.unit_price)
                else:
                    amount = ft.unit_price

                _, was_created = Invoice.objects.get_or_create(
                    fee_type=ft,
                    apartment=contract.apartment,
                    resident=contract.resident,
                    month=month,
                    year=year,
                    defaults={
                        "amount": amount,
                        "due_date": date(year, month, 15),
                        "status": Invoice.Status.PENDING,
                        "created_by": request.user,
                    },
                )
                if was_created:
                    created += 1
                else:
                    skipped += 1

        messages.success(request, f"Đã tạo {created} hóa đơn mới, bỏ qua {skipped} hóa đơn đã tồn tại")
        return redirect("invoice_list")

    fee_types = FeeType.objects.filter(is_mandatory=True).order_by("name")
    return render(request, "fees/invoice_bulk_create.html", {"fee_types": fee_types, "today": date.today()})


@login_required
def invoice_detail(request, pk):
    invoice = get_object_or_404(Invoice, pk=pk)
    payments = invoice.payments.select_related("received_by").order_by("-paid_at")
    return render(request, "fees/invoice_detail.html", {"invoice": invoice, "payments": payments})


@login_required
@admin_required
def invoice_cancel(request, pk):
    invoice = get_object_or_404(Invoice, pk=pk)
    if request.method == "POST":
        if invoice.status != Invoice.Status.PENDING:
            messages.error(request, "Chỉ hủy hóa đơn khi trạng thái PENDING.")
        else:
            invoice.status = Invoice.Status.CANCELLED
            invoice.save(update_fields=["status"])
            messages.success(request, "Đã hủy hóa đơn.")
    return redirect("invoice_detail", pk=pk)


@login_required
def invoice_pay(request, pk):
    invoice = get_object_or_404(Invoice, pk=pk)
    if invoice.status == Invoice.Status.CANCELLED:
        messages.error(request, "Hóa đơn đã bị hủy, không thể thanh toán.")
        return redirect("invoice_detail", pk=pk)
    if invoice.status == Invoice.Status.PAID:
        messages.error(request, "Hóa đơn đã thanh toán đủ.")
        return redirect("invoice_detail", pk=pk)

    if request.method == "POST":
        with transaction.atomic():
            invoice = Invoice.objects.select_for_update().get(pk=pk)
            if invoice.status == Invoice.Status.CANCELLED:
                messages.error(request, "Hóa đơn đã bị hủy, không thể thanh toán.")
                return redirect("invoice_detail", pk=pk)
            if invoice.status == Invoice.Status.PAID:
                messages.error(request, "Hóa đơn đã thanh toán đủ.")
                return redirect("invoice_detail", pk=pk)

            form = PaymentForm(request.POST, request.FILES)
            if form.is_valid():
                amount_paid = form.cleaned_data["amount_paid"]
                if amount_paid <= 0:
                    messages.error(request, "Số tiền phải lớn hơn 0")
                else:
                    remaining = invoice.remaining
                    payment = form.save(commit=False)
                    payment.invoice = invoice
                    payment.paid_at = timezone.now()
                    payment.received_by = request.user
                    if amount_paid > remaining and remaining > 0:
                        note = payment.note or ""
                        suffix = f"[Overpay] Trả thừa {int(amount_paid - remaining):,}đ"
                        payment.note = f"{note}\n{suffix}".strip() if note else suffix
                    payment.save()
                    messages.success(request, f"Ghi nhận thanh toán {int(amount_paid):,}đ thành công!")
                    return redirect("invoice_detail", pk=pk)
    else:
        form = PaymentForm()

    return render(request, "fees/invoice_pay.html", {"invoice": invoice, "form": form})


@login_required
def payment_list(request):
    payments = Payment.objects.select_related("invoice", "received_by").order_by("-paid_at")
    paginator = Paginator(payments, 30)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "fees/payment_list.html", {"page_obj": page_obj})
