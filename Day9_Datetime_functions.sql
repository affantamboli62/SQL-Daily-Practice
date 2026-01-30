use speedup;
select * from messy_data;
#Rename column date to joining_date
#add column coursename and course_completed_date
alter table messy_data rename column date to joining_date;
alter table messy_data add column coursename varchar(20);
alter table messy_data add column course_completed_date date;
update messy_data set coursename="DS" where std_id=1;
update messy_data set coursename="DA" where std_id=2;
update messy_data set coursename="SQL" where std_id=3;
update messy_data set course_completed_date="2027-11-05" where std_id=1;
update messy_data set course_completed_date="2027-03-08" where std_id=2;
update messy_data set course_completed_date="2027-02-01" where std_id=3;
#######################################
desc messy_data;
#Datetime functions
#1. str_to_date(): text to date conversion
select str_to_date(joining_date,"%d-%m-%y") from messy_data;
#update messy_data set joining_date=str_to_date(joining_date,"%d-%m-%y") ;

#2. Now(),curdate(),curtime(),current_timestamp()
select now();
select curdate(); #today()
select curtime();
select current_timestamp();
######################
#year(),month(),day()
select year("2027-02-02");
select year(str_to_date(joining_date,"%d-%m-%y")) from messy_data;
select year(course_completed_date) from messy_data;
select month(course_completed_date) from messy_data;
select day(course_completed_date) from messy_data;
##############################
#hour,minute,second
select hour(course_completed_date) from messy_data;
select minute(course_completed_date) from messy_data;
select second(course_completed_date) from messy_data;
select hour(now());
############################
#Dayname, monthname
select Dayname(course_completed_date) from messy_data;
select monthname(course_completed_date) from messy_data;
#############
#dayofmonth(), dayofweek(),dayofyear(),week()
select course_completed_date from messy_data;
select dayofmonth(course_completed_date) from messy_data;
select dayofweek(course_completed_date) from messy_data;
select dayofyear(course_completed_date) from messy_data;
################################
#datedif(recentdate,earlier_date): days difference, timestampdif()
select datediff(course_completed_date,str_to_date(joining_date,"%d-%m-%y")) from messy_data;
select timestampdiff(minute,now(),"2026-01-28 12:50:50");  #datetime
#e.g. student_in_time- student_out_time
###################################
#Date_add,date_sub()
select name,course_completed_date,date_add(course_completed_date,interval 1 day) as next_day from messy_data;
select name,course_completed_date,date_add(course_completed_date,interval 1 month) as next_month from messy_data;
select name,course_completed_date,date_add(course_completed_date,interval 1 year) as next_year from messy_data;
select name,course_completed_date,date_sub(course_completed_date,interval 3 day) as previous_3_day from messy_data;

##################################
select date("2026-01-28 12:50:50");
select time("2026-01-28 12:50:50");
###################################
#date_format(): to format date
#format(): to format numbers(number to text)
select name, date_format(course_completed_date,"%d/%b/%Y") from messy_data;
select date_format("2026-01-28 10:50:50", "%h:%i %p");
#common formats
-- %y- 2 digit year
-- %Y- 4 digit year
-- % d- day
-- %H- 24 hour
-- %h- 12-hour
-- %i- minutes
-- %p-- AM/PM
-- %b -- monthname
-- %m-- month no
############################
#last_day(), quarter()
select last_day(course_completed_date) from messy_data;
select quarter(course_completed_date) from messy_data;
#Find no of students in jan month
select count(std_id) from messy_data where month(str_to_date(joining_date,"%d-%m-%Y"))=1;
#find no of students in each year
select count(std_id) from messy_data group by year(str_to_date(joining_date,"%d-%m-%Y"));
select year(str_to_date(joining_date,"%d-%m-%Y")) as year_joining_date,count(std_id) from messy_data 
group by year_joining_date;

#find total fees in each month
select monthname(str_to_date(joining_date,"%d-%m-%Y")) as month_joining_date,sum(fees) from messy_data 
group by month_joining_date;
-- -------------------------------------- -------------------------------------- ------------------------------------
#classicmodels
#-- ------------------------------------
-- QUESTION: Report the number of customer who have made payments before October 28, 2004.
use classicmodels;
select * from customers;
select * from payments;
select count(*) from payments;  #273 ===>coint of payments
select customernumber,paymentdate from payments where paymentdate<"2004-10-28" ;  #filter
select count(customernumber) from payments where paymentdate<"2004-10-28" ; #189
#471: 4 payments
select count(distinct(customernumber)) from payments where paymentdate<"2004-10-28" ; #98


