
--drop database SQLTEST;
create database SQLTEST on primary
(
 name='SQLTEST',
 filename='C:\ZXZ\database\SQLTESET.dbf',
 size=5MB,
 maxsize=20MB,
 filegrowth=1MB
)
log on 
(
name='SQLTESTLog',
filename='C:\ZXZ\database\SQLTESET.ldf',
size=2MB,
maxsize=20MB,
filegrowth=1MB
);
alter database SQLTEST collate Chinese_PRC_CI_AS;

--学生表
if exists(select * from sys.tables where name='student')
drop table student;
go
create table student(
	student_id	uniqueidentifier not null primary key,
	student_no	varchar(10)
);
--新建guid   newid()



--学生信息表
if exists(select * from sys.tables where name='studentinfo')
drop table studentinfo;
go
create table studentinfo(
	student_id		uniqueidentifier not null,
	student_name	varchar(10),
	student_sex		char(2) check (student_sex = '男' or student_sex = '女') ,
	student_age		int,
	student_date	date,
	student_class	varchar(10)
);
--建立外键  关闭强制外键约束
alter table studentinfo with nocheck add constraint [FK_Student_Id] foreign key (student_id) references student (student_id);
go
alter table studentinfo nocheck constraint [FK_Student_Id];
go
--建立索引
CREATE UNIQUE INDEX FK_studentinfo ON studentinfo (student_id);


--教师表
if exists(select * from sys.tables where name='teacher')
drop table teacher;
go
create table teacher(
	teacher_id	uniqueidentifier not null primary key,
	teacher_no	varchar(10)
);

--教师信息表
if exists(select * from sys.tables where name='teacherinfo')
drop table teacherinfo;
go
create table teacherinfo(
	teacher_id		uniqueidentifier not null,
	teacher_name	varchar(10),
	teacher_sex		char(2) check (teacher_sex = '男' or teacher_sex = '女') ,
	teacher_age		int,
	teacher_date	date
);
alter table teacherinfo with nocheck add constraint [FK_Teacher_Id] foreign key (teacher_id) references teacher (teacher_id);
go
alter table teacherinfo nocheck constraint [FK_Teacher_Id];
go
CREATE UNIQUE INDEX FK_teacherinfo ON teacherinfo (teacher_id);

--课程信息表
if exists(select * from sys.tables where name='course')
drop table course;
go
create table course(
	course_id	uniqueidentifier not null primary key,
	course_no	varchar(10),
	course_name	varchar(10)
);


--教师课程关联表
if exists(select * from sys.tables where name='teacherCourse')
drop table teacherCourse;
go
create table teacherCourse(
	teacher_id	uniqueidentifier not null,
	course_id	uniqueidentifier not null
);
alter table teacherCourse with nocheck add constraint [FK_teacherCourse_teacherID] foreign key (teacher_id) references teacher (teacher_id);
go
alter table teacherCourse with nocheck add constraint [FK_teacherCourse_courseID] foreign key (course_id) references course (course_id);
go
alter table teacherCourse nocheck constraint [FK_teacherCourse_courseID],[FK_teacherCourse_teacherID];
go
create clustered index FK_teacherCourse on teacherCourse (teacher_id,course_id);



--学生课程关联表
if exists(select * from sys.tables where name='studentCourse')
drop table studentCourse;
go
create table studentCourse(
	student_id	uniqueidentifier not null,
	course_id	uniqueidentifier not null
);
alter table studentCourse with nocheck add constraint [FK_studentCourse_studentID] foreign key (student_id) references student (student_id);
go
alter table studentCourse with nocheck add constraint [FK_studentCourse_courseID] foreign key (course_id) references course (course_id);
go
alter table studentCourse nocheck constraint [FK_studentCourse_courseID],[FK_studentCourse_studentID];
go
create clustered index FK_studentCourse on studentCourse (student_id,course_id);


--考试类型表
if exists(select * from sys.tables where name='examtype')
drop table examtype;
go
create table examtype(
	examtype_no		char(10) not null primary key,
	examtype_name	varchar(10)
);


--考试成绩表
if exists(select * from sys.tables where name='exam')
drop table exam;
go
create table exam(
	student_id	uniqueidentifier not null,
	course_id	uniqueidentifier not null,
	exam_date	datetime,
	exam_score	float,
	exam_type	char(10)
);
alter table exam with nocheck add constraint [FK_exam_studentID] foreign key (student_id) references student (student_id);
go
alter table exam with nocheck add constraint [FK_exam_courseID] foreign key (course_id) references course (course_id);
go
alter table exam with nocheck add constraint [FK_exam_examtypeNo] foreign key (exam_type) references examtype (examtype_no);
go
alter table exam nocheck constraint [FK_exam_studentID],[FK_exam_courseID],[FK_exam_examtypeNo];
go
create clustered index FK_exam on exam (student_id,course_id,exam_date);



