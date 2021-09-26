# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
import uuid




'''
以下学生相关表
'''
class Course(models.Model):
    # course_id = models.CharField(primary_key=True, max_length=36)
    # course_id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    course_id = models.BigAutoField(primary_key=True)
    course_no = models.CharField(max_length=10, blank=True, null=True, unique=True)
    course_name = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        # managed 设置为False，django不对该表更新进行管理  需更新可以删除或设置为True
        managed = False
        db_table = 'course'


class Teacher(models.Model):
    teacher_id = models.BigAutoField(primary_key=True)
    # teacher_id = models.CharField(primary_key=True, max_length=36)
    # teacher_id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    teacher_no = models.CharField(max_length=10, blank=True, null=True, unique=True)

    class Meta:
        managed = False
        db_table = 'teacher'


class Teachercourse(models.Model):
    # teacher = models.ForeignKey(Teacher, models.DO_NOTHING)
    # course = models.ForeignKey(Course, models.DO_NOTHING)
    teacher_id = models.ForeignKey('Teacher', models.DO_NOTHING, db_column='teacher_id', blank=True)
    course_id = models.ForeignKey('Course', models.DO_NOTHING, db_column='course_id', blank=True)

    class Meta:
        managed = False
        db_table = 'teacherCourse'
        unique_together = (('teacher_id', 'course_id'),)


class Teacherinfo(models.Model):
    # teacher = models.ForeignKey(Teacher, models.DO_NOTHING, unique=True)
    teacher_id = models.ForeignKey('Teacher', models.DO_NOTHING, db_column='teacher_id', unique=True)
    teacher_name = models.CharField(max_length=10, blank=True, null=True)
    teacher_sex = models.CharField(max_length=2, blank=True, null=True)
    teacher_age = models.IntegerField(blank=True, null=True)
    teacher_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'teacherinfo'


'''
以下表修改，取消guid作为主键
'''



class Student(models.Model):
    # 设置单个主键
    # student_id = models.UUIDField(primary_key=True, default=uuid.uuid1, editable=False)
    # student_id = models.CharField(primary_key=True, max_length=36)
    student_id = models.BigAutoField(primary_key=True)
    student_no = models.CharField(max_length=10, blank=True, null=True, unique=True)

    class Meta:
        managed = False
        db_table = 'student'


class Studentinfo(models.Model):
    # student = models.ForeignKey(Student, models.DO_NOTHING, unique=True, primary_key=True)
    # 设置primary_key 解决默认id主键的问题，这里设置primary跟数据库中本身没关联
    # 但设置后可能无法使用migrate，没有测试  可能会将数据库中的该字段刷为主键
    # student_id = models.ForeignKey(Student, on_delete=models.DO_NOTHING, db_column='student_id', primary_key=True)
    student_id = models.ForeignKey(Student, on_delete=models.DO_NOTHING, db_column='student_id', unique=True)
    student_name = models.CharField(max_length=10, blank=True, null=True)
    student_sex = models.CharField(max_length=2, blank=True, null=True)
    student_age = models.IntegerField(blank=True, null=True, default=0)
    student_date = models.DateField(blank=True, null=True)
    student_class = models.CharField(max_length=10, blank=True, null=True)
    registration_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'studentinfo'


class Studentcourse(models.Model):
    # student = models.ForeignKey(Student, models.DO_NOTHING)
    # course = models.ForeignKey(Course, models.DO_NOTHING)
    student_id = models.ForeignKey('Student', models.DO_NOTHING, db_column='student_id', blank=True, )
    course_id = models.ForeignKey('Course', models.DO_NOTHING, db_column='course_id', blank=True)

    class Meta:
        managed = False
        db_table = 'studentCourse'
        unique_together = ('student_id', 'course_id', )


class Examtype(models.Model):
    examtype_no = models.CharField(primary_key=True, max_length=10, unique=True)
    examtype_name = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'examtype'


class Exam(models.Model):
    # student = models.ForeignKey('Student', models.DO_NOTHING)
    # course = models.ForeignKey('Course', models.DO_NOTHING)
    student_id = models.ForeignKey('Student', models.DO_NOTHING, db_column='student_id')
    course_id = models.ForeignKey('Course', models.DO_NOTHING, db_column='course_id')
    exam_date = models.DateTimeField(blank=True, null=True)
    exam_score = models.FloatField(blank=True, null=True)
    examtype_no = models.ForeignKey('Examtype', models.DO_NOTHING, db_column='examtype_no', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'exam'
        # 设置联合主键
        unique_together = ('student_id', 'course_id', 'exam_date', )


class vstudentcourse(models.Model):
    student_id = models.IntegerField(primary_key=True)
    student_no = models.CharField(blank=True, null=True, max_length=50)
    student_name = models.CharField(blank=True, null=True, max_length=50)
    student_sex = models.CharField(blank=True, null=True, max_length=50)
    student_age = models.CharField(blank=True, null=True, max_length=50)
    student_date = models.CharField(blank=True, null=True, max_length=50)
    student_class = models.CharField(blank=True, null=True, max_length=50)
    course_id = models.CharField(blank=True, null=True, max_length=50)
    course_name = models.CharField(blank=True, null=True, max_length=50)
    course_no = models.CharField(blank=True, null=True, max_length=50)
    select_course = models.CharField(blank=True, null=True, max_length=50)
    unselect_course = models.CharField(blank=True, null=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'v_student_course'
        unique_together = ('student_id', 'course_id', )


class vexam(models.Model):
    id = models.IntegerField(primary_key=True)
    student_id = models.ForeignKey('Student', models.DO_NOTHING, db_column='student_id')
    student_no = models.CharField(blank=True, null=True, max_length=50)
    student_name = models.CharField(blank=True, null=True, max_length=50)
    course_id = models.ForeignKey('Course', models.DO_NOTHING, db_column='course_id')
    course_no = models.CharField(blank=True, null=True, max_length=50)
    course_name = models.CharField(blank=True, null=True, max_length=50)
    exam_date = models.CharField(blank=True, null=True, max_length=50)
    exam_score = models.CharField(blank=True, null=True, max_length=50)
    examtype_no = models.CharField(blank=True, null=True, max_length=50)
    examtype_name = models.CharField(blank=True, null=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'v_exam'


class vstudentinfo(models.Model):
    student_id = models.IntegerField(primary_key=True)
    student_no = models.CharField(blank=True, null=True, max_length=50)
    student_name = models.CharField(blank=True, null=True, max_length=50)
    student_sex = models.CharField(blank=True, null=True, max_length=50)
    student_age = models.CharField(blank=True, null=True, max_length=50)
    student_date = models.CharField(blank=True, null=True, max_length=50)
    student_class = models.CharField(blank=True, null=True, max_length=50)
    registration_date = models.CharField(blank=True, null=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'v_student_info'

