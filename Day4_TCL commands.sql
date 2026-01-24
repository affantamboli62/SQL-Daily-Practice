#revision : DDL ,DML
#DDL: create table, create database, alter(add column, rename column,modify column,drop column)),
         #rename table,truncate ,drop
#DML: insert into, delete,update
use speedup;
select * from courses;
update courses set duration_months=8 where course_id=6;
delete from courses where course_id=7;
################################################
#TCL commands: Transaction Control lang
#start transaction
#1. rollback: undo
#2.commit: permenent changes
#3. savepoint: particulat point
#used to manage transaction(insert into,update delete) 
select * from students;
start transaction;
insert into students values(51,"Chetana Vasave","chetnavasve3@gmail.com",null,3,"Ratnagiri","2026-01-21");
delete from students where student_id=51;
rollback;

############
start transaction;
insert into students values(52,"Aniket","niket3@gmail.com",null,5,"Pune","2026-01-21");
update students set email="Abhishek@gmail.com" where student_id=47;
delete from students where student_id=49;
rollback;
#################################################
#commit
start transaction;
commit;
insert into students values(52,"Aniket","niket3@gmail.com",null,5,"Pune","2026-01-21");
update students set email="Abhishek@gmail.com" where student_id=47;
delete from students where student_id=49;
select * from students;
rollback;
##################################################
#savepoint: sets a point within transaction to roll back to.
start transaction;
savepoint s1;
insert into students values(53,"Aditya","Aditya3@gmail.com",null,5,"Pune",null),(54,"Prajwal","Prajwal@gmail.com",null,5,"Pune",null);
savepoint s2;
update students set phone=7687542 where student_id=4;
savepoint s3;
update students set city="Pune" where student_id=24;
savepoint s4;
delete from students where student_id=1;
savepoint s5;
delete from students where student_id=25;
select * from students;
rollback to s3;