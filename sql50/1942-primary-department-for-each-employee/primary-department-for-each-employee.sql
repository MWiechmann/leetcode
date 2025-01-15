-- PostgreSQL
/*
WITH count_dep AS (
    SELECT
        employee_id,
        COUNT(department_id) AS count_dep
    FROM employee
    GROUP BY
        employee_id
)
SELECT
    e.employee_id,
    e.department_id
FROM
    employee AS e
    INNER JOIN count_dep AS cd
        ON e.employee_id = cd.employee_id
WHERE
    e.primary_flag  = 'Y'
    OR cd.count_dep = 1 
*/

SELECT
    employee_id,
    department_id
FROM (
    SELECT
        *,
        COUNT(*) OVER (PARTITION BY employee_id) AS count_dep
    FROM employee
)
WHERE
    primary_flag  = 'Y'
    OR count_dep = 1