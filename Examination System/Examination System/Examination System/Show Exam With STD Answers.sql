--Show Exam With Answers
alter PROCEDURE getExamAnswersAndGrade @exam_id INT,@std_id INT 
AS
BEGIN TRY
	SELECT ea.Exam_ID, ea.Question_ID,q.questionText, ea.Student_ID,ea.StudentAnswer , q.correctAnswer ,ea.QuestionDegree
	FROM ExamAnswer ea INNER JOIN Question q
	ON ea.Question_ID = q.questionID
	INNER JOIN Student s 
	ON ea.Student_ID=s.ID
	WHERE ea.Exam_ID=@exam_id AND ea.Student_ID=@std_id
END try
BEGIN CATCH
	SELECT 'Error'
END CATCH

exec getExamAnswersAndGrade 1,1