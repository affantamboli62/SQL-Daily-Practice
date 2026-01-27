use speedup;
create table messy_data(std_id int,name varchar(50),date text);
insert into messy_data values (1,"affan","1-1-2026"),(2,"tanmay","2-3-2026");
select * from messy_data;
select * from emp;

#ucase,lcase,substring,len,concat,substring,format

#Tempeorary Result
select ucase(name) from messy_data;
select lcase(name) from messy_data;
select trim(name) from messy_data;
select ucase(trim(name))from messy_data;
select lcase(trim(name))from messy_data;

#Orignal changes in orignal table
update messy_data set name=ucase(name);
insert into messy_data values (3,"aditya ","4-6-2026");

#To find Extra space
select name from messy_data where name like " %" or name like "% ";

#To Update Single Column
update messy_data set name=trim(name);

#To Update Multiple Columns
update messy_data set name=trim(name),email=trim(email),city=trim(city);

###########################################################################################################
#Concat()
select concat("Affan"," ","Tamboli") as concat;
update messy_data set name=lcase(name);
select * from messy_data;

#Tempeorary Result
select concat(name,".","@gmail.com") as email from messy_data;

#Permenant Result
update messy_data set name=concat(name,".","@gmail.com");
###########################################################################################################

#Length()
select * from messy_data;
select length(name) from messy_data;
select length("affan");

###########################################################################################################

# left,right,Substring()==>mid : Extract
select left("DA-155",2) as left_fun;
select right("DA-155",2) as right_fun;
select * from messy_data;
select substring(name,8,6) from messy_data;

###########################################################################################################

#Format() : Use for Number Formating
select format(7657.3,0) as format;
select format(7657.73,1) as format;
select format(7657.787,1) as format;

##########################################################################################################3

alter table messy_data add column fees double;
select * from messy_data;
desc messy_data;
update messy_data set fees=15000 where name="affan.@gmail.com.@gmail.com";
update messy_data set fees=20000 where name="tanmay.@gmail.com.@gmail.com";
update messy_data set fees=35000 where name="aditya.@gmail.com.@gmail.com";

select format(fees,0) from messy_data;
select concat(format(fees,0),".rs") from messy_data;
select concat(format(fees,1),".rs") from messy_data;
select concat("Rs ",format(fees,0)) from messy_data;
select sum(concat("Rs ",format(fees,0))) from messy_data;
select sum(fees) from messy_data;

################################################################################

# Char and Varchar Difference
# 1.CHAR is fixed-length and faster
# 2.VARCHAR is variable-length and saves space.
# Use CHAR → gender (M/F), country code (IN, US)
# Use VARCHAR → name, email, address

###############################################################################

select 5+9;
select 5-9;
select 5*9;
select mod(45,15);  #Remainder
select mod(45,7);  #Remainder
select abs(-76);
select sqrt(64);

###############################################################################

#Discount For 10 %
select name,fees-fees*0.1 from messy_data;
##############################################################################

#Add new column Discount
alter table messy_data add column discount double;
select * from messy_data;
update messy_data set discount=fees*0.1;
select std_id,fees-discount as discount from messy_data;