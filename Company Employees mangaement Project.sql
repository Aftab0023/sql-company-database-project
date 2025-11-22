create database CompanyDB;
use CompanyDB;

-- Creating Department Table
create table Department(
	DeptID int primary key,
    DeptName varchar(20),
    Location varchar(30)
);

-- creating Employee Table  
create table Employee(
	EmpID int primary key,
    EmpName varchar(30),
    Gender char(1),
    HireDate date,
    DeptID int,
    foreign key (DeptID) references Department(DeptID)	
);

-- Creating Salaries Table
create table Salaries(
	SalaryID int primary key,
    EmpID int,
    BaseSalary decimal(10, 2),
    Bonus decimal(10, 2),
    foreign key (EmpID) references Employee(EmpID)
); 

-- Inserting Record in DEpartment Table
insert into Department values
(1, 'Human Resources', 'Pune'),
(2, 'IT', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'Marketing', 'Bangalore');

-- Inserting Records in EMployee table
insert into Employee values
(101, 'Aftab Tamboli', 'M', '2022-06-10', 2),
(102, 'Riya Sharma', 'F', '2021-09-15', 1),
(103, 'Neha Patil', 'F', '2020-03-20', 3),
(104, 'Prathmesh Patil', 'M', '2023-01-10', 4),
(105, 'Ayaan Tamboli', 'M', '2019-11-05', 2);

-- Inserting Records in Salary Table
insert into Salaries values
(1, 101, 60000, 5000),
(2, 102, 45000, 3000),
(3, 103, 55000, 4000),
(4, 104, 48000, 2500),
(5, 105, 70000, 6000); 

-- Showing All Employees with there Department Name
select E.EmpName, D.DeptName
from Employee E
join Department D on E.DeptID = D.DeptID;

-- Calculate each employee’s total salary
select E.EmpName, (S.BaseSalary + S.Bonus) as TotalSalary
from Employee E
join Salaries S on E.EmpID = S.EmpID;

-- Find average salary by department
select D.DeptName, avg(S.BaseSalary + S.Bonus) as AvgSalary
from Employee E
join Department D on E.DeptID = D.DeptID
join Salaries S on E.EmpID = S.EmpID
group by D.DeptName;

-- Find employees hired after 2021
select EmpName, HireDate
from Employee
where HireDate > '2021-12-31';

-- Show top 3 highest-paid employees
select E.EmpName, (S.BaseSalary + S.Bonus) as TotalSalary
from Employee E
join Salaries S on E.EmpID = S.EmpID
order by TotalSalary desc
limit 3;


-- Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
-- inserting records
INSERT INTO Projects VALUES
(201, 'AI Chatbot System', '2024-02-01', '2024-07-15', 2),
(202, 'Employee Wellness Program', '2024-03-10', '2024-09-30', 1),
(203, 'Financial Forecast Model', '2023-10-01', '2024-04-30', 3),
(204, 'Digital Marketing Campaign', '2024-01-15', '2024-06-15', 4);

-- EmployeeProjects Table (Many-to-Many relationship)
CREATE TABLE EmployeeProjects (
    EmpID INT,
    ProjectID INT,
    Role VARCHAR(50),
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
-- inserting Records
INSERT INTO EmployeeProjects VALUES
(101, 201, 'AI Developer'),
(102, 202, 'HR Coordinator'),
(103, 203, 'Data Analyst'),
(104, 204, 'Marketing Executive'),
(105, 201, 'Backend Engineer'),
(105, 203, 'Database Specialist'),
(101, 203, 'Project Lead');

-- PErformance Table
CREATE TABLE Performance (
    ReviewID INT PRIMARY KEY,
    EmpID INT,
    Year INT,
    Rating DECIMAL(2,1),
    Comments VARCHAR(255),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);
-- inserting records
INSERT INTO Performance VALUES
(1, 101, 2023, 4.5, 'Excellent performance in AI project'),
(2, 102, 2023, 3.9, 'Good HR coordination'),
(3, 103, 2023, 4.2, 'Strong analytical skills'),
(4, 104, 2023, 3.8, 'Good marketing outcomes'),
(5, 105, 2023, 4.6, 'Outstanding technical contribution');


-- Add Attendance or Leave Tracking
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmpID INT,
    Date DATE,
    Status ENUM('Present', 'Absent', 'Leave'),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);
