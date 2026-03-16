from pathlib import Path

from django import template


register = template.Library()


@register.filter
def is_image(file_field):
    try:
        if not file_field:
            return False
        url = getattr(file_field, "url", "") or ""
        ext = Path(url).suffix.lower()
        return ext in {".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg"}
    except Exception:
        return False

