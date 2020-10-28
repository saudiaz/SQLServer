create database Clases

create table Customers(
ID int not null primary key identity(1,1),
NAME varchar(100) not null,
AGE int not null,
ADDRESS varchar(100) not null,
SALARY DECIMAL(18,2) not null
)
INSERT INTO CUSTOMERS (NAME,AGE,ADDRESS,SALARY) 
VALUES ( 'Ramesh', 32, 'Ahmedabad', 2000.00 );
  
INSERT INTO CUSTOMERS (NAME,AGE,ADDRESS,SALARY) 
VALUES ( 'Khilan', 25, 'Delhi', 1500.00 );  

INSERT INTO CUSTOMERS (NAME,AGE,ADDRESS,SALARY) 
VALUES ( 'kaushik', 23, 'Kota', 2000.00 );  

INSERT INTO CUSTOMERS (NAME,AGE,ADDRESS,SALARY) 
VALUES ( 'Chaitali', 25, 'Mumbai', 6500.00 ); 
 
INSERT INTO CUSTOMERS (NAME,AGE,ADDRESS,SALARY) 
VALUES ( 'Hardik', 27, 'Bhopal', 8500.00 );  

INSERT INTO CUSTOMERS (NAME,AGE,ADDRESS,SALARY) 
VALUES ( 'Komal', 22, 'MP', 4500.00 );

create table Orders(
ID int not null identity(1,1) primary key,
Date datetime not null, 
Amount int not null,
IDCustomers int not null
foreign key(IDCustomers) references Customers(ID)
)

insert into Orders values('2009-10-08 00:00:00.000',1500,3)
insert into Orders values('2009-11-20 00:00:00.000',1500,2)
insert into Orders values('2009-10-08 00:00:00.000',3000,3)
insert into Orders values('2008-05-20 00:00:00.000',2060,4)

select c.ID,c.NAME,c.AGE, o.Amount from Customers c
inner join Orders o
on c.ID = o.IDCustomers

SELECT *  
   FROM CUSTOMERS
   WHERE ID IN (SELECT ID FROM CUSTOMERS WHERE SALARY > 4500)

create procedure SelectCustomers
as
select * from Customers
go



exec SelectCustomers



create table Students(
id int not null primary key identity(1,1),
student varchar(100) not null,
ssubject varchar(100) not null,
Marks int not null
)

insert into Students values('Camila','Ciencias',85)

select * from Students
--where--
select * from Students where student = 'Camila'
--like--
select * from Customers WHERE SALARY like '200%'
--order by is use to sort--
select * from Customers order by NAME,SALARY
select * from Customers order by NAME ASC
select * from Customers order by NAME DESC
select * from Customers order by AGE ASC
--group by is use to get data identical and group it, we can count, avrg, sum etc this data identical--
SELECT NAME, SUM(SALARY) as [Total a Pagar] from Customers
GROUP BY NAME
SELECT NAME,SALARY FROM Customers
SELECT SUM(SALARY) as [Total a Pagar en Sueldos] from Customers
--distinct--
select distinct SALARY FROM Customers
ORDER BY SALARY DESC
-- for pivot don't use the id
select *
from (
	select [student],[ssubject],[Marks] 
	from Students 
)S
pivot(
  sum(Marks)
  for[ssubject] in ([Matematica],[Ciencias],[Sociales],[Ingles])
)P

select * from Customers
select * from Orders
--Mostrando edades y abajo los nombre--
select * from
(
	select [NAME],[AGE] 
	from Customers
)S
PIVOT(
	MAX(NAME)
	FOR[AGE] IN ([25],[27])
)p
--Total de Salarios por edades--
select 'Salarios' as SalariosPorDepartamento,[25],[27] from
(
	select [SALARY],[AGE] 
	from Customers
)S
PIVOT(
	SUM(SALARY)
	FOR[AGE] IN ([25],[27])
)p
--Mostrando nombre y monto total en ordenes--
select c.NAME,c.SALARY, SUM(o.Amount) as MontoOrdenes from Customers c
inner join Orders o
on o.IDCustomers = c.ID
group by c.NAME, c.SALARY


