create database FinanceDB;
use FinanceDB;
create table Loans(LoanID INT, CustomerID INT, DisbursedDate DATE, LoanAmount DECIMAL(12,2),EMI DECIMAL(10,2), Status VARCHAR(20));
select * from Loans ;
insert into Loans values 
(1, 1001, '2023-01-15', 500000.00, 12000.00, 'Active'),
(2, 1002, '2023-03-10', 300000.00, 8000.00, 'Closed'),
(3, 1003, '2024-01-05', 400000.00, 10000.00, 'Defaulted'),
(4, 1004, '2024-04-22', 200000.00, 6000.00, 'Active'),
(5, 1005, '2024-06-18', 250000.00, 7000.00, 'Active'),
(6, 1006, '2024-12-13', 450000.00, 7500.00, 'Defaulted'),
(7, 1007, '2024-04-30', 450000.00, 9000.00, 'Closed'),
(8, 1008, '2025-05-08', 250000.00, 5000.00, 'Active'),
(9, 1009, '2023-07-14', 300000.00, 7500.00, 'Defaulted'),
(10, 1010, '2023-03-03', 350000.00, 5833.33, 'Closed'),
(11, 1011, '2022-05-30', 250000.00, 5000.00, 'Defaulted'),
(12, 1012, '2023-09-26', 400000.00, 6666.67, 'Closed'),
(13, 1013, '2024-07-16', 450000.00, 7500.00, 'Active'),
(14, 1014, '2024-01-26', 400000.00, 6666.67, 'Defaulted'),
(15, 1015, '2024-05-06', 200000.00, 4000.00, 'Closed'),
(16, 1016, '2024-01-31', 300000.00, 7500.00, 'Active'),
(17, 1017, '2025-04-15', 350000.00, 7000.00, 'Active'),
(18, 1018, '2023-12-05', 200000.00, 5000.00, 'Closed'),
(19, 1019, '2022-05-20', 450000.00, 7500.00, 'Closed'),
(20, 1020, '2022-09-05', 300000.00, 6000.00, 'Defaulted'),
(21, 1021, '2023-12-13', 450000.00, 7500.00, 'Defaulted'),
(22, 1022, '2025-03-12', 500000.00, 12500.00, 'Active'),
(23, 1023, '2023-01-19', 200000.00, 4000.00, 'Active'),
(24, 1024, '2023-08-10', 500000.00, 10000.00, 'Active'),
(25, 1025, '2023-02-14', 350000.00, 7000.00, 'Active');

select * from loans;
alter table loans add column TenureMonths INT;
alter table loans rename column Status to LoanStatus;
delete from loans where loanstatus = "Closed" and year(disburseddate) = 2022; 

start transaction;
update loans set emi = 0 where loanstatus = "Defaulted";
rollback;

select loanstatus, count(*)from Loans group by loanstatus;
select sum(LoanAmount) from loans where year(disburseddate) = 2024;
select avg(EMI) from loans where loanamount > 400000;
select loanid, customerid, loanamount from loans where emi > (select avg(emi) from loans);
select max(loanamount), min(loanamount), avg(loanamount) from loans group by loanstatus;
select loanstatus, sum(emi), count(*) from loans group by loanstatus;

update loans set emi = 0 where loanstatus = "Defaulted";
update loans set emi = emi * 1.05 where loanstatus = "Active";
delete from loans where loanamount < 250000;

start transaction;
insert into loans values(26, 1026, "2025-09-16",300000.00, 7500.00, "Active", 36);
update loans set emi = 8000.00 where loanid = 26;
commit;


start transaction;
delete from loans where loanstatus = "Closed";
rollback;

select loanstatus, count(*) from loans group by loanstatus;
