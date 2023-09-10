# Generated by Django 4.2.4 on 2023-09-10 03:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0003_alter_customuser_user_type'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='user_type',
            field=models.CharField(choices=[(1, 'HOD'), (2, 'STAFF'), (3, 'STUDENT')], default=1, max_length=50),
        ),
    ]