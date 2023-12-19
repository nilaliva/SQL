create database Academy;

use Academy;

create table Groups(
    Id int primary key identity(1,1),
    Name nvarchar(10) NOT NULL unique ,
    Rating int NOT NULL check (Rating >= 0 AND Rating <=5),
    Year int NOT NULL check (Year >= 1 And Year <=5)
);


insert into Groups(Name, Rating, Year) values (N'FBAS_3_22_11_ru', 5, 2);
insert into Groups(Name, Rating, Year) values (N'FBAS_3_12_13_ru', 3, 5);


create table Departments(
    Id int primary key identity(1,1),
    Financing money NOT NULL default(0) check( 0 <= Financing),
    Name nvarchar(100) NOT NULL unique check(Name != ''),

);


insert into Departments(Financing,Name) values (35000, N'step');
insert into Departments(Financing,Name) values (7000, N'kod az');
insert into Departments(Financing,Name) values (10000, N'Software Development');


create table Faculties(
    Id int primary key identity (1,1),
	Dean nvarchar(max) NOT NULL check(Dean != ''),
    Name nvarchar(100) NOT NULL check(Name != '') unique ,

);


insert into Faculties(Dean,Name) values (N'Togrul' , N'SQL ');
insert into Faculties(Dean,Name) values (N'Sames' , N'Computer Science ');


create table Teachers(
    Id int primary key identity (1,1),
    EmploymentDate date NOT NULL check(EmploymentDate >= '1990-01-01') ,
	IsAssistant bit NOT NULL default(0),
	IsProfessor bit NOT NULL default(0),
    Name nvarchar(max) NOT NULL check( '' != Name) ,
	Position nvarchar(max) NOT NULL check(Position != '' )
    Premium smallmoney NOT NULL check(Premium > 0) default(0) ,
    Salary money NOT NULL check(Salary > 0),
    Surname nvarchar(max) Not NULL check(Surname != '')

);


insert into Teachers(EmploymentDate,Name,Position,Premium,Salary,Surname) values ('02.12.1995',N'Sadiq',N'Profesor ',200,1020,N'Muradov');
insert into Teachers(EmploymentDate,Name,Position,Premium,Salary,Surname) values ('02.12.1995',N'Ali',N'Assistant ',200,800,N'Mirzoyev');
insert into Teachers(EmploymentDate,Name,Position,Premium,Salary,Surname) values ('02.12.1995',N'Said',N'Assistant ',200,500,N'Alieyev');



select * from Groups;
select * from Departments;
select * from Faculties;
select * from Teachers;


--Zad1
select Name ,Financing,Id from Departments;



--Zad2
select Name as '“Group Name',Rating as 'Group Rating' from Groups;



--Zad3
select (Salary/Premium) * 100 as "Rate percentage relative to premium",(Salary/Premium) * 100 as "Rate percentage relative to salary" from Teachers;



--Zad4
select concat('The dean of faculty' , Name , 'is' , Dean , '.')



--Zad5
select Surname from Teachers where IsProfessor = 1 and Salary > 1050;



--Zad6
select Name from Departments  where Financing < 11000 or Financing > 25000;



--Zad7
select Name from Faculties where Name != 'Computer Science';



--Zad8
select Surname from Teachers where IsProfessor != 1;



--Zad9
select Surname,Position,Salary,Premium from Teachers where IsAssistant = 1 and Premium >= 160 and Premium <= 550;



--Zad10
select Surname ,Salary from Teachers where IsAssistant = 1;



--Zad11
select Surname,position  from Teachers where EmploymentDate < '01.01.2000';




--Zad12
select Name as "Name of Department" from Departments where Name < 'Software Development' order by Name;




--Zad13
select Surname from Teachers where IsAssistant = 1 and (Premium + Salary) < 1200;



--Zad14
select Name from Groups where Year = 5 and Rating >=2 and Rating <=4;



--Zad14
select Surname from Teachers where Salary < 550 or Premium < 200;




--Zad15
select Surname from Teachers
where Premium < 200 or Salary < 550 ;