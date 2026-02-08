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
#3. scaler sub
#4.multiple column sub
#5. correlated subquery

#joins,basic window fn, basic subquery
