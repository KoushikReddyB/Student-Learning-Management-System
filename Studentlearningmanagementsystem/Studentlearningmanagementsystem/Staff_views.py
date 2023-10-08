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

def STAFF_NOTIFICATION_MARK_AS_DONE(request, status):
    notification = Staff_Notifications.objects.get(id=status)

    if notification.status == 0:
        notification.status = 1
        
        notification.save()
    return redirect('Staff_notifications')

def STAFF_APPLY_LEAVE(request):
    
    return render(request, 'Hod/staff_apply_leave.html')