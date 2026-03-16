from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.residents.models import Contract


class Command(BaseCommand):
    help = "Tự động mark hợp đồng hết hạn"

    def handle(self, *args, **options):
        today = timezone.localdate()
        expired = Contract.objects.filter(status=Contract.Status.ACTIVE, end_date__lt=today)
        count = expired.count()
        for contract in expired:
            contract.expire()
        self.stdout.write(f"Đã expire {count} hợp đồng")

