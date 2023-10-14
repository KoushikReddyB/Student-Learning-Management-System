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
    updated_at = models.DateTimeField(auto_now_add=True) 

    class Meta:
        db_table = 'staff_table'

    def __str__(self):
        return self.admin.username
    

class Course(models.Model):
    course_code = models.CharField(max_length=20,blank=False)
    course_title = models.CharField(max_length=100,blank=False)

    program = models.ForeignKey(Program, on_delete=models.CASCADE)
    staff = models.ForeignKey(Staff, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True) 

    class Meta:
        db_table = 'course_table'
    
    def __str__(self):
        return self.course_code
    
class Staff_Notifications(models.Model):
    staff_id = models.ForeignKey(Staff, on_delete = models.CASCADE)
    message = models.TextField()
    status = models.IntegerField(null=True, default=0)
    created_at = models.DateTimeField(auto_now_add = True)

    class Meta:
        db_table = 'staff_notification_table'

    def __str__(self):
        return self.staff_id.admin.first_name

class Staff_Leave(models.Model):
    staff_id = models.ForeignKey(Staff, on_delete = models.CASCADE)
    date = models.CharField(max_length = 50)
    message = models.TextField()
    status = models.IntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True) 
    updated_at = models.DateTimeField(auto_now_add=True) 

    class Meta:
        db_table = 'staff_leave_table'

    def __str__(self):
        return str(self.staff_id.admin.first_name + self.staff_id.admin.last_name)
    
class Staff_Feedback(models.Model):
    staff_id = models.ForeignKey(Staff, on_delete = models.CASCADE)
    feedback = models.TextField()
    feedback_reply = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True) 
    updated_at = models.DateTimeField(auto_now_add=True) 

    class Meta:
        db_table = 'staff_feedback_table'

    def __str__(self):
        return str(self.staff_id.admin.username)
    
class Student_Notifications(models.Model):
    student_id = models.ForeignKey(Student, on_delete = models.CASCADE)
    message = models.TextField()
    status = models.IntegerField(null=True, default=0)
    created_at = models.DateTimeField(auto_now_add = True)

    class Meta:
        db_table = 'student_notification_table'

    def __str__(self):
        return self.student_id.admin.first_name + self.student_id.admin.last_name