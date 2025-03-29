from django.urls import path
from django.urls import path, include
from . import views

urlpatterns = [
    path('students/', views.students, name='student-list'),
    path('subjects/', views.subjects, name='subject-list'),
]
