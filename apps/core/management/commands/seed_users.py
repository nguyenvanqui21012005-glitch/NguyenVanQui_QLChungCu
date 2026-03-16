import shutil
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand

from apps.accounts.models import User, UserProfile


USERS_DATA = [
    {
        "username": "admin",
        "password": "Admin@123",
        "first_name": "Nguyễn",
        "last_name": "Văn Admin",
        "email": "admin@apartmentms.com",
        "role": "ADMIN",
        "phone": "0901234567",
        "gender": "M",
        "avatar_src": "seed/avatars/admin.jpg",
        "avatar_dest": "avatars/2024/01/admin.jpg",
    },
    {
        "username": "staff01",
        "password": "Staff@123",
        "first_name": "Trần",
        "last_name": "Thị Staff",
        "email": "staff01@apartmentms.com",
        "role": "STAFF",
        "phone": "0912345678",
        "gender": "F",
        "avatar_src": "seed/avatars/staff_01.jpg",
        "avatar_dest": "avatars/2024/01/staff01.jpg",
    },
    {
        "username": "staff02",
        "password": "Staff@123",
        "first_name": "Lê",
        "last_name": "Văn Bảo",
        "email": "staff02@apartmentms.com",
        "role": "STAFF",
        "phone": "0923456789",
        "gender": "M",
        "avatar_src": "seed/avatars/staff_02.jpg",
        "avatar_dest": "avatars/2024/01/staff02.jpg",
    },
]


class Command(BaseCommand):
    help = "Seed tài khoản người dùng"

    def handle(self, *args, **options):
        media_root = Path(settings.MEDIA_ROOT)

        for data in USERS_DATA:
            user, created = User.objects.get_or_create(
                username=data["username"],
                defaults={
                    "email": data["email"],
                    "first_name": data["first_name"],
                    "last_name": data["last_name"],
                    "is_staff": data["role"] == "ADMIN",
                    "is_superuser": data["role"] == "ADMIN",
                },
            )

            if created:
                user.set_password(data["password"])
                user.save()
                self.stdout.write(f"  Created user: {user.username}")
            else:
                self.stdout.write(f"  Skip user: {user.username}")
                continue

            avatar_src = media_root / data["avatar_src"]
            avatar_dest = media_root / data["avatar_dest"]
            avatar_dest.parent.mkdir(parents=True, exist_ok=True)

            avatar_field = None
            if avatar_src.exists():
                shutil.copy2(avatar_src, avatar_dest)
                avatar_field = data["avatar_dest"]

            profile, _ = UserProfile.objects.get_or_create(user=user)
            profile.role = data["role"]
            profile.phone = data["phone"]
            profile.gender = data["gender"]
            if avatar_field:
                profile.avatar = avatar_field
            profile.save()

        self.stdout.write(f"Seeded {len(USERS_DATA)} users")

