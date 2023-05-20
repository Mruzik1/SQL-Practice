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