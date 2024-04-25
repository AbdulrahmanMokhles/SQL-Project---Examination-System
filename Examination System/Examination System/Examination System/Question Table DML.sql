--Add Question with its Answers

alter PROCEDURE AddQuestion
	@crs_id INT,
	@q_text VARCHAR(Max),
	@q_type char(5),
	@choices VARCHAR(Max),
    @q_CorrectAns char(5),
	@q_Degree int
    
AS
Begin
	--BEGIN TRY
		if not exists (select id from Course where id = @crs_id)
			print 'Invalid Course ID'
		INSERT INTO Question (courseID , questionText, questionType, Choices ,correctAnswer,questionDegree ) 
		VALUES (@crs_id, @q_text, @q_type,@choices , @q_CorrectAns , @q_Degree );
	--END TRY
	--BEGIN CATCH
	--	SELECT 'Error'
	--END CATCH
End
delete from question
delete from Exam


exec AddQuestion 5,'Test Question?','MCQ','(a)(b)(c)','b',1

exec AddQuestion 5,'Test Question?','T/F','(a)(b)','a',1

--Update Question
ALTER PROCEDURE UpdateQuestion
	@question_ID int,
	@crs_id INT,
	@q_text VARCHAR(Max),
	@q_type char(5),
	@choices VARCHAR(Max),
    @q_CorrectAns char(5),
	@q_Degree int
AS
Begin
	Begin Try
		Update Question
		set
		courseID =@crs_id , questionText = @q_text , questionType =@q_type , correctAnswer =@q_CorrectAns
		,Choices = @choices , questionDegree=@q_Degree
		where questionID = @question_ID
	End Try

	BEGIN CATCH
		SELECT 'Error'
	END CATCH
End

exec UpdateQuestion 20,1,'Whennnn???','MCQ','(A) 10  (B) 100 (C) 150 ','A'

--Delete Question
CREATE PROCEDURE DeleteQuestion
    @q_id INT
AS
Begin
	BEGIN TRY
		DELETE FROM Question WHERE questionID = @q_id;
	END TRY
	BEGIN CATCH
		SELECT 'Error'
	END CATCH
End

exec DeleteQuestion 19




