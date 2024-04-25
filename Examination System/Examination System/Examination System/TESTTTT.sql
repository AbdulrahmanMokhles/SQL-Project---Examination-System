----Test
exec AddNewBranch 'Minia'
exec AddNewTrack '.Net'
exec AddNewIntake '45'

exec addNewDepartment 'department 1','Minia','.Net','45'

exec AddNewStudent 'Marina',25,1,1

exec EditBranch 1,'Sohag'
exec EditTrack '1', 'python'
exec EditIntake '1','70'
exec ShowDepartment 1
exec EditDepartment 1,'department 2',1,1,1 
exec EditCourse 1,'C#','backend language',100,60
exec AddInstructor	'Mohamed','department 1','C#'
exec EditInstructor 1,2,2

exec AddNewStudent 'Ahmed' , 22 , 1,1

exec AddQuestion 1,'Java Script is oop based Language','T/F','(A)True (False)','B',1

exec InstructorChooseExam 3,2,'2-2-2024','8:00:00','10:00:00','False',1,1,78

exec GetExamDetails 2

exec getExamQuestions 2

exec getExamAnswersAndGrade 1,1

exec StoreAnswers 1,1,50,'a'
exec StoreAnswers 1,1,52,'a'
exec StoreAnswers 1,1,54,'a'

exec getExamAnswersAndGrade 4,2

exec CheckIfCorrect 1,1,50
exec CheckIfCorrect 1,1,52
exec CheckIfCorrect 1,1,54

exec getExamAnswersAndGrade 4,2


exec StoreStudentTotalDegree 1,1




delete from ExamAnswer
delete from ExamQuestion
delete from StudentExam
delete from Exam




--delete from StudentCourse

