alter proc StoreStudentTotalDegree
	@ExamID int,
	@STDID int
AS
BEGIN
	BEGIN TRY
		declare @CRS_ID int =(select courseID from Exam where id =@ExamID)
		
		declare @MinCrsDegree int =(select min_degree from Course where id =@CRS_ID)

		declare @ExamDegree int =(
		select  sum(QuestionDegree) As 'Exam Total Degree'
		from ExamAnswer
		where Exam_ID =@ExamID and Student_ID =@STDID)

		--Check Existance
		if exists(select Student_ID from StudentCourse where Student_ID=@STDID)
			Begin
				update StudentCourse
				set StudentDegree = StudentDegree + @ExamDegree
				--Change Student Status
				declare @StdDegInCrs int = (select StudentDegree from StudentCourse where Student_ID =@STDID)  
				IF(@StdDegInCrs > @MinCrsDegree)
					BEGIN
						update StudentCourse
						set [Status] = 'Success'
					END
			End
		Else
			BEGIN
				insert into StudentCourse (Student_ID,Course_ID, MinDegree ,StudentDegree)
				values (@STDID,@CRS_ID, @MinCrsDegree ,@ExamDegree)
			END

		--select  sum(ea.QuestionDegree) As 'Student Degree' , count(eq.questionID) AS 'Exam Total Degree'
		--from ExamAnswer ea join ExamQuestion eq on ea.Exam_ID = eq.examID
		--where ea.Exam_ID =@ExamID and ea.Student_ID =@STDID and ea.Exam_ID = eq.examID
		 select sum(QuestionDegree) As 'Student Degree In Exam'  from ExamAnswer where Exam_ID =1

		 select count(questionID) AS 'Exam Total Degree' from ExamQuestion where examID =1

		select * from StudentCourse
		where Student_ID =@STDID and Course_ID = @CRS_ID

	END TRY

	BEGIN CATCH
		Select 'ERROR!!'
	END CATCH
END

exec StoreStudentTotalDegree 1,1





