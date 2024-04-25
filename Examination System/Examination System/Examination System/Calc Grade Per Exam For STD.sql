CREATE PROCEDURE CalcGrades @Exam_id INT,@Std_ID INT,@crs_id int
 AS 
	BEGIN TRY
			DECLARE @std_grade INT=0
			SELECT @std_grade = COUNT(*)*10 FROM ExamAnswer ea , Questions q
			WHERE q.Q_ID=ea.Q_id AND ea.Exam_id=@Exam_id AND ea.Std_id=@Std_ID AND q.Q_ModelAnswer=ea.St_Answer
   
			UPDATE Student_Courses
			SET Std_Grade = @std_grade
			WHERE Std_ID = @Std_ID AND Crs_ID=@crs_id
	END TRY
	BEGIN CATCH
			SELECT 'Error'
	END CATCH
