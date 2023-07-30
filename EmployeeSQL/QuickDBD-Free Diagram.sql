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

