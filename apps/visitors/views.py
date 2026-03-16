import datetime

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone

from apps.accounts.decorators import staff_or_admin_required

from .forms import VisitorForm
from .models import Visitor


@login_required
def visitor_list(request):
    qs = Visitor.objects.select_related("visit_apartment", "resident", "registered_by").order_by("-check_in")
    paginator = Paginator(qs, 30)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "visitors/visitor_list.html", {"page_obj": page_obj})


@login_required
@staff_or_admin_required
def visitor_create(request):
    if request.method == "POST":
        form = VisitorForm(request.POST)
        if form.is_valid():
            visitor = form.save(commit=False)
            visitor.registered_by = request.user
            visitor.save()
            messages.success(request, "Đã đăng ký khách thăm.")
            return redirect("visitor_today")
    else:
        form = VisitorForm()
    return render(request, "visitors/visitor_form.html", {"form": form})


@login_required
@staff_or_admin_required
def visitor_checkout(request, pk):
    visitor = get_object_or_404(Visitor, pk=pk)
    if request.method == "POST":
        if visitor.check_out:
            messages.error(request, "Khách đã check-out trước đó.")
        else:
            visitor.check_out = timezone.now()
            visitor.save(update_fields=["check_out"])
            messages.success(request, "Đã check-out khách.")
    return redirect("visitor_today")


@login_required
@staff_or_admin_required
def visitor_today(request):
    today = timezone.localdate()
    start = datetime.datetime.combine(today, datetime.time.min).replace(tzinfo=timezone.get_current_timezone())
    end = datetime.datetime.combine(today, datetime.time.max).replace(tzinfo=timezone.get_current_timezone())
    qs = Visitor.objects.filter(check_in__range=(start, end)).select_related("visit_apartment").order_by("-check_in")
    paginator = Paginator(qs, 30)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "visitors/visitor_today.html", {"page_obj": page_obj})

