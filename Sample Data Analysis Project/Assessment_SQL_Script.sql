-- Create Employee table
CREATE TABLE Employee (
    Employee_Code INT PRIMARY KEY,
    First_Name VARCHAR(255),
    First_Name_MB VARCHAR(255),
    Last_Name VARCHAR(255),
    Last_Name_MB VARCHAR(255),
    Date_Hired DATE,
    Termination_Date DATE,
    Termination_Code VARCHAR(50),
    Birth_Date DATE,
    Gender_Code INT, -- Assuming reference to another table for Gender
    Work_Phone VARCHAR(20),
    Extension VARCHAR(10),
    Fax VARCHAR(20),
    Email VARCHAR(255)
);

-- Create EmpHist table
CREATE TABLE EmpHist (
    Employee_History_Code INT PRIMARY KEY,
    Employee_History_Parent INT,
    Employee_Code INT,
    Record_Start_Date DATE,
    Record_End_Date DATE,
    Position_Code VARCHAR(50),
    Position_Start_Date DATE,
    Manager_Code INT,
    Manager VARCHAR(255),
    Manager_MB VARCHAR(255),
    Branch_Code VARCHAR(50),
    Organization_Code VARCHAR(50),
    FOREIGN KEY (Employee_Code) REFERENCES Employee(Employee_Code)
);

-- Create EmpExp table
CREATE TABLE EmpExp (
    Employee_Code INT,
    Expense_Type_Code INT,
    Expense_Date DATE,
    Expense_Start_Date DATE,
    Expense_End_Date DATE,
    Expense_Unit_Quantity INT,
    Expense_Total DECIMAL(10, 2),
    PRIMARY KEY (Employee_Code, Expense_Type_Code, Expense_Date, Expense_Start_Date),
    FOREIGN KEY (Employee_Code) REFERENCES Employee(Employee_Code)
);

-- Create Employee_Expense_Detail table
CREATE TABLE Employee_Expense_Detail (
    Employee_Code INT,
    Expense_Type_Code INT,
    Expense_Date DATE,
    Expense_Start_Date DATE,
    Expense_End_Date DATE,
    Expense_Unit_Quantity INT,
    Expense_Total DECIMAL(10, 2),
    PRIMARY KEY (Employee_Code, Expense_Type_Code, Expense_Date, Expense_Start_Date),
    FOREIGN KEY (Employee_Code) REFERENCES Employee(Employee_Code),
    FOREIGN KEY (Expense_Type_Code) REFERENCES EmpExp(Expense_Type_Code)
);