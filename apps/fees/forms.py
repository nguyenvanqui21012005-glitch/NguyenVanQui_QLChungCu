from datetime import date

from django import forms

from apps.core.widgets import PreviewClearableFileInput

from .models import FeeType, Invoice, Payment


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class FeeTypeForm(forms.ModelForm):
    class Meta:
        model = FeeType
        fields = ["name", "description", "unit", "unit_price", "is_mandatory", "apply_to_all"]
        widgets = {
            "name": forms.TextInput(attrs={"class": UI_INPUT}),
            "description": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
            "unit": forms.Select(attrs={"class": UI_SELECT}),
            "unit_price": forms.NumberInput(attrs={"class": UI_INPUT}),
        }


class InvoiceForm(forms.ModelForm):
    class Meta:
        model = Invoice
        fields = ["fee_type", "apartment", "resident", "month", "year", "amount", "due_date", "note"]
        widgets = {
            "fee_type": forms.Select(attrs={"class": UI_SELECT}),
            "apartment": forms.Select(attrs={"class": UI_SELECT}),
            "resident": forms.Select(attrs={"class": UI_SELECT}),
            "month": forms.NumberInput(attrs={"class": UI_INPUT}),
            "year": forms.NumberInput(attrs={"class": UI_INPUT}),
            "amount": forms.NumberInput(attrs={"class": UI_INPUT}),
            "due_date": forms.DateInput(attrs={"class": UI_INPUT, "type": "date"}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if not self.initial.get("month"):
            self.initial["month"] = date.today().month
        if not self.initial.get("year"):
            self.initial["year"] = date.today().year


class PaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
        fields = ["amount_paid", "method", "note", "receipt_image"]
        widgets = {
            "amount_paid": forms.NumberInput(attrs={"class": UI_INPUT}),
            "method": forms.Select(attrs={"class": UI_SELECT}),
            "note": forms.Textarea(attrs={"class": UI_TEXTAREA, "rows": 2}),
            "receipt_image": PreviewClearableFileInput(attrs={"class": "ui-file"}),
        }
