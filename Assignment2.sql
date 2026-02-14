create database assign;
use assign;

select * from sqlassignment;
desc sqlassignment;
#step 1 : salary column
update sqlassignment set salary=null where salary="";
alter table sqlassignment modify column salary int;

# step 2 : date column
update sqlassignment set joiningdate=null where joiningdate="";
update sqlassignment set joiningdate=str_to_date(joiningdate,"%m/%d/%Y");
alter table sqlassignment modify column joiningdate date;

# 1. Retrieve all employees who work in the IT department.
select * from sqlassignment where Department="IT";

# 2. Find employees whose Salary is greater than 80,000.
select * from sqlassignment where Salary>80000;

# 3. Get all employees whose Position is either 'Manager' or 'Analyst'.
select * from sqlassignment where Position in("manager","analyst");
select * from sqlassignment where Position="manager" or Position="analyst";

# 4. List employees whose City is not 'Mumbai'.
select * from sqlassignment where city!="mumbai";
select * from sqlassignment where city not in("mumbai");

# 5. Show employees with a NULL value in the JoiningDate column.
select * from sqlassignment where JoiningDate is null;

# 6. Retrieve all employees whose Name starts with 'Employee_1'.
select * from sqlassignment where Name like "Employee_1%";

# 7. Get all employees whose Email contains 'company.com'.
select * from sqlassignment where email like "%company.com%";

# 8. Display employees whose Salary is between 50,000 and 1,00,000.
select * from sqlassignment where salary between 50000 and 100000;

# 9. List employees whose Salary is negative.
select * from sqlassignment where salary<0;

# 10. Retrieve employees who do not belong to 'HR' or 'Finance' departments.
select * from sqlassignment where Department not in("HR","Finance");

# 11. Get employees whose Position is NULL.
select * from sqlassignment where Position="";

# 12. Find employees whose City is either 'Delhi', 'Pune', or 'Chennai'.
select * from sqlassignment where city in("Delhi","Pune","Chennai");
select * from sqlassignment where city="pune" or city="chennai" or city="delhi";

# 13. Retrieve employees whose JoiningDate is after '2023-01-01'.
select * from sqlassignment where JoiningDate>"2023-01-01";

# 14. Show employees whose Name ends with '5'.
select * from sqlassignment where Name like "%5";

# 15. Get employees where Email is 'invalid_email'.
select * from sqlassignment where email="invalid_email";

# 16. List the top 10 highest-paid employees (order by Salary descending).
select * from sqlassignment order by salary desc limit 10;

# 17. Show the top 5 employees who joined earliest (order by JoiningDate ascending).
select * from sqlassignment where joiningdate is not null order by JoiningDate asc limit 5;

# 18. Retrieve employees from the IT department, ordered by Salary in descending order, but only show the first 3 records.
select * from sqlassignment where Department="IT" order by salary desc limit 3;

# 19. Display employees in the 'Sales' department ordered alphabetically by Name, skipping the first 5 rows and returning the next 10.
select * from sqlassignment where Department="Sales" order by Name limit 10 offset 5;

# 20. Get the top 15 employees with the latest joining dates but skip the first 5 results.
select * from sqlassignment order by JoiningDate desc limit 15 offset 5;

# 21. Retrieve the top 3 highest-paid employees from the IT department, ignoring NULL or negative salaries. Order by Salary descending and use LIMIT/OFFSET to get only the top 3.
select * from sqlassignment where Department="IT" order by salary desc limit 3;

# 22. Get the 5 most recently joined employees from Mumbai and Chennai, skipping the first 2 results.
select * from sqlassignment where City in("Mumbai","Chennai") and joiningdate is not null order by JoiningDate asc limit 5 offset 2;

# 23. List the first 10 employees whose Email is not 'invalid_email' and ends with 'company.com', ordered by JoiningDate descending.
select * from sqlassignment where email!="invalid_email" and email like "%company.com" order by JoiningDate desc limit 10;

# 24. Retrieve the first 7 employees in the Finance department with salaries between 50,000 and 1,00,000, ordered by Salary descending.
select * from sqlassignment where Department="Finance" AND Salary Between 50000 and 100000 order by salary desc limit 7;



























