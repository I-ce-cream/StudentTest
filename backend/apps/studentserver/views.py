from django.shortcuts import render
from rest_framework import viewsets
# from .models import Studentinfo,Student
# from .serializers import StudentSerializer, StudentInfoSerializer
from . import serializers
from . import models
from rest_framework.response import Response
from rest_framework import viewsets, status
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from rest_framework.pagination import PageNumberPagination
# Create your views here.

class MyPage(PageNumberPagination):
    page_size = 10 #每页显示记录数，前端没有传入 page_size_query_param 时使用该参数
    page_size_query_param = 'page_size'  #前端传入每页显示条数
    page_query_param = 'page' #前端传入 第几页
    # max_page_size = 20 #后端控制每页显示最大记录数


class StudentinfoViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    # queryset = models.Studentinfo.objects.all()
    # 序列化
    serializer_class = serializers.StudentInfoSerializer
    # 过滤器
    filter_backends = [DjangoFilterBackend, ]
    filter_fields = ('student_id', 'student_name', 'student_sex', 'student_age', 'student_date', 'student_class',
                     'registration_date', )
    # 分页
    pagination_class = MyPage

    def get_queryset(self):
        # 排序
        # return models.Studentinfo.objects.all().order_by('student_id', )
        return models.Studentinfo.objects.all()

    # 重写post方法
    # def post(self, request, *args, **kwargs):
    #     print(request)
    #     return Response(data=request, status=status.HTTP_200_OK)


class StudentViewSet(viewsets.ModelViewSet):
    # queryset = Studentinfo.objects.values_list('student_id', 'student_name', 'student_sex', 'student_age',
    #                                            'student_date', 'student_class')
    queryset = models.Student.objects.all()
    serializer_class = serializers.StudentSerializer

    filter_backends = [DjangoFilterBackend, ]
    filter_fields = ('student_id', 'student_no', )


class ExamtypeViewSet(viewsets.ModelViewSet):
    # queryset = models.Examtype.objects.all()
    serializer_class = serializers.ExamtypeSerializer

    filter_backends = [DjangoFilterBackend]
    filter_fields = ("examtype_no", "examtype_name")

    pagination_class = MyPage

    def get_queryset(self):
        # 排序
        return models.Examtype.objects.all().order_by('examtype_no', )


class CourseViewSet(viewsets.ModelViewSet):
    # queryset = models.Course.objects.all()
    serializer_class = serializers.CourseSerializer

    filter_backends = [DjangoFilterBackend]
    filter_fields = ("course_no", "course_name")

    pagination_class = MyPage

    def get_queryset(self):
        # 排序
        return models.Course.objects.all().order_by('course_no', )


class StudentcourseViewSet(viewsets.ModelViewSet):
    # queryset = models.Studentcourse.objects.all()
    serializer_class = serializers.StudentCourseSerializer

    filter_backends = [DjangoFilterBackend]
    filter_fields = ("course_id", "student_id")

    def get_queryset(self):
        # 排序
        return models.Studentcourse.objects.all().order_by('course_id', 'student_id', )


class ExamViewSet(viewsets.ModelViewSet):
    # queryset = models.Exam.objects.all()
    serializer_class = serializers.ExamSerializer

    filter_backends = [DjangoFilterBackend]
    filter_fields = ('student_id', 'course_id', 'exam_date', 'exam_score', 'examtype_no', )

    def get_queryset(self):
        # 排序
        return models.Exam.objects.all().order_by('student_id', 'course_id', 'exam_date', )


class VStudentCourseViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.vstudentcourseSerializer

    filter_backends = [DjangoFilterBackend]
    filter_fields = ('student_no', 'course_no', 'select_course', 'unselect_course', 'student_id', 'course_id', )

    pagination_class = MyPage

    # 设置允许的接口
    # http_method_names = ['get', 'post', 'head', 'options', 'put', ]
    # GET, POST, HEAD, OPTIONS

    def get_queryset(self):
        return models.vstudentcourse.objects.all().order_by('student_no', 'course_no', )


class VExamViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.vexamSerializer

    filter_backends = [DjangoFilterBackend]
    filter_fields = ('student_no', 'course_no', 'student_id', 'course_id', 'exam_date', 'examtype_no', )

    pagination_class = MyPage

    def get_queryset(self):
        return models.vexam.objects.all().order_by('student_no', 'course_no', 'exam_date', )









