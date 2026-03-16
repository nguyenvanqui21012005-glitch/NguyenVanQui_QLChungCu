import shutil
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand

from apps.accounts.models import User
from apps.buildings.models import Apartment, Building, Floor


BUILDINGS_DATA = [
    {
        "name": "Tòa A - Sapphire Tower",
        "address": "123 Nguyễn Hữu Thọ, Quận 7, TP.HCM",
        "total_floors": 20,
        "built_year": 2018,
        "description": "Tòa nhà cao cấp 20 tầng với đầy đủ tiện ích",
        "image_src": "seed/buildings/building_1.jpg",
        "image_dest": "buildings/2024/01/building_1.jpg",
        "phone": "028-1234-5678",
        "email": "toaa@sapphiretower.com",
        "floors": [
            {
                "floor_number": i,
                "apartments": [
                    {
                        "apartment_number": f"{i:02d}{j:02d}",
                        "area": [45.5, 52.0, 68.5, 75.0, 90.0][j % 5],
                        "bedroom_count": [1, 1, 2, 2, 3][j % 5],
                        "bathroom_count": [1, 1, 2, 2, 2][j % 5],
                        "status": "OCCUPIED" if (i * 4 + j) % 3 != 0 else "AVAILABLE",
                        "rent_price": [6000000, 7000000, 10000000, 12000000, 15000000][j % 5],
                        "direction": ["N", "S", "E", "W"][j % 4],
                        "balcony": j % 2 == 0,
                        "furniture_included": j % 3 == 0,
                        "image_src": f"seed/apartments/apt_{(j % 5) + 1}.jpg",
                        "image_dest": f"apartments/2024/01/apt_{i}_{j}.jpg",
                    }
                    for j in range(1, 5)
                ],
            }
            for i in range(1, 6)
        ],
    },
    {
        "name": "Tòa B - Emerald Heights",
        "address": "456 Lê Văn Lương, Quận 7, TP.HCM",
        "total_floors": 15,
        "built_year": 2020,
        "description": "Tòa nhà hiện đại 15 tầng, view sông tuyệt đẹp",
        "image_src": "seed/buildings/building_2.jpg",
        "image_dest": "buildings/2024/01/building_2.jpg",
        "phone": "028-9876-5432",
        "email": "toab@emeraldheights.com",
        "floors": [
            {
                "floor_number": i,
                "apartments": [
                    {
                        "apartment_number": f"B{i:02d}{j:02d}",
                        "area": [55.0, 65.0, 80.0][j % 3],
                        "bedroom_count": [2, 2, 3][j % 3],
                        "bathroom_count": [1, 2, 2][j % 3],
                        "status": "AVAILABLE" if (i + j) % 4 == 0 else "OCCUPIED",
                        "rent_price": [8000000, 10000000, 14000000][j % 3],
                        "direction": ["NE", "SW", "NW"][j % 3],
                        "balcony": True,
                        "furniture_included": j % 2 == 0,
                        "image_src": f"seed/apartments/apt_{(j % 5) + 1}.jpg",
                        "image_dest": f"apartments/2024/01/apt_b{i}_{j}.jpg",
                    }
                    for j in range(1, 4)
                ],
            }
            for i in range(1, 5)
        ],
    },
]


class Command(BaseCommand):
    help = "Seed tòa nhà, tầng, căn hộ"

    def handle(self, *args, **options):
        media_root = Path(settings.MEDIA_ROOT)
        admin_user = User.objects.filter(username="admin").first()

        for bdata in BUILDINGS_DATA:
            img_src = media_root / bdata["image_src"]
            img_dest = media_root / bdata["image_dest"]
            img_dest.parent.mkdir(parents=True, exist_ok=True)
            if img_src.exists():
                shutil.copy2(img_src, img_dest)

            building, created = Building.objects.get_or_create(
                name=bdata["name"],
                defaults={
                    "address": bdata["address"],
                    "total_floors": bdata["total_floors"],
                    "built_year": bdata["built_year"],
                    "description": bdata["description"],
                    "image": bdata["image_dest"] if img_src.exists() else None,
                    "manager": admin_user,
                    "phone": bdata["phone"],
                    "email": bdata["email"],
                },
            )

            if not created:
                continue

            for fdata in bdata["floors"]:
                floor = Floor.objects.create(
                    building=building,
                    floor_number=fdata["floor_number"],
                    name=f"Tầng {fdata['floor_number']}",
                )

                for adata in fdata["apartments"]:
                    apt_img_src = media_root / adata["image_src"]
                    apt_img_dest = media_root / adata["image_dest"]
                    apt_img_dest.parent.mkdir(parents=True, exist_ok=True)
                    if apt_img_src.exists():
                        shutil.copy2(apt_img_src, apt_img_dest)

                    Apartment.objects.create(
                        floor=floor,
                        apartment_number=adata["apartment_number"],
                        area=adata["area"],
                        bedroom_count=adata["bedroom_count"],
                        bathroom_count=adata["bathroom_count"],
                        status=adata["status"],
                        rent_price=adata["rent_price"],
                        direction=adata["direction"],
                        balcony=adata["balcony"],
                        furniture_included=adata["furniture_included"],
                        image=adata["image_dest"] if apt_img_src.exists() else None,
                    )

        self.stdout.write(f"Buildings: {Building.objects.count()}, Apartments: {Apartment.objects.count()}")

