alter PROCEDURE StoreExamRandomly 
	@InsID int,
	@ExamID int ,
	@Date date,
	@Start time,
	@End time ,
	--@Duration int ,
	@IsCorrective char(15),
	@CrsID int ,
	@StdID int,
	@TF_Qs int , 
	@MCQ_Qs int 
as
Begin 
	if not exists (select * from Course where id = @CrsID)
			print 'Invalid Course ID !!!!'
	else if not exists (select * from Student where ID = @StdID )
			print 'Invalid Student ID !!!! '
	else if not exists (select * from Instructor where ID = @InsID)
			print 'Invalid Instructor ID !!!! '

	else
		Begin
			--BEGIN TRY
				declare @MaxDeg int =(select max_degree from Course where id =@CrsID)
					declare @DegToCom int = (select sum(ExamDegree) from exam where courseID =@CrsID)
					if not exists (select id from Instructor where id =@InsID)
						print 'Invalid Instructor ID'
					else if not exists (select id from Course where id = @CrsID)
						print 'Invalid Course ID'
					else if not exists (select Course_ID from Instructor where id =@InsID and Course_ID =@CrsID  )
						print 'Instructor only allowed to add Exams of his Courses'
					else if(@MaxDeg< @DegToCom)
						print 'You Cannot Exceed Course Max Degree'
					else
						BEGIN
						-- Change DataTYPESSSSSS
						-- Insert Exam Details Into Exam Table
							declare @Duration int = DateDiff(Hour,@Start , @End)
							Insert into Exam (id , [Date], start_time , end_time , total_time,InstructorID ,isCorrective   , courseID) 
							values (@ExamID , @Date , @Start , @End ,@Duration , @InsID ,@IsCorrective  , @CrsID  )

						--Checksss
							declare @idFromStd int, @idFromExam int
							select @idFromStd = course_ID from Student where ID = @StdID
							select @idFromExam = courseID from Exam where id = @ExamID
							if not exists (select * from Exam where id = @ExamID)
								print ('exam not exist')
							else if not exists (select * from Student where ID = @StdID)
								print ('student not exist')
							else if not (@idFromExam = @idFromStd)
								print ('Student dont belong to this cousre')

						--Insert Exam With Student	
							Insert into StudentExam (Std_ID , Exam_ID , Course_ID)
							values (@StdID , @ExamID , @CrsID)

						-- Insert TF QS
							INSERT INTO ExamQuestion (examID, questionID)
							SELECT TOP (@TF_Qs) E.id, Q.questionID
							FROM Question Q join Exam E
							on q.courseID = @CrsID and E.courseID = @CrsID AND Q.questionType = 'T/F'
							ORDER BY NEWID();

						-- Insert MCQ QS
							INSERT INTO ExamQuestion (examID, questionID)
							SELECT TOP (@MCQ_Qs) E.id, Q.questionID
							FROM Question Q join Exam E
							on Q.courseID = @CrsID and E.courseID = @CrsID AND Q.questionType = 'MCQ'
							ORDER BY NEWID();

							declare @ExamDegree int = (select sum(q.questionDegree)
														from exam e join ExamQuestion eq on e.id = eq.examID
																	join Question q on eq.questionID = q.questionID
														where e.id = @ExamID)
							
							update Exam
							set ExamDegree = @ExamDegree
							where id =@ExamID
						END
			--END TRY

			--BEGIN CATCH
			--	Select 'Error!!'
			--END CATCH
		End
End

--declare @time time(7) = (select convert(varchar(10), GETDATE(), 108) )


delete from Exam

exec StoreExamRandomly 4,1,'2/2/2024','08:00:00','10:00:00','FALSE',5,6,3,7


--select convert(varchar(10), GETDATE(), 108) 
