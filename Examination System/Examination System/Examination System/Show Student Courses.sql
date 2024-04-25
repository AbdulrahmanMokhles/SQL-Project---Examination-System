create procedure ShowStudentCourses
	@StdID int
AS
	BEGIN
		create view studentCourse2_v
		as
		SELECT c.ID as student_id, c.name as student_name, a.id as cource_id, a.name AS course_name
			FROM [dbo].[Course] a INNER JOIN [dbo].[StudentCourse] b ON a.id = b.course_id INNER JOIN
				dbo.student c ON b.student_id = c.ID
			where b.Student_ID =@StdID

		select * from studentCourse2_v
	END