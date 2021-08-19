from rest_framework import serializers
#models内已经生成好的数据库表对象
from .models import Studentinfo


class StudentSerializer(serializers.HyperlinkedModelSerializer):
# class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Studentinfo
        # 指定全部使用 fields = '__all__'
        fields = ('student_id', 'student_name', 'student_sex', 'student_age', 'student_date', 'student_class')