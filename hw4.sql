use Academy;

create table People(
    [Id] int primary key identity(1, 1),
    [Name] nvarchar(30) NOT NULL,
    [Surname] nvarchar(30) NOT NULL,
    [Email] nvarchar(30) NOT NULL UNIQUE ,
    [Age] int NOT NULL check ([Age] >= 14 and [AGE] <= 100)
);
create table Employees(
    [Id] int primary key identity(1, 1),
    [Salary] smallmoney check ([Salary] >= 300),
    [Experience] int NOT NULL check([Experience] > 0)
);
create table Faculties(
    [Id] int primary key identity(1, 1),
    [Name] nvarchar(30) NOT NULL
);

create table Students(
    [Id] int primary key identity (1, 1),
    [PersonId] int foreign key references People(Id)
);


create table Teachers(
    [Id] int primary key identity (1, 1),
    [PersonId] int foreign key references People(Id),
    [EmployeeId] int foreign key references Employees(Id)
);


create table Groups(
    [Id] int primary key identity (1, 1),
    [Name] nvarchar(30) NOT NULL,
    [Course] int NOT NULL check([Course] >= 1 and [Course] <= 6),
    [FacyltyId] int foreign key references Faculties(Id)
);

create table GroupsData(
    [Id] int primary key identity (1, 1),
    [StudentId] int foreign key references Students(Id),
    [GroupId] int foreign key references Groups(Id)
);



create table StudyPlans(
    [Id] int primary key identity (1, 1),
    [TeacherId] int foreign key references Teachers(Id),
    [GroupId] int foreign key references Groups(Id)
);

alter table Students add [GPA] int NOT NULL check ([GPA] >= 1 and [GPA] <= 12);

insert into People ([Name], [Surname], [Age], [Email])
values
    (N'Юсиф', N'Байрамов', 20, N'yusif.bayramov@gmail.com'),
    (N'Магомед', N'Фарманов', 20, N'magomed.farmanov@gmail.com'),
    (N'Вагиф', N'Алиев', 17, N'vagif.aliev@gmail.com'),
    (N'Татьяна', N'Ермакова', 20, N'tatiana.ermakova@gmail.com'),
    (N'Бахтияр', N'Мирзоев', 18, N'bahtiyar.mirzoev@gmail.com'),
    (N'Алина', N'Оруджова', 17, N'alina.orujova@yahoo.com'),
    (N'Гариба', N'Дадашова', 18, N'gariba.dadashova@gmail.com'),
    (N'Анвер', N'Мамедов', 20, N'anver.mamedov@yahoo.com'),
    (N'Юсиф', N'Меликов', 16, N'yusif.melikov@yahoo.com'),
    (N'Хелил', N'Оруджлу', 16, N'helil.orujlu@gmail.com'),
    (N'Мурад', N'Эфендиев', 17, N'murad.efendiev@gmail.com'),
    (N'Афган', N'Максудлу', 18, N'afgan.maksudlu@gmail.com'),
    (N'Нилай', N'Алиева', 15, N'nilay.alieva@gmail.com'),
    (N'Эльданиз', N'Йолчуев', 19, N'eldaniz.yolchuev@gmail.com');

select * from People;
insert into Students values(1,20),(2,12),(3,11),(4,11),(5,12),(6,12),(7,12),(8,11),(9,11),(10,10),(11,9),(12,12),(13,9),(14,12);


select Students.Id , P.Name, P.Surname, P.Email,P.Age, Students.GPA
from Students
inner join People as P on Students.PersonId = P.Id;


insert into People ([Name], [Surname], [Age], [Email]) values (N'Elvin', N'Azimov', 22, N'elvinazimov@gmail.com');
insert into People ([Name], [Surname], [Age], [Email]) values (N'Sabina', N'Hajiyeva', 21, N'sabinahajiyeva@yahoo.com');
insert into People ([Name], [Surname], [Age], [Email]) values (N'Natig', N'Aliyev', 25, N'natigaliyev@gmail.com');




insert into Teachers ([PersonId], [EmployeeId]) values (4, 1), (5, 2), (6, 3);


insert into Employees ([Salary], [Experience])VALUES (5000, 5), (6000, 8), (4500, 3);



insert into Faculties ([Name]) values (N'programing'), (N'dizayn');
insert into Groups ([Name], [Course], [FacyltyId]) values (N'FBAS_3_22_11_ru', 2, 1), (N'FBAS_3_28_31_ru', 4, 2);


insert into GroupsData ([StudentId], [GroupId]) values (1, 1), (2, 2), (3, 1);

insert into StudyPlans ([TeacherId], [GroupId]) values (1, 1), (2, 2), (3, 1);