create database Academy;

use Academy;

create table Groups(
    Id int primary key identity(1,1),
    Name nvarchar(10) NOT NULL unique ,
    Rating int NOT NULL check (Rating >= 0 AND Rating <=5),
    Year int NOT NULL check (Year >= 1 And Year <=5)
);
insert into Groups(Name, Rating, Year) values (N'FBAS_3_22_11_ru', 5, 2);
create table Departments(
    Id int primary key identity(1,1),
    Financing money NOT NULL default(0) check( 0 <= Financing),
    Name nvarchar(100) NOT NULL unique check(Name != ''),

);
insert into Departments(Financing,Name) values (1000, N'step');

create table Faculties(
    Id int primary key identity (1,1),
    Name nvarchar(100) NOT NULL check(Name != '') unique ,

);
insert into Faculties(Name) values (N'SQL ');

create table Teachers(
    Id int primary key identity (1,1),
    EmploymentDate date NOT NULL check(EmploymentDate >= '1990-01-01') ,
    Name nvarchar(max) NOT NULL check( '' != Name) ,
    Premium money NOT NULL check(Premium > 0) default(0) ,
    Salary money NOT NULL check(Salary > 0),
    Surname nvarchar(max) Not NULL check(Surname != '')

);
insert into Teachers(EmploymentDate,Name,Premium,Salary,Surname) values ('02.12.1995',N'Sadiq',200,1000,N'Muradov');

select * from Groups;
select * from Departments;
select * from Faculties;
select * from Teachers;