from django.core.management import call_command
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = "Seed toàn bộ dữ liệu mẫu"

    def handle(self, *args, **options):
        self.stdout.write("Bắt đầu seed data...")

        commands = [
            "seed_images",
            "seed_users",
            "seed_buildings",
            "seed_residents",
            "seed_fees",
            "seed_maintenance",
            "seed_vehicles",
            "seed_announcements",
            "seed_visitors",
        ]

        for cmd in commands:
            self.stdout.write(f"  -> Running {cmd}...")
            call_command(cmd)

        self.stdout.write(self.style.SUCCESS("Seed data hoàn thành!"))
        self.stdout.write("")
        self.stdout.write("Tài khoản đăng nhập:")
        self.stdout.write("  Admin:  admin / Admin@123")
        self.stdout.write("  Staff:  staff01 / Staff@123")

