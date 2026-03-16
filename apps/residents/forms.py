from datetime import timedelta

from django import forms
from django.utils import timezone

from apps.buildings.models import Apartment
from apps.core.widgets import PreviewClearableFileInput

from .models import Contract, Resident


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class ResidentForm(forms.ModelForm):
    class Meta:
        model = Resident
        fields = [
            "full_name",
            "id_number",
            "phone",
            "email",
            "date_of_birth",
            "gender",
            "hometown",
            "permanent_address",
            "avatar",
            "emergency_contact_name",
            "emergency_contact_phone",
            "note",
        ]
        widgets = {
            "full_name": forms.TextInput(attrs={"class": UI_INPUT}),
            "id_number": forms.TextInput(attrs={"class": UI_INPUT}),
            "phone": forms.TextInput(attrs={"class": UI_INPUT}),
            "email": forms.EmailInput(attrs={"class": UI_INPUT}),
            "date_of_birth": forms.DateInput(attrs={"class": UI_INPUT, "type": "date"}),
            "gender": forms.Select(attrs={"class": UI_SELECT}),
            "hometown": forms.TextInput(attrs={"class": UI_INPUT}),
            "permanent_address": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
            "avatar": PreviewClearableFileInput(attrs={"class": "ui-file"}),
            "emergency_contact_name": forms.TextInput(attrs={"class": UI_INPUT}),
            "emergency_contact_phone": forms.TextInput(attrs={"class": UI_INPUT}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
        }


class ContractForm(forms.ModelForm):
    class Meta:
        model = Contract
        fields = ["resident", "apartment", "start_date", "end_date", "rent_amount", "deposit", "contract_file", "note"]
        widgets = {
            "resident": forms.Select(attrs={"class": UI_SELECT}),
            "apartment": forms.Select(attrs={"class": UI_SELECT}),
            "start_date": forms.DateInput(attrs={"class": UI_INPUT, "type": "date"}),
            "end_date": forms.DateInput(attrs={"class": UI_INPUT, "type": "date"}),
            "rent_amount": forms.NumberInput(attrs={"class": UI_INPUT}),
            "deposit": forms.NumberInput(attrs={"class": UI_INPUT}),
            "contract_file": forms.ClearableFileInput(attrs={"class": "ui-file"}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
        }

    def clean(self):
        cleaned = super().clean()
        start = cleaned.get("start_date")
        end = cleaned.get("end_date")
        apartment = cleaned.get("apartment")

        if start and end:
            if end <= start + timedelta(days=29):
                self.add_error("end_date", "Ngày kết thúc phải lớn hơn ngày bắt đầu ít nhất 1 tháng.")
            if end <= timezone.localdate():
                self.add_error("end_date", "Ngày kết thúc phải lớn hơn hôm nay.")

        if apartment:
            if apartment.status not in [Apartment.Status.AVAILABLE, Apartment.Status.RESERVED]:
                self.add_error("apartment", "Chỉ chọn căn hộ AVAILABLE hoặc RESERVED.")
            active = Contract.objects.filter(apartment=apartment, status=Contract.Status.ACTIVE).exists()
            if active:
                self.add_error("apartment", "Căn hộ đang có hợp đồng ACTIVE.")

        return cleaned
