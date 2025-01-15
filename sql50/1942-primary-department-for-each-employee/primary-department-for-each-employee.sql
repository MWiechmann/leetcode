-- PostgreSQL
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

/*
-- Alternative solution using CTE
-- Should in theory be slightly less performant due two needing two passes
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

/*
-- Alternative solution using correlated sub-query
-- obv worst performance
SELECT
    employee_id,
    department_id
FROM employee AS e
WHERE primary_flag = 'Y'
    OR EXISTS (
        SELECT cnt
        FROM 
            (
                SELECT COUNT(*) AS cnt
                FROM employee AS e2
                WHERE e.employee_id = e2.employee_id
            )
        WHERE cnt = 1
    )
*/