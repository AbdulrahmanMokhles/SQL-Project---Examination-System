create table ExamStudent  (
	ID int not null primary key identity(1,1),
	Exam_ID int not null,
	Student_ID int not null,
	Course_ID int not null
)

alter table examStudent
add constraint FK_ExamStudent_Exam
foreign key (Exam_ID) references Exam(id)

alter table examStudent
add constraint FK_ExamStudent_Student
foreign key (Student_ID) references Student(id)

alter table examStudent
add constraint FK_ExamStudent_Course
foreign key (Course_ID) references Course(id)
