import random

from django.core.management.base import BaseCommand

from apps.residents.models import Contract
from apps.vehicles.models import ParkingSlot, Vehicle


class Command(BaseCommand):
    help = "Seed bãi xe và xe mẫu"

    def handle(self, *args, **options):
        for i in range(1, 21):
            ParkingSlot.objects.get_or_create(
                slot_number=f"A{i:03d}",
                defaults={
                    "slot_type": "MOTORBIKE" if i <= 15 else "CAR",
                    "status": "AVAILABLE",
                    "monthly_fee": 150000 if i <= 15 else 1200000,
                },
            )

        active_contracts = list(
            Contract.objects.filter(status=Contract.Status.ACTIVE).select_related("resident", "apartment")[:10]
        )
        slots = list(ParkingSlot.objects.filter(status=ParkingSlot.Status.AVAILABLE)[:10])

        created = 0
        for idx, contract in enumerate(active_contracts):
            license_plate = f"59A-{random.randint(10000, 99999)}"
            slot = slots[idx] if idx < len(slots) else None

            vehicle, was_created = Vehicle.objects.get_or_create(
                license_plate=license_plate,
                defaults={
                    "resident": contract.resident,
                    "apartment": contract.apartment,
                    "vehicle_type": "MOTORBIKE",
                    "parking_slot": slot,
                    "card_number": f"CARD-{random.randint(100000, 999999)}",
                },
            )
            if was_created:
                created += 1
                if slot:
                    slot.status = ParkingSlot.Status.OCCUPIED
                    slot.save(update_fields=["status"])

        self.stdout.write(f"Seeded {created} vehicles")

