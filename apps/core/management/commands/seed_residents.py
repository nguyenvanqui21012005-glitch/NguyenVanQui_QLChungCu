import random
import shutil
from datetime import date, timedelta
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand

from apps.accounts.models import User
from apps.buildings.models import Apartment
from apps.residents.models import Contract, Resident


RESIDENTS_DATA = [
    {
        "full_name": "Nguyễn Văn Anh",
        "id_number": "001234567890",
        "phone": "0901111111",
        "email": "nguyenvananh@gmail.com",
        "gender": "M",
        "date_of_birth": date(1990, 3, 15),
        "hometown": "Hà Nội",
        "avatar_src": "seed/avatars/resident_m1.jpg",
    },
    {
        "full_name": "Trần Thị Bích",
        "id_number": "002345678901",
        "phone": "0902222222",
        "email": "tranthibich@gmail.com",
        "gender": "F",
        "date_of_birth": date(1988, 7, 22),
        "hometown": "TP.HCM",
        "avatar_src": "seed/avatars/resident_f1.jpg",
    },
    {
        "full_name": "Lê Văn Cường",
        "id_number": "003456789012",
        "phone": "0903333333",
        "email": "levancuong@gmail.com",
        "gender": "M",
        "date_of_birth": date(1992, 1, 8),
        "hometown": "Đà Nẵng",
        "avatar_src": "seed/avatars/resident_m2.jpg",
    },
    {
        "full_name": "Phạm Thị Dung",
        "id_number": "004567890123",
        "phone": "0904444444",
        "email": "phamthidung@gmail.com",
        "gender": "F",
        "date_of_birth": date(1995, 11, 30),
        "hometown": "Cần Thơ",
        "avatar_src": "seed/avatars/resident_f2.jpg",
    },
    {
        "full_name": "Hoàng Văn Em",
        "id_number": "005678901234",
        "phone": "0905555555",
        "email": "hoangvanem@gmail.com",
        "gender": "M",
        "date_of_birth": date(1987, 5, 19),
        "hometown": "Huế",
        "avatar_src": "seed/avatars/resident_m3.jpg",
    },
]


class Command(BaseCommand):
    help = "Seed cư dân và hợp đồng"

    def handle(self, *args, **options):
        media_root = Path(settings.MEDIA_ROOT)
        admin_user = User.objects.filter(username="admin").first()

        occupied_apartments = list(Apartment.objects.filter(status="OCCUPIED").order_by("?"))

        created_count = 0
        for i, rdata in enumerate(RESIDENTS_DATA):
            avatar_src = media_root / rdata["avatar_src"]
            avatar_dest_path = f"residents/2024/01/resident_{i+1}.jpg"
            avatar_dest = media_root / avatar_dest_path
            avatar_dest.parent.mkdir(parents=True, exist_ok=True)

            if avatar_src.exists():
                shutil.copy2(avatar_src, avatar_dest)

            resident, created = Resident.objects.get_or_create(
                id_number=rdata["id_number"],
                defaults={
                    "full_name": rdata["full_name"],
                    "phone": rdata["phone"],
                    "email": rdata["email"],
                    "gender": rdata["gender"],
                    "date_of_birth": rdata["date_of_birth"],
                    "hometown": rdata["hometown"],
                    "avatar": avatar_dest_path if avatar_src.exists() else None,
                    "emergency_contact_name": f"Liên hệ khẩn - {rdata['full_name']}",
                    "emergency_contact_phone": f"09{random.randint(10000000, 99999999)}",
                },
            )

            if created:
                created_count += 1

            if i < len(occupied_apartments):
                apt = occupied_apartments[i]
                if Contract.objects.filter(apartment=apt, status=Contract.Status.ACTIVE).exists():
                    continue

                start = date.today() - timedelta(days=random.randint(30, 365))
                end = start + timedelta(days=365)

                Contract.objects.create(
                    resident=resident,
                    apartment=apt,
                    start_date=start,
                    end_date=end,
                    rent_amount=apt.rent_price,
                    deposit=apt.rent_price * 2,
                    status=Contract.Status.ACTIVE,
                    created_by=admin_user,
                )

        self.stdout.write(f"Seeded {created_count} residents")

