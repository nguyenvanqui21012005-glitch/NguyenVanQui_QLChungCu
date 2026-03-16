from django.contrib import messages
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.shortcuts import get_object_or_404, redirect, render

from .decorators import admin_required
from .forms import ChangePasswordForm, LoginForm, StaffCreateForm, UserProfileForm
from .models import User, UserProfile


def login_view(request):
    if request.user.is_authenticated:
        return redirect("dashboard")

    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            user = authenticate(
                request,
                username=form.cleaned_data["username"],
                password=form.cleaned_data["password"],
            )
            if user and user.is_active and not getattr(user, "is_deleted", False):
                login(request, user)
                next_url = request.GET.get("next") or "dashboard"
                return redirect(next_url)
            form.add_error(None, "Tên đăng nhập hoặc mật khẩu không đúng")
    else:
        form = LoginForm()

    return render(request, "accounts/login.html", {"form": form})


def logout_view(request):
    if request.method == "POST":
        logout(request)
    return redirect("login")


@login_required
def dashboard_view(request):
    try:
        role = request.user.profile.role
    except Exception:
        return redirect("login")

    if role == "ADMIN":
        return _admin_dashboard(request)
    return _staff_dashboard(request)


def _admin_dashboard(request):
    from datetime import date, timedelta

    from django.db.models import F, Max, Sum

    from apps.buildings.models import Apartment, Building
    from apps.fees.models import Invoice, Payment
    from apps.maintenance.models import MaintenanceRequest
    from apps.residents.models import Contract, Resident

    today = date.today()
    expiring_soon = today + timedelta(days=30)
    first_day = today.replace(day=1)
    next_month = (first_day.replace(day=28) + timedelta(days=4)).replace(day=1)
    last_day = next_month - timedelta(days=1)
    prev_last_day = first_day - timedelta(days=1)
    prev_first_day = prev_last_day.replace(day=1)

    revenue_this_month = (
        Payment.objects.filter(paid_at__date__gte=first_day, paid_at__date__lte=last_day).aggregate(
            total=Sum("amount_paid")
        )["total"]
        or 0
    )
    revenue_prev_month = (
        Payment.objects.filter(paid_at__date__gte=prev_first_day, paid_at__date__lte=prev_last_day).aggregate(
            total=Sum("amount_paid")
        )["total"]
        or 0
    )

    total_month_invoices = Invoice.objects.filter(month=today.month, year=today.year).count()
    on_time_paid = 0
    if total_month_invoices:
        paid_qs = (
            Invoice.objects.filter(month=today.month, year=today.year, status=Invoice.Status.PAID)
            .annotate(last_paid=Max("payments__paid_at"))
            .filter(last_paid__isnull=False)
        )
        on_time_paid = paid_qs.filter(last_paid__date__lte=F("due_date")).count()
    on_time_rate = round((on_time_paid / total_month_invoices) * 100, 1) if total_month_invoices else 0

    context = {
        "total_buildings": Building.objects.count(),
        "total_apartments": Apartment.objects.count(),
        "occupied_apartments": Apartment.objects.filter(status="OCCUPIED").count(),
        "available_apartments": Apartment.objects.filter(status="AVAILABLE").count(),
        "maintenance_apartments": Apartment.objects.filter(status="MAINTENANCE").count(),
        "revenue_this_month": revenue_this_month,
        "revenue_prev_month": revenue_prev_month,
        "on_time_rate": on_time_rate,
        "revenue_labels": [prev_first_day.strftime("%m/%Y"), first_day.strftime("%m/%Y")],
        "revenue_values": [float(revenue_prev_month), float(revenue_this_month)],
        "total_residents": Resident.objects.count(),
        "active_contracts": Contract.objects.filter(status="ACTIVE").count(),
        "expiring_contracts": Contract.objects.filter(
            status="ACTIVE", end_date__lte=expiring_soon, end_date__gte=today
        ).count(),
        "pending_invoices": Invoice.objects.filter(status="PENDING").count(),
        "overdue_invoices": Invoice.objects.filter(status="OVERDUE").count(),
        "pending_maintenance": MaintenanceRequest.objects.filter(status="PENDING").count(),
        "urgent_maintenance": MaintenanceRequest.objects.filter(
            status__in=["PENDING", "ASSIGNED"], priority="URGENT"
        ).count(),
        "recent_contracts": Contract.objects.filter(status="ACTIVE")
        .select_related("resident", "apartment")
        .order_by("-created_at")[:5],
        "recent_maintenance": MaintenanceRequest.objects.filter(status="PENDING")
        .select_related("apartment", "resident")
        .order_by("-created_at")[:5],
    }
    return render(request, "accounts/dashboard_admin.html", context)


