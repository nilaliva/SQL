craete database Academy_5;
use Academy_5;

create table Departments(
	[Id] int primary key not null identity(1,1),
	[Financing] smallmoney not null check([Financing] >= 0) default(0),
	[Name] nvarchar(100) not null unique check([Name] != 0),
	[FacultyId] int not null foreign key references [Faculties](Id)
);
insert into Departments ([Financing], [Name], [FacultyId]) values (100000, 'Software Development', 1);



create table Faculties(
	[Id] int primary key not null identity(1,1),
	[Name] nvarchar(100) not null unique check([Name] is not null),
);
insert into Faculties ([Name]) values ('Computer Science');

create table Groups(
	[Id] int primary key not null identity(1,1),
	[Name] nvarchar(10) not null unique check([Name] is not null),
	[Year] int not null check([Year]between 1 and 5),
	[DepartmentId] int not null foreign key references [Departments](Id)
);
insert into Groups ([Name], [Year], [DepartmentId]) values ('FBAS_3_22_11_ru', 1, 1);

create table GroupsLectures(
	[Id] int primary key not null identity(1,1),
	[GroupId] int not null foreign key references Groups(Id),
	[LectureId] int not null foreign key references [Lectures](Id)
);

insert into GroupsLectures ([GroupId], [LectureId]) values (1, 1);
insert into GroupsLectures ([GroupId], [LectureId]) values (1, 2);


create table Lectures(
	[Id] int primary key not null identity(1,1),
	[DayOfWeek] int not null check([DayOfWeek] between 1 and 7),
	[LectureRoom] nvarchar(max) not null check([LectureRoom] is not null),
	[SubjectId] int not null foreign key references [Subjects](Id),
	[TeachersId] int not null foreign key references [Teachers](Id)
);
insert into Lectures ([DayOfWeek], [LectureRoom], [SubjectId], [TeachersId]) values (1, 'D201', 1, 1);
insert into Lectures ([DayOfWeek], [LectureRoom], [SubjectId], [TeachersId]) values (2, 'D202', 2, 2);


create table Subjects(
	[Id] int primary key not null identity(1,1),
	[Name] nvarchar(100) not null unique check([Name] is not null)
);


insert into Subjects ([Name]) values ('sql');
insert into Subjects ([Name]) values ('wpf');




create table Teachers(
	Id int primary key not null identity(1,1),
	[Name] nvarchar(max) not null check([Name] is not null),
	Salary money not null check(Salary > 0),
	Surname nvarchar(max) not null check(Surname is not null)
);

insert into Teachers ([Name], Salary, Surname) values ('Dave', 50000, 'McQueen');
insert into Teachers ([Name], Salary, Surname) values ('Jack', 60000, 'Underhill');




create table Students(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(max) NOT NULL check ([Name] is not null),
	[Surname] nvarchar(max) NOT NULL check ([Surname] is  not null),
	[Age] int NOT NULL check([Age]>14)
);

insert into Students ([Name], [Surname], [Age]) values ('Raul', 'Aliyev', 20);
insert into Students ([Name], [Surname], [Age]) values ('Sara', 'Valiyeva', 22);





--1
select count(*) as NumberOfTeachers
from Teachers
where [Name] in (select [Name] from Departments where [Name] = 'Software Development');


--2

select count(*) as NumberOfLectures
from Lectures
where [TeachersId] = (select [Id] from Teachers where [Name] = 'Dave McQueen');


--3
select count(*) as NumberOfLecturesInRoom from Lectures where [LectureRoom] = 'D201';


--4
select [LectureRoom], count(*) as NumberOfLectures
from Lectures
group by [LectureRoom];


--5
select count(distinct s.[Id]) as NumberOfStudents
from Students s
join GroupsLectures gl on s.[GroupId] = gl.[GroupId]
join Lectures l on gl.[LectureId] = l.[Id]
join Teachers t on l.[TeachersId] = t.[Id]
where t.[Name] = 'Jack';



--6
select avg(Salary) as AverageSalary
from Teachers
where [Id] in (select [Id] from Departments where [FacultyId] in (select [Id] from Faculties where [Name] = 'Computer Science'));



--7
select min(StudentCount) as MinStudentCount, max(StudentCount) as MaxStudentCount
from (select[GroupId], count(*) as StudentCount
    from Students
    group by [GroupId]
) as GroupStudentCounts;




-- 8


select avg([Financing]) as AverageFinancing from Departments;



-- 9
select [Name] + ' ' + Surname as FullName, count(*) as NumberOfSubjects
from Teachers
join Lectures on Teachers.[Id] = Lectures.[TeachersId]
group by Teachers.[Id], Teachers.[Name], Teachers.Surname;




-- 10
select [DayOfWeek], count(*) as NumberOfLectures
from Lectures
group by [DayOfWeek];



-- 11
select [LectureRoom], count(distinct d.[Id]) as NumberOfDepartments
from Lectures l
join Departments d on l.[SubjectId] = d.[Id]
group by [LectureRoom];



-- 12
select f.[Name] as FacultyName, count(distinct l.[SubjectId]) as NumberOfSubjects
from Faculties f
join Departments d on f.[Id] = d.[FacultyId]
join Lectures l on d.[Id] = l.[SubjectId]
group by f.[Name];