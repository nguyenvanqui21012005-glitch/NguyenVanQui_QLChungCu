from django.forms.widgets import ClearableFileInput


class PreviewClearableFileInput(ClearableFileInput):
    template_name = "widgets/preview_clearable_file_input.html"

