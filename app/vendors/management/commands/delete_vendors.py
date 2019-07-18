from django.conf import settings
from django.core.management.base import BaseCommand

from categories.models import SetAside, Pool, Zone
from vendors.models import Vendor, PoolMembership, Contact

class Command(BaseCommand):
    def handle(self, *args, **options):
        print("Processing delete vendors: {}")
        Contact.objects.all().delete()
        PoolMembership.objects.all().delete()
        Vendor.objects.all().delete()
        print("delete vendors completed")
