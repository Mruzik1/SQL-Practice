-- Task 1:
-- Write a query to display the top 5 employees (by salary) in the HR department, along with their department names.
SELECT DISTINCT
    e.*,
    d.department_name
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id
ORDER BY e.salary DESC
FETCH NEXT 5 ROWS ONLY;

-- Task 2:
-- Write a query to find the average salary of employees in each department, rounded to the nearest whole number.
-- Include only those departments where the average salary is greater than 5000.
SELECT DISTINCT
    d.department_id,
    d.department_name,
    ROUND(AVG(e.salary)) AS avg_salary
FROM hr.departments d
JOIN hr.employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING ROUND(AVG(e.salary)) > 5000;

-- Task 3:
-- Write a query to find the employees who have the same manager as employee 'John Russell'.
-- Display the employee name and their manager's name.
SELECT 
    e.first_name, 
    e.last_name, 
    m.first_name AS manager_fist_name, 
    m.last_name AS manager_last_name
FROM hr.employees e
JOIN hr.employees m
    ON m.employee_id = (
        SELECT jr.manager_id
        FROM hr.employees jr
        WHERE jr.first_name = 'John' AND jr.last_name = 'Russell'
    );

-- Task 4:
-- Write a query to calculate the total salary expense for each job title, ordered from highest to lowest expense.
SELECT
    j.job_id,
    j.job_title,
    SUM(e.salary) total_salary
FROM hr.employees e
JOIN hr.jobs j
    ON j.job_id = e.job_id
GROUP BY j.job_id, j.job_title
ORDER BY SUM(e.salary) DESC;

-- Task 5:
-- Write a query to find the department with the highest average salary across all departments.
-- Display the department name and the average salary.
SELECT
    d.department_name,
    ROUND(AVG(e.salary)) avg_salary
FROM hr.employees e
JOIN hr.departments d
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY AVG(e.salary) DESC
FETCH NEXT ROW ONLY;

-- Task 6:
-- Write a query to display the top 3 departments with the highest number of employees.
-- Include the department name and the number of employees.
SELECT
    d.department_name,
    COUNT(*) number_of_employees
FROM hr.employees e
JOIN hr.departments d
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY COUNT(*) DESC
FETCH NEXT 3 ROWS ONLY;

-- Task 7:
-- Write a query to find the employees who joined the company in the year 2005 and have the
-- highest salary in their department. Display their employee ID, name, and salary.
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
	ce.max_salary
FROM hr.employees e
JOIN (SELECT
        e1.department_id,
        MAX(e1.salary) max_salary
    FROM hr.employees e1
    WHERE EXTRACT(YEAR FROM e1.hire_date) = 2005 AND e1.department_id IS NOT NULL
    GROUP BY e1.department_id) ce
ON ce.max_salary = e.salary AND e.department_id = ce.department_id;

-- Task 8:
-- Write a query to calculate the average salary of employees who have been with the company
-- for more than 20 years (considering todays date). Exclude employees with a job title of 'President'.
SELECT
    AVG(e.salary) average_salary
FROM hr.employees e
WHERE MONTHS_BETWEEN(SYSDATE, e.hire_date) >= 240 
      AND e.job_id != 'AD_PRES';

-- Task 9:
-- Write a query to find the departments where the average salary is higher than the average salary of
-- the Sales department. Display the department name and the average salary.


-- Task 10:
-- Write a query to display the employee name and the number of employees who
-- joined the company in the same year as that employee.
