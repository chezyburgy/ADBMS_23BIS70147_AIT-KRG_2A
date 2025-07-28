create database exp2
use exp2

create table yeartbl(
	id int,
	ynum int,
	npv int
)

create table querytbl(
	id int,
	qyear int
)

insert into yeartbl (id, ynum, npv) values
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

insert into querytbl (id, qyear) values
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

select q.id as [ID], q.qyear as [Year], ISNULL(y.npv, 0) as NPV
from querytbl as q
left join
yeartbl as y
on q.id = y.id and q.qyear = y.ynum
order by q.id
