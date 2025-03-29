from django.http import JsonResponse
from .models import Student, Subject

def students(request):
    students_data = list(Student.objects.values())
    return JsonResponse(students_data, safe=False)

def subjects(request):
    subjects_data = list(Subject.objects.values().order_by('year'))
    return JsonResponse(subjects_data, safe=False)


#from django.shortcuts import render

# Create your views here.