declare @rtn_str varchar(50)
exec insert_update_delete_student 'insert','ST001','张三','男',15,'2020-9-1','CLASS1','C01','2020-11-1',76,'EXAMTYPE1','N',@rtn_str output;
exec insert_update_delete_student 'insert','ST002','李四','男',17,'2019-9-1','CLASS1','C01','2020-11-1',80,'EXAMTYPE1','N',@rtn_str output;
exec insert_update_delete_student 'insert','ST003','王五','女',18,'2021-9-1','CLASS2','C01','2020-11-1',83,'EXAMTYPE1','N',@rtn_str output;
exec insert_update_delete_student 'insert','ST004','赵六','男',14,'2018-9-1','CLASS3','C01','2020-11-1',91,'EXAMTYPE1','N',@rtn_str output;
exec insert_update_delete_student 'insert','ST005','李静','女',15,'2019-9-1','CLASS4','C01','2020-11-1',57,'EXAMTYPE1','N',@rtn_str output;
exec insert_update_delete_student 'insert','ST006','王雯','女',16,'2020-9-1','CLASS3','C01','2020-11-1',61,'EXAMTYPE1','N',@rtn_str output;

declare @rtn_str varchar(50)
exec insert_update_delete_student 'update','ST001','','',0,'2020-9-1','','C01','2020-11-1',89,'EXAMTYPE1','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST001','','',0,'2020-9-1','','C02','2020-11-2',90,'EXAMTYPE1','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST001','','',0,'2020-9-1','','C03','2020-11-3',70,'EXAMTYPE2','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST002','','',0,'2020-9-1','','C01','2020-12-1',40,'EXAMTYPE1','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST002','','',0,'2020-9-1','','C02','2020-12-2',60,'EXAMTYPE1','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST002','','',0,'2020-9-1','','C03','2020-12-3',80,'EXAMTYPE3','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST003','','',0,'2020-9-1','','C01','2020-12-8',50,'EXAMTYPE1','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST003','','',0,'2020-9-1','','C02','2020-12-9',60,'EXAMTYPE2','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST003','','',0,'2020-9-1','','C03','2020-12-10',80,'EXAMTYPE3','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST004','','',0,'2020-9-1','','C01','2020-11-15',40,'EXAMTYPE1','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST004','','',0,'2020-9-1','','C02','2020-11-16',90,'EXAMTYPE2','Y',@rtn_str output;
exec insert_update_delete_student 'update','ST004','','',0,'2020-9-1','','C03','2020-11-17',80,'EXAMTYPE3','Y',@rtn_str output;



exec insert_update_delete_exam 0,'ST001','C01','2021-7-28 12:00:00',89,'1';
exec insert_update_delete_exam 0,'ST001','C02','2021-7-28 12:01:00',90,'1';
exec insert_update_delete_exam 0,'ST001','C03','2021-7-28 12:02:00',70,'2';
exec insert_update_delete_exam 0,'ST002','C01','2021-7-28 12:03:00',50,'1';
exec insert_update_delete_exam 0,'ST002','C02','2021-7-28 12:04:00',90,'1';
exec insert_update_delete_exam 0,'ST002','C03','2021-7-28 12:05:00',70,'2';
exec insert_update_delete_exam 0,'ST003','C01','2021-7-28 12:06:00',40,'1';
exec insert_update_delete_exam 0,'ST003','C02','2021-7-28 12:07:00',80,'1';
exec insert_update_delete_exam 0,'ST003','C03','2021-7-28 12:08:00',60,'2';
exec insert_update_delete_exam 0,'ST004','C01','2021-7-28 12:09:00',80,'1';
exec insert_update_delete_exam 0,'ST004','C02','2021-7-28 12:10:00',70,'1';
exec insert_update_delete_exam 0,'ST004','C03','2021-7-28 12:11:00',50,'2';





insert into course (course_id,course_no,course_name) values (newid(),'C01','语文');
insert into course (course_id,course_no,course_name) values (newid(),'C02','数学');
insert into course (course_id,course_no,course_name) values (newid(),'C03','英语');
insert into course (course_id,course_no,course_name) values (newid(),'C04','物理');
insert into course (course_id,course_no,course_name) values (newid(),'C05','化学');
insert into course (course_id,course_no,course_name) values (newid(),'C06','历史');

insert into examtype(examtype_no,examtype_name) values ('EXAMTYPE1','期中考试');
insert into examtype(examtype_no,examtype_name) values ('EXAMTYPE2','期末考试');
insert into examtype(examtype_no,examtype_name) values ('EXAMTYPE3','测试');



declare @rtn_str varchar(50)
exec insert_update_delete_teacher 'insert','T001','张老师','男',36,'2020-9-1','C01','N',@rtn_str output;
exec insert_update_delete_teacher 'insert','T002','王老师','男',30,'2018-9-1','C02','N',@rtn_str output;
exec insert_update_delete_teacher 'insert','T003','李老师','男',42,'2011-9-1','C03','N',@rtn_str output;
exec insert_update_delete_teacher 'insert','T004','赵老师','女',31,'2009-9-1','C03','N',@rtn_str output;
exec insert_update_delete_teacher 'insert','T005','周老师','女',37,'2019-9-1','C04','N',@rtn_str output;
exec insert_update_delete_teacher 'insert','T006','吴老师','女',38,'2018-9-1','C05','N',@rtn_str output;
exec insert_update_delete_teacher 'insert','T007','魏老师','男',39,'2015-9-1','C06','N',@rtn_str output;

