 -- Basic Query
 --1 Write a query to select the first 5 employees, displaying their EmployeeNumber, Age, and Department.

 SELECT TOP (10) [Age]
      ,[Attrition]
      ,[BusinessTravel]
      ,[DailyRate]
      ,[Department]
      ,[DistanceFromHome]
  FROM [dbo].[Employees];

  -- Filtering Data
  --2 Retrieve all employees who work in the "Sales" department.
 Select * from [dbo].[Employees]  where Department = 'Sales';

 -- Sorting Data
 --3 Get the top 10 employees with the highest MonthlyIncome, sorted in descending order.
Select  Top 10* from [dbo].[Employees] order by MonthlyIncome desc;

-- Using WHERE Condition:

--4 .Retrieve only the EmployeeNumber, Age, and Department of employees who are older than 40.
Select EmployeeNumber, Age, Department From [dbo].[Employees] where  Age > 40; 
 
-- Combining Conditions:
-- 6. Get a list of employees who are in the "Research & Development" department and earn more than 5000 per month.
Select EmployeeNumber, Age, Department, MonthlyIncome from [dbo].[Employees] Where Department = 'Research & Development' and MonthlyIncome >5000;

-- Counting Records:
-- 7.How many employees have "Yes" in the Attrition column (employees who left the company)?

Select count(*) As Attirted_Employee From [dbo].[Employees] where Attrition = 1;

-- Grouping Data:
 -- 8: Count how many employees works in each department

 Select Department, count(*) As Number_of_Employee From dbo.[Employees] Group by Department Order by Number_of_Employee Desc ;

--  Average Calculation:

-- 9: Find the average MonthlyIncome of all employees department wise.

Select  Department, Avg(MonthlyIncome) As Avg_Monthly_Income From dbo.[Employees] Group by Department Order By Avg_Monthly_Income Desc;

--   Minimum & Maximum Values:

-- 10 . Find the youngest and oldest employee in the company Department wise.

Select Department,
	MIN(Age) As Youngest_Age,
	MAX(Age) As Oldest_Age
	from dbo.[Employees]
	Group by Department
	Order by Department; 

-- 11 Checking Distinct Values:
-- How many unique job roles are there in the dataset and what are those

SELECT Count(Distinct(Department)) as Distinct_Department FROM dbo.[Employees] 

SELECT Distinct(Department) as Distinct_Department FROM dbo.[Employees] 

