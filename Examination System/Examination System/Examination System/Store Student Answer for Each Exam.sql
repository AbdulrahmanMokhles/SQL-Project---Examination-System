alter proc StoreAnswers
	@Exam_ID int,
	@STD_ID int,
	@Q_ID int,
	@Ans char(5)
AS
BEGIN
	--BEGIN TRY
		if not exists(select * from Exam where id = @Exam_ID)
			print 'Invalid Exam ID !!!!'
		if not exists(select * from Student where id = @STD_ID)
			print 'Invalid Student  ID !!!!'
		if not exists(select * from Question where questionID = @Q_ID)
			print 'Invalid Question ID !!!!'

		if exists(select StudentAnswer from ExamAnswer where Exam_ID =@Exam_ID and Student_ID =@STD_ID and Question_ID=@Q_ID)
				BEGIN
					--print 'Error!! Already Exists'
					update ExamAnswer
					set StudentAnswer = @Ans
					print 'Answer Changed Successfully'
					--exec CheckIfCorrect @exam_ID,@STD_ID,Q_ID
				END
		Else
			BEGIN
				Insert into ExamAnswer (Exam_ID , Student_ID , Question_ID , StudentAnswer)
				values (@Exam_ID , @STD_ID , @Q_ID , @Ans)
				--exec CheckIfCorrect @exam_ID,@STD_ID,Q_ID
			END

		
	--END TRY
	--BEGIN CATCH
	--	Select 'ERROR!!'
	--END CATCH

END

exec StoreAnswers 1,6,88,'a'
