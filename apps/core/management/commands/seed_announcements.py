import shutil
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand

from apps.accounts.models import User
from apps.announcements.models import Announcement


ANNOUNCEMENTS = [
    {
        "title": "Thông báo lịch bảo trì thang máy tháng này",
        "content": "Kính gửi quý cư dân,\n\nBan quản lý thông báo lịch bảo trì thang máy định kỳ sẽ được thực hiện vào Thứ 7, ngày 20 tháng này từ 8h00 đến 12h00.\n\nXin cảm ơn.",
        "category": "MAINTENANCE",
        "is_pinned": True,
        "image_src": "seed/announcements/announce_1.jpg",
        "image_dest": "announcements/2024/01/announce_1.jpg",
    },
    {
        "title": "Sự kiện Tất niên 2025 — Đêm hội chung cư",
        "content": "Ban quản lý trân trọng kính mời toàn thể quý cư dân tham dự Đêm Tất niên.\n\nThời gian: 18h00 - 22h00\nĐịa điểm: Sân vườn tầng 1.",
        "category": "EVENT",
        "is_pinned": False,
        "image_src": "seed/announcements/announce_2.jpg",
        "image_dest": "announcements/2024/01/announce_2.jpg",
    },
    {
        "title": "Thông báo cúp điện khẩn",
        "content": "Kính thông báo: Điện lực khu vực sẽ tiến hành bảo dưỡng. Điện sẽ bị cúp từ 14h00 đến 17h00 hôm nay.",
        "category": "EMERGENCY",
        "is_pinned": True,
        "image_src": None,
        "image_dest": None,
    },
]


class Command(BaseCommand):
    help = "Seed thông báo mẫu"

    def handle(self, *args, **options):
        media_root = Path(settings.MEDIA_ROOT)
        admin = User.objects.filter(username="admin").first()

        for adata in ANNOUNCEMENTS:
            if Announcement.objects.filter(title=adata["title"]).exists():
                continue

            image_field = None
            if adata.get("image_src"):
                img_src = media_root / adata["image_src"]
                img_dest = media_root / adata["image_dest"]
                img_dest.parent.mkdir(parents=True, exist_ok=True)
                if img_src.exists():
                    shutil.copy2(img_src, img_dest)
                    image_field = adata["image_dest"]

            Announcement.objects.create(
                title=adata["title"],
                content=adata["content"],
                category=adata["category"],
                is_pinned=adata["is_pinned"],
                image=image_field,
                created_by=admin,
            )

        self.stdout.write("Seeded announcements")

