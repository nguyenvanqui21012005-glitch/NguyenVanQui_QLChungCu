from datetime import date

from django.core.management.base import BaseCommand

from apps.accounts.models import User
from apps.fees.models import FeeType, Invoice
from apps.residents.models import Contract


FEE_TYPES = [
    {
        "name": "Phí quản lý",
        "unit": "M2",
        "unit_price": 12000,
        "is_mandatory": True,
        "description": "Phí quản lý chung cư tính theo m²",
    },
    {
        "name": "Phí gửi xe ô tô",
        "unit": "VEHICLE",
        "unit_price": 1200000,
        "is_mandatory": False,
        "description": "Phí giữ xe ô tô hàng tháng",
    },
    {
        "name": "Phí gửi xe máy",
        "unit": "VEHICLE",
        "unit_price": 150000,
        "is_mandatory": False,
        "description": "Phí giữ xe máy hàng tháng",
    },
    {
        "name": "Phí vệ sinh",
        "unit": "MONTH",
        "unit_price": 50000,
        "is_mandatory": True,
        "description": "Phí dịch vụ vệ sinh hàng tháng",
    },
    {
        "name": "Phí thang máy",
        "unit": "MONTH",
        "unit_price": 100000,
        "is_mandatory": True,
        "description": "Phí sử dụng thang máy",
    },
    {
        "name": "Internet cáp quang",
        "unit": "MONTH",
        "unit_price": 200000,
        "is_mandatory": False,
        "description": "Gói internet 100Mbps",
    },
    {
        "name": "Điện",
        "unit": "KWH",
        "unit_price": 3500,
        "is_mandatory": False,
        "description": "Tính theo chỉ số điện kế (đơn giá mẫu)",
    },
    {
        "name": "Nước",
        "unit": "M3",
        "unit_price": 18000,
        "is_mandatory": False,
        "description": "Tính theo chỉ số nước (đơn giá mẫu)",
    },
]


class Command(BaseCommand):
    help = "Seed loại phí và hóa đơn mẫu"

    def handle(self, *args, **options):
        admin = User.objects.filter(username="admin").first()

        for fdata in FEE_TYPES:
            FeeType.objects.get_or_create(name=fdata["name"], defaults=fdata)

        today = date.today()
        management_fee = FeeType.objects.get(name="Phí quản lý")
        cleaning_fee = FeeType.objects.get(name="Phí vệ sinh")
        elevator_fee = FeeType.objects.get(name="Phí thang máy")

        active_contracts = Contract.objects.filter(status=Contract.Status.ACTIVE).select_related("apartment", "resident")
        created = 0

        for contract in active_contracts:
            apt = contract.apartment
            resident = contract.resident

            inv1, c1 = Invoice.objects.get_or_create(
                fee_type=management_fee,
                apartment=apt,
                resident=resident,
                month=today.month,
                year=today.year,
                defaults={
                    "amount": int(apt.area * management_fee.unit_price),
                    "due_date": date(today.year, today.month, 15),
                    "status": Invoice.Status.PENDING,
                    "created_by": admin,
                },
            )
            inv2, c2 = Invoice.objects.get_or_create(
                fee_type=cleaning_fee,
                apartment=apt,
                resident=resident,
                month=today.month,
                year=today.year,
                defaults={
                    "amount": cleaning_fee.unit_price,
                    "due_date": date(today.year, today.month, 15),
                    "status": Invoice.Status.PENDING,
                    "created_by": admin,
                },
            )
            inv3, c3 = Invoice.objects.get_or_create(
                fee_type=elevator_fee,
                apartment=apt,
                resident=resident,
                month=today.month,
                year=today.year,
                defaults={
                    "amount": elevator_fee.unit_price,
                    "due_date": date(today.year, today.month, 15),
                    "status": Invoice.Status.PENDING,
                    "created_by": admin,
                },
            )
            created += int(c1) + int(c2) + int(c3)

        self.stdout.write(f"Created {created} invoices")
