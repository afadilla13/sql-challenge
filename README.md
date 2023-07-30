**BACKGROUND**

It’s been two weeks since you were hired as a new data engineer at Pewlett Hackard (a fictional company). Your first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

For this project, you’ll design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. That is, you’ll perform data modelling, data engineering, and data analysis, respectively.


**DATA MODELLING**

Inspect the CSV files, and then sketch an ERD of the tables. To create the sketch, feel free to use a tool like QuickDBDLinks to an external site.

![image](https://github.com/afadilla13/sql-challenge/assets/128363337/388c26ad-b699-46d8-8d97-eafbbacb7b4f)

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/JXL3cu
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "DepartmentsNo" varchar(5)   NOT NULL,
    "DepartmentsName" varchar(35)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "DepartmentsNo"
     )
);

CREATE TABLE "DepartmentsEmployee" (
    "EmployeeNo" varchar(10)   NOT NULL,
    "DepartmentsNo" varchar(5)   NOT NULL
);

CREATE TABLE "DepartmentManager" (
    "DepartmentsNo" varchar(5)   NOT NULL,
    "EmployeeNo" varchar(10)   NOT NULL
);

CREATE TABLE "Employees" (
    "EmployeeNo" varchar(10)   NOT NULL,
    "EmployeeTitleID" varchar(5)   NOT NULL,
    "BirthDate" Date   NOT NULL,
    "FirstName" varchar(50)   NOT NULL,
    "LastName" varchar(50)   NOT NULL,
    "Sex" Varchar(1)   NOT NULL,
    "HireDate" Date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "EmployeeNo"
     )
);

CREATE TABLE "Salaries" (
    "EmployeeNo" varchar(10)   NOT NULL,
    "Salary" Int   NOT NULL
);

CREATE TABLE "Titles" (
    "TitleID" varchar(5)   NOT NULL,
    "Title" varchar(35)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "TitleID"
     )
);

ALTER TABLE "DepartmentsEmployee" ADD CONSTRAINT "fk_DepartmentsEmployee_EmployeeNo" FOREIGN KEY("EmployeeNo")
REFERENCES "Employees" ("EmployeeNo");

ALTER TABLE "DepartmentsEmployee" ADD CONSTRAINT "fk_DepartmentsEmployee_DepartmentsNo" FOREIGN KEY("DepartmentsNo")
REFERENCES "Departments" ("DepartmentsNo");

ALTER TABLE "DepartmentManager" ADD CONSTRAINT "fk_DepartmentManager_DepartmentsNo" FOREIGN KEY("DepartmentsNo")
REFERENCES "Departments" ("DepartmentsNo");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_EmployeeNo" FOREIGN KEY("EmployeeNo")
REFERENCES "DepartmentManager" ("EmployeeNo");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_EmployeeTitleID" FOREIGN KEY("EmployeeTitleID")
REFERENCES "Titles" ("TitleID");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_EmployeeNo" FOREIGN KEY("EmployeeNo")
REFERENCES "Employees" ("EmployeeNo");


**DATA ENGINEERING**

Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:

Remember to specify the data types, primary keys, foreign keys, and other constraints.

For the primary keys, verify that the column is unique. Otherwise, create a composite keyLinks to an external site., which takes two primary keys to uniquely identify a row.

Be sure to create the tables in the correct order to handle the foreign keys.

Import each CSV file into its corresponding SQL table.

-- Create Titles Table
CREATE TABLE titles (
	title_id varchar(5) PRIMARY KEY NOT NULL,
	title varchar(35) NOT NULL
);

-- Create Employees Table
CREATE TABLE employees (
	emp_no varchar(10) PRIMARY KEY NOT NULL,
	emp_title_id varchar(5) references titles(title_id) NOT NULL,
	birth_date date NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	sex varchar(1) NOT NULL,
	hire_date date NOT NULL
);

-- Create Salaries Table
CREATE TABLE salaries (
	emp_no varchar(10) references employees(emp_no),
	salary int NOT NULL
);

-- Create Departments Table
CREATE TABLE departments (
	dept_no varchar(5) PRIMARY KEY NOT NULL,
	dept_name varchar(35) NOT NULL
);

-- Create Department Employees Table
CREATE TABLE dept_emp (
	emp_no varchar(10) references employees(emp_no),
	dept_no varchar(5) references departments(dept_no)
);

-- Create Department Managers Table
CREATE TABLE dept_manager (
	dept_no varchar(5) references departments(dept_no),
	emp_no varchar(10)references employees(emp_no)
);


**DATA ANALYSIS**

List the employee number, last name, first name, sex, and salary of each employee.

List the first name, last name, and hire date for the employees who were hired in 1986.

List the manager of each department along with their department number, department name, employee number, last name, and first name.

List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

List each employee in the Sales department, including their employee number, last name, and first name.

List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

--- List of Employee number, last name, first name, sex, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

--- List of first name, last name, and hire date for employees hired in 1986
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-1-1' and '1986-12-31'
ORDER BY hire_date ASC;

--- List of managers in each department (dept number, dept name, emp number, last name, first name)
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name 
FROM dept_manager dm
JOIN employees e
ON dm.emp_no = e.emp_no
JOIN departments d
ON dm.dept_no = d.dept_no
ORDER BY d.dept_name ASC;

--- List of department of each employee (emp number, last name, first name, dept name)
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
ORDER BY d.dept_name ASC;

--- List of first name, last name, and sex for employees named "Hercules B."
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;

--- List of employees in Sales department (emp no, last name, first name, dept name)
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

--- List of employees in Sales and Development departments (emp no, last name, first name, dept name)
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name ASC;

--- List of frequency count of employee last names
SELECT last_name, count(emp_no) as num_employees_with_same_last_name
FROM employees
GROUP BY last_name
ORDER BY num_employees_with_same_last_name DESC;

Shoutout to Alplky for the codes that I referred to. 


