from rest_framework import serializers
#models内已经生成好的数据库表对象
# from .models import Studentinfo
from . import models


# # 该方法将外键显示替换
# class StudentField(serializers.RelatedField):
#     def to_representation(self, value):
#         return value.student_no


class StudentInfoSerializer(serializers.HyperlinkedModelSerializer):
# class StudentSerializer(serializers.ModelSerializer):
    student_no = serializers.CharField(source='student_id.student_no',read_only=True)
    # # 该方法使用StudentField将外键显示替换
    # student_id = StudentField(read_only=True)
    class Meta:
        model = models.Studentinfo
        # 指定全部使用 fields = '__all__'
        fields = ('url', 'student_id', 'student_no', 'student_name', 'student_sex', 'student_age', 'student_date', 'student_class')


class StudentSerializer(serializers.HyperlinkedModelSerializer):
    # student_id = serializers.UUIDField()
    class Meta:
        model = models.Student
        # 指定全部使用 fields = '__all__'
        fields = ('url', 'student_id', 'student_no')


class ExamtypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Examtype
        fields = ('url', 'examtype_no', 'examtype_name')
