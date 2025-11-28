# 📚 CompanyDB – SQL Employee Management System  
A complete relational database project built in **MySQL**, designed to manage company employee data, salaries, projects, performance, attendance, and HR operations.  
This project demonstrates SQL skills required for internships or entry-level data roles.

---

## 🚀 Project Overview  
The **CompanyDB** database simulates a real-world HR management system.  
It includes:

- Employee management  
- Department hierarchy  
- Salaries + salary history  
- Project assignments (many-to-many)  
- Attendance tracking  
- Performance reviews  
- Administrative access for BI tools  

---

# 📂 **Database Structure**

companydb
│
├── Department
├── Employee
├── Salaries
├── SalaryHistory
├── Projects
├── EmployeeProjects
├── Performance
└── Attendance


---

# 🗄️ **Table Explanation**

### **1. Department**
| Column | Description |
|--------|-------------|
| DeptID | Primary key |
| DeptName | Name of department |
| Location | City |
| ManagerID | Employee who manages dept |

---

### **2. Employee**
| Column | Description |
|--------|-------------|
| EmpID | Primary key |
| EmpName | Employee full name |
| Gender | M/F |
| HireDate | Joining date |
| DeptID | Linked to Department |

---

### **3. Salaries**
Stores current salary information with Base + Bonus.

---

### **4. SalaryHistory**
Maintains increment history of each employee.

---

### **5. Projects**
Department-level project information.

---

### **6. EmployeeProjects**
Many-to-many mapping of employees to projects.

---

### **7. Performance**
Yearly performance rating for each employee.

---

### **8. Attendance**
Daily attendance tracking (Present/Absent/Leave).

---

# 🧪 **SQL Features Covered**

### ✔ Database Design & Normalization  
All tables follow **1NF, 2NF, 3NF**.

### ✔ Primary & Foreign Keys  
Used to maintain referential integrity.

### ✔ Many-to-Many Relationship  
`EmployeeProjects (EmpID, ProjectID)`.

### ✔ Sample Data Insertions  
For realistic testing.

### ✔ Analytical Queries  
You included **HR analytics**, **salary analytics**, and **performance insights**.

### ✔ User Creation for BI Tools  
A separate user `powerbi` created for dashboard access.

---

# 📊 **Key SQL Queries (Included in Project)**

🔹 1. Employees with their departments**
SELECT E.EmpName, D.DeptName
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID;'''

🔹 2. Total salary (base + bonus)
SELECT E.EmpName, (S.BaseSalary + S.Bonus) AS TotalSalary
FROM Employee E
JOIN Salaries S ON E.EmpID = S.EmpID;

🔹 3. Average salary by department
SELECT D.DeptName, AVG(S.BaseSalary + S.Bonus) AS AvgSalary
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID
JOIN Salaries S ON E.EmpID = S.EmpID
GROUP BY D.DeptName;

🔹 4. Top 3 highest-paid employees
SELECT E.EmpName, (S.BaseSalary + S.Bonus) AS TotalSalary
FROM Employee E
JOIN Salaries S ON E.EmpID = S.EmpID
ORDER BY TotalSalary DESC
LIMIT 3;

🔹 5. Employee attendance summary
SELECT EmpID,
       COUNT(*) AS TotalDays,
       SUM(CASE WHEN Status='Present' THEN 1 ELSE 0 END) AS DaysPresent
FROM Attendance
GROUP BY EmpID;

🔹 6. Employees working on more than 1 project
SELECT EmpID, COUNT(ProjectID) AS ProjectCount
FROM EmployeeProjects
GROUP BY EmpID
HAVING ProjectCount > 1;

🔹 7. Department with highest salary expense
SELECT D.DeptName, SUM(S.BaseSalary + S.Bonus) AS TotalExpense
FROM Employee E
JOIN Salaries S ON E.EmpID = S.EmpID
JOIN Department D ON E.DeptID = D.DeptID
GROUP BY D.DeptName
ORDER BY TotalExpense DESC
LIMIT 1;
