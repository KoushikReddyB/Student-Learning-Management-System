from django.http import HttpResponse
from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser, Staff_Feedback, Staff_Leave
from app.models import Program, Session_Year, Student, Staff, Course, Staff_Notifications
from django.contrib import messages

@login_required(login_url='/')
def HOME(request):
     return render(request, 'Student/Student_home.html')