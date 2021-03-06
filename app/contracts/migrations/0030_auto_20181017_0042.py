# Generated by Django 2.0.9 on 2018-10-17 00:34

from django.db import migrations, models

from contracts.models import Agency

import django.db.models.deletion


def migrate_agencies(apps, schema_editor):
    Contract = apps.get_model('contracts', 'Contract')
    
    for contract in Contract.objects.all().iterator():
        if contract.agency_id_backup:
            agency, created = Agency.objects.get_or_create(id = contract.agency_id_backup)
            agency.name = contract.agency_name
            agency.save()
        
        contract.agency_id = contract.agency_id_backup
        contract.save()


class Migration(migrations.Migration):

    dependencies = [
        ('contracts', '0029_auto_20181017_0034'),
    ]

    operations = [
        migrations.AddField(
            model_name='contract',
            name='agency',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='contracts.Agency'),
        ),
        migrations.RunPython(migrate_agencies),
        migrations.RemoveField(
            model_name='contract',
            name='agency_id_backup',
        ),
        migrations.RemoveField(
            model_name='contract',
            name='agency_name',
        ),
    ]
