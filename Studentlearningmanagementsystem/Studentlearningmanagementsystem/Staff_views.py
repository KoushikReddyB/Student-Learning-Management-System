from django.http import HttpResponse
from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser, Staff_Feedback, Staff_Leave
from app.models import Program, Session_Year, Student, Staff, Course, Staff_Notifications
from django.contrib import messages

@login_required(login_url='/')
def HOME(request):
     return render(request, 'Staff/Staff_home.html')

@login_required(login_url='/')
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

@login_required(login_url='/')
def STAFF_NOTIFICATION_MARK_AS_DONE(request, status):
    notification = Staff_Notifications.objects.get(id=status)

    if notification.status == 0:
        notification.status = 1
        
        notification.save()
    return redirect('Staff_notifications')


@login_required(login_url='/')
def STAFF_APPLY_LEAVE(request):
    staff = Staff.objects.filter(admin = request.user.id)
    for i in staff:
        # print(i.id)
        staff_leave_history = Staff_Leave.objects.filter(staff_id=i.id)

        context = {
            'staff_leave_history': staff_leave_history,

        }

    return render(request, 'Staff/staff_apply_leave.html', context)


@login_required(login_url='/')
def STAFF_APPLY_LEAVE_SAVE(request):
    if request.method == "POST":
        date = request.POST.get('date')
        message = request.POST.get('message')

        staff = Staff.objects.get(admin=request.user.id)

        leave = Staff_Leave(
            staff_id=staff,
            date=date,
            message=message,
        )

        leave.save()
        messages.success(request, "You Sent a request to apply for leave")
        return render(request, 'Staff/staff_apply_leave.html')
    return HttpResponse("Invalid Request")


@login_required(login_url='/')
def STAFF_FEEDBACK(request):
    staff = Staff.objects.filter(admin = request.user.id)
    for i in staff:
        # print(i.id)
        staff_feedback_history = Staff_Feedback.objects.filter(staff_id=i.id)

        context = {
            'staff_feedback_history': staff_feedback_history,

        }

    return render(request, 'Staff/feedback.html', context)

@login_required(login_url='/')
def STAFF_FEEDBACK_SAVE(request):
    if request.method == "POST":
        feedback = request.POST.get('feedback')

        staff = Staff.objects.get(admin = request.user.id)
        feedback = Staff_Feedback(
            staff_id = staff,
            feedback = feedback, 
            feedback_reply = "",
        )
        feedback.save()
        messages.success(request, "Successfully Sent the Feedback")
    return redirect('Staff_feedback')

def STAFF_TAKE_ATTENDANCE(request):
    staff_id = Staff.objects.get(admin = request.user.id)

    course = Course.objects.filter(staff = staff_id)
    session_year = Session_Year.objects.all()
    action = request.GET.get('action')
    get_course = None
    get_session_year = None
    if action is not None:
        if request.method == 'POST':
            course_id = request.POST.get('course_id')
            session_year_id = request.POST.get('session_year_id')

            get_course = Course.objects.get(id = course_id)
            get_session_year = Session_Year.objects.get(id = session_year_id)
    context = {
        'course': course,
        'session_year': session_year,
        'get_course': get_course,
        'get_session_year': get_session_year,
    }
    return render(request, 'Staff/take_attendance.html', context)