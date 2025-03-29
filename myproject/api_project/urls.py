from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('student_api.urls')),  # This must be included
]
