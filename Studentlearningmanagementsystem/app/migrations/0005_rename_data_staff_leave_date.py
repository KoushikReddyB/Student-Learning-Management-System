# Generated by Django 4.2.6 on 2023-10-08 15:18

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0004_staff_leave'),
    ]

    operations = [
        migrations.RenameField(
            model_name='staff_leave',
            old_name='data',
            new_name='date',
        ),
    ]
