-- Retrive All Student In specific Exam
create procedure StudentInExam(@ExamID int)
as begin
	select se.Std_ID as 'Student ID', s.Name from StudentExam se inner join Student s 
		on se.Std_ID = s.ID
		where se.Exam_ID = @ExamID
end
-----------------------------------------------------------
-- manager add new student
create procedure AddNewStudent
	@StudentName varchar(50),
	@StudentAge int,
	@DepartmentID int,
	@CourseID int
as
begin
	insert into Student (Name,Age,dept_ID,course_ID)
	values (@StudentName,@StudentAge,@DepartmentID,@CourseID)
end
------------------------------------------------------------
-- manager add new branch
create procedure AddNewBranch
	@BranchName varchar(50)
as
begin	
	insert into Branch
	values (@BranchName)
end
----------------------------------------------------------------
-- manager add new Track
create procedure AddNewTrack
	@TrackName varchar(50)
as
begin
	insert into Track
	values (@TrackName)
end
------------------------------------------------------------------
-- manager add new intake
create procedure AddNewIntake
	@IntakeName varchar(50)
as
begin
	insert into Intake
	values (@IntakeName)
end
--------------------------------------------------------------------
-- manager add new department
create procedure addNewDepartment
	@DepartmentName varchar(50),
	@BranchName varchar(50),
	@IntakeName varchar(50),
	@TrackName varchar(50)
as
begin
	if not exists(select * from Branch where branchName = @BranchName)
	begin
		print ('branch dont exist')
	end
	else if not exists(select * from Intake where intakeName = @IntakeName)
	begin
		print ('intake dont exist')
	end
	else if not exists(select * from Track where trackName = @TrackName)
	begin
		print ('track dont exist')
	end
	else
		begin
			declare @BranchID int
			select @BranchID = branchID from Branch where branchName = @BranchName
			declare @IntakeID int
			select @IntakeID = intakeID from Intake where intakeName = @IntakeName
			declare @TrackID int
			select @TrackID = trackID from Track where trackName = @TrackName
			insert into Department
			values (@DepartmentName,@BranchID,@IntakeID,@TrackID)
		end
end
--------------------------------------------------------------------
-- manager edit branch
create procedure EditBranch
	@BranchID int,
	@NewBranchName varchar(50)
as
begin
	update Branch
	set branchName = @NewBranchName
	where branchID = @BranchID
end
-------------------------------------------------------------------
-- manager edit track
create procedure EditTrack
	@TrackId int,
	@NewTrackName varchar(50)
as
begin
	update Track
	set trackName = @NewTrackName
	where trackID = @TrackId
end
-------------------------------------------------------------------
-- manager edit intake
create procedure EditIntake
	@IntakeID int,
	@NewIntakeName varchar(50)
as
begin
	update Intake
	set intakeName = @NewIntakeName
	where intakeID = @IntakeID
end
---------------------------------------------------------------------
-- manager show department
create procedure ShowDepartment
	@DepartmentID int
as
begin
	if not exists (select deptID from Department where deptID = @DepartmentID)
	begin
		print ('department dont exist')
	end
	else
	begin
		select * from Department where deptID = @DepartmentID
	end
end
---------------------------------------------------------------------
-- manager edit department
create procedure EditDepartment
	@DepartmentID int,
	@NewDepartmentName varchar(50),
	@NewBranchID int,
	@NewIntakeID int,
	@NewTrackID int
as
begin
	if not exists (select deptID from Department where deptID = @DepartmentID)
		print ('department dont exist')
	else if not exists (select branchID from Branch where branchID = @NewBranchID)
		print ('branch dont exist')
	else if not exists (select intakeID from Intake where intakeID = @NewIntakeID)
		print ('intake dont exists')
	else if not exists (select trackID from Track where trackID = @NewTrackID)
		print ('track dont exist')
	else
	begin
		--declare @branchID int, @intakeID int, @trackID int
		--select @branchID = b.branchID from Branch as b inner join Department as d on d.branchID = b.branchID
		--select @intakeID = i.intakeID from Intake as i inner join Department as d on d.intakeID = i.intakeID
		--select @trackID = t.trackID from Track as t inner join Department as d on d.trackID = t.trackID
		
		update Department
		set deptName = @NewDepartmentName,
			branchID = @NewBranchID,
			intakeID = @NewIntakeID,
			trackID = @NewTrackID
		where deptID = @DepartmentID
	end
end
--------------------------------------------------------------------------------------------
-- manger store new course information	
create procedure AddNewCourse
	@CourseName varchar(30),
	@CourseDescription varchar(50),
	@CourseMaxDegree int,
	@CourseMinDegree int
as
begin
	insert into Course (name,description,max_degree,min_degree)
	values (@CourseName,@CourseDescription,@CourseMaxDegree,@CourseMinDegree)
