#Subquery: Query inside another query
#inner query : first run
#then outer query will run: query1(query2(query3)))
#Types of subquery

#1.single row subquery
-- one row, one value-- used with operators (=,<,>,>=,<=,<>)===>
-- used in where cluase
#e.g. 1.find customers with same credit limit as customer 103
use classicmodels;
select * from customers;
select * from customers where creditlimit=(select creditlimit from customers where customerNumber=103 );
#or
select creditlimit from customers where customerNumber=103 ; #21000
select * from customers where creditlimit=21000;

#e.g.2. find customer with second highest credit limit
select customerName,creditLimit from customers where creditLimit
<(select max(creditlimit) from customers)
order by creditlimit desc limit 1;
#OR
select customerName,creditLimit from customers order by creditlimit desc limit 1 offset 1;

#e.g.3 find customers whose payment is greater than the avg payment of all
select * from payments;
select * from payments where amount>(select avg(amount) from payments);
select customername,contactfirstname,contactLastName,amount from customers c
inner join payments p
on c.customerNumber=p.customerNumber
where amount>(select avg(amount) from payments);

#e.g.4.customers with more no of orders than average no of orders
select * from orders;
select customerNumber ,count(*) as ordercount from orders
group by customerNumber
having count(*)  >
(select avg(cnt) from (select count(*) as cnt from orders
group by customerNumber) as table1);
#1st inner query result==>multiple row
#2nd inner query result==>single row

###################################################
##2.multiple row subquery
#Returns multiple rows
#used with:  in,not in,any,all
#used with clause: from ,where
#e.g.1. Customers who have placed orders
select * from customers where customernumber in (select customernumber from orders);   
#e.g.2 Customers who never placed any order
select * from customers where customernumber not in (select customernumber from orders);   

#e.g.3 ...find products costlier than all "Motorcycles" category
select * from products;
select productname,buyprice,productline from products where buyprice>all
(select buyprice from products where productline="Motorcycles");

select productname,buyprice,productline from products where buyprice>any
(select buyprice from products where productline="Motorcycles");

#############################
-- List the employee codes for sales representatives of customers in Spain, France and Italy. 
-- Make another query to list the names and email addresses of those employees.
select * from customers;
select * from employees;
select employeeNumber,firstName,email from employees where employeeNumber in
(select salesRepEmployeeNumber from customers where country in("Spain", "France", "Italy"));
#########
#List producst whose buyprice is lower than any buyprice of products supplied in "Planes" category
select * from products where buyprice<any(select buyprice from products where productline="Planes");

#########
#3. scalar sub:
-- returns single value using aggregate function
-- aggregate functions: (AVG, SUM, MIN, MAX, COUNT)
-- used in WHERE / SELECT clause
-- comparison happens with one computed value
#e.g. Display product name, buy price, and average buy price of all products.
use classicmodels;
SELECT 
    productName,
    buyPrice,
    (SELECT AVG(buyPrice) FROM products) AS avg_price
FROM products;
#without subquery we will get error
select productName,buyPrice,avg(buyPrice) from products;
#using window fun: overall average in front of each row
select productName,buyPrice, avg(buyPrice) over() from products;
#product wise average
select productName,buyPrice, avg(buyPrice) over(partition by productName) from products;

#e.g2 Mark products as EXPENSIVE or CHEAP compared to average.
#CASE Statements: ifs/switch
SELECT 
    productName,
    buyPrice,
    CASE 
        WHEN buyPrice > (SELECT AVG(buyPrice) FROM products) 
        THEN 'EXPENSIVE'
        ELSE 'CHEAP'
    END AS price_category
FROM products;
select * from customers;
#if creditlimit<20000 then "less than 20K"
#if creditlimit<50000 then "less than 50K"
#if creditlimit<85000 then "less than 85K"
#else : greater than 85k
select * ,
case 
when creditlimit<20000
then "less than 20K"
when creditlimit<50000
then "less than 50K"
when creditlimit<85000
then "less than 85K"
else "greater than 85k"
end as creditlimit_category from customers;



