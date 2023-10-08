from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser
from app.models import Program, Session_Year, Student, Staff, Course, Staff_Notifications
from django.contrib import messages

def HOME(request):
     return render(request, 'Staff/Staff_home.html')

def NOTIFICATIONS(request):
     staff = Staff.objects.filter(admin = request.user.id)
     # print(staff)
     for i in staff:
          staff_id = i.id
          notification = Staff_Notifications.objects.filter(staff_id = staff_id)

          context = {
               'notification': notification,
          }
     return render(request, 'Staff/notifications.html', context)