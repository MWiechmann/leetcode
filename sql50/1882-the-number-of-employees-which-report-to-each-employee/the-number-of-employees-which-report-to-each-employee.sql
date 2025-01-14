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
