create table ExamQuestion(
	ID int not null primary key identity (1,1),
	examID int not null,
	questionID int not null
	)

alter table ExamQuestion
add constraint Fk_ExamQuestion_Exam
foreign key (examID) references Exam(id)

alter table ExamQuestion
add constraint Fk_ExamQuestion_Question
foreign key (questionID) references Question(questionID)