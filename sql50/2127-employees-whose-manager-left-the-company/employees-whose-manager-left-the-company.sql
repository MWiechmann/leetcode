-- PostgreSQL
SELECT e1.employee_id
FROM Employees as e1
    LEFT OUTER JOIN employees as e2
        ON e1.manager_id  = e2.employee_id
WHERE e1.salary < 30000 AND e1.manager_id  IS NOT NULL AND e2.employee_id IS NULL
ORDER BY employee_id ASC