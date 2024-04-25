create database Examination_Sys on 
(
	name = 'ExaminationSystem',
	filename ='F:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ExaminationSystem-Data.mdf',
	size = 10MB,
	MaxSize = 100MB,
	FileGrowth=10 
),
(
	name = 'Net23-Company-Log',
	filename ='F:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ExaminationSystem-Log.ldf',
	size = 5MB,
	MaxSize = 100MB,
	FileGrowth=10
)