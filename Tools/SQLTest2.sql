if exists(select * from sys.tables where name='student')
drop table student;
go
create table student(
	st_id	char(10) not null primary key,
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
	th_id	char(10) not null primary key,
	th_no	varchar(10)
);

--drop table teacherinfo
create table teacherinfo(
	th_id	char(10) not null primary key foreign key references teacher(th_id),
	th_name	varchar(10),
	th_sex	char(2),
	th_age	int
);

--drop table course;
create table course(
	cr_id	char(10) not null primary key,
	cr_no	varchar(10),
	cr_name	varchar(10)
);

--drop table teacherCourse;
create table teacherCourse(
	th_id	char(10) not null foreign key references teacher(th_id),
	cr_id	char(10) not null foreign key references course(cr_id),
	primary key (th_id,cr_id),
);

--drop table studentCourse;
create table studentCourse(
	st_id	char(10) not null foreign key references student(st_id),
	cr_id	char(10) not null foreign key references course(cr_id),
	primary key (st_id,cr_id),
);

--drop table exam;
create table exam(
	st_id char(10) not null,
	cr_id char(10) not null,
	exam_date	datetime,
	primary key (st_id,cr_id,exam_date),
	exam_score	float,
	exam_type	char(10)
);



--drop table examtype
create table examtype(
	examtype_id		char(10) not null primary key,
	examtype_name	varchar(10)
);

if exists(select * from sys.procedures where name='insert_update_student')
drop procedure insert_update_student;
go
create proc insert_update_student
	@st_id	char(10),
	@st_no	varchar(10),
	@st_name	varchar(10),
	@st_sex	varchar(2),
	@st_age	int,
	@st_class	varchar(10)
as
declare @count int
select @count=count(1) from student where trim(st_id) = @st_id;
if(@count > 0)
	begin
	update student set st_no=@st_no where st_id=@st_id;
	update studentinfo set st_name=@st_name,st_sex=@st_sex,st_age=@st_age,st_class=@st_class where st_id=@st_id;
	end
else
	begin
	insert into student (st_id,st_no) values (@st_id,@st_no);
	insert into studentinfo (st_id,st_name,st_sex,st_age,st_class) values (@st_id,@st_name,@st_sex,@st_age,@st_class);
	end

exec insert_update_student '1','ST001','张三','男',15,'CLASS1';
exec insert_update_student '2','ST002','李四','男',17,'CLASS1';
exec insert_update_student '3','ST003','王五','女',18,'CLASS2';
exec insert_update_student '4','ST004','赵六','男',14,'CLASS3';
exec insert_update_student '5','ST005','李静','女',15,'CLASS4';
exec insert_update_student '6','ST006','王雯','女',16,'CLASS3';
select * from student;
select * from studentinfo;


if exists(select * from sys.procedures where name='insert_update_teacher')
drop procedure insert_update_teacher;
go
create proc insert_update_teacher
	@th_id	char(10),
	@th_no	varchar(10),
	@th_name	varchar(10),
	@th_sex	varchar(2),
	@th_age	int
as
declare @count int
select @count=count(1) from teacher where trim(th_id) = @th_id;
if(@count > 0)
	begin
	update teacher set th_no=@th_no where th_id=@th_id;
	update teacherinfo set th_name=@th_name,th_sex=@th_sex,th_age=@th_age where th_id=@th_id;
	end
else
	begin
	insert into teacher (th_id,th_no) values (@th_id,@th_no);
	insert into teacherinfo (th_id,th_name,th_sex,th_age) values (@th_id,@th_name,@th_sex,@th_age);
	end


exec insert_update_teacher '1','T001','张老师','男',36;
exec insert_update_teacher '2','T002','王老师','男',30;
exec insert_update_teacher '3','T003','李老师','男',42;
exec insert_update_teacher '4','T004','赵老师','女',31;
exec insert_update_teacher '5','T005','周老师','女',37;
exec insert_update_teacher '6','T006','吴老师','女',38;
exec insert_update_teacher '7','T011','魏老师','男',39;

select * from teacher;
select * from teacherinfo;


if exists(select * from sys.procedures where name='insert_update_course')
drop procedure insert_update_course;
go
create proc insert_update_course
	@cr_id	char(10),
	@cr_no	varchar(10),
	@cr_name	varchar(10)
as
declare @count int
select @count=count(1) from course where trim(cr_id) = @cr_id;
if(@count > 0)
	begin
	update course set cr_no=@cr_no,cr_name=@cr_name where cr_id=@cr_id;
	end
else
	begin
	insert into course (cr_id,cr_no,cr_name) values (@cr_id,@cr_no,@cr_name);
	end

exec insert_update_course '1','C01','语文';
exec insert_update_course '2','C02','数学';
exec insert_update_course '3','C03','英语';
exec insert_update_course '4','C04','物理';
exec insert_update_course '5','C05','化学';
exec insert_update_course '6','C06','历史';

