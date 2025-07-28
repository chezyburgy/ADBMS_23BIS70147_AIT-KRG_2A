create database exp2
use exp2

create table emplo(
	eid int primary key identity(1,1),
	ename varchar(20),
	depart varchar(20),
	managid int foreign key references emplo(eid)
)
insert into emplo values 
('Alice', 'hr', NULL), 
('bob', 'finance', 1),
('charlie', 'it', 1),
('david', 'finance', 2),
('eve', 'it', 3),
('frank', 'hr', 1)

select e1.ename as [employee name], e1.depart as [department], e2.ename as [Manager Name], e2.depart as [Manager depart]
from emplo as e1
left outer join
emplo as e2
on
e1.managid = e2.eid
