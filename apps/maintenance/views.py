from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Count
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone

from apps.accounts.decorators import admin_required, staff_or_admin_required

from .forms import MaintenanceAssignForm, MaintenanceRequestForm, MaintenanceUpdateStatusForm
from .models import MaintenanceRequest


@login_required
def maintenance_list(request):
    qs = MaintenanceRequest.objects.select_related("apartment", "resident", "assigned_to").order_by("-created_at")
    if request.user.profile.role != "ADMIN":
        qs = qs.filter(assigned_to=request.user)
    paginator = Paginator(qs, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "maintenance/maintenance_list.html", {"page_obj": page_obj})


@login_required
@staff_or_admin_required
def maintenance_create(request):
    if request.method == "POST":
        form = MaintenanceRequestForm(request.POST, request.FILES)
        if form.is_valid():
            obj = form.save()
            messages.success(request, "Đã tạo yêu cầu bảo trì.")
            return redirect("maintenance_detail", pk=obj.pk)
    else:
        form = MaintenanceRequestForm()
    return render(request, "maintenance/maintenance_form.html", {"form": form, "mode": "create"})


@login_required
def maintenance_detail(request, pk):
    obj = get_object_or_404(MaintenanceRequest, pk=pk)
    if request.user.profile.role != "ADMIN":
        if obj.assigned_to_id and obj.assigned_to_id != request.user.id:
            messages.error(request, "Bạn không có quyền xem yêu cầu này.")
            return redirect("maintenance_my_tasks")
        if not obj.assigned_to_id:
            messages.error(request, "Bạn không có quyền xem yêu cầu này.")
            return redirect("maintenance_my_tasks")
    return render(request, "maintenance/maintenance_detail.html", {"item": obj})


@login_required
@admin_required
def maintenance_assign(request, pk):
    obj = get_object_or_404(MaintenanceRequest, pk=pk)
    if request.method == "POST":
        form = MaintenanceAssignForm(request.POST, instance=obj)
        if form.is_valid():
            req = form.save(commit=False)
            req.status = MaintenanceRequest.Status.ASSIGNED
            req.assigned_at = timezone.now()
            req.save()
            messages.success(request, "Đã phân công nhân viên.")
            return redirect("maintenance_detail", pk=pk)
    else:
        form = MaintenanceAssignForm(instance=obj)
    return render(request, "maintenance/maintenance_assign.html", {"form": form, "item": obj})


@login_required
@admin_required
def maintenance_close(request, pk):
    obj = get_object_or_404(MaintenanceRequest, pk=pk)
    if request.method == "POST":
        obj.status = MaintenanceRequest.Status.CLOSED
        obj.resolved_at = timezone.now()
        obj.save(update_fields=["status", "resolved_at"])
        messages.success(request, "Đã đóng yêu cầu.")
    return redirect("maintenance_detail", pk=pk)


@login_required
def maintenance_stats(request):
    if request.user.profile.role != "ADMIN":
        messages.error(request, "Bạn không có quyền truy cập.")
        return redirect("dashboard")
    by_status = (
        MaintenanceRequest.objects.values("status")
        .annotate(total=Count("id"))
        .order_by("status")
    )
    by_priority = (
        MaintenanceRequest.objects.values("priority")
        .annotate(total=Count("id"))
        .order_by("priority")
    )
    return render(request, "maintenance/maintenance_stats.html", {"by_status": by_status, "by_priority": by_priority})


@login_required
def maintenance_my_tasks(request):
    qs = MaintenanceRequest.objects.filter(assigned_to=request.user).select_related("apartment").order_by("-created_at")
    paginator = Paginator(qs, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "maintenance/maintenance_my_tasks.html", {"page_obj": page_obj})


@login_required
def maintenance_update_status(request, pk):
    obj = get_object_or_404(MaintenanceRequest, pk=pk)
    if obj.assigned_to_id and obj.assigned_to_id != request.user.id and request.user.profile.role != "ADMIN":
        messages.error(request, "Bạn không có quyền cập nhật yêu cầu này.")
        return redirect("maintenance_detail", pk=pk)

    if request.method == "POST":
        form = MaintenanceUpdateStatusForm(request.POST, instance=obj)
        if form.is_valid():
            req = form.save(commit=False)
            if req.status == MaintenanceRequest.Status.RESOLVED and not req.resolved_at:
                req.resolved_at = timezone.now()
            req.save()
            messages.success(request, "Đã cập nhật trạng thái.")
            return redirect("maintenance_detail", pk=pk)
    else:
        form = MaintenanceUpdateStatusForm(instance=obj)
    return render(request, "maintenance/maintenance_update_status.html", {"form": form, "item": obj})