declare @rtn_str varchar(50)
exec insert_update_delete_teacher 'update','T001','','',0,'2020-9-1','C01','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T001','','',0,'2020-9-1','C04','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T002','','',0,'2020-9-1','C02','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T002','','',0,'2020-9-1','C05','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T003','','',0,'2020-9-1','C03','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T003','','',0,'2020-9-1','C06','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T004','','',0,'2020-9-1','C03','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T005','','',0,'2020-9-1','C05','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T005','','',0,'2020-9-1','C04','Y',@rtn_str output;
exec insert_update_delete_teacher 'update','T006','','',0,'2020-9-1','C06','Y',@rtn_str output;
print(@rtn_str)


select * from teacher;
select * from teacherinfo;
select * from teachercourse;
select * from student;
select * from studentinfo;
select * from studentCourse;
select * from exam;
select * from course;
select * from examtype;

select t1.teacher_id,t2.teacher_no,t1.course_id,t3.course_no
from teacherCourse t1
left join teacher t2 on t1.teacher_id=t2.teacher_id
left join course t3 on t1.course_id=t3.course_id;





--学生课程
if exists(select 1 from sys.views where name = 'v_student_course')
drop view v_student_course
go
create view v_student_course as
select t1.student_id,student_no,student_name,student_sex,student_age,student_date,student_class,t1.course_id,course_no,course_name
from studentCourse as t1
left join student t2 on t1.student_id=t2.student_id
left join course t3 on t1.course_id=t3.course_id
left join studentinfo t4 on t1.student_id=t4.student_id;

select * from v_student_course order by student_no,course_no;


--教师课程
if exists(select 1 from sys.views where name = 'v_teacher_course')
drop view v_teacher_course;
go
create view v_teacher_course as
select t1.teacher_id,teacher_no,teacher_name,teacher_sex,teacher_age,teacher_date,t1.course_id,t3.course_no,t3.course_name
from teacherCourse as t1
left join teacher t2 on t1.teacher_id=t2.teacher_id
left join course t3 on t1.course_id=t3.course_id
left join teacherinfo t4 on t1.teacher_id=t4.teacher_id;

select * from v_teacher_course;


--学生成绩
if exists(select 1 from sys.views where name = 'v_student_exam')
drop view v_student_exam;
go
create view v_student_exam as
select t1.student_id,student_no,student_name,student_sex,student_age,student_date,student_class,t1.course_id,t3.course_no,t3.course_name,t1.exam_date,t1.exam_score,t1.exam_type,t5.examtype_name
from exam as t1
left join student t2 on t1.student_id=t2.student_id
left join course t3 on t1.course_id=t3.course_id
left join studentinfo t4 on t1.student_id=t4.student_id
left join examtype t5 on t1.exam_type=t5.examtype_no;

select * from v_student_exam;


--学生未选课程
if exists(select 1 from sys.views where name = 'v_student_noselected_course')
drop view v_student_noselected_course;
go
create view v_student_noselected_course as
select a.student_id,a.student_no,c.student_name,c.student_sex,c.student_age,c.student_date,student_class,a.course_id,a.course_no,a.course_name
from (select * from student,course) a
left join studentcourse b on a.student_id = b.student_id and a.course_id = b.course_id,
studentinfo c
where b.student_id is null and a.student_id=c.student_id;

select * from v_student_noselected_course order by student_no,course_no;


--select a.student_id,a.student_no,b.student_name,b.student_sex,b.student_age,b.student_date,student_class,a.course_id,a.course_no,a.course_name
--from (select * from student,course) a,studentinfo b
--where not exists (select 1 from studentCourse where a.student_id = student_id and a.course_id = course_id)
--and a.student_id=b.student_id;


if exists(select 1 from sys.views where name = 'v_student_course')
drop view v_student_course;
go
create view v_student_course as
select a.student_id,a.student_no,c.student_name,c.student_sex,c.student_age,c.student_date,c.student_class,a.course_id,a.course_name,
	   (case when b.student_id is null then null else a.course_no end) select_course,
	   (case when b.student_id is null then a.course_no else null end) unselect_course
from (select * from student,course) a
left join studentcourse b on a.student_id = b.student_id and a.course_id = b.course_id,
studentinfo c
where  a.student_id=c.student_id;

select * from v_student_course order by student_id,course_id;




if exists(select 1 from sys.views where name = 'v_student_course')
drop view v_student_course;
go
create view v_student_course as
select a.student_id,a.student_no,c.student_name,c.student_sex,c.student_age,c.student_date,c.student_class,a.course_id,a.course_name,a.course_no,
	   (case when b.student_id is null then '' else a.course_no end) select_course,
	   (case when b.student_id is null then a.course_no else '' end) unselect_course
from (select * from student,course) a
left join studentcourse b on a.student_id = b.student_id and a.course_id = b.course_id,
studentinfo c
where  a.student_id=c.student_id;


select * from v_student_course order by student_no,unselect_course,select_course;


