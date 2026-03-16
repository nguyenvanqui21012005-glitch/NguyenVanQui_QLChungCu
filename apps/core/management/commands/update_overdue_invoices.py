from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.fees.models import Invoice


class Command(BaseCommand):
    help = "Cập nhật hóa đơn quá hạn"

    def handle(self, *args, **options):
        today = timezone.localdate()
        updated = (
            Invoice.objects.filter(status=Invoice.Status.PENDING, due_date__lt=today)
            .update(status=Invoice.Status.OVERDUE)
        )
        self.stdout.write(f"Cập nhật {updated} hóa đơn -> OVERDUE")

