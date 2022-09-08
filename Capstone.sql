create database capstone;
use capstone;

select * from bank;
select count(*) from bank;

# Below is the table which have been taken from the bank-full.csv file using library create_engine


# 1. Write an SQL query to identify the age group which is taking more loan and then calculate the sum of all of the balances of it?

select age, Total_Balance from (select age, count(loan), sum(balance) as Total_Balance from bank where loan='yes' 
group by age order by count(loan) DESC limit 1)T;

# 2. Write an SQL query to calculate for each record if a loan has been taken less than 100, then calculate the fine of 15% 
	#of the current balance and create a temp table and then add the amount for each month from that temp table? 
create temporary table temp_table select count(loan),age, (sum(balance)+((sum(balance)*15)/100)) As Fine from bank group by age having count(loan)<100;
select * from temp_table;

# 3. Write an SQL query to calculate each age group along with each department's highest balance record? 
select age, highest_balance from (select age,job, max(balance) As highest_balance from bank 
group by job)T group by age;

# 4. Write an SQL query to find the secondary highest education, where duration is more than 150. The query 
# should contain only married people, and then calculate the interest amount? (Formula interest => balance*15%). 
select education, (balance*15/100) As interest from bank where education='secondary' and duration>150 and marital='married';

# 5. Write an SQL query to find which profession has taken more loan along with age?
select job, age, count(loan) from bank group by job order by age;

# 6. Write an SQL query to calculate each month's total balance and then calculate in which month the highest amount of transaction was performed?
select month, sum(balance) from bank group by month order by sum(balance) Desc limit 1; 