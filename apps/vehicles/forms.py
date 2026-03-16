from django import forms

from apps.residents.models import Contract
from apps.core.widgets import PreviewClearableFileInput

from .models import ParkingSlot, Vehicle


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class VehicleForm(forms.ModelForm):
    class Meta:
        model = Vehicle
        fields = [
            "resident",
            "apartment",
            "vehicle_type",
            "license_plate",
            "brand",
            "model",
            "color",
            "parking_slot",
            "card_number",
            "image",
            "note",
        ]
        widgets = {
            "resident": forms.Select(attrs={"class": UI_SELECT}),
            "apartment": forms.Select(attrs={"class": UI_SELECT}),
            "vehicle_type": forms.Select(attrs={"class": UI_SELECT}),
            "license_plate": forms.TextInput(attrs={"class": UI_INPUT}),
            "brand": forms.TextInput(attrs={"class": UI_INPUT}),
            "model": forms.TextInput(attrs={"class": UI_INPUT}),
            "color": forms.TextInput(attrs={"class": UI_INPUT}),
            "parking_slot": forms.Select(attrs={"class": UI_SELECT}),
            "card_number": forms.TextInput(attrs={"class": UI_INPUT}),
            "image": PreviewClearableFileInput(attrs={"class": "ui-file"}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
        }

    def clean(self):
        cleaned = super().clean()
        resident = cleaned.get("resident")
        apartment = cleaned.get("apartment")
        if resident and apartment:
            has_active = Contract.objects.filter(resident=resident, apartment=apartment, status="ACTIVE").exists()
            if not has_active:
                self.add_error("resident", "Cư dân phải có hợp đồng ACTIVE với căn hộ.")
        return cleaned


class ParkingSlotForm(forms.ModelForm):
    class Meta:
        model = ParkingSlot
        fields = ["slot_number", "slot_type", "floor", "status", "monthly_fee", "note"]
        widgets = {
            "slot_number": forms.TextInput(attrs={"class": UI_INPUT}),
            "slot_type": forms.Select(attrs={"class": UI_SELECT}),
            "floor": forms.TextInput(attrs={"class": UI_INPUT}),
            "status": forms.Select(attrs={"class": UI_SELECT}),
            "monthly_fee": forms.NumberInput(attrs={"class": UI_INPUT}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
        }
