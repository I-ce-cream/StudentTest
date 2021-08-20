from rest_framework import serializers
#models内已经生成好的数据库表对象
# from .models import Studentinfo
from . import models

class StudentInfoSerializer(serializers.HyperlinkedModelSerializer):
# class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Studentinfo
        # 指定全部使用 fields = '__all__'
        fields = ('student_id', 'student_name', 'student_sex', 'student_age', 'student_date', 'student_class')


class StudentSerializer(serializers.HyperlinkedModelSerializer):
    student_id = serializers.UUIDField()
    class Meta:
        model = models.Student
        # 指定全部使用 fields = '__all__'
        fields = ('student_id', 'student_no')


class ExamtypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Examtype
        fields = ('examtype_no', 'examtype_name')
