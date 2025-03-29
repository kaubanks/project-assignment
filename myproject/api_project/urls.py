from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('student_api/', include('student_api.urls')),  # This includes student_api's URLs
]
