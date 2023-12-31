from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin
# Register your models here.

class UserModel(UserAdmin):
    list_display = ['username', 'user_type']
admin.site.register(CustomUser, UserModel)
admin.site.register(Course)
admin.site.register(Session_Year)
admin.site.register(Student)
admin.site.register(Program)
admin.site.register(Staff)
# admin.site.register(CustomUser)
admin.site.register(Staff_Notifications)
admin.site.register(Staff_Leave)
admin.site.register(Staff_Feedback)
admin.site.register(Student_Notifications)
admin.site.register(Student_Feedback)
admin.site.register(Student_Leave)
admin.site.register(Attendance)
admin.site.register(Attendance_Report)