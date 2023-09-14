"""
URL configuration for Studentlearningmanagementsystem project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from . import views, HOD_views, Student_views, Staff_views
urlpatterns = [
    path('admin/', admin.site.urls),
    path('base/', views.BASE, name = 'base' ),

    # <LOGIN PATH>
    path('', views.LOGIN, name = 'login'),
    path('doLogin', views.doLogin, name = 'doLogin'),
    path('doLogout',views.doLogout, name = 'Logout'),

    # <PROFILE UPDATE>
    path('profile',views.PROFILE,name = 'profile'),
    path('Profile/update',views.PROFILE_UPDATE,name='profile_update'),

    # <HOD PANEL>
    path('HOD/home', HOD_views.HOME, name='HOD_home',),
    path('HOD/Student/Add', HOD_views.ADD_STUDENT, name='add_student'),
    path('HOD/Student/View', HOD_views.VIEW_STUDENT, name='view_student'),
    path('HOD/Student/Edit/<str:id>', HOD_views.EDIT_STUDENT, name='edit_student'),
    path('HOD/Student/Update', HOD_views.UPDATE_STUDENT, name='update_student'),
    path('HOD/Student/Delete/<str:admin>', HOD_views.DELETE_STUDENT, name='delete_student'),
    ####
    path('HOD/Program/Add', HOD_views.ADD_PROGRAM, name = 'add_program'),
    path('HOD/Program/View', HOD_views.VIEW_PROGRAM, name='view_program'),
    path('HOD/Program/Edit/<str:id>', HOD_views.EDIT_PROGRAM, name='edit_program'),
    path('HOD/Program/Update', HOD_views.UPDATE_PROGRAM, name='update_program'),
    path('HOD/Program/Delete/<str:id>', HOD_views.DELETE_PROGRAM, name='delete_program'),
    ####
    path('HOD/Staff/Add', HOD_views.ADD_STAFF, name = 'add_staff'),
    path('HOD/Staff/View', HOD_views.VIEW_STAFF, name = 'view_staff'),
    path('HOD/Staff/Edit/<str:id>', HOD_views.EDIT_STAFF, name='edit_staff'),
    path('HOD/Staff/Update', HOD_views.UPDATE_STAFF, name='update_staff'),
    path('HOD/Staff/Delete/<str:admin>', HOD_views.DELETE_STAFF, name='delete_staff'),

] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)

