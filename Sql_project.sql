Create database Sql_BankProject;
use Sql_BankProject;

select * from finance_1;
select * from finance_2;


# 1) Year wise loan amount Stats
SELECT
YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS year,
	SUM(loan_amnt) AS total_loan_amount
FROM Finance_1
GROUP BY year;
 
 
# 2) Grade and sub grade wise revol_bal
SELECT 
f1.grade,
f1.sub_grade,
    SUM(f2.revol_bal) AS revol_bal
FROM Finance_1 f1
join Finance_2 f2
on f1.id = f2.ï»¿id
GROUP BY f1.grade, f1.sub_grade;
     

# 3) Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT 
f1.verification_status,
    ROUND(SUM(f2.total_pymnt), 2) AS total_payment
FROM Finance_1 f1
JOIN Finance_2 f2 
ON f1.id = f2.ï»¿id
WHERE f1.verification_status IN ('Verified', 'Not Verified')
GROUP BY f1.verification_status;


# 4) State wise and month wise loan status
SELECT 
addr_state,
    MONTHNAME(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS issue_month,
loan_status,
    COUNT(id) AS loan_count
FROM Finance_1
GROUP BY addr_state, issue_month, loan_status;


# 5) Home ownership Vs last payment date stats
SELECT 
    f1.home_ownership,
    f2.last_pymnt_d,
    COUNT(f1.id) AS total_loans,
    ROUND(SUM(f2.total_pymnt), 2) AS total_payment
FROM Finance_1 f1
JOIN Finance_2 f2 
ON f1.id = f2.ï»¿id
WHERE f2.last_pymnt_d IS NOT NULL
GROUP BY f1.home_ownership, f2.last_pymnt_d;


