select * from orders;
select * from customers;
#order by
select * from orders order by Quantity desc limit 2;
desc orders;
#Sequence of cluases : select,from, where,group by,having,order by,limit
select CustomerId ,sum(Quantity) from orders group by CustomerId
order by sum(Quantity) desc limit 2 ;
#group by clause with aggrgation fun
#aggrgation fn without group by
#1.Total quantity,Total orders ,avg discount

select count(OrderID) as Total_orders ,sum(Quantity) as total_sold_qty,
avg(discount) as average_discount from orders;
#2.Total orders by customer_id
select customerid, count(OrderID) from orders group by  customerid;
select productid,customerid, count(OrderID) from orders group by  customerid; #error
select * from orders where customerid=111;  #6

