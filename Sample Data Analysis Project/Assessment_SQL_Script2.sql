-- 1) SQL query that returns the total expense amounts by expense unit, expense type, and year of submission (EXPENSE_DATE)
SELECT 
    Expense_Unit_Quantity, 
    Expense_Type_Code, 
    YEAR(Expense_Date) AS Year_Of_Submission, 
    SUM(Expense_Total) AS Total_Expense_Amount
FROM 
    Employee_Expense_Detail
GROUP BY 
    Expense_Unit_Quantity, 
    Expense_Type_Code, 
    YEAR(Expense_Date);

-- 2) SQL query that returns the employees that spent more than $1000 in a year.
SELECT 
    Employee_Code, 
    YEAR(Expense_Date) AS Year, 
    SUM(Expense_Total) AS Total_Expense
FROM 
    Employee_Expense_Detail
GROUP BY 
    Employee_Code, 
    YEAR(Expense_Date)
HAVING 
    SUM(Expense_Total) > 1000;

-- 3) SQL query that identifies all employees that spent less than $100 (or nothing at all) in 2023.
-- First, create a list of all employees and then LEFT JOIN with their expenses in 2023, filtering for those who spent less than $100 or have no expenses.

SELECT 
    E.Employee_Code
FROM 
    Employee E
LEFT JOIN (
    SELECT 
        Employee_Code, 
        SUM(Expense_Total) AS Total_Expense
    FROM 
        Employee_Expense_Detail
    WHERE 
        YEAR(Expense_Date) = 2023
    GROUP BY 
        Employee_Code
    ) AS Exp2023 ON E.Employee_Code = Exp2023.Employee_Code
WHERE 
    IFNULL(Exp2023.Total_Expense, 0) < 100;