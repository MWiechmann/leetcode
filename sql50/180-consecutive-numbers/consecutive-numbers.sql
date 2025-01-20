-- PostgreSQL
SELECT DISTINCT l.num AS ConsecutiveNums
FROM logs AS l
    INNER JOIN logs AS l2
        ON l.id = l2.id-1
    INNER JOIN logs AS l3
        ON l.id = l3.id-2
    WHERE
        l.num = l2.num
        AND l.num = l3.num

/*
-- ALternative solution using correlated subqueries
-- (terrible performance-wise ofc...)
SELECT DISTINCT num AS ConsecutiveNums
FROM logs AS l
WHERE 
    EXISTS (
        SELECT 1
        FROM (
            SELECT id, num
            FROM logs AS l2
            WHERE l2.id = l.id +1
            AND l.num = l2.num
        )
    )
    AND EXISTS (
        SELECT 1
        FROM (
            SELECT id, num
            FROM logs AS l3
            WHERE l3.id = l.id +2
            AND l.num = l3.num
        )
    )
*/