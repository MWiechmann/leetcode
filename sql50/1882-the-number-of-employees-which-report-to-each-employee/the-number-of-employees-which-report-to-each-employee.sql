-- PostgreSQL
SELECT
    e.employee_id,
    e.name,
    COUNT(e2.employee_id) AS reports_count,
    AVG(e2.age)::INTEGER AS average_age
FROM
    employees AS e
    INNER JOIN employees AS e2
        ON e.employee_id = e2.reports_to
GROUP BY
    e.employee_id,
    e.name
ORDER BY
    employee_id

/*
-- Alternative solution using correlated subqueries
-- Terrible performance wise ofc, but wanted to practice them...
SELECT
    employee_id,
    name,
    (
        SELECT COUNT(reports_to)
        FROM employees AS e2
        WHERE e.employee_id = e2.reports_to
    ) AS reports_count,
    (
        SELECT AVG(age)::INTEGER
        FROM employees AS e2
        WHERE e.employee_id = e2.reports_to
    ) AS average_age
FROM employees as e
WHERE EXISTS (
    SELECT 1
    FROM employees as e2
    WHERE e.employee_id = e2.reports_to
)
*/