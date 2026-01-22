#DDL: Data Defination lang: create ,alter,rename table, truncate,drop
#1.create
create database databasename;
use speedup;  #to select database
#syntax: create table tablename (column1 datatype,column2 datatype,column3 datatype.....)
create table students(stdid int ,stdname char(100),joining_date date, mobile_no bigint);
select * from students;

#DML: insert into,delete,update==>rowwise(add,delete,row value update)
insert into students values(101,"Chetana","2025-12-05",867545345);
insert into students values(102,"Prajwal","2026-1-05",867654534),(103,"Aniket","2024-01-15",5454524);
#delete: row delete
#when SQL safe update mode is on will get error : sql will not allow to delete and update
#edit===preferences==sql editor==>uncheck safe update
delete from students where stdid=101;
#using command 
set sql_safe_updates=0;

#update: to change cell value

#DDL: 2. alter==>columnwise(add column to existing table,rename column,data type change,column drop)
#students table==>add city column
alter table students add column city varchar(50);
select * from students;
#rename colunb
alter table students rename column city to Location;
#insert row with stdid=A103===>we cant insert this id coz stdid is in int format, we need to convert it into char
#so to change datatype we can use modify column command with alter
alter table students modify column stdid char(50);
desc students; #to describe table ===>fieldname,data type,whether column allows null or not,keys(primary key,foreign key,unique)
alter table students drop column location;

#DDL: 3.rename table
rename table students to students_details;

#DDL : 4. truncate table: table data(rows) delete : structure remains as it is
#DDL : 5. drop table/drop database: Entire table /entire databse will delete from system with structure
truncate table students_details;
select * from students_details;
drop table students_details;
