# Generated by Django 4.2.6 on 2023-10-14 20:20

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0007_staff_feedback'),
    ]

    operations = [
        migrations.CreateModel(
            name='Student_Notifications',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('message', models.TextField()),
                ('status', models.IntegerField(default=0, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('student_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.student')),
            ],
            options={
                'db_table': 'student_notification_table',
            },
        ),
    ]