select * from course;

if exists(select * from sys.procedures where name='delete_info')
drop procedure delete_info;
go
create proc delete_info
	@id	char(10),
	@tbl_name	varchar(20)
as
if(@tbl_name='student')
	begin
	delete from studentCourse where st_id=@id;
	delete from studentinfo where st_id=@id;
	delete from student where st_id=@id;	
	end

if(@tbl_name='teacher')
	begin
	delete from teacherCourse where th_id=@id;
	delete from teacherinfo where th_id=@id;
	delete from teacher where th_id=@id;	
	end

if(@tbl_name='course')
	begin
	delete from studentCourse where cr_id=@id;
	delete from teacherCourse where cr_id=@id;
	delete from course where cr_id=@id;	
	end

exec delete_info '1','student';
exec delete_info '1','teacher';
exec delete_info '1','course';
select * from teacherinfo;


if exists(select * from sys.procedures where name='insert_delete_studentcourse')
drop procedure insert_delete_studentcourse;
go
create proc insert_delete_studentcourse
	@delete_flg	int,
	@st_no	varchar(10),
	@cr_no	varchar(10),
	@rtn_str	varchar(20)	output
as
declare @st_id char(10),
		@cr_id char(10)
select @st_id=st_id from student where st_no = @st_no;
select @cr_id=cr_id from course where cr_no = @cr_no;
if(@st_id='' or @st_id is null)
	begin
	set @rtn_str='学号不存在';
	end
if(@cr_id='' or @cr_id is null)
	begin
	set @rtn_str='课程号不存在';
	end
if(@delete_flg=1)
	begin
	delete from studentCourse where st_id=@st_id and cr_id=@cr_id;
	set @rtn_str='删除成功';
	end	
else
	begin
	insert into studentCourse (st_id,cr_id) values (@st_id,@cr_id);
	set @rtn_str='创建成功';
	end

declare @rtn varchar(20)
exec insert_delete_studentcourse 0,'ST001','C01',@rtn output;
print(@rtn)


if exists(select * from sys.procedures where name='proc_test')
drop procedure proc_test;
go
create proc proc_test
	@para1	varchar(10),
	@para2	varchar(10),
	@para3	varchar(10),
	@rtn_str	varchar(20) output
as
begin
set @rtn_str='都是';
end

declare @rtn1 varchar(20)
exec proc_test '','','',@rtn1 output;
print(@rtn1)



select * from studentcourse;

exec insert_delete_studentcourse 0,'ST001','C01';
exec insert_delete_studentcourse 0,'ST001','C02';
exec insert_delete_studentcourse 0,'ST001','C03';
exec insert_delete_studentcourse 0,'ST001','C04';
exec insert_delete_studentcourse 0,'ST002','C01';
exec insert_delete_studentcourse 0,'ST002','C02';
exec insert_delete_studentcourse 0,'ST002','C03';
exec insert_delete_studentcourse 0,'ST003','C01';
exec insert_delete_studentcourse 0,'ST003','C02';
exec insert_delete_studentcourse 0,'ST003','C03';
exec insert_delete_studentcourse 0,'ST003','C05';
exec insert_delete_studentcourse 0,'ST004','C01';
exec insert_delete_studentcourse 0,'ST004','C02';
exec insert_delete_studentcourse 0,'ST004','C03';



if exists(select * from sys.procedures where name='insert_delete_teachercourse')
drop procedure insert_delete_teachercourse;
go
create proc insert_delete_teachercourse
	@delete_flg	int,
	@th_no	varchar(10),
	@cr_no	varchar(10)
	--@ret_str	int output
as
declare @th_id char(10),
		@cr_id char(10)
select @th_id=th_id from teacher where th_no = @th_no;
select @cr_id=cr_id from course where cr_no = @cr_no;
if(@th_id='' or @th_id is null)
	--set @ret_str=111;
	return -1;
if(@cr_id='' or @cr_id is null)
	--set @ret_str=222;
	return -2;
if(@delete_flg=1)
	begin
	delete from teacherCourse where th_id=@th_id and cr_id=@cr_id;
	--set @ret_str=333;
	return 1;
	end
else
	begin
	insert into teacherCourse (th_id,cr_id) values (@th_id,@cr_id);
	--set @ret_str=444;
	return 0;
	end

select * from teacherCourse;
exec insert_delete_teachercourse 0,'T001','C01';
exec insert_delete_teachercourse 0,'T001','C04';
exec insert_delete_teachercourse 0,'T002','C02';
exec insert_delete_teachercourse 0,'T002','C05';
exec insert_delete_teachercourse 0,'T003','C03';
exec insert_delete_teachercourse 0,'T003','C06';
exec insert_delete_teachercourse 0,'T004','C03';
exec insert_delete_teachercourse 0,'T005','C05';
exec insert_delete_teachercourse 0,'T006','C04';
exec insert_delete_teachercourse 0,'T006','C06';




