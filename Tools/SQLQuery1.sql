--侧边栏  4个页面

--studentlist
--学生 增删改查
--每个学生 可点击打开弹窗 选择课程 student studentinfo studentCourse


--teacherlist
--教师增删改查
--每个教师 可点击打开弹窗  选择课程	teacher teacherinfo teacherCourse


--courselist
--课程 增删改查
--course	course


--考试表
--exam增删改查 可以点击按钮维护考试类型 exam  examtype



drop table student;
select * from student;
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,ST002
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,ST003
-- 96D074BD-40FA-4586-ABB8-B49555130FFA,ST005
-- 0CE426A6-FF04-4B2C-B005-BAFEA6BD6381,ST010
-- A44682E7-7B28-44C3-AC8F-C1D0A08140EB,ST006
-- 9521B081-3806-4677-BA20-D1B641749E76,ST004
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,ST001


drop table studentinfo;
select * from studentinfo ;
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,张三,男,15,2020-09-01,CLASS1
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,李四,男,17,2019-09-01,CLASS1
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,王五,女,18,2021-09-01,CLASS2
-- 9521B081-3806-4677-BA20-D1B641749E76,赵六,男,14,2018-09-01,CLASS3
-- 96D074BD-40FA-4586-ABB8-B49555130FFA,李静,女,15,2019-09-01,CLASS4
-- A44682E7-7B28-44C3-AC8F-C1D0A08140EB,王雯,女,16,2020-09-01,CLASS3
-- 957E3DFB-9958-4AD8-8A43-DE402F21D12B,王超,男,19,2010-09-01,CLASS1

drop table studentCourse;
select * from studentCourse;
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,4C6E627D-02B8-4FF1-AF63-171447183345
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,53FDB116-122B-4C48-BF0F-9AA1ECB314C6
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,A807E11F-BB14-4335-83BC-FEA3113A480A
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,4C6E627D-02B8-4FF1-AF63-171447183345
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,53FDB116-122B-4C48-BF0F-9AA1ECB314C6
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,A807E11F-BB14-4335-83BC-FEA3113A480A
-- 96D074BD-40FA-4586-ABB8-B49555130FFA,4C6E627D-02B8-4FF1-AF63-171447183345
-- A44682E7-7B28-44C3-AC8F-C1D0A08140EB,4C6E627D-02B8-4FF1-AF63-171447183345
-- 9521B081-3806-4677-BA20-D1B641749E76,4C6E627D-02B8-4FF1-AF63-171447183345
-- 9521B081-3806-4677-BA20-D1B641749E76,53FDB116-122B-4C48-BF0F-9AA1ECB314C6
-- 9521B081-3806-4677-BA20-D1B641749E76,A807E11F-BB14-4335-83BC-FEA3113A480A
-- 957E3DFB-9958-4AD8-8A43-DE402F21D12B,4C6E627D-02B8-4FF1-AF63-171447183345
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,4C6E627D-02B8-4FF1-AF63-171447183345
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,53FDB116-122B-4C48-BF0F-9AA1ECB314C6
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,A807E11F-BB14-4335-83BC-FEA3113A480A


drop table course;
drop table teachercourse;
select * from course;
-- 4C6E627D-02B8-4FF1-AF63-171447183345,C01,语文
-- 40F23AAE-BDC3-4758-B626-5B7E94BC3BEF,C05,化学
-- B47BF0FD-9EF6-4A9D-9683-717C5B96805C,C06,历史
-- 53FDB116-122B-4C48-BF0F-9AA1ECB314C6,C03,英语
-- 82916C2D-1F89-465D-95DA-B2792FC5E7F7,C04,物理
-- A807E11F-BB14-4335-83BC-FEA3113A480A,C02,数学

drop table exam;
select * from exam;
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,80,EXAMTYPE1
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,4C6E627D-02B8-4FF1-AF63-171447183345,2020-12-01 00:00:00.000,40,EXAMTYPE1
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,53FDB116-122B-4C48-BF0F-9AA1ECB314C6,2020-12-03 00:00:00.000,80,EXAMTYPE3
-- 0C7D3973-2709-4FA0-A8B1-399F3F5C5CAB,A807E11F-BB14-4335-83BC-FEA3113A480A,2020-12-02 00:00:00.000,60,EXAMTYPE1
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,83,EXAMTYPE1
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,4C6E627D-02B8-4FF1-AF63-171447183345,2020-12-08 00:00:00.000,50,EXAMTYPE1
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,53FDB116-122B-4C48-BF0F-9AA1ECB314C6,2020-12-10 00:00:00.000,80,EXAMTYPE3
-- CB73C570-1543-40C0-A290-B3826AEDD4B8,A807E11F-BB14-4335-83BC-FEA3113A480A,2020-12-09 00:00:00.000,60,EXAMTYPE2
-- 96D074BD-40FA-4586-ABB8-B49555130FFA,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,57,EXAMTYPE1
-- A44682E7-7B28-44C3-AC8F-C1D0A08140EB,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,61,EXAMTYPE1
-- 9521B081-3806-4677-BA20-D1B641749E76,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,91,EXAMTYPE1
-- 9521B081-3806-4677-BA20-D1B641749E76,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-15 00:00:00.000,40,EXAMTYPE1
-- 9521B081-3806-4677-BA20-D1B641749E76,53FDB116-122B-4C48-BF0F-9AA1ECB314C6,2020-11-17 00:00:00.000,80,EXAMTYPE3
-- 9521B081-3806-4677-BA20-D1B641749E76,A807E11F-BB14-4335-83BC-FEA3113A480A,2020-11-16 00:00:00.000,90,EXAMTYPE2
-- 957E3DFB-9958-4AD8-8A43-DE402F21D12B,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,76,EXAMTYPE1
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,4C6E627D-02B8-4FF1-AF63-171447183345,2020-11-01 00:00:00.000,89,EXAMTYPE1
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,53FDB116-122B-4C48-BF0F-9AA1ECB314C6,2020-11-03 00:00:00.000,70,EXAMTYPE2
-- 87DAF9A2-857B-4FE6-8FAB-E28529B708E9,A807E11F-BB14-4335-83BC-FEA3113A480A,2020-11-02 00:00:00.000,90,EXAMTYPE1


select * from examtype;



select * from student;



select * from studentinfo;

select * from course;


select * from studentcourse;

select * from exam;

select * from auth_user;


alter table studentinfo add registration_date date;



select * from student where student_id not in (select student_id from studentinfo);

delete from student where student_id in (26);

delete from student where student_no in ('ST010');




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


select * from v_student_course order by student_no,unselect_course,select_course;


select * from student;
select * from studentinfo;
select * from studentcourse;

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
delete from exam where id = 3;

insert into exam (exam_date,exam_score,course_id,examtype_no,student_id) values ('2021-09-09 09:54:00',11,2,'EXAMTYPE2',2);


select * from exam;


