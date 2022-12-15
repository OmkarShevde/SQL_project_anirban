Create database ABDB
USE ABDB

CREATE TABLE orders
(ord_no int, purch_amt money, ord_date date, customer_id int, salesman_id int)
INSERT INTO orders VALUES
	(70001, 150.5, '2012-10-05', 3005, 5002),
	(70009, 270.65, '2012-09-10', 3001, 5005),
	(70002, 65.26, '2012-10-05', 3002, 5001),
	(70004, 110.5, '2012-08-17', 3009, 5003),
	(70007, 948.5, '2012-09-10', 3005, 5002),
	(70005, 2400.6, '2012-07-27', 3007, 5001),
	(70008, 5760, '2012-09-10', 3002, 5001),
	(70010, 1983.43, '2012-10-10', 3004, 5006),
	(70003, 2480.1, '2012-10-10', 3009, 5003),
	(70012, 250.45, '2012-06-27', 3008, 5002),
	(70011, 75.29, '2012-08-17', 3003, 5007),
	(70013, 3045.6, '2012-04-25', 3002, 5001)

	CREATE TABLE Customers
	(Customer_id int,
	cust_name varchar(50),
	city Varchar(20),
	grade int,
	salesman_id int)

INSERT INTO Customers Values
	(3002,'Nick Rimando','New york',100,5001),
	(3007,'Brad Davis','New york',200,5001),
	(3005,'Graham Zusi','California',200,5002),
	(3008,'Julian Green','London',300,5002),
	(3004,'Fabian Johnson','Paris',300,5006),
	(3009,'Geoff Cameron','Berlin',300,5003),
	(3003,'Jozy Altidor','Moscow',200,5007),
	(3001,'Brad Guzan','London',Null,5005)

create table salesman(name varchar(30),city varchar(20),commission decimal(3,2), salesman_id int,)

insert into salesman values('James Hoog','New York',0.15,5001),
							('Nail Knite','Paris',0.13,5002),
							('Lauson Hen','San Jose',0.12,5003),
							('Pit Alex','London', 0.11,5005),
							('Mc lyon','Paris', 0.14,5006),
							('Paul Adam','Rome',0.13,5007)



 SELECT * FROM salesman
 SELECT * FROM Customers
 SELECT * FROM orders
 
 --Procedure 1 for getting the matching records--
 ALTER PROCEDURE sp_1
 @purch_amt int
 AS
 BEGIN
	SELECT	s.name AS Salesman, s.city,
		c.cust_name AS Customers, c.grade, 
		o.ord_no, o.purch_amt, o.ord_date
	FROM Customers c
	RIGHT JOIN salesman s ON
	s.salesman_id = c.salesman_id
	LEFT JOIN orders o ON
	c.Customer_id = o.customer_id
	WHERE o.purch_amt >= @purch_amt AND c.grade IS NOT NULL
 END 

EXEC sp_1 2000

 CREATE TABLE Final_rpt
	(salesman varchar(60), city Varchar(50), Customers Varchar(50),
	grade int, ord_no int, purch_amt money, ord_date date)

	INSERT INTO Final_rpt sp_1 

	SELECT * FROM Final_rpt
	DROP Table final_rpt

	ALTER TABLE Final_rpt
	ADD CurrentDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP

	--Adding a primary key to an existing table 
	ALTER TABLE Final_rpt
	ALTER COLUMN ord_no int NOT NULL;

	ALTER TABLE Final_rpt
	ADD PRIMARY KEY (ord_no)

	--Procedure for UPSERT -- 
	CREATE PROCEDURE sp_2
	@salesman Varchar(50),
	@customers Varchar(50),
	@City Varchar(50),
	@Grade int,
	@ord_no int,
	@purch_amt money,
	@ord_date date
	AS
	BEGIN
		IF EXISTS (SELECT * FROM Final_rpt WHERE ord_no = @ord_no)
			UPDATE Final_rpt
			SET salesman = @salesman,
			Customers = @customers,
			City = @City,
			Grade = @Grade,
			Purch_amt = @purch_amt,
			ord_date = @ord_date 
			WHERE ord_no = @ord_no
		ELSE 
			INSERT INTO Final_rpt
			(salesman,City,customers,Grade,ord_no,purch_amt,ord_date)
			VALUES (@salesman,
					@City,
					@customers,
					@Grade,
					@ord_no,
					@purch_amt,
					@ord_date)
	END

	EXEC sp_2 'Viraj j','Geoff Cameron','San Jose', 455, 70013,2480.10,'2012-10-10' -- Old Record 
	EXEC sp_2 'Ramakant','Nivid Deskhmukh','Malvan',300,70014,4000.28,'2022-12-12' -- New Record

	DELETE FROM Final_rpt WHERE ord_no = 700017
	rollback
	SELECT * FROM Final_rpt




	
