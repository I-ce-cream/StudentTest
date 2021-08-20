from django.shortcuts import render
from rest_framework import viewsets
# from .models import Studentinfo,Student
# from .serializers import StudentSerializer, StudentInfoSerializer
from . import serializers
from . import models
# Create your views here.


class StudentinfoViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    queryset = models.Studentinfo.objects.all()
    serializer_class = serializers.StudentInfoSerializer


class StudentViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    queryset = models.Student.objects.all()
    serializer_class = serializers.StudentSerializer


class ExamtypeViewSet(viewsets.ModelViewSet):
    queryset = models.Examtype.objects.all()
    serializer_class = serializers.ExamtypeSerializer



