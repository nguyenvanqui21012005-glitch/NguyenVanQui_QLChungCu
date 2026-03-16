import random
from datetime import date, datetime, timedelta
from decimal import Decimal

from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone

from apps.buildings.models import Apartment
from apps.fees.models import FeeType, Invoice, Payment
from apps.residents.models import Contract


def _month_iter(start: date, months_back: int):
    y, m = start.year, start.month
    for i in range(1, months_back + 1):
        mm = m - i
        yy = y
        while mm <= 0:
            mm += 12
            yy -= 1
        yield yy, mm


def _due_date_for(year: int, month: int):
    return date(year, month, 15)


def _aware(dt: datetime):
    try:
        return timezone.make_aware(dt)
    except Exception:
        return dt


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument("--months", type=int, default=12)
        parser.add_argument("--dry-run", action="store_true")
        parser.add_argument("--seed", type=int, default=42)

    @transaction.atomic
    def handle(self, *args, **options):
        random.seed(int(options["seed"]))
        months = int(options["months"])
        dry_run = bool(options["dry_run"])

        fee_types = list(FeeType.objects.filter(is_mandatory=True).order_by("id"))
        if not fee_types:
            self.stdout.write(self.style.ERROR("Không có FeeType bắt buộc. Hãy seed fee trước."))
            return

        contracts = (
            Contract.objects.filter(status=Contract.Status.ACTIVE)
            .select_related("apartment", "resident")
            .order_by("id")
        )
        contract_by_apartment = {c.apartment_id: c for c in contracts}

        apartments = list(
            Apartment.objects.filter(id__in=contract_by_apartment.keys()).select_related("floor").order_by("id")
        )
        if not apartments:
            self.stdout.write(self.style.ERROR("Không có căn hộ có hợp đồng ACTIVE để seed hóa đơn lịch sử."))
            return

        staff_user = None
        try:
            from apps.accounts.models import User

            staff_user = User.objects.filter(profile__role="ADMIN").order_by("id").first()
        except Exception:
            staff_user = None

        created_invoices = 0
        created_payments = 0

        today = timezone.localdate()
        for year, month in _month_iter(today, months_back=months):
            due = _due_date_for(year, month)
            for apt in apartments:
                c = contract_by_apartment.get(apt.id)
                if not c:
                    continue
                resident = c.resident

                for ft in fee_types:
                    exists = Invoice.objects.filter(
                        fee_type=ft, apartment=apt, month=month, year=year
                    ).exists()
                    if exists:
                        continue

                    if ft.unit == FeeType.Unit.M2:
                        amount = (Decimal(apt.area or 0) * Decimal(ft.unit_price or 0)).quantize(Decimal("1"))
                    else:
                        amount = Decimal(ft.unit_price or 0)

                    inv = Invoice(
                        fee_type=ft,
                        apartment=apt,
                        resident=resident,
                        month=month,
                        year=year,
                        amount=amount,
                        due_date=due,
                        status=Invoice.Status.PENDING,
                    )

                    if not dry_run:
                        inv.save()
                    created_invoices += 1

                    r = random.random()
                    if r < 0.65:
                        paid_at = _aware(datetime.combine(due - timedelta(days=random.randint(0, 5)), datetime.min.time()))
                        p = Payment(
                            invoice=inv,
                            amount_paid=amount,
                            paid_at=paid_at,
                            method=Payment.Method.CASH,
                            received_by=staff_user,
                        )
                        if not dry_run:
                            p.save()
                        created_payments += 1
                    elif r < 0.85:
                        paid_at = _aware(datetime.combine(due + timedelta(days=random.randint(1, 20)), datetime.min.time()))
                        p = Payment(
                            invoice=inv,
                            amount_paid=amount,
                            paid_at=paid_at,
                            method=Payment.Method.TRANSFER,
                            received_by=staff_user,
                        )
                        if not dry_run:
                            p.save()
                        created_payments += 1
                    elif r < 0.95:
                        first = (amount * Decimal("0.5")).quantize(Decimal("1"))
                        paid1 = _aware(datetime.combine(due - timedelta(days=random.randint(0, 3)), datetime.min.time()))
                        paid2 = _aware(datetime.combine(due + timedelta(days=random.randint(5, 25)), datetime.min.time()))
                        p1 = Payment(
                            invoice=inv,
                            amount_paid=first,
                            paid_at=paid1,
                            method=Payment.Method.CASH,
                            received_by=staff_user,
                        )
                        p2 = Payment(
                            invoice=inv,
                            amount_paid=(amount - first),
                            paid_at=paid2,
                            method=Payment.Method.CASH,
                            received_by=staff_user,
                        )
                        if not dry_run:
                            p1.save()
                            p2.save()
                        created_payments += 2

        if dry_run:
            transaction.set_rollback(True)

        msg = f"Invoices: {created_invoices} | Payments: {created_payments}"
        if dry_run:
            msg += " | dry-run"
        self.stdout.write(self.style.SUCCESS(msg))

