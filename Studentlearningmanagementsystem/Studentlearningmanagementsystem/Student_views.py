from django.http import HttpResponse
from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser, Staff_Feedback, Staff_Leave, Student_Notifications
from app.models import Program, Session_Year, Student, Staff, Course, Staff_Notifications
from django.contrib import messages

@login_required(login_url='/')
def HOME(request):
     return render(request, 'Student/Student_home.html')

@login_required(login_url='/')
def NOTIFICATIONS(request):
     student = Student.objects.filter(admin = request.user.id)
     # print(staff)
     for i in student:
          student_id = i.id
          notification = Student_Notifications.objects.filter(student_id = student_id)

          context = {
               'notification': notification,
          }
     return render(request, 'Student/notifications.html', context)

@login_required(login_url='/')
def STUDENT_NOTIFICATION_MARK_AS_DONE(request, status):
    notification = Student_Notifications.objects.get(id=status)

    if notification.status == 0:
        notification.status = 1
        
        notification.save()
    return redirect('student_notifications')