if exists(select * from sys.procedures where name='insert_update_delete_examtype')
drop procedure insert_update_delete_examtype;
go
create proc insert_update_delete_examtype
	@delete_flg	int,
	@examtype_id	char(10),
	@examtype_name	varchar(10)
as
if(@delete_flg=1)
	begin
	delete from examtype where examtype_id=@examtype_id;
	return 1;
	end
else
	declare @count int
	select @count=count(1) from examtype where trim(examtype_id) = @examtype_id;
	if(@count > 0)
		begin
		update examtype set examtype_name=@examtype_name where examtype_id=@examtype_id;
		return 2;
		end
	else
		begin
		insert into examtype (examtype_id,examtype_name) values (@examtype_id,@examtype_name);
		return 0;
		end

select * from examtype;

exec insert_update_delete_examtype 0,'1','期中考试';
exec insert_update_delete_examtype 0,'2','期末考试';



if exists(select * from sys.procedures where name='insert_update_delete_exam')
drop procedure insert_update_delete_exam;
go
create proc insert_update_delete_exam
	@delete_flg	int,
	@st_no	varchar(10),
	@cr_no	varchar(10),
	@exam_date	datetime,
	@exam_score	int,
	@exam_type char(10)
as
declare @st_id char(10),
		@cr_id char(10),
		@typecount int
select @st_id=st_id from student where st_no = @st_no;
select @cr_id=cr_id from course where cr_no = @cr_no;
if(@st_id='' or @st_id is null)
	return -1;
if(@cr_id='' or @cr_id is null)
	return -2;
select count(1)

if(@delete_flg=1)
	begin
	delete from exam where st_id=@st_id and cr_id=@cr_id and exam_date=@exam_date;
	return 1;
	end
else
	declare @count int
	select @count=count(1) from exam where st_id=@st_id and cr_id=@cr_id and exam_date=@exam_date;
	if(@count > 0)
		begin
		update exam set exam_score=@exam_score,exam_type=@exam_type where st_id=@st_id and cr_id=@cr_id and exam_date=@exam_date;
		return 2;
		end
	else
		begin
		insert into exam (st_id,cr_id,exam_date,exam_score,exam_type) values (@st_id,@cr_id,@exam_date,@exam_score,@exam_type);
		return 0;
		end

declare @return int
exec @return=insert_update_delete_exam 0,'ST001','C01','2021-7-28 12:00:00',89,'1';
print(@return);

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
select * from exam;



if exists(select 1 from sys.views where name = 'v_student_course')
drop view v_student_course
go
create view v_student_course as
select t1.st_id,st_no,st_name,st_sex,st_age,st_class,t1.cr_id,cr_no,cr_name
from studentCourse as t1
left join student t2 on t1.st_id=t2.st_id
left join course t3 on t1.cr_id=t3.cr_id
left join studentinfo t4 on t1.st_id=t4.st_id;

select * from v_student_course;
select st_id,st_no from student;
select st_id,st_name,st_sex,st_class from studentinfo;
select st_id,cr_id from studentcourse;
select cr_id,cr_no,cr_name from course;



if exists(select 1 from sys.views where name = 'v_teacher_course')
drop view v_teacher_course;
go
create view v_teacher_course as
select t1.th_id,th_no,th_name,th_sex,th_age,t1.cr_id,cr_no,cr_name
from teacherCourse as t1
left join teacher t2 on t1.th_id=t2.th_id
left join course t3 on t1.cr_id=t3.cr_id
left join teacherinfo t4 on t1.th_id=t4.th_id;

select * from v_teacher_course;

select th_id,th_no from teacher;
select th_id,th_name,th_sex,th_age from teacherinfo;
select th_id,cr_id from teacherCourse;
select cr_id,cr_no,cr_name from course;





if exists(select 1 from sys.views where name = 'v_student_exam')
drop view v_student_exam;
go
create view v_student_exam as
select t1.st_id,st_no,st_name,st_sex,st_age,st_class,t1.cr_id,cr_no,cr_name,exam_date,exam_score,exam_type,examtype_name
from exam as t1
left join student t2 on t1.st_id=t2.st_id
left join course t3 on t1.cr_id=t3.cr_id
left join studentinfo t4 on t1.st_id=t4.st_id
left join examtype t5 on t1.exam_type=t5.examtype_id;

select * from v_student_exam;

select st_id,st_no from student;
select st_id,st_name,st_sex,st_class from studentinfo;
select cr_id,cr_no,cr_name from course;
select st_id,cr_id,exam_date,exam_score,exam_type from exam;
select examtype_id,examtype_name from examtype;









