from django.shortcuts import render
from rest_framework import viewsets
from .models import Studentinfo
from .serializers import StudentSerializer
# Create your views here.


class StudentinfoViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    queryset = Studentinfo.objects.all()
    serializer_class = StudentSerializer

