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


--- Common table Expressions: 

-- 11 . Write a CTE to find employees who have been in the company for more than 10 years and earn above the average salary.

With Employee_CTE AS ( Select EmployeeNumber, Age, Department, YearsAtCompany, MonthlyIncome
from dbo.[Employees]
where YearsAtCompany > 10 )
select * from Employee_CTE where MonthlyIncome > ( select Avg(MonthlyIncome) from dbo.[Employees]); 

 select * from Employees


 -- 12 . Write a CTE to find employees who have been in the company for more than 10 years and earn above the average salary.

WITH Employee_CTE AS ( SELECT EmployeeNumber, Age, Department, YearsAtCompany, MonthlyIncome
FROM dbo.[Employees]
WHERE YearsAtCompany > 10 )

SELECT * FROM Employee_CTE WHERE MonthlyIncome > ( SELECT Avg(MonthlyIncome) FROM dbo.[Employees]); 

 SELECT * FROM Employees;

 --13 Write a CTE to find employees who have worked for more than 5 years in the company and have a Job Level higher 
 -- than the average Job Level of all employees.

WITH Experienced_Employees 
AS ( SELECT  EmployeeNumber, Age, Department, YearsAtCompany, MonthlyIncome, JobLevel from dbo. [Employees]
    WHERE YearsAtCompany > 5
)

SELECT * FROM Experienced_Employees WHERE JobLevel > (SELECT AVG(JobLevel) FROM dbo.[Employees]);

-- 14. Create a CTE to calculate the total number of employees in each department, 
--- then select only those departments where employee count is more than 500.


WITH Total_Employees AS (SELECT Count(*) AS TotEmployee, Department FROM dbo.[Employees] GROUP BY Department)

SELECT * FROM  Total_Employees WHERE TotEmployee >500;


-- 15  Create a CTE that calculates the total employees in each department, 
-- then assign a RANK() based on the number of employees in descending order.

WITH Total_Emp AS (SELECT Department,  Count(*) AS Num_of_Emp FROM dbo.[Employees] GROUP BY Department )

SELECT Department, Num_of_Emp,  RANK() OVER(ORDER BY Num_of_Emp DESC ) AS Rank_of_Department FROM Total_Emp


--16 Retrieve Total employee whose  MonthlyIncome is more than the average MonthlyIncome of their department using PARTITION BY.


WITH Department_Income AS  (
    SELECT EmployeeNumber, Department,  MonthlyIncome , AVG(MonthlyIncome) 
    OVER (PARTITION BY Department )AS AvgDepartmentIncome FROM dbo.[Employees])

SELECT Department , count(*) AS Total_Employee_with_Handsome_salary 
FROM Department_Income WHERE MonthlyIncome > AvgDepartmentIncome GROUP BY Department;


-- Advanced SQL Questions: 
--17 Assign a rank to employees based on their MonthlyIncome in descending order for each department 
--only for top 5 employees for each of the department.

WITH Ranked_Employees  AS(
    SELECT EmployeeNumber, Department, MonthlyIncome, RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome) AS Rank 
    FROM dbo.[Employees]
)
SELECT * FROM Ranked_Employees
where rank<=5;

-- 18 Use DENSE_RANK() to rank employees by JobLevel in desc within each Department.
WITH Ranked_Employee AS (
    SELECT EmployeeNumber, Department , JobLevel, DENSE_RANK () OVER (PARTITION BY Department ORDER BY JobLevel DESC ) as Dense_Rank 
    FROM dbo.[Employees]
)

SELECT * FROM Ranked_Employee

--19. Use ROW_NUMBER() to assign a unique row number to employees in each department, ordered by YearsAtCompany in descending order.
WITH Ranked_Employee AS (
    SELECT Department, YearsAtCompany, 
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY YearsAtCompany) as ROW_NUMBER
    FROM dbo.[Employees])

    Select * From Ranked_Employee where ROW_NUMBER <=4;

--20: Find the second highest salary in each department using RANK().
WITH Second_Highest_Salary AS (
    SELECT EmployeeNumber, Department, MonthlyIncome,  
           RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS rnk 
    FROM dbo.[Employees]
)
SELECT * FROM Second_Highest_Salary WHERE rnk = 2;

--21: Find the top 3 highest-paid employees in each department using RANK() or DENSE_RANK().
WITH Highest_Paid_Emp AS (
    SELECT EmployeeNumber, Department, MonthlyIncome, 
        RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS rnk 
    FROM dbo.[Employees]
)

SELECT * FROM Highest_Paid_Emp WHERE rnk <=3;
