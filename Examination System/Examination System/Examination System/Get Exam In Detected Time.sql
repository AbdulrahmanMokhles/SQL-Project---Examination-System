CREATE OR ALTER PROCEDURE GetExamDetails
    @ExamID INT
AS
BEGIN
    DECLARE @StartTime DATETIME;
    DECLARE @EndTime DATETIME;

    SELECT @StartTime = start_time, @EndTime = end_time
    FROM Exam
    WHERE id = @ExamID;

    IF @StartTime IS NOT NULL AND @EndTime IS NOT NULL AND GETDATE() BETWEEN @StartTime AND @EndTime
    BEGIN

        SELECT *
        FROM Exam
        WHERE id= @ExamID;
    END
    ELSE
    BEGIN
      
        PRINT 'The selected exam is not currently available.';
    END
END;

exec GetExamDetails 1