from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Q
from django.shortcuts import get_object_or_404, redirect, render

from apps.accounts.decorators import admin_required

from .forms import ContractForm, ResidentForm
from .models import Contract, Resident


@login_required
def resident_list(request):
    residents = Resident.objects.order_by("full_name")
    q = request.GET.get("q", "")
    if q:
        residents = residents.filter(
            Q(full_name__icontains=q) | Q(phone__icontains=q) | Q(id_number__icontains=q)
        )
    paginator = Paginator(residents, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "residents/resident_list.html", {"page_obj": page_obj, "q": q})


@login_required
@admin_required
def resident_create(request):
    if request.method == "POST":
        form = ResidentForm(request.POST, request.FILES)
        if form.is_valid():
            resident = form.save()
            messages.success(request, f"Đã thêm cư dân {resident.full_name}")
            return redirect("resident_list")
    else:
        form = ResidentForm()
    return render(request, "residents/resident_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def resident_edit(request, pk):
    resident = get_object_or_404(Resident, pk=pk)
    if request.method == "POST":
        form = ResidentForm(request.POST, request.FILES, instance=resident)
        if form.is_valid():
            form.save()
            messages.success(request, "Cập nhật cư dân thành công!")
            return redirect("resident_list")
    else:
        form = ResidentForm(instance=resident)
    return render(request, "residents/resident_form.html", {"form": form, "mode": "edit", "resident": resident})


@login_required
@admin_required
def resident_delete(request, pk):
    resident = get_object_or_404(Resident, pk=pk)
    if request.method == "POST":
        has_active = Contract.objects.filter(resident=resident, status=Contract.Status.ACTIVE).exists()
        if has_active:
            messages.error(request, "Không thể xóa cư dân đang có hợp đồng ACTIVE!")
        else:
            resident.delete()
            messages.success(request, f"Đã xóa cư dân {resident.full_name}")
    return redirect("resident_list")


@login_required
def resident_contracts(request, pk):
    resident = get_object_or_404(Resident, pk=pk)
    contracts = resident.contracts.select_related("apartment").order_by("-start_date")
    return render(
        request,
        "residents/resident_contracts.html",
        {"resident": resident, "contracts": contracts},
    )


@login_required
def contract_list(request):
    contracts = Contract.objects.select_related("resident", "apartment").order_by("-start_date")
    q = request.GET.get("q", "")
    if q:
        contracts = contracts.filter(
            Q(resident__full_name__icontains=q) | Q(apartment__apartment_number__icontains=q)
        )
    paginator = Paginator(contracts, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "residents/contract_list.html", {"page_obj": page_obj, "q": q})


@login_required
@admin_required
def contract_create(request):
    if request.method == "POST":
        form = ContractForm(request.POST, request.FILES)
        if form.is_valid():
            contract = form.save(commit=False)
            contract.created_by = request.user
            contract.save()
            if contract.apartment.status == contract.apartment.Status.AVAILABLE:
                contract.apartment.status = contract.apartment.Status.RESERVED
                contract.apartment.save(update_fields=["status"])
            messages.success(request, "Đã tạo hợp đồng (PENDING).")
            return redirect("contract_list")
    else:
        form = ContractForm()
    return render(request, "residents/contract_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def contract_activate(request, pk):
    contract = get_object_or_404(Contract, pk=pk)
    if request.method == "POST":
        active_exists = Contract.objects.filter(
            apartment=contract.apartment, status=Contract.Status.ACTIVE
        ).exclude(pk=contract.pk).exists()
        if active_exists:
            messages.error(request, "Căn hộ đang có hợp đồng ACTIVE.")
        else:
            contract.activate()
            messages.success(request, "Đã duyệt hợp đồng → ACTIVE.")
    return redirect("contract_list")


@login_required
@admin_required
def contract_terminate(request, pk):
    contract = get_object_or_404(Contract, pk=pk)
    if request.method == "POST":
        contract.terminate()
        messages.success(request, "Đã kết thúc hợp đồng.")
    return redirect("contract_list")
