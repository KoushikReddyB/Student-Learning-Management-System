from django.db import models
from django.contrib.auth.models import AbstractUser

class CustomUser(AbstractUser):
    USER_CHOICES = (
        (1, 'HOD'),
        (2, 'STAFF'),
        (3, 'STUDENT'),
    )
    user_type = models.CharField(choices=USER_CHOICES, max_length=50, default=1)
    profile_pic = models.ImageField(upload_to='media/profile_pics')

    class Meta:
        db_table = 'custom_user_table'

class Program(models.Model):
    name = models.CharField(max_length=100, blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.name
    
    class Meta:
        db_table = "program_table"

'''
class Course(models.Model):
    id = models.AutoField(primary_key=True)
    course_code = models.CharField(max_length=20,blank=False)
    course_title = models.CharField(max_length=100,blank=False)

    department_choises = ( ("CSE","CSE"), ("CS&IT","CS&IT"), ("AI&DS","AI&DS"), ("ECS","ECE"), ("EEE","EEE"), ("IoT","IoT"), ("BT","BT"), ("ME","ME"), ("CIVIL","CIVIL")  )
    department = models.CharField(max_length=50,blank=False,choices=department_choises)
    
    program_choise = ( ("B.Tech","B.Tech"), ("M.Tech","M.Tech"))
    program = models.CharField(max_length=30,blank=False,choices=program_choise)
    
    academic_year_choises = ( ("2020-2021", "2020-21"), ("2021-2022", "2021-22"), ("2022-2023", "2022-23"), ("2023-2024", "2023-24"))
    academic_year = models.CharField(max_length=100,blank=False,choices=academic_year_choises)

    sem_choise = ( ("ODD","ODD"), ("EVEN","EVEN"), ("SUMMER","SUMMER") )
    semester = models.CharField(max_length=10,blank=False,choices=sem_choise)

    year_choise = ( ("1st", "1st"), ("2nd", "2nd"), ("3rd", "3rd"), ("4th", "4th"), ("5th", "5th"))
    year = models.CharField(max_length=10,blank=False,choices=year_choise)

    class Meta:
        db_table = 'course_table'
    
    def __str__(self):
        return self.course_code
'''

class Session_Year(models.Model):
    session_start = models.CharField(max_length=100)
    session_end = models.CharField(max_length=100)
    
    class Meta:
        db_table = 'session_year_table'

    def __str__(self):
        return self.session_start +  '-->'  + self.session_end    

        
class Student(models.Model):
    admin = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    address = models.TextField()
    gender = models.CharField(max_length=100)
    program_id = models.ForeignKey(Program, on_delete=models.DO_NOTHING)
    session_year_id = models.ForeignKey(Session_Year, on_delete=models.DO_NOTHING)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True) 

    class Meta:
        db_table = 'student_table'

    def __str__(self):
        return str(self.admin.first_name + self.admin.last_name)

class Staff(models.Model):
    admin = models.OneToOneField(CustomUser,on_delete=models.CASCADE)
    address = models.TextField()
    gender = models.CharField(max_length=100)
    desgination = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.admin.username