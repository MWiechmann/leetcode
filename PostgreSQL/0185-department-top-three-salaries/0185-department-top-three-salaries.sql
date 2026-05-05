-- Write your PostgreSQL query statement below
WITH salaries_drank AS (
    SELECT
        d.name AS department,
        e.name AS employee,
        salary,
        DENSE_RANK() OVER (
                PARTITION BY e.departmentID
                ORDER BY e.salary DESC
            ) AS rank
    FROM employee AS e
    INNER JOIN department as d
        ON e.departmentId = d.id
)
SELECT
    department AS "Department",
    employee AS "Employee",
    salary AS "Salary"
FROM salaries_drank
WHERE rank <= 3
ORDER BY department, rank