from django import forms
from django.contrib.auth.forms import PasswordChangeForm

from .models import User, UserProfile


UI_INPUT = "ui-input"
UI_SELECT = "ui-select"
UI_TEXTAREA = "ui-textarea"


class LoginForm(forms.Form):
    username = forms.CharField(
        max_length=150,
        widget=forms.TextInput(attrs={"placeholder": "Tên đăng nhập", "class": UI_INPUT}),
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={"placeholder": "Mật khẩu", "class": UI_INPUT})
    )


class UserProfileForm(forms.ModelForm):
    first_name = forms.CharField(max_length=50, required=True, label="Tên")
    last_name = forms.CharField(max_length=50, required=True, label="Họ")
    email = forms.EmailField(required=False, label="Email")

    class Meta:
        model = UserProfile
        fields = ["phone", "date_of_birth", "gender", "address", "note"]
        widgets = {
            "date_of_birth": forms.DateInput(attrs={"type": "date"}),
            "address": forms.Textarea(attrs={"rows": 2}),
            "note": forms.Textarea(attrs={"rows": 2}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.instance and getattr(self.instance, "user_id", None):
            self.fields["first_name"].initial = self.instance.user.first_name
            self.fields["last_name"].initial = self.instance.user.last_name
            self.fields["email"].initial = self.instance.user.email

        for field in self.fields.values():
            if isinstance(field.widget, forms.Select):
                field.widget.attrs["class"] = UI_SELECT
            elif isinstance(field.widget, forms.Textarea):
                field.widget.attrs["class"] = UI_TEXTAREA
            else:
                field.widget.attrs["class"] = UI_INPUT


class ChangePasswordForm(PasswordChangeForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs["class"] = UI_INPUT

        self.fields["old_password"].label = "Mật khẩu hiện tại"
        self.fields["new_password1"].label = "Mật khẩu mới"
        self.fields["new_password2"].label = "Xác nhận mật khẩu mới"


class StaffCreateForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput(), min_length=8, label="Mật khẩu")
    phone = forms.CharField(max_length=15, required=False)
    gender = forms.ChoiceField(choices=[("", "---")] + list(UserProfile.Gender.choices), required=False)

    class Meta:
        model = User
        fields = ["username", "first_name", "last_name", "email"]
        labels = {
            "username": "Tên đăng nhập",
            "first_name": "Tên",
            "last_name": "Họ",
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            if isinstance(field.widget, forms.Select):
                field.widget.attrs["class"] = UI_SELECT
            elif isinstance(field.widget, forms.Textarea):
                field.widget.attrs["class"] = UI_TEXTAREA
            else:
                field.widget.attrs["class"] = UI_INPUT

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password"])
        if commit:
            user.save()
            profile, _ = UserProfile.objects.get_or_create(user=user)
            profile.role = UserProfile.Role.STAFF
            profile.phone = self.cleaned_data.get("phone") or ""
            profile.gender = self.cleaned_data.get("gender") or ""
            profile.save()
        return user
