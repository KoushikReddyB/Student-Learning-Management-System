from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser
from app.models import Program, Session_Year, Student, Staff, Course
from django.contrib import messages

def HOME(request):
     return render(request, 'Staff/Staff_home.html')