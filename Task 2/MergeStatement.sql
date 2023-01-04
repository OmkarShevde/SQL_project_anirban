select * from [dbo].[100 HRA Records]

SELECT Count(employeeNumber) AS CountOfEmp, BusinessTravel, Department
FROM [dbo].[100 HRA Records]
GROUP BY BusinessTravel, Department

ALTER PROCEDURE T1
AS
BEGIN
SELECT TOP 20 age, Attrition, BusinessTravel, DailyRate, Department, EmployeeNumber FROM [dbo].[100 HRA Records]
END 

exec T1

Create table Source
(age int, Attrition varchar(5), BusinessTravel varchar(60) , DailyRate int , Department varchar(70), EmployeeNumber int)

INSERT INTO Source exec T1

Create table Target
(age int, Attrition varchar(5), BusinessTravel varchar(60) , DailyRate int , Department varchar(70), EmployeeNumber int)

Create table Targetempty
(age int, Attrition varchar(5), BusinessTravel varchar(60) , DailyRate int , Department varchar(70), EmployeeNumber int)

ALTER PROCEDURE T2
AS
BEGIN
SELECT age, Attrition, BusinessTravel, DailyRate, Department, EmployeeNumber 
FROM [dbo].[100 HRA Records] 
WHERE EmployeeNumber BETWEEN 21 AND 25
END 

DROP TABLE Source

SELECT * FROM Source --Source
SELECT * FROM Target --Target
SELECT * FROM Targetempty



Declare @employeeNumber int
Declare @Age int 
Declare @attrition varchar(6)
Declare @BusinessTravel Varchar(50)
Declare @dailyrate int
Declare @department varchar(50) 
MERGE Target AS T
USING Source AS S
ON T.employeenumber = S.employeenumber
WHEN MATCHED THEN
     UPDATE SET T.BusinessTravel = S.BusinessTravel
WHEN NOT MATCHED BY TARGET THEN
     INSERT (Employeenumber,Age, Attrition,BusinessTravel,dailyrate, department)
	 VALUES(s.Employeenumber,s.Age, s.Attrition, s.BusinessTravel,s.dailyrate, s.department)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

--New record 
INSERT INTO Source (Employeenumber,Age, Attrition,BusinessTravel,dailyrate, department) VALUES (21,100,'NO','Non-Travel',252,'NEW DEPT')

--Update source record
UPDATE Source SET Department = 'Test' WHERE Department = 'Hardware'
	
	SELECT * FROM Target
	SELECT * FROM Source

Declare @employeeNumber int
Declare @Age int 
Declare @attrition varchar(6)
Declare @BusinessTravel Varchar(50)
Declare @dailyrate int
Declare @department varchar(50) 
MERGE Targetempty AS T
USING Source AS S
ON T.employeenumber = S.employeenumber
WHEN MATCHED THEN
     UPDATE SET T.BusinessTravel = S.BusinessTravel
WHEN NOT MATCHED BY Target THEN
     INSERT (Employeenumber,Age, Attrition,BusinessTravel,dailyrate, department)
	 VALUES(s.Employeenumber,s.Age, s.Attrition, s.BusinessTravel,s.dailyrate, s.department)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;

