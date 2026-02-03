#star,snowflake,galaxy
#Joins: When we want to solve any business question which depends on multiple tables then we use joins
#it helps you see related data together instead of seperatly
#types of joins
#1. inner join: common data from both the table
#2. left join: all data from left/ first table and common from second
#3. right join:  all data from right/ second table and common from firts
#4.cross join:
#5. self join
#6. full jon
#######################################
#books
#editor
#author
#translator

create database  joins;
use  joins;
select * from authors;
select * from editors;
select * from books;
select * from translators;
#q1. find authorname for book="My Last book"
#without join
select * from books
where title="My Last book"; #11
select * from authors where id=11;
#syntax
-- select * from table1 temporaryname1
-- inner/left/right/cross join table2 temporaryname2
-- on temporaryname.commoncolumn=temporaryname2.commoncolum;
select * from books
inner join authors 
on books.author_id=authors.id
where title="My Last Book";

####
select b.id, a.id as athor_id,b.title,a.first_name,a.last_name from books b
inner join authors a
on b.author_id=a.id
where title="My Last Book";
######################################
#join multiple tables
#table1-table2
#table1-table3
select * from books b
inner join authors a
on b.author_id=a.id
inner join editors e
on b.editor_id=e.id
where title="My Last Book";  #empty result set > coz editorid=28 is not common between the books and editoes table

select * from books b
inner join authors a
on b.author_id=a.id
inner join editors e
on b.editor_id=e.id
where title="Time To Grow Up!";
