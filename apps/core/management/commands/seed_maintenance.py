import random
import shutil
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.accounts.models import User
from apps.buildings.models import Apartment
from apps.maintenance.models import MaintenanceRequest
from apps.residents.models import Resident


ISSUES = [
    ("ELECTRIC", "Đèn hành lang bị chập", "Đèn hành lang tầng 2 chập chờn, cần kiểm tra."),
    ("PLUMBING", "Rò rỉ nước dưới bồn rửa", "Nước rò nhẹ dưới bồn rửa, cần xử lý sớm."),
    ("HVAC", "Máy lạnh không mát", "Máy lạnh chạy nhưng không mát."),
]

IMAGES = [
    ("seed/maintenance/issue_electric.jpg", "maintenance/2024/01/issue_electric.jpg"),
    ("seed/maintenance/issue_water.jpg", "maintenance/2024/01/issue_water.jpg"),
    ("seed/maintenance/issue_hvac.jpg", "maintenance/2024/01/issue_hvac.jpg"),
]


class Command(BaseCommand):
    help = "Seed yêu cầu bảo trì mẫu"

    def handle(self, *args, **options):
        media_root = Path(settings.MEDIA_ROOT)
        staff_users = list(User.objects.filter(profile__role="STAFF", is_active=True))
        residents = list(Resident.objects.all()[:10])
        apartments = list(Apartment.objects.all()[:20])

        if not apartments:
            self.stdout.write("No apartments to seed maintenance.")
            return

        created = 0
        for i in range(min(10, len(apartments))):
            apt = apartments[i]
            resident = residents[i % len(residents)] if residents else None
            category, title, desc = random.choice(ISSUES)

            image_field = None
            src_rel, dest_rel = IMAGES[i % len(IMAGES)]
            src = media_root / src_rel
            dest = media_root / dest_rel
            dest.parent.mkdir(parents=True, exist_ok=True)
            if src.exists():
                shutil.copy2(src, dest)
                image_field = dest_rel

            req = MaintenanceRequest.objects.create(
                resident=resident,
                apartment=apt,
                category=category,
                title=title,
                description=desc,
                priority=random.choice([p[0] for p in MaintenanceRequest.Priority.choices]),
                status=MaintenanceRequest.Status.PENDING,
                image=image_field,
            )

            if staff_users and i % 2 == 0:
                req.assigned_to = staff_users[i % len(staff_users)]
                req.status = MaintenanceRequest.Status.ASSIGNED
                req.assigned_at = timezone.now()
                req.save(update_fields=["assigned_to", "status", "assigned_at"])

            created += 1

        self.stdout.write(f"Seeded {created} maintenance requests")

