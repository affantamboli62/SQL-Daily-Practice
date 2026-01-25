#Clause in SQL: are used to filter,group,sort and limit data in a query
#1. select : Retrieve data
#2. from : specify table
#3. where : Filter rows with condition
#4. Group by: Group rows
      #e.g.
      # city                  Sales
      #Pune               500
      #Mumbai           400
      #Pune               300
      #Mumbai           800
      #Nagpur           500
      # city wise sum sales: group by city sum(sales)
#5. having: filter rows after grouping
#6. order by: Sort the data
#7. limit: data limit(show only first 5 rows)
#8. distinct: unique values/rows
########################################################
#where clause operators:
#=
#>
#<
#!= or <>
#<=
#>=
#and
#or
#not
#in and not in: membership operators
#like  : pattern matching
#between: range
select * from courses;
select * from students;
#1. select course where duration_months is greater than 3

#2. select cosurse where fees <50000

#3. select students data where course id= 2

#4. select student_id,student_name and city where city="Pune"
select city,Student_ID, student_name from students where  city ="Pune";
#5. students who do not belong to "Mumbai"
#########################-----------------------------------
#and/ or
use speedup;
select * from students;
select * from courses;
#6.find course name where duration >3 and laso fees >30000
select * from courses where duration_months>3 and fees>30000 ;
#in and not in
#7. select students where city =Mumbai,pune,Delhi,Patna
select * from students where city="Mumbai" or city="Pune" or city="Delhi" or city="Patna";
select * from students where city in("Mumbai","pune","Delhi","Patna");
#not with in
select * from students where city not in("Mumbai","pune","Delhi","Patna");
#not with comparision op
select * from courses where fees not >3000;
###############################
#between operator:with and range select
#8. select fess from 30000 to 50000
select * from courses where fees between 10000 and 20000;  #10000 and 20000 : included
select * from courses where fees not between 10000 and 20000; 
###################################
-- like operator: pattern matching
#9. Extract students names starts with leter "A":
#wild cards with like operator
#1. %: any number of charcters(start and end):   "A%"
#2. _: Exactly one character  : "A__": two character after A
select  student_name from students where student_name like "A%";  #startswith
select  student_name from students where student_name like "%A";  #endswith
#9. extract course name conatining AI
select course_name from courses where course_name like "%AI%";
#10. Names with exactly 5 characters
select * from students where student_name like "__________";
select * from students where student_name like "A_________";
select * from students where student_name like "_________r%";
select * from students where student_name like "_________%r";
select * from students where student_name like "_r%";
#email
select * from students;
select * from students where phone like "%9";
select * from students where student_id like "1_%";
select * from students where enrollment_date like "2026%";