use exp1

create table tbl_depart(
	depart_id int primary key,
	depart_name varchar(20)
)

create table tbl_course(
	course_id int primary key,
	course_name varchar(20),
	dep_id int foreign key references tbl_depart(depart_id),
)

insert into tbl_depart values (1, 'AIT'), (2, 'CSE'), (3, 'EC'), (4, 'MEH')

INSERT INTO tbl_course VALUES
(1, 'CC', 1),
(2, 'DBMA', 1),
(3, 'DSA', 1),
(4, 'MATHS', 2),
(5, 'DBMS', 2),
(6, 'CN', 3),
(7, 'QP', 4),
(8, 'PS', 2),
(9, 'SD', 3),
(10, 'EC', 3)

select d.depart_name
from tbl_depart as d
inner join
tbl_course as c
on d.depart_id = c.dep_id
group by d.depart_name
having count(d.depart_id) > 2
