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
on e.emp_no=s.emp_no
order by emp_no asc;

-- 2.List the first name, last name, and hire date for the employees who were hired in 1986.
select e.first_name, e.last_name, e.hire_date 
from Employees as e
where e.hire_date in
	(select e.hire_date 
	from Employees as e
	where e.hire_date like '%1986');
	
-- 3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
select dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
from departments as d
join dept_manager as dm
on d.dept_no=dm.dept_no
join Employees as e
on dm.emp_no=e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d
join dept_emp as de 
on d.dept_no = de.dept_no
join employees as e 
on de.emp_no =e.emp_no
order by emp_no asc;

-- 5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
select e.first_name, e.last_name, e.sex 
from employees as e
where e.first_name='Hercules'
and e.last_name like 'B%';

-- 6.List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no, e.first_name, e.last_name 
from employees as e
where e.emp_no in
	(select de.emp_no
	from dept_emp as de
	where de.dept_no in
	 	(select d.dept_no
		from departments as d
		where d.dept_name ='Sales'))
order by emp_no asc;

-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select de.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de
on e.emp_no =de.emp_no
join departments as d
on de.dept_no=d.dept_no
where d.dept_name in ('Sales', 'Development')
order by emp_no asc;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select e.last_name, count(last_name)
from employees as e
group by last_name
order by count desc; 
