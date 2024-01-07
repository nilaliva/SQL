create database ecommerce;
use ecommerce;
go;


create table FuelTypes (
    fuel_type_id int primary key identity(1, 1),
    fuel_type nvarchar(100) NOT NULL check(fuel_type != '')
);

insert into FuelTypes (fuel_type) values ('Gasoline');
insert into FuelTypes (fuel_type) values ('Electric')
insert into FuelTypes (fuel_type) values ('Diesel');




create table BodyTypes (
    body_type_id int primary key identity(1, 1),
    body_type nvarchar(100) NOT NULL check(body_type != '')
);

insert into BodyTypes (body_type) values ('SUV');
insert into BodyTypes (body_type) values ('Coupe');
insert into BodyTypes (body_type) values ('Sedan');
insert into BodyTypes (body_type) values ('Hatchback');




create table Colors (
    color_id int primary key identity(1, 1),
    color_name nvarchar(100) NOT NULL check(color_name != '')
);

insert into Colors (color_name) values ('Red');
insert into Colors (color_name) values ('White');
insert into Colors (color_name) values ('Black');
insert into Colors (color_name) values ('Navy Blue');




create table Cars (
    car_id int primary key identity(1, 1),
    brand nvarchar(100) NOT NULL check(brand != ''),
    model nvarchar(100)  NOT NULL check(model != ''),
    year int NOT NULL check (year != ''),
    fuel_type_id int foreign key references FuelTypes(fuel_type_id) check(fuel_type_id != ''),
    body_type_id int foreign key references BodyTypes(body_type_id) check(body_type_id != ''),
    color_id int foreign key references Colors(color_id) check(color_id != ''),
    image_link nvarchar(max) NOT NULL check(image_link != '')
);

insert into Cars (brand, model, year, fuel_type_id, body_type_id, color_id, image_link) VALUES ('Porsche', 'Cayenne S Coupé', 2023, 1, 2, 3, 'https://cdn.dicklovett.co.uk/uploads/used_stock_image/1_1355359_e.jpg?v=1699421527');
insert into Cars (brand, model, year, fuel_type_id, body_type_id, color_id, image_link) VALUES ('Lexus', 'RX', 2024, 1, 1, 1, 'https://tmna.aemassets.toyota.com/is/image/toyota/lexus/images/models/rx/2024/styles/Lexus-RX-350-visualizer-styles-750x471-LEX-RXG-MY24-0001.03.png?wid=750&hei=471&fmt=png-alpha');
insert into Cars (brand, model, year, fuel_type_id, body_type_id, color_id, image_link) VALUES ('BMW', 'X5', 2023, 2, 1, 4, 'https://cdn.bmwblog.com/wp-content/uploads/2023/05/2024-BMW-X5-M-Competition-2.jpg');
insert into Cars (brand, model, year, fuel_type_id, body_type_id, color_id, image_link) VALUES ('Mercedes', 'EQB', 2022, 3, 1, 2, 'https://www.mbusa.com/content/dam/mb-nafta/us/myco/my23/eqb-suv/byo-options/2023-EQB-SUV-MP-019.jpg');




create table Users (
    user_id int primary key identity(1, 1),
    username nvarchar(100) NOT NULL unique check(username != ''),
    password nvarchar(100) NOT NULL check(password != ''),
    email nvarchar(100) NOT NULL unique check(email != '')
);

insert into Users (username, password, email) values ('samed_abbasli', 'fhhr@567parol', 'abbaslisamed@gmail.com');
insert into Users (username, password, email) values ('leyla_nagiyeva', 'birth1207', 'nagiyevaleyla@yahoo.com');
insert into Users (username, password, email) values ('sara_aliyeva', 'retjhub45@_hmndm34', 'aliyevasara@gmail.com');




create table ManufacturingCountries (
    country_id int primary key identity(1, 1),
    country_name nvarchar(100) NOT NULL unique check(country_name != '')
);

insert into ManufacturingCountries (country_name) values ('USA');
insert into ManufacturingCountries (country_name) values ('Japan');
insert into ManufacturingCountries (country_name) values ('India');
insert into ManufacturingCountries (country_name) values ('Russia');
insert into ManufacturingCountries (country_name) values ('China');




create table Sellers (
    seller_id int primary key identity(1, 1),
    user_id int foreign key references Users(user_id) check(user_id != ''),
    company_name nvarchar(100) NOT NULL check(company_name != ''),
    contact_number nvarchar(100) NOT NULL unique check(contact_number != ''),
    country_id int foreign key references ManufacturingCountries(country_id) check(country_id != ''),
	rating int NOT NULL check(rating != '')
);

insert into Sellers (user_id, company_name, contact_number, country_id, rating) values (1, 'Auto Az', '070-321-45-67', 2, 4.9);
insert into Sellers (user_id, company_name, contact_number, country_id, rating) values (2, 'Super Car', '050-221-32-63', 1, 4.2);
insert into Sellers (user_id, company_name, contact_number, country_id, rating) values (3, 'Best Cars', '055-520-52-35', 3, 3.9);





create table ProductList (
    product_id int primary key identity(1, 1),
    car_id int foreign key references Cars(car_id) NOT NULL check(car_id != ''),
    seller_id int foreign key references Sellers(seller_id) NOT NULL check(seller_id != ''),
    price smallmoney NOT NULL check(price != ''),
    quantity int check(quantity != '')
);

insert into ProductList (car_id, seller_id, price, quantity) values (1, 1, 25000, 5);
insert into ProductList (car_id, seller_id, price, quantity) values (2, 2, 40000, 3);
insert into ProductList (car_id, seller_id, price, quantity) values (3, 3, 50000, 2);
insert into ProductList (car_id, seller_id, price, quantity) values (4, 4, 35000, 4);





go;
select * from Cars;
select * from Users;
select * from ProductList;
select * from ManufacturingCountries;
select * from FuelTypes;
select * from BodyTypes;
select * from Colors;
select * from Sellers;