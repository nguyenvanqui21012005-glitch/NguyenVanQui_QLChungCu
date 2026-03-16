from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.shortcuts import get_object_or_404, redirect, render

from apps.accounts.decorators import admin_required, staff_or_admin_required

from .forms import ParkingSlotForm, VehicleForm
from .models import ParkingSlot, Vehicle


@login_required
def vehicle_list(request):
    qs = Vehicle.objects.select_related("resident", "apartment", "parking_slot").order_by("license_plate")
    paginator = Paginator(qs, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "vehicles/vehicle_list.html", {"page_obj": page_obj})


@login_required
@staff_or_admin_required
def vehicle_create(request):
    if request.method == "POST":
        form = VehicleForm(request.POST, request.FILES)
        if form.is_valid():
            vehicle = form.save()
            if vehicle.parking_slot:
                vehicle.parking_slot.status = ParkingSlot.Status.OCCUPIED
                vehicle.parking_slot.save(update_fields=["status"])
            messages.success(request, "Đã đăng ký xe.")
            return redirect("vehicle_list")
    else:
        form = VehicleForm()
    return render(request, "vehicles/vehicle_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def vehicle_edit(request, pk):
    vehicle = get_object_or_404(Vehicle, pk=pk)
    old_slot = vehicle.parking_slot
    if request.method == "POST":
        form = VehicleForm(request.POST, request.FILES, instance=vehicle)
        if form.is_valid():
            vehicle = form.save()
            if old_slot and old_slot != vehicle.parking_slot:
                old_slot.status = ParkingSlot.Status.AVAILABLE
                old_slot.save(update_fields=["status"])
            if vehicle.parking_slot:
                vehicle.parking_slot.status = ParkingSlot.Status.OCCUPIED
                vehicle.parking_slot.save(update_fields=["status"])
            messages.success(request, "Đã cập nhật xe.")
            return redirect("vehicle_list")
    else:
        form = VehicleForm(instance=vehicle)
    return render(request, "vehicles/vehicle_form.html", {"form": form, "mode": "edit", "vehicle": vehicle})


@login_required
@admin_required
def vehicle_delete(request, pk):
    vehicle = get_object_or_404(Vehicle, pk=pk)
    if request.method == "POST":
        vehicle.delete()
        messages.success(request, "Đã xóa xe.")
    return redirect("vehicle_list")


@login_required
@admin_required
def parking_slot_list(request):
    qs = ParkingSlot.objects.order_by("slot_number")
    paginator = Paginator(qs, 30)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "vehicles/parking_slot_list.html", {"page_obj": page_obj})


@login_required
@admin_required
def parking_slot_assign(request, pk):
    slot = get_object_or_404(ParkingSlot, pk=pk)
    if request.method == "POST":
        action = request.POST.get("action")
        if action == "free":
            slot.status = ParkingSlot.Status.AVAILABLE
            slot.save(update_fields=["status"])
            messages.success(request, "Đã thu chỗ đậu.")
        elif action == "occupy":
            slot.status = ParkingSlot.Status.OCCUPIED
            slot.save(update_fields=["status"])
            messages.success(request, "Đã cấp chỗ đậu.")
    return redirect("parking_slot_list")


@login_required
@admin_required
def parking_slot_create(request):
    if request.method == "POST":
        form = ParkingSlotForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Đã tạo chỗ đậu.")
            return redirect("parking_slot_list")
    else:
        form = ParkingSlotForm()
    return render(request, "vehicles/parking_slot_form.html", {"form": form})

