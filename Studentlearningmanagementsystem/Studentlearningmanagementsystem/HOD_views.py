from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from app.models import CustomUser
from app.models import Program, Session_Year, Student, Staff, Course
from django.contrib import messages

@login_required(login_url='/')
def HOME(request):
    return render(request, 'HOD/home.html')

@login_required(login_url='/')
def ADD_STUDENT(request):
    program = Program.objects.all()
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
        program_id = request.POST.get('program_id')
        session_year_id = request.POST.get('session_year_id')

        if CustomUser.objects.filter(email=email).exists():
           messages.warning(request,'Email Is Already Taken')
           return redirect('add_student')
        if CustomUser.objects.filter(username=username).exists():
           messages.warning(request,'Username Is Already Taken')
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

            program = Program.objects.get(id=program_id)
            session_year = Session_Year.objects.get(id=session_year_id)

            student = Student(
                admin = user,
                address = address,
                session_year_id = session_year,
                program_id = program,
                gender = gender,
            )
            student.save()
            messages.success(request, user.first_name + "  " + user.last_name + " is Successfully Added !")
            return redirect('add_student')



    context = {
        'program':program,
        'session_year':session_year,
    }

    return render(request,'Hod/add_student.html',context)


@login_required(login_url='/')
def VIEW_STUDENT(request):
    student = Student.objects.all()
    # print(student)
    context = {
        'student': student,
    }
    return render(request, 'Hod/view_student.html', context)


@login_required(login_url='/')
def EDIT_STUDENT(request, id):
    student = Student.objects.filter(id = id)
    program = Program.objects.all()
    session = Session_Year.objects.all()
    context = {
        'student':student,
        'program': program,
        'session': session,
    }
    return render(request, 'Hod/edit_student.html', context)


@login_required(login_url='/')
def UPDATE_STUDENT(request):
    if request.method == 'POST':
        student_id = request.POST.get('student_id')
        # print(student_id)
        profile_pic = request.FILES.get('profile_pic')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        address = request.POST.get('address')
        gender = request.POST.get('gender')
        program_id = request.POST.get('program_id')
        session_year_id = request.POST.get('session_year_id')

        user = CustomUser.objects.get(id = student_id)
        user.profile_pic = profile_pic
        user.first_name = first_name
        user.last_name = last_name
        user.email = email
        user.username = username
        
        if password != None and password != "":
            user.set_password(password)
        if profile_pic != None and profile_pic != "":
            user.profile_pic = profile_pic
        user.save()

        student = Student.objects.get(admin = student_id)
        student.address = address
        student.gender = gender

        program = Program.objects.get(id = program_id)
        student.program_id = program 

        session_year = Session_Year.objects.get( id = session_year_id)
        student.session_year_id = session_year

        student.save()
        messages.success(request, "Records are sucessfully Updated !")
        return redirect('view_student')
    
    return render(request, 'Hod/edit_student.html')


@login_required(login_url='/')
def DELETE_STUDENT(request, admin):
    student = CustomUser.objects.get(id = admin)
    student.delete()

    messages.success(request, 'Record is Successfully Deleted!')
    return redirect('view_student')

@login_required(login_url='/')
def ADD_PROGRAM(request):
    if request.method == 'POST':
        program_name = request.POST.get('name')

        program = Program(
            name  = program_name,
        )
        program.save()
        messages.success(request, 'Record is Created Successfully!')
        return redirect('add_program')
    return render(request, 'Hod/add_program.html')


@login_required(login_url='/')
def VIEW_PROGRAM(request):
    program = Program.objects.all()
    # print(program)
    context = {
        'program': program,
    }
    return render(request, 'Hod/view_program.html', context)


@login_required(login_url='/')
def EDIT_PROGRAM(request, id):
    program = Program.objects.get(id=id)

    context = {
        'program': program,
    }
    return render(request, 'Hod/edit_program.html', context)


@login_required(login_url='/')
def UPDATE_PROGRAM(request):
    if request.method == "POST":
        name = request.POST.get('name')
        program_id = request.POST.get('program_id')

        program = Program.objects.get(id = program_id)
        program.name = name 
        program.save()
        messages.success(request, 'Record is Successfully Updated! ')
        return redirect('view_program')
    return render(request, 'view_program.html')


@login_required(login_url='/')
def DELETE_PROGRAM(request, id):
    program = Program.objects.get(id = id)
    program.delete()
    messages.success(request, "Record is Successfully Purged!")

    return redirect('view_program')

@login_required(login_url='/')
def ADD_STAFF(request):
    if request.method=="POST":
        profile_pic = request.FILES.get('profile_pic')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        address = request.POST.get('address')
        gender = request.POST.get('gender')
        desgination = request.POST.get('desgination')

        if CustomUser.objects.filter(email=email).exists():
           messages.warning(request,'Email Is Already Taken')
           return redirect('add_staff')
        if CustomUser.objects.filter(username=username).exists():
           messages.warning(request,'Email Is Already Taken')
           return redirect('add_staff')
        
        else:
            user = CustomUser(
                first_name = first_name,
                last_name = last_name,
                username = username,
                email = email,
                profile_pic = profile_pic,
                user_type = 2
            )
            user.set_password(password)
            user.save()

            staff = Staff(
                admin = user,
                address = address,
                desgination = desgination,
                gender = gender,
            )
            staff.save()
            messages.success(request, user.first_name + " " + user.last_name + " is Successfully Added !")
            return redirect('add_staff')
            
    return render(request, 'Hod/add_staff.html')

