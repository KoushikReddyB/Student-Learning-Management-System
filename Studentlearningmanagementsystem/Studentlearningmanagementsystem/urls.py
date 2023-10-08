from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from . import views, HOD_views, Student_views, Staff_views
urlpatterns = [
    path('admin/', admin.site.urls),
    path('base/', views.BASE, name='base'),

    # <LOGIN PATH>
    path('', views.LOGIN, name='login'),
    path('doLogin', views.doLogin, name='doLogin'),
    path('doLogout', views.doLogout, name='Logout'),

    # <PROFILE UPDATE>
    path('profile', views.PROFILE, name='profile'),
    path('Profile/update', views.PROFILE_UPDATE, name='profile_update'),

    # <HOD PANEL>
    path('HOD/home', HOD_views.HOME, name='HOD_home'),
    path('HOD/Student/Add', HOD_views.ADD_STUDENT, name='add_student'),
    path('HOD/Student/View', HOD_views.VIEW_STUDENT, name='view_student'),
    path('HOD/Student/Edit/<str:id>', HOD_views.EDIT_STUDENT, name='edit_student'),
    path('HOD/Student/Update', HOD_views.UPDATE_STUDENT, name='update_student'),
    path('HOD/Student/Delete/<str:admin>', HOD_views.DELETE_STUDENT, name='delete_student'),
    ####
    path('HOD/Program/Add', HOD_views.ADD_PROGRAM, name='add_program'),
    path('HOD/Program/View', HOD_views.VIEW_PROGRAM, name='view_program'),
    path('HOD/Program/Edit/<str:id>', HOD_views.EDIT_PROGRAM, name='edit_program'),
    path('HOD/Program/Update', HOD_views.UPDATE_PROGRAM, name='update_program'),
    path('HOD/Program/Delete/<str:id>', HOD_views.DELETE_PROGRAM, name='delete_program'),
    ####
    path('HOD/Staff/Add', HOD_views.ADD_STAFF, name='add_staff'),
    path('HOD/Staff/View', HOD_views.VIEW_STAFF, name='view_staff'),
    path('HOD/Staff/Edit/<str:id>', HOD_views.EDIT_STAFF, name='edit_staff'),
    path('HOD/Staff/Update', HOD_views.UPDATE_STAFF, name='update_staff'),
    path('HOD/Staff/Delete/<str:admin>', HOD_views.DELETE_STAFF, name='delete_staff'),
    ####
    path('HOD/Course/Add', HOD_views.ADD_COURSE, name='add_course'),
    path('HOD/Course/View', HOD_views.VIEW_COURSE, name='view_course'),
    path('HOD/Course/Edit/<str:id>', HOD_views.EDIT_COURSE, name='edit_course'),
    path('HOD/Course/Update', HOD_views.UPDATE_COURSE, name='update_course'),
    path('HOD/Course/Delete/<int:id>', HOD_views.DELETE_COURSE, name='delete_course'),
    ####
    path('HOD/Session/Add', HOD_views.ADD_SESSION, name='add_session'),
    path('HOD/Session/View', HOD_views.VIEW_SESSION, name='view_session'),
    path('HOD/Session/Edit/<str:id>', HOD_views.EDIT_SESSION, name='edit_session'),
    path('HOD/Session/Update', HOD_views.UPDATE_SESSION, name='update_session'),
    path('HOD/Session/Delete/<int:id>', HOD_views.DELETE_SESSION, name='delete_session'),
    ####
    path('HOD/Staff/Send_Notification', HOD_views.STAFF_SEND_NOTIFICATIONS, name = 'staff_send_notifications'),
    path('HOD/Staff/Save_Notification', HOD_views.STAFF_SAVE_NOTIFICATIONS, name = 'staff_save_notifications'),
    # THIS IS FOR STAFF URLS
    path('Staff/home', Staff_views.HOME, name = 'Staff_home'),
    
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