def _staff_dashboard(request):
    import datetime
    from datetime import date

    from django.db.models import Sum

    from apps.fees.models import Payment
    from apps.maintenance.models import MaintenanceRequest
    from apps.visitors.models import Visitor

    today = date.today()
    today_start = datetime.datetime.combine(today, datetime.time.min)
    today_end = datetime.datetime.combine(today, datetime.time.max)

    context = {
        "my_tasks": MaintenanceRequest.objects.filter(
            assigned_to=request.user, status__in=["ASSIGNED", "IN_PROCESS"]
        )
        .select_related("apartment")
        .order_by("-created_at")[:10],
        "today_visitors": Visitor.objects.filter(check_in__range=(today_start, today_end))
        .select_related("visit_apartment")
        .order_by("-check_in")[:10],
        "current_visitors": Visitor.objects.filter(check_in__date=today, check_out__isnull=True).count(),
        "payments_today_count": Payment.objects.filter(received_by=request.user, paid_at__date=today).count(),
        "payments_today_sum": Payment.objects.filter(received_by=request.user, paid_at__date=today).aggregate(
            total=Sum("amount_paid")
        )["total"]
        or 0,
    }
    return render(request, "accounts/dashboard_staff.html", context)


@login_required
def profile_view(request):
    return render(request, "accounts/profile.html", {"profile": request.user.profile})


@login_required
def profile_edit_view(request):
    profile = request.user.profile

    if request.method == "POST":
        form = UserProfileForm(request.POST, request.FILES, instance=profile)
        user_form_data = {
            "first_name": request.POST.get("first_name", ""),
            "last_name": request.POST.get("last_name", ""),
            "email": request.POST.get("email", ""),
        }
        if form.is_valid():
            user = request.user
            user.first_name = user_form_data["first_name"]
            user.last_name = user_form_data["last_name"]
            user.email = user_form_data["email"]
            user.save(update_fields=["first_name", "last_name", "email"])
            form.save()
            messages.success(request, "Cập nhật thông tin thành công!")
            return redirect("profile")
    else:
        form = UserProfileForm(
            instance=profile,
            initial={
                "first_name": request.user.first_name,
                "last_name": request.user.last_name,
                "email": request.user.email,
            },
        )

    return render(request, "accounts/profile_edit.html", {"form": form})


@login_required
def change_password_view(request):
    if request.method == "POST":
        form = ChangePasswordForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)
            messages.success(request, "Đổi mật khẩu thành công!")
            return redirect("profile")
    else:
        form = ChangePasswordForm(request.user)

    return render(request, "accounts/change_password.html", {"form": form})


@login_required
def update_avatar_view(request):
    if request.method == "POST" and request.FILES.get("avatar"):
        profile = request.user.profile
        profile.avatar = request.FILES["avatar"]
        profile.save(update_fields=["avatar"])
        messages.success(request, "Cập nhật ảnh đại diện thành công!")
    return redirect("profile")


@login_required
@admin_required
def staff_list_view(request):
    staff = User.objects.filter(profile__role="STAFF").select_related("profile").order_by(
        "last_name", "first_name"
    )

    q = request.GET.get("q", "")
    if q:
        staff = staff.filter(username__icontains=q) | staff.filter(first_name__icontains=q) | staff.filter(
            last_name__icontains=q
        )

    paginator = Paginator(staff, 20)
    page_obj = paginator.get_page(request.GET.get("page"))
    return render(request, "accounts/staff_list.html", {"page_obj": page_obj, "q": q})


@login_required
@admin_required
def staff_create_view(request):
    if request.method == "POST":
        form = StaffCreateForm(request.POST, request.FILES)
        if form.is_valid():
            user = form.save()
            messages.success(request, f"Tạo tài khoản {user.username} thành công!")
            return redirect("staff_list")
    else:
        form = StaffCreateForm()
    return render(request, "accounts/staff_form.html", {"form": form, "mode": "create"})


@login_required
@admin_required
def staff_edit_view(request, pk):
    staff = get_object_or_404(User, pk=pk, profile__role="STAFF")
    if request.method == "POST":
        form = StaffCreateForm(request.POST, request.FILES, instance=staff)
        if form.is_valid():
            form.save()
            messages.success(request, f"Cập nhật tài khoản {staff.username} thành công!")
            return redirect("staff_list")
    else:
        form = StaffCreateForm(instance=staff)
    return render(request, "accounts/staff_form.html", {"form": form, "mode": "edit", "staff": staff})


@login_required
@admin_required
def staff_toggle_active(request, pk):
    staff = get_object_or_404(User, pk=pk, profile__role="STAFF")
    staff.is_active = not staff.is_active
    staff.save(update_fields=["is_active"])
    action = "kích hoạt" if staff.is_active else "vô hiệu hóa"
    messages.success(request, f"Đã {action} tài khoản {staff.username}")
    return redirect("staff_list")


@login_required
@admin_required
def staff_reset_password(request, pk):
    staff = get_object_or_404(User, pk=pk, profile__role="STAFF")
    if request.method == "POST":
        new_password = request.POST.get("new_password") or "Staff@123"
        staff.set_password(new_password)
        staff.save()
        messages.success(request, f"Reset mật khẩu cho {staff.username} thành công!")
    return redirect("staff_list")


@login_required
@admin_required
def staff_delete_view(request, pk):
    staff = get_object_or_404(User, pk=pk, profile__role="STAFF")
    if request.method == "POST":
        staff.delete()
        messages.success(request, f"Đã xóa tài khoản {staff.username}")
    return redirect("staff_list")
