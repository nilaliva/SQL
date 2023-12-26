create database Academy_1;
use Academy_1;
create table Curators(
     Id int primary key identity(1, 1),
	 Name nvarchar(max) NOT NULL check(Name != ''),
	 Surname nvarchar(max) NOT NULL check(Surname != ''),
);

insert into Curators (Name, Surname) values (N'Samed', N'Abbasov');
insert into Curators (Name, Surname) values (N'Mahmud', N'Aliyev');

create table Departments(
     Id int primary key identity(1, 1),
	 Financing smallmoney NOT NULL check(Financing >= 0) default(0),
	 Name nvarchar(100) NOT NULL check(Name != '') unique,
	 FacultyId int NOT NULL references Faculties(Id)
);
insert into Departments (Financing, Name, FacultyId) values (30000, N'Computer Engineering', 1);
insert into Departments (Financing, Name, FacultyId) values (18000, N'Software Development', 1);
insert into Departments (Financing, Name, FacultyId) values (25000, N'Architect Engineering', 2);




create table Faculties(
     Id int primary key identity(1, 1),
	 Financing smallmoney NOT NULL check(Financing >= 0) default(0),
	 Name nvarchar(100) NOT NULL check(Name != '') unique
);


insert into Faculties (Financing, Name) values (47000, N'Architect');
insert into Faculties (Financing, Name) values (50000, N'Computer Science');


create table Groups(
     Id int primary key identity(1, 1),
	 Name nvarchar(10) NOT NULL check(Name != '') unique,
	 Year int NOT NULL check(Year>= 1 and Year=<5),
	 DepartmentId int NOT NULL foreign key
);

insert into Groups (Name, Year, DepartmentId) values (N'FBAS_3_22_11_ru', 1, 1);
insert into Groups (Name, Year, DepartmentId) values (N'FBAS_7_32_11_ru', 2, 1);
insert into Groups (Name, Year, DepartmentId) values (N'FBAS_3_2_1__3', 3, 2);


create table GroupsCurators(
     Id int primary key identiry(1, 1),
	 CuratorId int NOT NULL foreign key,
	 GroupId int NOT NULL foreign key
);
insert into GroupsCurators (CuratorId, GroupId) values (1, 1);
insert into GroupsCurators (CuratorId, GroupId) values (2, 2);

create table GroupsLectures(
     Id int primary key identity(1, 1),
	 GroupId int NOT NULL foreign key,
	 LectureId int NOT NULL foreign key
);
insert into GroupsLectures (GroupId, LectureId) values (1, 1);
insert into GroupsLectures (GroupId, LectureId) values (2, 2);

create table Lectures(
     Id int primary key identity(1, 1),
	 LectureRoom nvarchar(max) NOT NULL check(LectureRoom != ''),
	 SubjectId int NOT NULL foreign key,
	 TeacherId int NOT NULL foreign key
);

insert into Lectures (LectureRoom, SubjectId, TeacherId) values (N'B103', 1, 1);
insert into Lectures (LectureRoom, SubjectId, TeacherId) values (N'A301', 2, 2);

create table Subjects(
      Id int primary key identity(1, 1),
	  Name varchar(100) NOT NULL check(Name != '') unique
);

insert into Subjects (Name) values (N'Database Theory');
insert into Subjects (Name) values (N'Software Engineering');



create table Teachers(
       Id int primary key identity(1, 1),
	   Name nvarchar(max) NOT NULL check(Name != ''),
	   Salary smallmoney NOT NULL check(Salary>=0),
	   Surname nvarchar(max) NOT NULL check(Surname != 0)
);


insert into Teachers (Name, Salary, Surname) values ('Samantha', 60000, 'Adams');
insert into Teachers (Name, Salary, Surname) values ('Senan', 45000, 'Samurov');




--1

select Teachers.Name as TeacherName, Teachers.Surname as TeacherSurname, Groups.Name as GroupName
from Teachers
cross join Groups;


--2

select distinct F1.Name as FacultyName, D1.Financing as DepartmentFinancing, F1.Financing as FacultyFinancing
from Departments D1
join Faculties F1 on D1.FacultyId = F1.Id
where D1.Financing > F1.Financing;

--3

select C.Surname as CuratorSurname, G.Name as GroupName
from Curators C
join GroupsCurators GC on C.Id = GC.CuratorId
join Groups G on GC.GroupId = G.Id;

--4
select distinct T.Name as TeacherName, T.Surname as TeacherSurname
from Teachers T
join Lectures L on T.Id = L.TeacherId
join GroupsLectures GL on L.Id = GL.LectureId
join Groups G on GL.GroupId = G.Id
where G.Name = 'P107';


--5


select distinct T.Surname as TeacherSurname, F.Name as FacultyName
from Teachers T
join Lectures L on T.Id = L.TeacherId
join Subjects S on L.SubjectId = S.Id
join Departments D on S.Id = D.FacultyId
join Faculties F on D.FacultyId = F.Id;



--6


select D.Name as DepartmentName, G.Name as GroupName
from Departments D
join Groups G on D.Id = G.DepartmentId;



--7

select S.Name as SubjectName
from Teachers T
join Lectures L on T.Id = L.TeacherId
join Subjects S on L.SubjectId = S.Id
where T.Name = 'Samantha' and T.Surname = 'Adams';



--8

select D.Name as DepartmentName
from Departments D
join Subjects S on D.Id = S.Id
join Lectures L on S.Id = L.SubjectId
where S.Name = 'Database Theory';


--9


select G.Name as GroupName
from Groups G
join Departments D on G.DepartmentId = D.Id
join Faculties F on D.FacultyId = F.Id
where F.Name = 'Computer Science';


--10


select G.Name as GroupName, F.Name as FacultyName
from Groups G
join Departments D on G.DepartmentId = D.Id
join Faculties F on D.FacultyId = F.Id
where G.Year = 5;



--11

select T.Name as TeacherName, T.Surname as TeacherSurname, S.Name as SubjectName, G.Name as GroupName
from Teachers T
join Lectures L on T.Id = L.TeacherId
join Subjects S on L.SubjectId = S.Id
join GroupsLectures GL on L.Id = GL.LectureId
join Groups G on GL.GroupId = G.Id
where L.LectureRoom = 'B103';