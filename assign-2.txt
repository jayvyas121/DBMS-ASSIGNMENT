

1. Display names using alias names "First Name" and "Last Name"

SELECT first_name AS `First Name`,
       last_name AS `Last Name`
FROM employees;

2. Get unique department IDs

SELECT DISTINCT department_id
FROM employees;

3. Get all employee details ordered by first name in descending order

SELECT *
FROM employees
ORDER BY first_name DESC;

4. Display first name, last name, salary and PF (15% of salary)

SELECT first_name,
       last_name,
       salary,
       salary * 0.15 AS PF
FROM employees;

5. Get employee ID, names and salary in ascending order of salary

SELECT employee_id,
       first_name,
       last_name,
       salary
FROM employees
ORDER BY salary ASC;

6. Get total salaries payable to employees

SELECT SUM(salary) AS `Total Salary`
FROM employees;

7. Get maximum and minimum salary

SELECT MAX(salary) AS `Maximum Salary`,
       MIN(salary) AS `Minimum Salary`
FROM employees;

8. Get average salary and number of employees

SELECT AVG(salary) AS `Average Salary`,
       COUNT(*) AS `Number of Employees`
FROM employees;

9. Get the number of employees working with the company

SELECT COUNT(*) AS `Number of Employees`
FROM employees;

10. Get the number of jobs available in the employees table

SELECT COUNT(DISTINCT job_id) AS `Number of Jobs`
FROM employees;

11. Get all first names in uppercase

SELECT UPPER(first_name) AS `First Name`
FROM employees;

12. Get the first 3 characters of first name

SELECT LEFT(first_name, 3) AS `First 3 Characters`
FROM employees;

13. Calculate 171 * 214 + 625

SELECT 171 * 214 + 625 AS Result;

Output:

37279

14. Display full names such as "Ellen Abel", "Sundar Ande"

SELECT CONCAT(first_name, ' ', last_name) AS `Employee Name`
FROM employees;

15. Get first name after removing white spaces from both sides

SELECT TRIM(first_name) AS `First Name`
FROM employees;

16. Get the length of employee names (first name and last name)

SELECT first_name,
       last_name,
       LENGTH(CONCAT(first_name, ' ', last_name)) AS `Name Length`
FROM employees;

17. Check whether first_name contains numbers

SELECT first_name
FROM employees
WHERE first_name REGEXP '[0-9]';

This returns the first names that contain at least one numeric digit.

18. Select the first 10 records from the table

SELECT *
FROM employees
LIMIT 10;

19. Get monthly salary rounded to 2 decimal places

Since salary is the annual salary:

SELECT first_name,
       last_name,
       ROUND(salary / 12, 2) AS `Monthly Salary`
FROM employees;
