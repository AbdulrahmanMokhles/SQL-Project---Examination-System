alter proc CheckIfCorrect 
	@exam_ID int ,
	@std_ID int ,
	@q_ID int  
AS
Begin
	
	if not exists(select * from Exam where id = @exam_ID)
			print 'Invalid Exam ID !!!!'
	else if not exists(select * from Question where questionID = @q_ID)
			print 'Invalid Question ID !!!!'
	else if not exists(select * from Student where id = @std_ID)
			print 'Invalid Student ID !!!!'
	else if not exists(select eq.questionID
					from ExamQuestion eq join StudentExam se on eq.examID = se.Exam_ID
					where se.Std_ID = @std_ID )
			print 'Student does not have this question in his Exam'

	else if not exists(select ea.Question_ID from ExamAnswer ea where ea.Student_ID = @std_ID)
			print 'Student did not answer this question'
	else
		BEGIN
			declare @CorrectAns char(5) = (select correctAnswer from Question where questionID = @q_ID)
			--declare @CorrectAns char(5) = (select correctAnswer
			--								from Question q join ExamQuestion eq
			--								on q.questionID =eq.questionID)

			declare @StdAns char(5) = (select StudentAnswer from ExamAnswer where Exam_ID = @exam_ID and Student_ID=@std_ID and Question_ID=@q_ID )

				if(@CorrectAns = @StdAns)
					Begin				
						update ExamAnswer set QuestionDegree =1
						where   Question_ID=@q_ID
					End	
		END
End

--and Question_ID=@q_ID

exec CheckIfCorrect 1,6,88




