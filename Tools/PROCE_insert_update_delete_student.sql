--学生信息更新
if exists(select * from sys.procedures where name='insert_update_delete_student')
drop procedure insert_update_delete_student;
go
create proc insert_update_delete_student
	@type			char(10),--指定修改类型
	@student_no		varchar(10),
	@student_name	varchar(10),
	@student_sex	char(2),
	@student_age	int,
	@student_date	date,
	@student_class	varchar(10),
	@course_no		varchar(10),
	@exam_date		datetime,
	@exam_score		float,
	@exam_type		char(10),
	@exam_only		varchar(1),
	@return_message	varchar(50) output
as
declare @count int,
		@student_id uniqueidentifier,
		@course_id	uniqueidentifier,
		@return	int

begin transaction
if(@type='insert')
	begin
	if exists (select 1 from student where student_no=@student_no)
		begin
		set @return_message='学号已经存在';
		rollback transaction
		return 0
		end

	set @student_id = newid();
	insert into student (student_id,student_no) values (@student_id,@student_no);
	insert into studentinfo (student_id) values (@student_id);
	exec @return=insert_update_delete_student 'update',@student_no,@student_name,@student_sex,@student_age,@student_date,@student_class,@course_no,@exam_date,@exam_score,@exam_type,@exam_only,@return_message output;
	if(@return = 0)
		return 0
	end

if(@type='update')
	begin
	select @student_id=student_id from student where student_no=@student_no;
	if(@student_id is null)
		begin
		set @return_message='学号不存在';
		rollback transaction
		return 0
		end		

	select @course_id=course_id from course where course_no=@course_no;
	if(@course_id is null)
		begin
		set @return_message='课程号不存在';
		rollback transaction
		return 0
		end	

	select @count = count(1) from examtype where examtype_no=@exam_type;
	if(@count < 1)
		begin
		set @return_message='考试类型不存在';
		rollback transaction
		return 0
		end	

	if(@exam_only = 'N')
		begin
		update student set student_no=@student_no where student_id=@student_id;

		update studentinfo 
		set student_name=@student_name, student_sex=@student_sex,student_age=@student_age,student_date=@student_date,student_class=@student_class 
		where student_id=@student_id;
		end
	
	if not exists(select 1 from studentCourse where student_id=@student_id and course_id=@course_id)
		insert into studentCourse (student_id,course_id) values (@student_id,@course_id);
		
	if exists(select 1 from exam where student_id=@student_id and course_id=@course_id and exam_date=@exam_date)
		update exam set exam_date=@exam_date,exam_score=@exam_score,exam_type=@exam_type where student_id=@student_id and course_id=@course_id and exam_date=@exam_date;
	else
		insert into exam (student_id,course_id,exam_date,exam_score,exam_type) values (@student_id,@course_id,@exam_date,@exam_score,@exam_type);
	end

if(@type='delete')
--信息记录表不删除
	begin
	select @student_id=student_id from student where student_no=@student_no;
	if(@student_id is null)
		begin
		set @return_message='学号不存在';
		rollback transaction
		return 0
		end	

	delete from student where student_id=@student_id;
	set @return_message='删除成功';
	end
commit transaction
return 1;