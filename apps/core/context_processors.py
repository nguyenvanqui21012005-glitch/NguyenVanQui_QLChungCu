from apps.announcements.models import Announcement


def global_context(request):
    if not getattr(request, "user", None) or not request.user.is_authenticated:
        return {}

    context = {
        "pinned_announcements": Announcement.objects.filter(is_pinned=True).order_by("-created_at")[
            :3
        ],
    }

    try:
        role = request.user.profile.role
    except Exception:
        return context

    if role == "ADMIN":
        from apps.fees.models import Invoice
        from apps.maintenance.models import MaintenanceRequest

        context.update(
            {
                "pending_maintenance_count": MaintenanceRequest.objects.filter(status="PENDING").count(),
                "overdue_invoice_count": Invoice.objects.filter(status="OVERDUE").count(),
            }
        )
    else:
        from apps.maintenance.models import MaintenanceRequest

        context.update(
            {
                "my_maintenance_count": MaintenanceRequest.objects.filter(
                    assigned_to=request.user, status__in=["ASSIGNED", "IN_PROCESS"]
                ).count(),
            }
        )

    return context

