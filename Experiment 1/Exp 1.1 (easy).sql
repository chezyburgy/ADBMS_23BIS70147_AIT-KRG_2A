create database exp1
use exp1

create table tbl_author(
	aid int primary key,
	aname varchar(20),
	acountry varchar(20)
)

create table tbl_book(
	bid int primary key,
	bname varchar(20),
	auth_id int foreign key references tbl_author(aid)
)

insert into tbl_author values (1, 'ram', 'India'), (2, 'sham', 'USA'), (3, 'jack', 'Germany'), (4, 'julie', 'France')

insert into tbl_book values (1, 'book1', 1), (2, 'book2', 4), (3, 'book3', 3), (4, 'book4', 2), (5, 'book5', 2)

select b.bname, a.aname, a.acountry
from tbl_author as a
inner join
tbl_book as b
on a.aid = b.auth_id
