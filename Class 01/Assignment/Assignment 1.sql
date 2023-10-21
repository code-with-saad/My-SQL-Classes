SELECT * FROM hr_db.employees;

select * from employees limit 10;

Select FIRST_NAME as first_name, LAST_NAME as last_name from employees;

Select distinct DEPARTMENT_ID from employees;

Select * from employees order by FIRST_NAME desc limit 10;

SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS FullName, salary FROM employees;

select salary from employees order by salary;

select sum(salary) as Total_Salary from employees;


select min(salary), max(salary), avg(salary) from employees;

SELECT FIRST_NAME, LAST_NAME, salary FROM employees WHERE salary > ALL(SELECT avg(salary) FROM employees);

select count(*) from employees;

select count(*) as Number_Of_Employees, avg(salary) from employees;

select count(DISTINCT  JOB_ID) from employees;

select upper(FIRST_NAME) from employees;

SELECT TRIM(first_name) FROM employees;

SELECT first_name, last_name, round(salary/12,2) as 'Monthly Salary' FROM employees;

SELECT * FROM employees ORDER BY `salary` DESC LIMIT 1 OFFSET 2;


SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS FullName, salary FROM employees where SALARY between 10000 and 15000;

