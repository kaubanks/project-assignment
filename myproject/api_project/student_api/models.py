from django.db import models

class Student(models.Model):
    name = models.CharField(max_length=100)
    enrolled_program = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Subject(models.Model):
    name = models.CharField(max_length=100)
    year = models.IntegerField()

    def __str__(self):
        return self.name
