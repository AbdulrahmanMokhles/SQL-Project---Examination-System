alter PROCEDURE InstructorChooseExam
	@InsID int,
	@ExamID int ,
	@Date date,
	@Start time,
	@End time ,
	@IsCorrective char(15),
	@CrsID int ,
	@StdID int ,
	@Q_ID int
As
Begin
	if not exists (select * from course where id = @CrsID)
		Begin
			print 'There is no Course with this ID'
		End
	else
		Begin
			--Checksss
			if exists(select questionID from ExamQuestion where questionID =@Q_ID and examID =@ExamID)
				BEGIN
					print CONCAT('Question With ID : ',@Q_ID,' Already Exists in Exam : ',@ExamID )
				END
			else
				BEGIN
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
							declare @idFromStd int, @idFromExam int
							select @idFromStd = course_ID from Student where ID = @StdID
							select @idFromExam = courseID from Exam where id = @ExamID
							--if not exists (select * from Exam where id = @ExamID)
							--	print ('exam not exist')
							if not exists (select * from Student where ID = @StdID)
								print ('student not exist')
							else if not (@idFromExam = @idFromStd)
								print ('Student dont belong to this cousre')

		

							--Insert Exam With Student		
							Insert into StudentExam (Std_ID , Exam_ID , Course_ID)
							values (@StdID , @ExamID , @CrsID)
			
							declare @Duration2 int = DateDiff(Hour,@Start , @End) 
						-- Insert Exam Details Into Exam Table
							Insert into Exam (id , [Date], start_time , end_time , total_time,InstructorID , isCorrective , courseID ) 
							values (@ExamID , @Date , @Start , @End ,@Duration2 ,@InsID , @IsCorrective  , @CrsID  )

							declare @ExamDegree int = (select sum(q.questionDegree)
														from exam e join ExamQuestion eq on e.id = eq.examID
																	join Question q on eq.questionID = q.questionID
														where e.id = @ExamID)
							
							update Exam
							set ExamDegree = @ExamDegree
							where id =@ExamID

							exec SetCorrectiveStatus @stdID,@CrsID

		--------------------Corrective Or not-----------------------------------------------------------------------

							--DECLARE @previousExamCount INT;
							--SELECT @previousExamCount = COUNT(*)
							--FROM exam
							--INNER JOIN Course ON Exam.courseID = Course.id
							--INNER JOIN StudentCourse ON Course.id = StudentCourse.Course_ID
							--INNER JOIN Student ON StudentCourse.Student_ID = Student.ID
							--WHERE Student.ID = @StdID AND Course.id = @CrsID;

							----Declare @ExamID int = (select id from Exam where courseID =@courseId )

							--IF @previousExamCount > 0
							--	BEGIN
							--	UPDATE exam
							--	SET iscorrective = 'True'  
							--	WHERE courseID = @CrsID and id =@ExamID ;
							--	END
							--ELSE
							--	BEGIN
							--	UPDATE exam
							--	SET iscorrective = 'False'
							--	WHERE courseID = @CrsID and id =@ExamID;
							--	END

		---------------------------------------------------------------------------------------------------------------------------------------------

						--Insert Exam With Student
								Insert into StudentExam (Std_ID , Exam_ID , Course_ID)
								values (@StdID , @ExamID , @CrsID)

						-- Instructor inserts QS
							INSERT INTO ExamQuestion (examID, questionID)
							values(@ExamID,@Q_ID)
					END
				End
		End
End



exec InstructorChooseExam 3,3,'1/2/2024','08:00:00','10:00:00','True',1,1,44
exec InstructorChooseExam 3,1,'1/2/2024','08:00:00','10:00:00','True',1,1,52
exec InstructorChooseExam 1,'1/2/2024','08:00:00','10:00:00','FALSE',1,1,33
exec InstructorChooseExam 1,'1/2/2024','08:00:00','10:00:00','FALSE',1,1,35
exec InstructorChooseExam 1,'1/2/2024','08:00:00','10:00:00','FALSE',1,1,40
exec InstructorChooseExam 1,'1/2/2024','08:00:00','10:00:00','FALSE',1,1,41
exec InstructorChooseExam 1,'1/2/2024','08:00:00','10:00:00','FALSE',1,1,44
exec InstructorChooseExam 1,'1/2/2024','08:00:00','10:00:00','FALSE',1,1,48



	