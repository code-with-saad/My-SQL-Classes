use hr_db;

# ================================================ 10 TASKS OF SUB QUERIES START ================================================
 
SELECT * FROM employees;

# Task 01
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    SALARY = (SELECT 
            MAX(salary)
        FROM
            employees
        WHERE
            last_name = 'Bull');

# TASK 01 SECOND WAY
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    SALARY > (SELECT 
            salary
        FROM
            employees
        WHERE
            last_name = 'Bull');


# Task 02

SELECT 
    FIRST_NAME, LAST_NAME
FROM
    employees
WHERE
    DEPARTMENT_ID = (SELECT 
            DEPARTMENT_ID
        FROM
            departments
        WHERE
            DEPARTMENT_NAME = 'IT');

   
# TASK 03
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    manager_id IN (SELECT 
            employee_id
        FROM
            employees
        WHERE
            department_id IN (SELECT 
                    department_id
                FROM
                    departments
                WHERE
                    location_id IN (SELECT 
                            location_id
                        FROM
                            locations
                        WHERE
                            country_id = 'US')));


# TASK 04
SELECT 
    FIRST_NAME, LAST_NAME, SALARY
FROM
    employees
WHERE
    SALARY > (SELECT 
            AVG(SALARY)
        FROM
            employees);


# TASK 05
SELECT 
    FIRST_NAME, LAST_NAME, SALARY
FROM
    employees
WHERE
    SALARY = (SELECT 
            MIN(SALARY)
        FROM
            employees);


# TASK 06
SELECT 
    FIRST_NAME, LAST_NAME, SALARY
FROM
    employees
WHERE
    DEPARTMENT_ID IN (SELECT 
            DEPARTMENT_ID
        FROM
            departments
        WHERE
            DEPARTMENT_NAME LIKE 'IT%')
        AND SALARY > (SELECT 
            AVG(SALARY)
        FROM
            employees);


# TASK 07
SELECT 
    FIRST_NAME, LAST_NAME, SALARY
FROM
    EMPLOYEES
WHERE
    SALARY > (SELECT 
            SALARY
        FROM
            employees
        WHERE
            LAST_NAME = 'Bell') ORDER BY SALARY;


# TASK 08
SELECT 
    FIRST_NAME, LAST_NAME, SALARY
FROM
    employees
WHERE
    salary = (SELECT 
            MIN(salary)
        FROM
            employees);

# TASK 09
SELECT 
    *
FROM
    (SELECT 
        *
    FROM
        employees
    ORDER BY employee_id DESC
    LIMIT 10) AS sub
ORDER BY employee_id ASC;


# TASK 10
SELECT 
    *
FROM
    departments
WHERE
    department_id NOT IN (SELECT 
            department_id
        FROM
            employees);


# ================================================ 10 TASKS OF SUB QUERIES END ================================================



# ================================================ 05 TASKS OF DATETIME QUERIES START ================================================

# TASK 01
SELECT 
    FIRST_NAME, HIRE_DATE
FROM
    employees
WHERE
    HIRE_DATE BETWEEN '1987-06-01' AND '1987-07-30';
         
         
# TASK 02
SELECT 
    FIRST_NAME, YEAR(HIRE_DATE) AS 'Year'
FROM
    employees
WHERE
    YEAR(HIRE_DATE) = '1987';


# TASK 03
SELECT 
    FIRST_NAME,
    LAST_NAME,
    YEAR(HIRE_DATE) AS 'Year',
    MONTH(HIRE_DATE) AS 'Month'
FROM
    employees
WHERE
    MONTH(HIRE_DATE) = 6;


# TASK 04
SELECT 
    DATE_FORMAT(HIRE_DATE, '%Y')
FROM
    employees
GROUP BY DATE_FORMAT(HIRE_DATE, '%Y')
HAVING COUNT(EMPLOYEE_ID) > 10;
        
        
# TASK 05

SELECT 
    (SELECT 
            DEPARTMENT_NAME
        FROM
            departments
        WHERE
            DEPARTMENT_ID = employees.DEPARTMENT_ID) AS Department_Name,
    FIRST_NAME AS Manager_Name,
    SALARY AS Manager_Salary
FROM
    employees
WHERE
    EMPLOYEE_ID IN (SELECT 
            MANAGER_ID
        FROM
            employees
        WHERE
            DATEDIFF(NOW(), hire_date) / 365 > 5);



# ================================================ 05 TASKS OF DATETIME QUERIES END ================================================




# ================================================ 14 TASKS OF Aggregate QUERIES START ================================================

# TASK 01
SELECT DISTINCT
    JOB_ID
FROM
    employees;


# TASK 02
SELECT 
    COUNT(*) AS 'Total Employees',
    SUM(SALARY) AS 'Total Salary Cost'
FROM
    employees;


# TASK 03
SELECT 
    COUNT(*) AS 'Total Employees',
    MIN(SALARY) AS 'Minimum Salary Cost'
FROM
    employees;


# TASK 04
SELECT 
    COUNT(*) AS 'Total Employees',
    MAX(SALARY) AS 'Maximum Salary Cost'
FROM
    employees;


# TASK 05
SELECT 
    MAX(SALARY) AS 'Highest Salary',
    MIN(SALARY) AS 'Lowest Salary',
    SUM(SALARY) AS 'Total Salary',
    AVG(SALARY) AS 'Average Salary'
FROM
    employees;


# TASK 06
SELECT 
    MAX(SALARY)
FROM
    employees
WHERE
    JOB_ID = 'IT_PROG';


# TASK 07
SELECT 
    JOB_ID, COUNT(*) AS 'Number Of Employees'
FROM
    employees
GROUP BY JOB_ID;



# TASK 08
SELECT 
    MANAGER_ID, MIN(SALARY) AS Lowest_Salary
FROM
    employees
GROUP BY MANAGER_ID
ORDER BY Lowest_Salary;


# TASK 09
SELECT 
    d.department_name, SUM(e.salary) AS Total_Salary
FROM
    employees e,
    departments d
WHERE
    e.department_id = d.department_id
GROUP BY d.department_name;


# TASK 10
SELECT 
    d.department_name, AVG(salary) AS average_salary
FROM
    employees e,
    departments d
WHERE
    d.department_name NOT LIKE 'IT%'
GROUP BY d.department_name
ORDER BY d.department_name ASC;


# TASK 11
SELECT 
    d.DEPARTMENT_NAME, AVG(e.salary) AS Average_Salary
FROM
    employees e,
    departments d
WHERE
    e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC
LIMIT 3;



# TASK 12
SELECT 
    JOB_ID, AVG(SALARY) AS DEPARTMENT_AVG_SALARY
FROM
    employees
GROUP BY JOB_ID
HAVING AVG(SALARY) > (SELECT 
        AVG(SALARY)
    FROM
        employees); 


# TASK 13
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    LAST_DAY(HIRE_DATE) AS 'DATE OF FIRST SALARY'
FROM
    employees;


# TASK 14
SELECT DEPARTMENT_NAME, DEPARTMENT_ID
FROM departments
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID
    FROM employees
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) > 10
);

# ================================================ 14 TASKS OF Aggregate QUERIES END ================================================

