-- inserting records
INSERT INTO Attendance VALUES
(1, 101, '2024-11-04', 'Present'),
(2, 101, '2024-11-05', 'Present'),
(3, 101, '2024-11-06', 'Leave'),
(4, 102, '2024-11-04', 'Present'),
(5, 102, '2024-11-05', 'Present'),
(6, 102, '2024-11-06', 'Present'),
(7, 103, '2024-11-04', 'Present'),
(8, 103, '2024-11-05', 'Absent'),
(9, 103, '2024-11-06', 'Present'),
(10, 104, '2024-11-04', 'Present'),
(11, 104, '2024-11-05', 'Leave'),
(12, 105, '2024-11-04', 'Present'),
(13, 105, '2024-11-05', 'Present'),
(14, 105, '2024-11-06', 'Present');


-- Add Department Manager Info
ALTER TABLE Department ADD ManagerID INT;

UPDATE Department SET ManagerID = 101 WHERE DeptID = 2; -- IT Dept managed by Aftab Tamboli
UPDATE Department SET ManagerID = 102 WHERE DeptID = 1; -- HR managed by Riya Sharma
UPDATE Department SET ManagerID = 103 WHERE DeptID = 3; -- Finance managed by Neha Patil
UPDATE Department SET ManagerID = 104 WHERE DeptID = 4; -- Marketing managed by Rohit Deshmukh


-- Add Salary History Table
CREATE TABLE SalaryHistory (
    RecordID INT PRIMARY KEY,
    EmpID INT,
    EffectiveDate DATE,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

-- inserting record 
INSERT INTO SalaryHistory VALUES
(1, 101, '2023-01-01', 55000, 60000),
(2, 102, '2023-01-01', 42000, 45000),
(3, 103, '2023-01-01', 50000, 55000),
(4, 104, '2023-01-01', 45000, 48000),
(5, 105, '2023-01-01', 65000, 70000);




-- Showing Present days
SELECT EmpID, COUNT(*) AS TotalDays, 
SUM(CASE WHEN Status='Present' THEN 1 ELSE 0 END) AS DaysPresent
FROM Attendance
GROUP BY EmpID;

-- This can help find top-performing employees.
SELECT E.EmpName, P.Year, P.Rating
FROM Employee E
JOIN Performance P ON E.EmpID = P.EmpID
WHERE P.Rating >= 4.0;

SELECT E.EmpName, P.ProjectName, EP.Role
FROM Employee E
JOIN EmployeeProjects EP ON E.EmpID = EP.EmpID
JOIN Projects P ON EP.ProjectID = P.ProjectID;


SELECT D.DeptName, E.EmpName AS ManagerName
FROM Department D
JOIN Employee E ON D.ManagerID = E.EmpID;

-- Finding AVerage Rating Per Document
SELECT D.DeptName, AVG(P.Rating) AS AvgRating
FROM Performance P
JOIN Employee E ON P.EmpID = E.EmpID
JOIN Department D ON E.DeptID = D.DeptID
GROUP BY D.DeptName;

-- Find department with highest total salary expense
SELECT D.DeptName, SUM(S.BaseSalary + S.Bonus) AS TotalExpense
FROM Employee E
JOIN Salaries S ON E.EmpID = S.EmpID
JOIN Department D ON E.DeptID = D.DeptID
GROUP BY D.DeptName
ORDER BY TotalExpense DESC
LIMIT 1;

-- Find employees working on more than one project
SELECT EmpID, COUNT(ProjectID) AS ProjectCount
FROM EmployeeProjects
GROUP BY EmpID
HAVING ProjectCount > 1;



 