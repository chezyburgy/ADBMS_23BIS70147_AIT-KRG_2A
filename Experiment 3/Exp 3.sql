/*------EASY-------*/
CREATE TABLE employ(
    emp_id INT
);

INSERT INTO employ values (2),(4),(4),(6),(6),(7),(8),(8),(8);

select * from employ;

select MAX(e.emp_id)
from employ as e
where emp_id not in(
    select Max(e1.emp_id) 
    from employ as e1
    group by e1.emp_id
    having count(*) > 1
)


/*----MEDIUM-----*/
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

select * from department;
select * from employee;

select d.dept_name as [department name],e.name as [Name], e.salary as [Salary], d.id 
from
employee as e
inner join
department as d
on e.department_id = d.id
where e.salary in
(
  select MAX(e2.salary)
  from employee as e2
  where e2.department_id = d.id
) order by d.id;

/*----HARD---------*/

create table table1 (
  empid INT,
  ename varchar(20),
  salary INT
)
create table table2 (
  empid INT,
  ename varchar(20),
  salary INT
  
)
insert into table1 values (1, 'AA', 1000), (2, 'BB', 300);
insert into table2 values (2, 'BB', 400), (3, 'CC', 100);

select * from table1;
select * from table2;

select empid as [empid], MIN(ename) as [Ename], MIN(salary) as [Salary]
from
(
select * from table1
UNION all
select * from table2
) as d
group by empid
