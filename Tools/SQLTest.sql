
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

--drop table student;
create table student(
	st_id	char(10),
	st_no	varchar(10)
);

--drop table studentinfo;
create table studentinfo(
	st_id	char(10) not null foreign key references student(st_id),
	primary key(st_id),
	st_name	varchar(10),
	st_sex	char(2),
	st_age	int,
	st_class	varchar(10)
);

--drop table teacher;
create table teacher(
	tno		char(10) not null primary key,
	tname	varchar(10),
	tsex	char(2),
	tage	int
);

--drop table course;
create table course(
	cno		char(10) not null primary key,
	cname	varchar(10)
);

--drop table teacherCourse;
create table teacherCourse(
	tno		char(10) not null foreign key references teacher(tno),
	cno		char(10) not null foreign key references course(cno),
	primary key (tno,cno),
);

--drop table exam;
create table exam(
	sno		char(10) not null foreign key references student(sno),
	cno		char(10) not null foreign key references course(cno),
	number	int	not null,
	primary key (sno,cno,number),
	score	float
);

insert into student (sno,sname,ssex,sage,class) values 
('1001','张三','男',15,'class1'),
('1002','李四','男',17,'class1'),
('1003','王五','女',18,'class2'),
('1004','赵六','男',14,'class3'),
('1005','李静','女',15,'class4'),
('1006','王雯','女',16,'class3');

select * from student;
delete student;

delete student where sno = '1001';
update student set sage = 20 where sno = '1002';


insert into ParentInfo (sno,parents,pname,pphone) values 
('1001','父','张三父','12345678901'),
('1001','母','张三母','65412057'),
('1002','父','李四父','11111111111'),
('1002','母','李四母','22222222222'),
('1003','父','王五父','65417512'),
('1003','母','王五母','68417524'),
('1004','父','赵六父','33652312542'),
('1004','母','赵六母','85471254'),
('1005','父','李静父','68541254'),
('1005','母','李静母','47512365412'),
('1006','父','王雯父','13542685423'),
('1006','母','王雯母','64582193');

select * from parentinfo;
insert into parentinfo (sno,parents) values ('1001','');


insert into teacher (tno,tname,tsex,tage) values
('T001','张老师','男',36),
('T002','王老师','男',30),
('T003','李老师','男',42),
('T004','赵老师','女',31),
('T005','周老师','女',37),
('T006','吴老师','女',38);

select * from teacher;


insert into course (cno,cname) values
('C01','语文'),
('C02','数学'),
('C03','英语'),
('C04','物理'),
('C05','化学'),
('C06','历史');

select * from course;

insert into teacherCourse (tno,cno) values
('T001','C01'),
('T001','C02'),
('T002','C03'),
('T003','C03'),
('T004','C04'),
('T005','C05'),
('T005','C06'),
('T006','C06'),
('T006','C01'),
('T001','C04');

select * from teacherCourse order by tno;
select * from teacherCourse order by cno;


insert into exam (sno,cno,number,score) values
('1001','C01',1,64),('1001','C01',2,75),('1001','C01',3,73),('1001','C02',1,85),('1001','C02',2,90),('1001','C02',3,86),('1001','C03',1,87),
('1002','C01',1,80.5),('1002','C01',2,86),('1002','C01',3,90),('1002','C02',1,96.5),('1002','C02',2,98),('1002','C02',3,91),('1002','C03',1,70),
('1003','C01',1,65),('1003','C01',2,58),('1003','C01',3,80.5),('1003','C02',1,60),('1003','C02',2,70.5),('1003','C02',3,83),('1003','C03',1,90),
('1004','C01',1,76),('1004','C01',2,78),('1004','C01',3,79),('1004','C02',1,86.5),('1004','C02',2,89),('1004','C02',3,93),('1004','C03',1,88),
('1005','C01',1,96),('1005','C01',2,94),('1005','C01',3,95),('1005','C02',1,99),('1005','C02',2,97.5),('1005','C02',3,96),('1005','C03',1,93),
('1006','C01',1,87),('1006','C01',2,88),('1006','C01',3,86),('1006','C02',1,60),('1006','C02',2,88),('1006','C02',3,85),('1006','C03',1,90);


insert into exam (sno,cno,number,score) values
('1001','C04',1,53),('1001','C04',2,65),('1001','C06',1,60),('1001','C06',2,70),
('1002','C05',1,70),('1002','C05',2,65),
('1003','C05',1,40),('1003','C05',2,65),('1003','C06',1,56),('1003','C06',2,43),
('1004','C04',1,65),('1004','C04',2,73);
delete exam;

select * from exam;

select getdate();



--C02比C01成绩好的学号
select a.sno,a.score,b.score 
from (select sno,sum(score) score from exam where cno = 'C01' group by sno) a,
	 (select sno,sum(score) score from exam where cno = 'C02' group by sno) b
where a.score < b.score and a.sno = b.sno;

--平均分大于80分
select sno,avg(score) from exam group by sno having avg(score) > 80;

--所有学生姓名 选修课 总成绩
select sno,(select sname from student where student.sno = exam.sno) sname,cno,sum(score)
from exam
group by sno,cno;


--所教课程没有成绩记录的老师
select tno,cno,(select tname from teacher where teacher.tno = teacherCourse.tno)
from teacherCourse
where cno not in (select cno from exam);

--成绩小于60的学生，课程，成绩
select exam.sno,sname,cno,number,score
from student,exam
where student.sno = exam.sno
and score < 60;

--查询两门以上不及格课程的学号  平均成绩
select sno,avg(score) 
from exam 
where sno in (select sno from exam where score < 60 group by sno having count(1)>2)
group by sno;


--查询每门课最高的一个分数
select t1.sno,t1.cno,t1.score
from exam t1,(select cno,max(score) score from exam group by cno) t2
where t1.cno = t2.cno and t1.score = t2.score order by cno;


--将T005教师的课程全部加10分
select * from exam where cno in (select cno from teachercourse where tno = 'T005');
update exam set score = (case when score > 90 then 100 else score + 10 end) from teachercourse where tno = 'T005' and teacherCourse.cno = exam.cno;


--删除T004教师教的学生的父母信息
select * from parentinfo;
delete parentinfo from exam where exam.sno = parentinfo.sno and exam.cno in (select cno from teacherCourse where tno = 'T004');

--新增一条1003  C06课程的考试记录
select * from exam where cno = 'C06' and sno = '1003';
insert into exam select sno,cno,max(number) + 1,70 from exam where cno = 'C06' and sno = '1003' group by sno,cno;





select (select sname from student where student.sno = exam.sno) sname ,(select cname from course where course.cno = exam.cno) cname,score from exam where sno = '1003' and cno = 'C06';


--1.范式  满足第三范式
--2.查询  多使用join   union   少用子查询
--3.view  多表查询先建立视图
--4.procedure   多表更新使用存储过程

--字段名完整易懂
--头表明细表结构  头表需要内键  唯一主键，内部使用
--需要完整关联表   学生 课程 教师  又要有关联表
--看书，书上有完整教程  SQL的艺术
--成绩表不要用序号计数，使用日期记录考试时间  和考试类型  同时建立一张考试类型表