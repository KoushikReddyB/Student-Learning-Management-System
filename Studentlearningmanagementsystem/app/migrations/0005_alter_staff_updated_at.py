# Generated by Django 4.2.5 on 2023-09-15 11:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0004_course'),
    ]

    operations = [
        migrations.AlterField(
            model_name='staff',
            name='updated_at',
            field=models.DateTimeField(auto_now_add=True),
        ),
    ]
