-- Write your PostgreSQL query statement below
WITH salary_dr AS (
    SELECT
        *,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS drank
    FROM employee    
),
sec_sal AS (
    SELECT salary AS SecondHighestSalary
    FROM salary_dr
    WHERE drank = 2
)
SELECT MAX(SecondHighestSalary) AS SecondHighestSalary
FROM (
    SELECT SecondHighestSalary
    FROM sec_sal

    UNION

    SELECT NULL AS SecondHighestSalary    
)
