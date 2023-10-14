from django.http import HttpResponse
from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser, Student_Feedback, Student_Leave, Student_Notifications
from app.models import Program, Session_Year, Student
from django.contrib import messages

@login_required(login_url='/')
def HOME(request):
     return render(request, 'Student/Student_home.html')

@login_required(login_url='/')
def NOTIFICATIONS(request):
     student = Student.objects.filter(admin = request.user.id)
     # print(student)
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

@login_required(login_url='/')
def STUDENT_FEEDBACK(request):
    student = Student.objects.filter(admin = request.user.id)
    for i in student:
        # print(i.id)
        student_feedback_history = Student_Feedback.objects.filter(student_id=i.id)

        context = {
            'student_feedback_history': student_feedback_history,

        }

    return render(request, 'Student/feedback.html', context)

@login_required(login_url='/')
def STUDENT_FEEDBACK_SAVE(request):
    if request.method == "POST":
        feedback = request.POST.get('feedback')

        student  = Student.objects.get(admin = request.user.id)
        feedback = Student_Feedback(
            student_id = student,
            feedback = feedback, 
            feedback_reply = "",
        )
        feedback.save()
        messages.success(request, "Successfully Sent the Feedback")
    return redirect('Student_feedback')

@login_required(login_url='/')
def STUDENT_APPLY_LEAVE(request):
    student = Student.objects.filter(admin = request.user.id)
    for i in student:
        # print(i.id)
        student_leave_history = Student_Leave.objects.filter(student_id=i.id)

        context = {
            'student_leave_history': student_leave_history,

        }

    return render(request, 'Student/student_apply_leave.html', context)


@login_required(login_url='/')
def STUDENT_APPLY_LEAVE_SAVE(request):
    if request.method == "POST":
        date = request.POST.get('date')
        message = request.POST.get('message')

        student = Student.objects.get(admin=request.user.id)

        leave = Student_Leave(
            student_id=student,
            date=date,
            message=message,
        )

        leave.save()
        messages.success(request, "You Sent a request to apply for leave")
        return render(request, 'Student/student_apply_leave.html')
    return HttpResponse("Invalid Request")