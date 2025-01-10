-- PostgreSQL
WITH counts_per_num AS (
    SELECT
        num,
        COUNT(num) as count
    FROM mynumbers
    GROUP BY num
)
SELECT MAX(num) AS num
FROM counts_per_num
WHERE count = 1;