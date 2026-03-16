from django import forms
from django.utils import timezone

from .models import Visitor


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class VisitorForm(forms.ModelForm):
    class Meta:
        model = Visitor
        fields = ["full_name", "id_number", "phone", "visit_apartment", "resident", "purpose", "note"]
        widgets = {
            "full_name": forms.TextInput(attrs={"class": UI_INPUT}),
            "id_number": forms.TextInput(attrs={"class": UI_INPUT}),
            "phone": forms.TextInput(attrs={"class": UI_INPUT}),
            "visit_apartment": forms.Select(attrs={"class": UI_SELECT}),
            "resident": forms.Select(attrs={"class": UI_SELECT}),
            "purpose": forms.TextInput(attrs={"class": UI_INPUT}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
        }

    def clean(self):
        cleaned = super().clean()
        now = timezone.localtime()
        if now.hour >= 22 and not cleaned.get("resident"):
            self.add_error("resident", "Sau 22h cần có xác nhận của cư dân (chọn cư dân).")
        return cleaned
