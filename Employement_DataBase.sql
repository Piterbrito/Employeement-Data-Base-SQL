-- Employee Database

--Data Modeling, setting 

CREATE TABLE "departments" (
    "dept_no" CHAR(4)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "department_employeement" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" CHAR(4)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_department-employeement" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "department_manager" (
    "dept_no" CHAR(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_department-manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_no","title","from_date"
     )
);


--Data Engineering, creating the Archteture 
--of the Data Base

ALTER TABLE "department-employeement" ADD CONSTRAINT "fk_department-employeement_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "department-employeement" ADD CONSTRAINT "fk_department-employeement_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "department-manager" ADD CONSTRAINT "fk_department-manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "department-manager" ADD CONSTRAINT "fk_department-manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Pray!!!!

SELECT *  FROM titles

--Works!!! Great
--Now..

--Data Analysis

SELECT * FROM department-employeement
-- Question 1
--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender,
s.salary
FROM employees as e
JOIN salaries as s
ON e.emp_no = s.emp_no;

-- Question 2
--List employees who were hired in 1986.

SELECT emp_no, first_name, last_name, hire_date
FROM employees 
WHERE hire_date LIKE '1986%';


-- Question 3
--List the manager of each department with the following info: 
--department number, department name, the manager's employee number
--last name, first name, and start and end employment dates.

SELECT dm.dept_no, dm.emp_no, dm.from_date, dm.to_date,
d.dept_name,
e.first_name, e.last_name
FROM department_manager AS dm
JOIN departments AS d
ON dm.dept_no = d.dept_no
JOIN employees AS e
ON dm.emp_no = e.emp_no;

-- Question 4
--List the department of each employee with the following: 
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name,
de.dept_no,
d.dept_name
FROM employees AS e
JOIN department_employeement AS de
ON e.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no;

-- Question 5
--List all employees whose first name is "Hercules" 
--and last names begin with "B."

SELECT first_name, last_name FROM employees
WHERE first_name = 'Hercules' 
AND Last_name LIKE 'B%';



--Question 6
--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.

SELECT * FROM departments --Sales dept = d007

--Select what'll be included in the table
SELECT e.emp_no, e.last_name, e.first_name,
de.dept_no,
d.dept_name

--From (table has key), 
--JOIN (table getting info)
--ON (use 2 columns that are the some as reference to grab info)
FROM employees AS e
JOIN department_employeement AS de
ON e.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no

--Parameter of the searching
WHERE d.dept_no = 'd007';



-- Question 7
--List all employees in the Sales and Development departments,INCLUDING
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.first_name, e.last_name, 
de.dept_no,
d.dept_name

FROM employees as e
JOIN department_employeement as de
ON e.emp_no = de.emp_no
JOIN departments as d
ON de.dept_no = d.dept_no

WHERE de.dept_no = 'd005' OR de.dept_no = 'd007';


--Question 8
--In descending order, list the frequency count of last names
--how many employees share each last name.

SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT DESC;