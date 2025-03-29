from django.db import models

class Student(models.Model):
    name = models.CharField(max_length=100)
    enrolled_program = models.CharField(max_length=100)

class Subject(models.Model):
    name = models.CharField(max_length=100)
    year = models.IntegerField()


#from django.db import models

# Create your models here.
