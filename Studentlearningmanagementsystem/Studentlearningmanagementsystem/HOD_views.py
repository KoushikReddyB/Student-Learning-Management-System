from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser
from app.models import Course, Session_Year, Student
from django.contrib import messages

@login_required(login_url='/')
def HOME(request):
    return render(request, 'HOD/home.html')

@login_required(login_url='/')
def ADD_STUDENT(request):
    course = Course.objects.all()
    session_year = Session_Year.objects.all()

    if request.method == "POST":
        profile_pic = request.FILES.get('profile_pic')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        address = request.POST.get('address')
        gender = request.POST.get('gender')
        course_id = request.POST.get('course_id')
        session_year_id = request.POST.get('session_year_id')
        
        # print(profile_pic, first_name, last_name, email, password, username, address, gender, course_id, session_year_id)

        if CustomUser.objects.filter(email=email).exists():
            messages.warning(request, 'Email is Already Taken')
            return redirect('add_student')
        if CustomUser.objects.filter(username=username).exists():
            messages.warning(request, 'Username is Already Taken')
            return redirect('add_student')
        else:
            user = CustomUser(
                first_name = first_name,
                last_name = last_name,
                username = username,
                email = email,
                profile_pic = profile_pic,
                user_type = 3
            )
            user.set_password(password)
            user.save()
            course = Course.objects.get(course_code = course_id)
            session_year = Session_Year.objects.get(id = session_year_id)
            Student = Student(
                admin = user, 
                address = address,
                gender = gender, 
                session_year_id = session_year_id,
                course_id = course_id,
            )
            Student.save()
            messages.success(request, 'Successfully Added the Student')
            
    context = {
        'course': course ,
        'session_year': session_year,
    }
    return render(request, 'HOD/add_student.html', context)