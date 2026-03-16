from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import F, Q
from django.shortcuts import get_object_or_404, redirect, render

from apps.accounts.decorators import admin_required

from .forms import AnnouncementForm
from .models import Announcement


@login_required
def announcement_list(request):
    qs = Announcement.objects.order_by("-is_pinned", "-created_at")
    q = request.GET.get("q", "")
    if q:
        qs = qs.filter(Q(title__icontains=q) | Q(content__icontains=q))
    paginator = Paginator(qs, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "announcements/announcement_list.html", {"page_obj": page_obj, "q": q})


@login_required
def announcement_detail(request, pk):
    item = get_object_or_404(Announcement, pk=pk)
    Announcement.objects.filter(pk=item.pk).update(views_count=F("views_count") + 1)
    item.refresh_from_db(fields=["views_count"])
    return render(request, "announcements/announcement_detail.html", {"item": item})


@login_required
@admin_required
def announcement_create(request):
    if request.method == "POST":
        form = AnnouncementForm(request.POST, request.FILES)
        if form.is_valid():
            item = form.save(commit=False)
            item.created_by = request.user
            item.save()
            messages.success(request, "Đã tạo thông báo.")
            return redirect("announcement_list")
    else:
        form = AnnouncementForm()
    return render(request, "announcements/announcement_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def announcement_edit(request, pk):
    item = get_object_or_404(Announcement, pk=pk)
    if request.method == "POST":
        form = AnnouncementForm(request.POST, request.FILES, instance=item)
        if form.is_valid():
            form.save()
            messages.success(request, "Đã cập nhật thông báo.")
            return redirect("announcement_detail", pk=pk)
    else:
        form = AnnouncementForm(instance=item)
    return render(request, "announcements/announcement_form.html", {"form": form, "mode": "edit", "item": item})


@login_required
@admin_required
def announcement_delete(request, pk):
    item = get_object_or_404(Announcement, pk=pk)
    if request.method == "POST":
        item.delete()
        messages.success(request, "Đã xóa thông báo.")
    return redirect("announcement_list")


@login_required
@admin_required
def announcement_pin(request, pk):
    item = get_object_or_404(Announcement, pk=pk)
    if request.method == "POST":
        item.is_pinned = not item.is_pinned
        item.save(update_fields=["is_pinned"])
        messages.success(request, "Đã cập nhật ghim/bỏ ghim.")
    return redirect("announcement_list")

