from functools import wraps

from django.contrib import messages
from django.shortcuts import redirect


def admin_required(view_func):
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect("login")
        try:
            if request.user.profile.role != "ADMIN":
                messages.error(request, "Bạn không có quyền truy cập.")
                return redirect("dashboard")
        except Exception:
            return redirect("login")
        return view_func(request, *args, **kwargs)

    return wrapper


def staff_or_admin_required(view_func):
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated:
            return redirect("login")
        if not hasattr(request.user, "profile"):
            return redirect("login")
        if request.user.profile.role not in ["ADMIN", "STAFF"]:
            messages.error(request, "Bạn không có quyền truy cập.")
            return redirect("dashboard")
        return view_func(request, *args, **kwargs)

    return wrapper

