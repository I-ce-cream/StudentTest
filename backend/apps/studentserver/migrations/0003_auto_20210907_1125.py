# Generated by Django 2.2 on 2021-09-07 11:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('studentserver', '0002_auto_20210830_1035'),
    ]

    operations = [
        migrations.CreateModel(
            name='vstudentcourse',
            fields=[
                ('student_id', models.IntegerField(primary_key=True, serialize=False)),
                ('student_no', models.CharField(blank=True, max_length=50, null=True)),
                ('student_name', models.CharField(blank=True, max_length=50, null=True)),
                ('student_sex', models.CharField(blank=True, max_length=50, null=True)),
                ('student_age', models.CharField(blank=True, max_length=50, null=True)),
                ('student_date', models.CharField(blank=True, max_length=50, null=True)),
                ('student_class', models.CharField(blank=True, max_length=50, null=True)),
                ('course_id', models.CharField(blank=True, max_length=50, null=True)),
                ('course_name', models.CharField(blank=True, max_length=50, null=True)),
                ('course_no', models.CharField(blank=True, max_length=50, null=True)),
                ('select_course', models.CharField(blank=True, max_length=50, null=True)),
                ('unselect_course', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'v_student_course',
                'managed': False,
            },
        ),
        migrations.AlterModelOptions(
            name='course',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='exam',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='examtype',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='student',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='studentcourse',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='studentinfo',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='teacher',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='teachercourse',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='teacherinfo',
            options={'managed': False},
        ),
    ]