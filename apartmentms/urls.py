from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.urls import include, path, re_path
from django.views.generic import RedirectView


urlpatterns = [
    re_path(r"^$", RedirectView.as_view(pattern_name="login", permanent=False)),
    path("admin/", admin.site.urls),
    path("", include("apps.accounts.urls")),
    path("", include("apps.buildings.urls")),
    path("", include("apps.residents.urls")),
    path("", include("apps.fees.urls")),
    path("", include("apps.maintenance.urls")),
    path("", include("apps.vehicles.urls")),
    path("", include("apps.announcements.urls")),
    path("", include("apps.visitors.urls")),
    path("", include("apps.reports.urls")),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
