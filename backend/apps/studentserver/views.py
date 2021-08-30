from django.shortcuts import render
from rest_framework import viewsets
# from .models import Studentinfo,Student
# from .serializers import StudentSerializer, StudentInfoSerializer
from . import serializers
from . import models
from rest_framework.response import Response
from rest_framework import viewsets, status
# Create your views here.


class StudentinfoViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    queryset = models.Studentinfo.objects.all()
    serializer_class = serializers.StudentInfoSerializer
    # 重写post方法
    # def post(self, request, *args, **kwargs):
    #     print(request)
    #     return Response(data=request, status=status.HTTP_200_OK)




class StudentViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    queryset = models.Student.objects.all()
    serializer_class = serializers.StudentSerializer


class ExamtypeViewSet(viewsets.ModelViewSet):
    queryset = models.Examtype.objects.all()
    serializer_class = serializers.ExamtypeSerializer


class CourseViewSet(viewsets.ModelViewSet):
    queryset = models.Course.objects.all()
    serializer_class = serializers.CourseSerializer


class StudentcourseViewSet(viewsets.ModelViewSet):
    queryset = models.Studentcourse.objects.all()
    serializer_class = serializers.StudentCourseSerializer


class ExamViewSet(viewsets.ModelViewSet):
    queryset = models.Exam.objects.all()
    serializer_class = serializers.ExamSerializer



