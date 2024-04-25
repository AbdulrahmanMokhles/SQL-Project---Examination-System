create PROCEDURE SetCorrectiveStatus
  @studentId INT,
  @courseId INT
AS
BEGIN
  DECLARE @previousExamCount INT;
  SELECT @previousExamCount = COUNT(*)
  FROM exam
  INNER JOIN Course ON Exam.courseID = Course.id
  INNER JOIN StudentCourse ON Course.id = StudentCourse.Course_ID
  INNER JOIN Student ON StudentCourse.Student_ID = Student.ID
  WHERE Student.ID = @studentId AND Course.id = @courseId;

  Declare @ExamID int = (select id from Exam where courseID =@courseId )

  IF @previousExamCount > 0
	  BEGIN
		UPDATE exam
		SET iscorrective = 'True'  -- Assuming iscorrective is a bit/boolean column
		WHERE courseID = @courseId;
	  END
  ELSE
	  BEGIN
		UPDATE exam
		SET iscorrective = 'False'
		WHERE courseID = @courseId;
	  END
END;