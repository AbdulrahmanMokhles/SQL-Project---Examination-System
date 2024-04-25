create table ExamAnswer (
	ID int not null primary key identity (1,1),
	Exam_ID int not null ,
	Student_ID int not null,
	Question_ID int not null ,
	StudentAnswer varchar(5),
	--primary key (Exam_ID,Student_ID,Question_ID)
)

Alter table ExamAnswer
add constraint FK_ExamANS_Exam
foreign key (Exam_ID) references Exam(id)

Alter table ExamAnswer
add constraint FK_ExamANS_Student
foreign key (Student_ID) references Student(id)

Alter table ExamAnswer
add constraint FK_ExamANS_Question
foreign key (Question_ID) references Question(Questionid)

drop table ExamAnswer


create proc StoreStdAns @Exam_id INT,@Std_ID INT,@Q_id INT , @answer varchar(5)
AS
Begin
	BEGIN TRY
		UPDATE ExamAnswer SET StudentAnswer = @answer WHERE Student_id=@Std_ID AND Question_ID=@Q_id AND Exam_id=@Exam_id
	END TRY
	BEGIN CATCH
		SELECT 'Error'
	END CATCH
End