#difference between single row and scalar
-- Type	                               Returns	                     Usually uses
-- Single-row subquery	     1 row, 1 value	       Normal column value: filtered single value from row
-- Scalar subquery	         1 row, 1 value         Aggregate / derived value : constatnt value

#e.g 3 Show total revenue with each order
SELECT 
    orderNumber,
    (SELECT SUM(amount) FROM payments) AS total_revenue
FROM orders;

#e.g.4Find all orders placed on the same date as order number 10100.
SELECT orderNumber, orderDate
FROM orders
WHERE orderDate =
(
    SELECT orderDate
    FROM orders
    WHERE orderNumber = 10100
);  #single row,single column



-- -------------------------------------------------------------------
#4.multiple column sub
-- returns multiple columns
-- comparison done using row constructor
-- used in WHERE clause
-- columns must match number and order

#Example 1: Customers in the same city and country as customer=103
SELECT customerName, city, country,customerNumber
FROM customers
WHERE (city, country) =
(
    SELECT city, country
    FROM customers
    WHERE customerNumber = 103
);


#Example 2: Customers whose total order amount exceed 5000 (totalAmount + customerNumber)
SELECT customerNumber, customerName
FROM customers
WHERE (customerNumber, customerName) IN
(
    SELECT c.customerNumber, customerName
    FROM payments p
    JOIN customers c ON p.customerNumber = c.customerNumber
    GROUP BY customerNumber, customerName
    HAVING SUM(amount) > 5000
);  #multiple row_multiple column
#OR
SELECT c.customerNumber, customerName
    FROM payments p
    JOIN customers c ON p.customerNumber = c.customerNumber
    GROUP BY customerNumber, customerName
    HAVING SUM(amount) > 5000;


#5. correlated subquery
#it is a subquery that depends on the outer query for its values
#IMP: It is eavluated once for each row of the outer query
#it cannot run independantly
#e.g. we want to find employees whose salary is higher that the average salary in their office

-- #office code   salary
-- 1                      40
-- 2                      50
-- 3                      10
-- 1                       20
-- 2                       30
-- 2                       10

#1         30   ===>1 40
#2         45=====>2 50

-- select * from employees;(empnum,firstname,lastname,officecode,salary)
-- select * from offices; (officecode,city,country)

select e.empnum,e.firstname,e.lastname, e.officecode
from employees e
where e.salary>
(select avg(salary) from employees 
where officecdoe=e.officecode);  #for loop

-- the subquery (select avg(salary) from employees 
-- where officecdoe=e.officecode);  this calculates the avg salary for the office of the current employee
-- this query will run for each emlpoyees 
-- e.g. 2 find customers and their count of orders for thier city
select * from customers;
select * from orders;
select c.customernumber,c.city from customers c
where city in
(select count(*) from orders o
inner join customers c2
on c.customernumber=o.customernumber
where c2.city=c.city);

-- --
#  find customers whose count of orders greater than avg orders  for thier city
SELECT 
    c.customerNumber,
    c.city,
    COUNT(o.orderNumber) AS customer_orders
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.city
HAVING COUNT(o.orderNumber) >
(
    SELECT AVG(city_orders)
    FROM (
        SELECT COUNT(o2.orderNumber) AS city_orders
        FROM customers c2
        JOIN orders o2
            ON c2.customerNumber = o2.customerNumber
        WHERE c2.city = c.city        --  correlation here
        GROUP BY c2.customerNumber
    ) t
);

-- What’s happening here
-- c.city in the WHERE clause makes this a correlated subquery
-- For each outer row (each city):
-- Inner query calculates order count only for THAT city
-- Then AVG(cnt) is calculated for that same city
-- So comparison becomes: Customer’s count vs average order count of their own city


