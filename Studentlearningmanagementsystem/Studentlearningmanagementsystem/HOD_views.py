from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required

@login_required(login_url='/')
def HOME(request):
    return render(request, 'HOD/home.html')

@login_required(login_url='/')
def ADD_STUDENT(request):
    return render(request, 'HOD/add_student.html')