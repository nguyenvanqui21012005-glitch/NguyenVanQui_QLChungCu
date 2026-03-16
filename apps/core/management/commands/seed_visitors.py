import random
from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.accounts.models import User
from apps.buildings.models import Apartment
from apps.residents.models import Resident
from apps.visitors.models import Visitor


class Command(BaseCommand):
    help = "Seed khách thăm mẫu"

    def handle(self, *args, **options):
        staff = User.objects.filter(profile__role="STAFF").first()
        apartments = list(Apartment.objects.all()[:10])
        residents = list(Resident.objects.all()[:10])
        if not apartments:
            self.stdout.write("No apartments to seed visitors.")
            return

        names = ["Nguyễn Minh", "Trần Hương", "Lê Quốc", "Phạm An", "Hoàng Vy"]
        created = 0
        for i in range(10):
            visit_apartment = apartments[i % len(apartments)]
            resident = residents[i % len(residents)] if residents else None
            Visitor.objects.create(
                full_name=f"{random.choice(names)} {random.randint(1, 99)}",
                id_number=str(random.randint(100000000000, 999999999999)),
                phone=f"09{random.randint(10000000, 99999999)}",
                visit_apartment=visit_apartment,
                resident=resident,
                purpose="Thăm cư dân",
                registered_by=staff,
                note=None,
                check_in=timezone.now(),
            )
            created += 1

        self.stdout.write(f"Seeded {created} visitors")

