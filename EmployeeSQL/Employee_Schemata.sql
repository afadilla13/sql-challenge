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