@login_required(login_url='/')
def VIEW_STAFF(request):
    staff = Staff.objects.all()
    # print(staff)
    context = {
        'staff':staff,
    }
    return render(request, 'Hod/view_staff.html', context)


@login_required(login_url='/')
def EDIT_STAFF(request, id):
    staff = Staff.objects.filter(id = id)
    context = {
        'staff':staff,
    }
    return render(request, 'Hod/edit_staff.html', context)


@login_required(login_url='/')
def UPDATE_STAFF(request):
    if request.method == "POST":
        staff_id = request.POST.get('staff_id')
        # print(staff_id)
        profile_pic = request.FILES.get('profile_pic')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        address = request.POST.get('address')
        gender = request.POST.get('gender')
        desgination = request.POST.get('desgination')

        user = CustomUser.objects.get(id = staff_id)
        user.profile_pic = profile_pic
        user.first_name = first_name
        user.last_name = last_name
        user.email = email
        user.username = username
        
        if password != None and password != "":
            user.set_password(password)
        if profile_pic != None and profile_pic != "":
            user.profile_pic = profile_pic
        user.save()

        staff = Staff.objects.get(admin = staff_id)
        staff.address = address
        staff.gender = gender
        staff.desgination = desgination

        staff.save()
        messages.success(request, "Records are sucessfully Updated !")
        return redirect('view_staff')
    return render(request, 'Hod/Staff/View')


@login_required(login_url='/')
def DELETE_STAFF(request, admin):
    staff = CustomUser.objects.get(id = admin)
    staff.delete()

    messages.success(request, 'Record is Successfully Deleted!')
    return redirect('view_staff')

@login_required(login_url='/')
def ADD_COURSE(request):
    program = Program.objects.all()
    staff = Staff.objects.all()

    if request.method == 'POST':
        course_code = request.POST.get('course_code')
        course_title = request.POST.get('course_title')
        program_id = request.POST.get('program_id')
        staff_id = request.POST.get('staff_id')

        program = Program.objects.get(id = program_id)
        staff = Staff.objects.get(id = staff_id)

        course = Course(
            course_code = course_code,
            course_title = course_title,
            program = program, 
            staff = staff,
        )
        course.save()
        messages.success(request, course_code + " is Successfully Added !")
        
        return redirect('add_course')

    context = {
        'program': program,
        'staff': staff,
    }

    return render(request, 'Hod/add_course.html', context)

@login_required(login_url='/')
def VIEW_COURSE(request):
    course = Course.objects.all()
    # print(course)
    context = {
        'course':course,
    }
    return render(request, 'Hod/view_course.html', context)

@login_required(login_url='/')
def EDIT_COURSE(request, id):
    course = Course.objects.filter(id = id)
    program = Program.objects.all()
    staff = Staff.objects.all()
    context = {
        'course':course,
        'program': program,
        'staff': staff,
    }
    return render(request, 'Hod/edit_course.html', context)

@login_required(login_url='/')
def UPDATE_COURSE(request):
    if request.method == 'POST':
        course_id = request.POST.get('course_id')
        course_code = request.POST.get('course_code')
        course_title = request.POST.get('course_title')
        program_id = request.POST.get('program_id')
        staff_id = request.POST.get('staff_id')

        program = Program.objects.get(id=program_id)
        staff = Staff.objects.get(id=staff_id)

        course = Course.objects.get(id=course_id)
        course.course_code = course_code
        course.course_title = course_title
        course.program = program
        course.staff = staff
        course.save()

        messages.success(request, course_code + ' Course is Successfully Updated!')
        context = {
            'program': program,
            'staff': staff,
        }
        return redirect('view_course')

    return render(request, 'Hod/view_course.html', context)


@login_required(login_url='/')
def DELETE_COURSE(request, id):    
    course = Course.objects.get(id=id)
    course.delete()

    messages.success(request, 'Course is Successfully Deleted in the database!')
    return redirect('view_course')

@login_required(login_url='/')
def ADD_SESSION(request):
    if request.method == 'POST':
        session_start = request.POST.get('session_start')
        session_end = request.POST.get('session_end')

        session = Session_Year(
            session_start = session_start,
            session_end = session_end
        )
        session.save()
        messages.success(request, 'Session is Created Successfully!')
        return redirect('add_session')
    return render(request, 'Hod/add_session.html')

@login_required(login_url='/')
def VIEW_SESSION(request):
    session = Session_Year.objects.all()
    # print(course)
    context = {
        'session': session,
    }
    return render(request, 'Hod/view_session.html', context)


@login_required(login_url='/')
def EDIT_SESSION(request, id):
    return render(request, 'Hod/view_session.html')

@login_required(login_url='/')
def UPDATE_SESSION(request):
    return render(request, 'Hod/view_session.html')

@login_required(login_url='/')
def DELETE_SESSION(request, id):
    return render(request, 'Hod/view_session.html')