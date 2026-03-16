from django import forms

from apps.accounts.models import User
from apps.core.widgets import PreviewClearableFileInput

from .models import MaintenanceRequest


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class MaintenanceRequestForm(forms.ModelForm):
    class Meta:
        model = MaintenanceRequest
        fields = ["resident", "apartment", "category", "title", "description", "priority", "image"]
        widgets = {
            "resident": forms.Select(attrs={"class": UI_SELECT}),
            "apartment": forms.Select(attrs={"class": UI_SELECT}),
            "category": forms.Select(attrs={"class": UI_SELECT}),
            "title": forms.TextInput(attrs={"class": UI_INPUT}),
            "description": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 3}),
            "priority": forms.Select(attrs={"class": UI_SELECT}),
            "image": PreviewClearableFileInput(attrs={"class": "ui-file"}),
        }


class MaintenanceAssignForm(forms.ModelForm):
    class Meta:
        model = MaintenanceRequest
        fields = ["assigned_to", "priority"]
        widgets = {
            "assigned_to": forms.Select(attrs={"class": UI_SELECT}),
            "priority": forms.Select(attrs={"class": UI_SELECT}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["assigned_to"].queryset = User.objects.filter(profile__role="STAFF", is_active=True)


class MaintenanceUpdateStatusForm(forms.ModelForm):
    class Meta:
        model = MaintenanceRequest
        fields = ["status", "resolution_note", "actual_cost"]
        widgets = {
            "status": forms.Select(attrs={"class": UI_SELECT}),
            "resolution_note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 3}),
            "actual_cost": forms.NumberInput(attrs={"class": UI_INPUT}),
        }
