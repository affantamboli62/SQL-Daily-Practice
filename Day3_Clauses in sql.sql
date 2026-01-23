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
