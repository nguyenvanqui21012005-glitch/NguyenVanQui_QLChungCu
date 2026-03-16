from django.db import models

from apps.accounts.models import User
from apps.core.models import BaseModel


class Announcement(BaseModel):
    class Category(models.TextChoices):
        GENERAL = "GENERAL", "Thông báo chung"
        MAINTENANCE = "MAINTENANCE", "Bảo trì"
        RULE = "RULE", "Nội quy"
        EVENT = "EVENT", "Sự kiện"
        SECURITY = "SECURITY", "An ninh"
        FEE = "FEE", "Phí & thanh toán"
        EMERGENCY = "EMERGENCY", "Khẩn cấp"

    title = models.CharField(max_length=300, verbose_name="Tiêu đề")
    content = models.TextField(verbose_name="Nội dung")
    category = models.CharField(max_length=15, choices=Category.choices, default=Category.GENERAL)
    is_pinned = models.BooleanField(default=False, verbose_name="Ghim")
    image = models.ImageField(upload_to="announcements/%Y/%m/", blank=True, null=True)
    attachment = models.FileField(upload_to="announcements/files/%Y/%m/", blank=True, null=True)
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name="announcements")
    views_count = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = "announcements_announcement"
        verbose_name = "Thông báo"
        ordering = ["-is_pinned", "-created_at"]

    def __str__(self):
        return self.title

