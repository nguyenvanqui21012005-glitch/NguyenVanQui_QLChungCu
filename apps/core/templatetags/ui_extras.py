from django import template

register = template.Library()


@register.filter
def badge_class(value):
    v = (value or "").upper()

    if v in {"PAID", "ACTIVE", "OCCUPIED"}:
        return "ui-badge-success"

    if v in {"PARTIAL", "RESERVED", "ASSIGNED", "IN_PROCESS"}:
        return "ui-badge-info"

    if v in {"OVERDUE", "URGENT", "HIGH"}:
        return "ui-badge-warning"

    if v in {"CANCELLED", "CANCELED", "EXPIRED", "CLOSED", "MAINTENANCE"}:
        return "ui-badge-danger"

    if v in {"AVAILABLE", "PENDING", "LOW", "MEDIUM", "DISABLED"}:
        return "ui-badge-muted"

    return "ui-badge-muted"

