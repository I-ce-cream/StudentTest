--django

select * from sys.messages;

--创建数据库
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



select * from student;
select * from studentinfo;


--学生表
--建立外键  关闭强制外键约束
alter table studentinfo with nocheck add constraint [FK_Student_Id] foreign key (student_id) references student (student_id);
go
alter table studentinfo nocheck constraint [FK_Student_Id];
go
--建立索引
CREATE UNIQUE INDEX FK_studentinfo ON studentinfo (student_id);


select * from student;
select * from course;
select * from examtype;
select * from exam;
--学生课程表
alter table studentCourse with nocheck add constraint [FK_studentCourse_studentID] foreign key (student_id) references student (student_id);
go
alter table studentCourse with nocheck add constraint [FK_studentCourse_courseID] foreign key (course_id) references course (course_id);
go
alter table studentCourse nocheck constraint [FK_studentCourse_courseID],[FK_studentCourse_studentID];
go
--create clustered index FK_studentCourse on studentCourse (student_id,course_id);


--成绩表
alter table exam with nocheck add constraint [FK_exam_studentID] foreign key (student_id) references student (student_id);
go
alter table exam with nocheck add constraint [FK_exam_courseID] foreign key (course_id) references course (course_id);
go
alter table exam with nocheck add constraint [FK_exam_examtypeNo] foreign key (examtype_no) references examtype (examtype_no);
go
alter table exam nocheck constraint [FK_exam_studentID],[FK_exam_courseID],[FK_exam_examtypeNo];
go
--create clustered index FK_exam on exam (student_id,course_id,exam_date);


--学生信息视图
if exists(select 1 from sys.views where name = 'v_student_info')
drop view v_student_info
go
create view v_student_info as
select a.student_id,a.student_no,b.student_name,b.student_sex,b.student_age,b.student_date,b.registration_date,b.student_class
from student a
left join studentinfo b on a.student_id = b.student_id;

select * from v_student_info;


--学生选课视图 同时显示已选课程和未选课程
if exists(select 1 from sys.views where name = 'v_student_course')
drop view v_student_course;
go
create view v_student_course as
select a.student_id,a.student_no,c.student_name,c.student_sex,c.student_age,c.student_date,c.student_class,a.course_id,a.course_name,a.course_no,
	   (case when b.student_id is null then '-' else a.course_no end) select_course,
	   (case when b.student_id is null then a.course_no else '-' end) unselect_course
from (select * from student,course) a
left join studentcourse b on a.student_id = b.student_id and a.course_id = b.course_id,
studentinfo c
where  a.student_id=c.student_id;


select * from v_student_course;



--学生成绩视图
if exists(select 1 from sys.views where name = 'v_exam')
drop view v_exam;
go
create view v_exam as
select a.id,a.student_id,b.student_no,c.student_name,a.course_id,d.course_no,d.course_name,convert(varchar(100),a.exam_date,20) exam_date,a.exam_score,a.examtype_no,e.examtype_name
from exam a
left join student b on a.student_id = b.student_id
left join studentinfo c on a.student_id = c.student_id
left join course d on a.course_id = d.course_id
left join examtype e on a.examtype_no = e.examtype_no;

select * from v_exam;



--学生表 创建  修改  删除
select * from student;
select * from studentinfo;

if exists(select * from sys.procedures where name='student_insert')
drop procedure student_insert;
go
create proc student_insert
	@student_no		varchar(10),
	@student_name	varchar(10),
	@student_sex	varchar(2),
	@student_age	int,
	@student_class	varchar(10),
	@student_date	date,
	@registration_date	date,
	@return_message	varchar(50) output
as
begin
	begin transaction
	if exists (select 1 from student where student_no=@student_no)
		begin
		set @return_message='学号已经存在';
		rollback transaction;
		return 0
		end

	begin try
		insert into student (student_no) values (@student_no);

		declare @student_id int
		select @student_id=student_id from student where trim(student_no)=@student_no;

		insert into studentinfo (student_name,student_sex,student_age,student_date,student_class,student_id,registration_date)
		values (@student_name,@student_sex,@student_age,@student_date,@student_class,@student_id,@registration_date);

		commit;
	end try
	begin catch
		rollback transaction;
		set @return_message=ERROR_MESSAGE();
		return ERROR_STATE()
	end catch
end


declare @rtn_str varchar(50)
exec student_insert '123','321','男','abc','CLASS1','2020-9-1','2020-11-1',@rtn_str output;
print(@rtn_str)


if exists(select * from sys.procedures where name='student_update')
drop procedure student_update;
go
create proc student_update
	@student_no		varchar(10),
	@student_name	varchar(10),
	@student_sex	varchar(2),
	@student_age	int,
	@student_class	varchar(10),
	@student_date	date,
	@registration_date	date,
	@return_message	varchar(50) output
as
begin
	begin transaction
	begin try
		declare @student_id int
		select @student_id=student_id from student where trim(student_no)=@student_no;
		if(@student_id is null or @student_id = '')
			begin
			set @return_message='学号不存在';
			rollback transaction;
			return 0
			end
		
		update studentinfo 
		set student_name=@student_name,student_sex=@student_sex,student_age=@student_age,student_date=@student_date,
						 student_class=@student_class,registration_date=@registration_date
		where student_id=@student_id;
		commit;
	end try
	begin catch
		rollback transaction;
		set @return_message=ERROR_MESSAGE();
		return ERROR_STATE()
	end catch
end


declare @rtn_str varchar(50)
exec student_update '999','321','男','dv','CLASS1','2020-9-1','2020-11-1',@rtn_str output;
print(@rtn_str)

select * from student;

if exists(select * from sys.procedures where name='student_delete')
drop procedure student_delete;
go
create proc student_delete
	@student_no		varchar(10),
	@return_message	varchar(50) output
as
begin
	begin transaction
	begin try
		declare @student_id int
		select @student_id=student_id from student where trim(student_no)=@student_no;
		if(@student_id is null or @student_id = '')
			begin
			set @return_message='学号不存在';
			rollback transaction;
			return 0
			end

		delete from studentinfo where student_id=@student_id;
		delete from student where student_id=@student_id;
		commit;
	end try
	begin catch
		rollback transaction;
		set @return_message=ERROR_MESSAGE();
		return ERROR_STATE()
	end catch
end

declare @rtn_str varchar(50)
exec student_delete '999',@rtn_str output;
print(@rtn_str)



--考试类型 创建  修改   删除







--课程 创建  修改  删除





--学生课程关联表 创建 删除







--成绩表 创建 修改  删除














