#Window functions: window fns helps us calculate totals,aveges or ranks without hiding individual rows unlike group by
#sum
#min
#max
#count
#avg
#rank
#dense_rank
#row_number
#lead
#lag
#first_value
#last_value
#Use of window functions: calculate running totals, YOY,MOM etc
#clause: over()
#syntax:
#select * ,window_fun over(partition by columnname order by column name) from tablename;
use classicmodels;
select * from orderdetails;
#total number order placed by each product
select *, sum(quantityOrdered) over() from orderdetails;
select sum(quantityOrdered) from orderdetails;
select *, sum(quantityOrdered) over(partition by productCode) as total_orders from orderdetails
order by total_orders desc;

select *, sum(quantityOrdered) over(partition by productCode) from orderdetails
where orderLineNumber=3;

#group by
select productcode, sum(quantityOrdered) from orderdetails
where orderLineNumber=3
group by productcode;


#rank(),dense_rank()
select * from payments;
select *, rank() over(order by amount desc) from payments; #if duplicate amount it will skip rank
select *, dense_rank() over(order by amount desc) from payments; #if duplicate amount it will not skip rank
select *, dense_rank() over(partition by customerNumber order by amount desc) from payments;
update payments set amount=120166.58 where checkNumber="ID10962";


#row number()
select *, row_number() over(order by amount desc) from payments; 
select *, row_number() over(partition by customerNumber) from payments;
#find second highest amount in payments
select * from payments order by amount desc limit 1 offset 1;
#find second highrest payments made by each customer
select *, row_number() over(partition by customerNumber order by amount desc) as row_num from payments;
#using subqquery
select * from(select *, row_number() over(partition by customerNumber order by amount desc) as row_num from payments) t
where row_num=2;

#######################################################
use classicmodels;
select * from orderdetails;
#rank by quantityOrdered : desc
select productCode,quantityOrdered, rank() over(order by quantityOrdered desc) as rank_qty
from orderdetails ;

select productCode,quantityOrdered, row_number() over() as row_num from orderdetails;
select productCode,quantityOrdered, row_number() over(order by quantityOrdered desc)
 as row_num from orderdetails;

#lead(), lag(): YOY,MOM,total running
select * from payments;
select * ,lag(amount) over(order by paymentDate) from payments;
select * ,lead(amount) over(order by paymentDate) from payments;
#total amount yearwise
select year(paymentDate) as year, sum(amount)
over(partition by year(paymentDate) order by paymentDate)
 from payments;
 #group by
 select year(paymentDate) as year,sum(amount)  from payments
 group by year(paymentDate);
 
 ##running total paymentdatewise
 select paymentDate,amount,sum(amount)
 over(order by paymentDate) as running_total from payments;
 
 #running total yearwise
 select year(paymentDate),amount,sum(amount)
 over(partition by year(paymentDate) order by paymentDate) as running_total from payments;
 
 #Q1. monthwise Running total
 #Q2. Top 3 customers by total sales(per year)
 #using group by
 select customernumber, year(paymentdate) ,sum(amount)
 from payments
 group by customernumber, year(paymentdate)
 order by sum(amount) limit 3;
 #window fun
 select * , rank() over(partition by year(paymentdate) order by amount) as rank_amount from payments;
 #subqery 
 select * from 
 (select * , rank() over(partition by year(paymentdate) order by amount) as rank_amount from payments) table1
 where rank_amount<4;
 #Q3.Rank product by sales within each productline
 select * from products;
 select *, rank() over(partition by productline order by MSRP desc) from products;
 #Q4.Find highest order per customer
select * from customers; #customerNumber
select * from orders; #customerNumber
select * from orderdetails; #orderNumber
select customerNumber,od.orderNumber,priceEach,
rank() over(partition by customerNumber order by priceEach) as rank_price
from orders o
inner join orderdetails od
on o.orderNumber=od.orderNumber;

select * from (select customerNumber,od.orderNumber,priceEach,
rank() over(partition by customerNumber order by priceEach desc) as rank_price
from orders o
inner join orderdetails od
on o.orderNumber=od.orderNumber) table1
where rank_price=1;



 #Q5.Comapare previous order amount with current
 
 #first_value()
 #last_value()
 
 
 #second highest payment amount
 select * from payments;
 select * from payments order by amount desc limit 1 offset 1;
 select * from payments where amount < (select amount from payments order by amount desc limit 1)
 limit 1;
 #amount where amount is greater that average amount
 select * from payments where amount>(select avg(amount) from payments);