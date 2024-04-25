--Show Exam Questions
alter PROCEDURE getExamQuestions @exam_id INT
AS
Begin
	BEGIN TRY
		SELECT eq.examID 'Exam Number',eq.questionID 'Question Number',q.questionText,q.Choices 
		FROM ExamQuestion eq INNER JOIN Question q
		ON eq.questionID = q.questionID
		WHERE eq.examID=@exam_id 
	END try
	BEGIN CATCH
		SELECT 'Error'
	END CATCH
End

exec getExamQuestions 1
exec StoreAnswers 1,1,40,'a'
exec StoreAnswers 1,1,39,'a'
exec getExamAnswersAndGrade 1,1
exec CheckIfCorrect 1,1,39
