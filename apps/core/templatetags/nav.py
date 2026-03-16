from django import template


register = template.Library()


@register.simple_tag(takes_context=True)
def active_link(context, prefix):
    request = context.get("request")
    if request is None:
        return ""

    path = request.path or ""
    if prefix == "dashboard" and path.startswith("/dashboard/"):
        return "bg-slate-700 text-white"
    if prefix and path.startswith(f"/{prefix}"):
        return "bg-slate-700 text-white"
    return ""

