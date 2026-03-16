from django import forms

from apps.core.widgets import PreviewClearableFileInput

from .models import Announcement


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class AnnouncementForm(forms.ModelForm):
    class Meta:
        model = Announcement
        fields = ["title", "content", "category", "is_pinned", "image", "attachment"]
        widgets = {
            "title": forms.TextInput(attrs={"class": UI_INPUT}),
            "content": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 6}),
            "category": forms.Select(attrs={"class": UI_SELECT}),
            "image": PreviewClearableFileInput(attrs={"class": "ui-file"}),
            "attachment": forms.ClearableFileInput(attrs={"class": "ui-file"}),
        }
