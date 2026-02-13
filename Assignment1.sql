drop database financedb;
create database financedb;
use financedb;
create table loan(ID INT, CustomerID INT, DisbursedDate DATE, LoanAmount DECIMAL(12,2),EMI DECIMAL(10,2), Status VARCHAR(20));
insert into loan values(1, 1001, '2023-01-15', 500000.00, 12000.00, 'Active'),
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
alter table loan add column TenureMonths int;
select * from loan;
alter table loan rename column status to loanstatus;
delete from loan where loanstatus='closed' and year(disburseddate)=2022;
SELECT LoanStatus, COUNT(*) AS LoanCount FROM Loan GROUP BY LoanStatus;
SELECT SUM(LoanAmount) AS TotalLoanAmount_2024 FROM Loan WHERE YEAR(DisbursedDate) = 2024;
SELECT AVG(EMI) AS AvgEMI FROM Loan WHERE LoanAmount > 400000; 
SELECT ID, CustomerID, LoanAmount FROM Loan WHERE EMI > (SELECT AVG(EMI) FROM Loan);
SELECT LoanStatus,MAX(LoanAmount) AS MaxLoan,MIN(LoanAmount) AS MinLoan,AVG(LoanAmount) AS AvgLoan FROM Loan GROUP BY LoanStatus;
SELECT LoanStatus,SUM(EMI) AS TotalEMI,COUNT(*) AS LoanCount FROM Loan GROUP BY LoanStatus;
UPDATE Loan SET EMI = EMI * 1.05 WHERE LoanStatus = 'Active';
UPDATE Loan SET EMI = 0 WHERE LoanStatus = 'Defaulted';
delete from loan where loanamount<250000;



       




