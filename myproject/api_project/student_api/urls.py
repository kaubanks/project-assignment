from django.urls import path
from . import views

urlpatterns = [
    path('students/', views.students, name='students'),
    path('subjects/', views.subjects, name='subjects'),
]
