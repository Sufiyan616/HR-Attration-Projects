CREATE DATABASE HrDb; -- Creating Database
USE HrDb; -- Using HrDb Database

SELECT * FROM Company;
-- Answering Some Busniess Question

-- Q1. Find the total number of employees in each Department.
SELECT Department,COUNT(*) AS Total_Employees
FROM Company
GROUP BY Department;

-- Q2. Find the average MonthlyIncome for each JobRole.
SELECT JobRole,ROUND(AVG(MonthlyIncome),2) AS Avg_Monthly_Income
FROM Company
GROUP BY JobRole
ORDER BY Avg_Monthly_Income DESC;

-- Q3. Find the count of employees by Attrition (Yes/No).
SELECT Attrition,COUNT(*) AS Attrition_Count 
FROM Company
GROUP BY Attrition;

-- Q4.Find the Departments where average MonthlyIncome is greater than 5000.
SELECT Department,AVG(MonthlyIncome) AS Avg_Monthly_Income
FROM Company
GROUP BY Department
HAVING AVG(MonthlyIncome) > 5000;

-- Q5. Rank employees by MonthlyIncome within each Department.
SELECT MonthlyIncome,Department,
RANK() 
	OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS Rank_By_Dep
    FROM Company;

-- Q6. Difference between employee income and department average
SELECT *,
       MonthlyIncome - AVG(MonthlyIncome) OVER (PARTITION BY Department) AS diff_from_dept_avg
FROM Company;

-- Q7. Employees earning more than department average
SELECT *
FROM Company c
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM Company
    WHERE Department = c.Department
);

-- Q8. JobRoles having more than 50 employees
SELECT JobRole, COUNT(*) AS total
FROM Company
GROUP BY JobRole
HAVING COUNT(*) > 50;

-- Q9. Running count of employees by YearsAtCompany in each Department
SELECT *,
       COUNT(*) OVER (PARTITION BY Department ORDER BY YearsAtCompany) AS running_count
FROM Company;

-- Q.10 First hired / most experienced employee in each JobRole
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY JobRole ORDER BY YearsAtCompany DESC) AS rn
    FROM Company
) t
WHERE rn = 1;















 
