from django import forms

from apps.core.widgets import PreviewClearableFileInput

from .models import Apartment, Building, Floor


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class BuildingForm(forms.ModelForm):
    class Meta:
        model = Building
        fields = ["name", "address", "total_floors", "description", "image", "built_year", "phone", "email"]
        widgets = {
            "name": forms.TextInput(attrs={"class": UI_INPUT, "placeholder": "Tên tòa nhà"}),
            "address": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
            "total_floors": forms.NumberInput(attrs={"class": UI_INPUT}),
            "description": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 3}),
            "built_year": forms.NumberInput(attrs={"class": UI_INPUT}),
            "phone": forms.TextInput(attrs={"class": UI_INPUT}),
            "email": forms.EmailInput(attrs={"class": UI_INPUT}),
            "image": PreviewClearableFileInput(attrs={"class": "ui-file"}),
        }


class FloorForm(forms.ModelForm):
    class Meta:
        model = Floor
        fields = ["floor_number", "name"]
        widgets = {
            "floor_number": forms.NumberInput(attrs={"class": UI_INPUT}),
            "name": forms.TextInput(attrs={"class": UI_INPUT}),
        }


class ApartmentForm(forms.ModelForm):
    class Meta:
        model = Apartment
        fields = [
            "floor",
            "apartment_number",
            "area",
            "bedroom_count",
            "bathroom_count",
            "rent_price",
            "direction",
            "balcony",
            "furniture_included",
            "description",
            "image",
        ]
        widgets = {
            "floor": forms.Select(attrs={"class": UI_SELECT}),
            "apartment_number": forms.TextInput(attrs={"class": UI_INPUT}),
            "area": forms.NumberInput(attrs={"class": UI_INPUT, "step": "0.01"}),
            "bedroom_count": forms.NumberInput(attrs={"class": UI_INPUT}),
            "bathroom_count": forms.NumberInput(attrs={"class": UI_INPUT}),
            "rent_price": forms.NumberInput(attrs={"class": UI_INPUT}),
            "direction": forms.Select(attrs={"class": UI_SELECT}),
            "description": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 3}),
            "image": PreviewClearableFileInput(attrs={"class": "ui-file"}),
        }