end
--------------------------------------------------------------------------------------------
-- manager edit course
create procedure EditCourse
	@CourseID int,
	@NewCourseName varchar(30),
	@NewCourseDescription varchar(50),
	@NewCourseMaxDegree int,
	@NewCourseMinDegree int
as
begin
	if not exists (select id from Course where id = @CourseID)
		print ('course not exist')
	else
	begin
		update Course
		set name = @NewCourseName,
			description = @NewCourseDescription,
			max_degree = @NewCourseMaxDegree,
			min_degree = @NewCourseMinDegree
		where id = @CourseID
	end
end
------------------------------------------------------------------------------------------------
-- add new instructor
create procedure AddInstructor
	@InstructorName varchar(50),
	@DepartmentName varchar(50),
	@CourseName varchar(50) 
as
begin
	if not exists (select deptName from Department where deptName = @DepartmentName)
	begin
		print('Department not exist')
	end
	else if not exists (select name from Course where name = @CourseName)
	begin
		print('Course not exist')
	end
	else
	begin
		declare @DepartmentID int, @CourseID int
		select @DepartmentID = deptID from Department where deptName = @DepartmentName
		select @CourseID = id from Course where name = @CourseName
		insert into Instructor
		values (@InstructorName,@DepartmentID,@CourseID)
	end
end
-----------------------------------------------------------------------------------------------------------
-- instructor insert specific student to specific exam
create procedure InstructorSelectStudent 
	@ExamID int, 
	@StudentId int
as
begin
	declare @idFromStd int, @idFromExam int
	select @idFromStd = course_ID from Student where ID = @StudentId
	select @idFromExam = courseID from Exam where id = @ExamID
	if not exists (select * from Exam where id = @ExamID)
		print ('exam not exist')
	else if not exists (select * from Student where ID = @StudentId)
		print ('student not exist')
	else if not (@idFromExam = @idFromStd)
		print ('Student dont belong to this cousre')
	else
	begin
		insert into StudentExam
		values (@StudentId, @ExamID, @idFromExam)
	end
end
-----------------------------------------------------------------------------------------------
-- cursor procedure
alter procedure ShowQuestionToStudent
	@examID int
as
begin

	declare question_cursor cursor for
	select q.questionText,q.Choices from ExamAnswer e inner join Question q
	on q.questionID = e.Question_ID
	where e.Exam_ID = @examID
	for read only
	declare @q_ID int, @questionText varchar(30), @questionChoices varchar(30) ,@studentAnswer char(5)
	open question_cursor
	fetch quetion_cursor into @questionText,@questionChoices
	while @@fetch_status = 0
	begin
		select q.questionText,q.Choices from ExamAnswer e inner join Question q
		on q.questionID = e.Question_ID
		where e.Exam_ID = @examID
		open question_cursor
		--print 'Question : ' + @questionText
		--print 'Choices : ' + @questionChoices
		set @studentAnswer = null
		while @studentAnswer not in ('A','B','C')
		begin
			set @studentAnswer = UPPER(CHAR(ASCII('Enter your answer (A, B or C): ')))
		end
		fetch next from question_cursor into @questionText,@questionChoices
	end
	close question_cursor
	deallocate question_cursor
end

exec ShowQuestionToStudent 1
-------------------------------------------------------------------------------------------
-- manager edit instructor
create procedure EditInstructor
	@Instructor_ID int,
	@NewDepartmentID int,
	@NewCourseID int
as
begin
	if not exists (select ID from Instructor where ID = @Instructor_ID)
		print ('instructor dont exist')
	else if not exists (select deptID from Department where deptID = @NewDepartmentID)
		print ('department id not valid')
	else if not exists (select id from Course where id = @NewCourseID)
		print ('course id not valid')
	else
	begin
		update Instructor
		set Dept_ID = @NewDepartmentID,
			Course_ID = @NewCourseID
		where ID = @Instructor_ID
	end
end
------------------------------------------------------------------------------------------
alter proc StoreStudentTotalDegree
	@ExamID int,
	@STDID int
AS
BEGIN
	BEGIN TRY
		declare @ExamDegree int =(
		select  sum(QuestionDegree) As 'Exam Total Degree'
		from ExamAnswer
		where Exam_ID =@ExamID and Student_ID =@STDID)

		declare @CRS_ID int =(select courseID
							  from Exam
							  where id =@ExamID)


		insert into StudentCourse (Student_ID,Course_ID, StudentGrade)
		values (@STDID,@CRS_ID,@ExamDegree)
	END TRY

	BEGIN CATCH
		Select 'ERROR!!'
	END CATCH
END
--------------------------------------------------------------------------------------------
create trigger instructorTrigger 
on Instructor
After 
insert or update
--for each row
begin
	declare @instructor_count int
	select COUNT(*) into @instructor_count
	from Instructor
	where Course_ID = NEW.Course_ID
	and ID = NEW.ID
	if (@instructor_count > 0)
		print ('Course is already assigned to another instructor')

end