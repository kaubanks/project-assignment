from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse  # ✅ Import HttpResponse for a simple response

def home(request):
    return HttpResponse("Welcome to the API. Use /student_api/students/ or /student_api/subjects/")

urlpatterns = [
    path('admin/', admin.site.urls),
    path('student_api/', include('student_api.urls')),
    path('', home),  # ✅ Add this for a default homepage
]
