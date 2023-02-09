CREATE TABLE Titles (
    title_id varchar Primary key  NOT NULL,
    title varchar   NOT NULL
);

CREATE TABLE Employees (
    emp_no int primary key   NOT NULL,
    emp_title_id varchar    NOT NULL,
    birth_date varchar   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date varchar   NOT NULL,
	foreign key (emp_title_id) references titles(title_id)
);
-- select * from employees

CREATE TABLE Departments (
    dept_no varchar Primary Key   NOT NULL,
    dept_name varchar   NOT NULL
);
-- drop table dept_emp
CREATE TABLE dept_emp (
    emp_no int  NOT NULL,
    dept_no varchar   NOT NULL,
	foreign key (dept_no) references Departments(dept_no),
	foreign key (emp_no) references Employees(emp_no)
);

-- select * from dept_emp

CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no int   NOT NULL,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references Employees(emp_no)
);
-- select * from dept_manager

CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
	foreign key (emp_no) references Employees(emp_no)
);
-- select * from salaries

-- 1.List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from Employees as e 
join Salaries as s 
on e.emp_no=s.emp_no;

-- 2.List the first name, last name, and hire date for the employees who were hired in 1986.
select e.first_name, e.last_name, e.hire_date 
from Employees as e
where e.hire_date in
	(select e.hire_date 
	from Employees as e
	where e.hire_date like '%1986')








