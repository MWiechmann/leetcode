-- PostgreSQL

-- solution using windows function and CTE
WITH running_total_weight AS(
    SELECT
        person_name,
        turn,
        SUM(weight) OVER (
            ORDER BY turn ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS rt_weight
    FROM queue
    ORDER BY turn ASC
)
SELECT person_name
FROM running_total_weight
WHERE rt_weight <= 1000
ORDER BY turn DESC
LIMIT 1;


/*
-- Alternative solution using correlated subqueries
SELECT
    person_name
FROM queue as q
WHERE (SELECT SUM(weight) FROM queue AS q2
    WHERE q2.turn <= q.turn) <= 1000
ORDER BY turn DESC
LIMIT 1;
*/