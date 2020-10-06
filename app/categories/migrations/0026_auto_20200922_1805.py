# Generated by Django 2.2.13 on 2020-09-22 18:05

from django.db import migrations


def remove_pss(apps, scheme_editor):
    model = apps.get_model('categories', 'vehicle')
    model.objects.filter(id='PSS').delete()
    
    model = apps.get_model('categories', 'pool')
    model.objects.filter(id='PSS').delete()



class Migration(migrations.Migration):

    dependencies = [
        ('vendors', '0041_auto_20200923_1539'),
        ('categories', '0024_auto_20180918_1959'),

    ]

    operations = [
    	migrations.RunPython(remove_pss)
    ]

