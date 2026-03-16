from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Count, Q
from django.shortcuts import get_object_or_404, redirect, render

from apps.accounts.decorators import admin_required

from .forms import ApartmentForm, BuildingForm, FloorForm
from .models import Apartment, Building, Floor


@login_required
def building_list(request):
    buildings = Building.objects.annotate(
        apt_count=Count(
            "floors__apartments",
            filter=Q(floors__apartments__deleted_at__isnull=True),
        )
    ).order_by("name")

    q = request.GET.get("q", "")
    if q:
        buildings = buildings.filter(Q(name__icontains=q) | Q(address__icontains=q))

    paginator = Paginator(buildings, 12)
    page_obj = paginator.get_page(request.GET.get("page"))

    return render(request, "buildings/building_list.html", {"page_obj": page_obj, "q": q})


@login_required
@admin_required
def building_create(request):
    if request.method == "POST":
        form = BuildingForm(request.POST, request.FILES)
        if form.is_valid():
            building = form.save(commit=False)
            building.manager = request.user
            building.save()
            messages.success(request, f'Đã thêm tòa nhà "{building.name}"')
            return redirect("building_list")
    else:
        form = BuildingForm()
    return render(request, "buildings/building_form.html", {"form": form, "mode": "create"})


@login_required
def building_detail(request, pk):
    building = get_object_or_404(Building, pk=pk)
    floors = building.floors.prefetch_related("apartments").order_by("floor_number")

    context = {
        "building": building,
        "floors": floors,
        "total_apartments": Apartment.objects.filter(floor__building=building).count(),
        "occupied": Apartment.objects.filter(floor__building=building, status="OCCUPIED").count(),
        "available": Apartment.objects.filter(floor__building=building, status="AVAILABLE").count(),
    }
    return render(request, "buildings/building_detail.html", context)


@login_required
@admin_required
def building_edit(request, pk):
    building = get_object_or_404(Building, pk=pk)
    if request.method == "POST":
        form = BuildingForm(request.POST, request.FILES, instance=building)
        if form.is_valid():
            form.save()
            messages.success(request, "Cập nhật tòa nhà thành công!")
            return redirect("building_detail", pk=pk)
    else:
        form = BuildingForm(instance=building)
    return render(
        request,
        "buildings/building_form.html",
        {"form": form, "building": building, "mode": "edit"},
    )


@login_required
@admin_required
def building_delete(request, pk):
    building = get_object_or_404(Building, pk=pk)
    if request.method == "POST":
        occupied = Apartment.objects.filter(floor__building=building, status="OCCUPIED").exists()
        if occupied:
            messages.error(request, "Không thể xóa tòa nhà có căn hộ đang cư trú!")
        else:
            building.delete()
            messages.success(request, f'Đã xóa tòa nhà "{building.name}"')
            return redirect("building_list")
    return redirect("building_detail", pk=pk)


@login_required
@admin_required
def floor_manage(request, pk):
    building = get_object_or_404(Building, pk=pk)
    floors = building.floors.order_by("floor_number")

    if request.method == "POST":
        form = FloorForm(request.POST)
        if form.is_valid():
            floor = form.save(commit=False)
            floor.building = building
            floor.save()
            messages.success(request, f"Đã thêm tầng {floor.floor_number}")
            return redirect("floor_manage", pk=pk)
    else:
        form = FloorForm()

    return render(
        request,
        "buildings/floor_manage.html",
        {"building": building, "floors": floors, "form": form},
    )


@login_required
def apartment_list(request):
    apartments = Apartment.objects.select_related("floor__building").order_by(
        "floor__building__name", "floor__floor_number", "apartment_number"
    )

    status = request.GET.get("status", "")
    building_id = request.GET.get("building", "")
    q = request.GET.get("q", "")

    if status:
        apartments = apartments.filter(status=status)
    if building_id:
        apartments = apartments.filter(floor__building_id=building_id)
    if q:
        apartments = apartments.filter(
            Q(apartment_number__icontains=q) | Q(floor__building__name__icontains=q)
        )

    paginator = Paginator(apartments, 20)
    page_obj = paginator.get_page(request.GET.get("page"))

    context = {
        "page_obj": page_obj,
        "buildings": Building.objects.all(),
        "status_choices": Apartment.Status.choices,
        "current_status": status,
        "current_building": building_id,
        "q": q,
    }
    return render(request, "buildings/apartment_list.html", context)


@login_required
@admin_required
def apartment_create(request):
    if request.method == "POST":
        form = ApartmentForm(request.POST, request.FILES)
        if form.is_valid():
            apt = form.save()
            messages.success(request, f"Đã thêm căn hộ {apt.apartment_number}")
            return redirect("apartment_list")
    else:
        form = ApartmentForm()
    return render(request, "buildings/apartment_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def apartment_edit(request, pk):
    apt = get_object_or_404(Apartment, pk=pk)
    if request.method == "POST":
        form = ApartmentForm(request.POST, request.FILES, instance=apt)
        if form.is_valid():
            form.save()
            messages.success(request, "Cập nhật căn hộ thành công!")
            return redirect("apartment_list")
    else:
        form = ApartmentForm(instance=apt)
    return render(request, "buildings/apartment_form.html", {"form": form, "mode": "edit", "apartment": apt})


@login_required
@admin_required
def apartment_delete(request, pk):
    apt = get_object_or_404(Apartment, pk=pk)
    if request.method == "POST":
        from apps.residents.models import Contract

        has_active = Contract.objects.filter(apartment=apt, status=Contract.Status.ACTIVE).exists()
        if has_active:
            messages.error(request, "Không thể xóa căn hộ đang có hợp đồng ACTIVE!")
        else:
            apt.delete()
            messages.success(request, f"Đã xóa căn hộ {apt.apartment_number}")
    return redirect("apartment_list")


@login_required
@admin_required
def apartment_status(request, pk):
    apt = get_object_or_404(Apartment, pk=pk)
    if request.method == "POST":
        new_status = request.POST.get("status") or ""
        allowed = {s[0] for s in Apartment.Status.choices}
        if new_status in allowed:
            from apps.residents.models import Contract

            has_active = Contract.objects.filter(apartment=apt, status=Contract.Status.ACTIVE).exists()
            if new_status == Apartment.Status.OCCUPIED and not has_active:
                messages.error(request, "Không thể set OCCUPIED khi không có hợp đồng ACTIVE.")
                return redirect("apartment_list")
            if new_status in {Apartment.Status.AVAILABLE, Apartment.Status.RESERVED, Apartment.Status.MAINTENANCE} and has_active:
                messages.error(request, "Không thể đổi trạng thái khi căn hộ đang có hợp đồng ACTIVE.")
                return redirect("apartment_list")

            apt.status = new_status
            apt.save(update_fields=["status"])
            messages.success(request, "Đã cập nhật trạng thái căn hộ.")
    return redirect("apartment_list")
