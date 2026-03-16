from pathlib import Path

import requests
from django.conf import settings
from django.core.management.base import BaseCommand


IMAGES = {
    "buildings/building_1.jpg": "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800",
    "buildings/building_2.jpg": "https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800",
    "buildings/building_3.jpg": "https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800",
    "apartments/apt_1.jpg": "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800",
    "apartments/apt_2.jpg": "https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800",
    "apartments/apt_3.jpg": "https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800",
    "apartments/apt_4.jpg": "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800",
    "apartments/apt_5.jpg": "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800",
    "avatars/resident_m1.jpg": "https://randomuser.me/api/portraits/men/32.jpg",
    "avatars/resident_m2.jpg": "https://randomuser.me/api/portraits/men/45.jpg",
    "avatars/resident_m3.jpg": "https://randomuser.me/api/portraits/men/67.jpg",
    "avatars/resident_m4.jpg": "https://randomuser.me/api/portraits/men/12.jpg",
    "avatars/resident_m5.jpg": "https://randomuser.me/api/portraits/men/88.jpg",
    "avatars/resident_f1.jpg": "https://randomuser.me/api/portraits/women/32.jpg",
    "avatars/resident_f2.jpg": "https://randomuser.me/api/portraits/women/45.jpg",
    "avatars/resident_f3.jpg": "https://randomuser.me/api/portraits/women/67.jpg",
    "avatars/resident_f4.jpg": "https://randomuser.me/api/portraits/women/12.jpg",
    "avatars/resident_f5.jpg": "https://randomuser.me/api/portraits/women/88.jpg",
    "avatars/admin.jpg": "https://randomuser.me/api/portraits/men/1.jpg",
    "avatars/staff_01.jpg": "https://randomuser.me/api/portraits/women/1.jpg",
    "avatars/staff_02.jpg": "https://randomuser.me/api/portraits/men/2.jpg",
    "maintenance/issue_electric.jpg": "https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=600",
    "maintenance/issue_water.jpg": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600",
    "maintenance/issue_hvac.jpg": "https://images.unsplash.com/photo-1598023696416-0193a0bcd302?w=600",
    "announcements/announce_1.jpg": "https://images.unsplash.com/photo-1497366216548-37526070297c?w=800",
    "announcements/announce_2.jpg": "https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=800",
}


class Command(BaseCommand):
    help = "Download ảnh seed từ internet về local"

    def handle(self, *args, **options):
        seed_dir = Path(settings.MEDIA_ROOT) / "seed"
        headers = {"User-Agent": "Mozilla/5.0"}

        success = 0
        failed = 0

        for rel_path, url in IMAGES.items():
            dest = seed_dir / rel_path
            dest.parent.mkdir(parents=True, exist_ok=True)

            if dest.exists():
                success += 1
                continue

            try:
                resp = requests.get(url, timeout=15, headers=headers)
                resp.raise_for_status()
                dest.write_bytes(resp.content)
                success += 1
            except Exception:
                failed += 1

        self.stdout.write(f"Images: {success} OK, {failed} failed")

