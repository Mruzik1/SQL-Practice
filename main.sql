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