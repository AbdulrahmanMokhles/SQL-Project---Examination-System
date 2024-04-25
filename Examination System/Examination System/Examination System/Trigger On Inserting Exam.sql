create trigger Exam_TRG
on Exam
After Insert
AS
	declare @MaxDeg int =(select max_degree from Course where)