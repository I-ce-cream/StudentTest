--教师信息更新
if exists(select * from sys.procedures where name='insert_update_delete_teacher')
drop procedure insert_update_delete_teacher;
go
create proc insert_update_delete_teacher
	@type			char(10),--指定修改类型
	@teacher_no		varchar(10),
	@teacher_name	varchar(10),
	@teacher_sex	char(2),
	@teacher_age	int,
	@teacher_date	date,
	@course_no		varchar(10),
	@teacherCourse_only	varchar(1),
	@return_message	varchar(50) output
as
declare @teacher_id uniqueidentifier,
		@course_id	uniqueidentifier,
		@return	int

begin transaction
if(@type='insert')
	begin
	if exists (select 1 from teacher where teacher_no=@teacher_no)
		begin
		set @return_message='教师号已经存在';
		rollback transaction
		return 0
		end

	set @teacher_id = newid();
	insert into teacher (teacher_id,teacher_no) values (@teacher_id,@teacher_no);
	insert into teacherinfo (teacher_id) values (@teacher_id);
	exec @return=insert_update_delete_teacher 'update',@teacher_no,@teacher_name,@teacher_sex,@teacher_age,@teacher_date,@course_no,@teacherCourse_only,@return_message output;
	if(@return = 0)
		return 0
	end

if(@type='update')
	begin
	select @teacher_id=teacher_id from teacher where teacher_no=@teacher_no;
	if(@teacher_id is null)
		begin
		set @return_message='教师号不存在';
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

	if(@teacherCourse_only = 'N')
		begin
		update teacher set teacher_no=@teacher_no where teacher_id=@teacher_id;

		update teacherinfo 
		set teacher_name=@teacher_name, teacher_sex=@teacher_sex,teacher_age=@teacher_age,teacher_date=@teacher_date
		where teacher_id=@teacher_id;
		end
	
	if not exists(select 1 from teacherCourse where teacher_id=@teacher_id and course_id=@course_id)
		insert into teacherCourse (teacher_id,course_id) values (@teacher_id,@course_id);

	end

if(@type='delete')
--信息记录表不删除
	begin
	select @teacher_id=teacher_id from teacher where teacher_no=@teacher_no;
	if(@teacher_id is null)
		begin
		set @return_message='教师号不存在';
		rollback transaction
		return 0
		end	

	delete from teacher where teacher_id=@teacher_id;
	set @return_message='删除成功';
	end
commit transaction
return 1;