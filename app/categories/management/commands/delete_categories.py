from django.conf import settings
from django.core.management.base import BaseCommand
from django.core.management import call_command

from categories.models import Keyword

class Command(BaseCommand):
    def handle(self, *args, **options):
        print("Deleating keywords")
        Keyword.objects.all().delete()
        
       