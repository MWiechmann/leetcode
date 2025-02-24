-- PostgreSQL
SELECT
    id-1 AS id,
    student
FROM seat
WHERE mod(id,2) = 0
UNION ALL
SELECT
    CASE 
        WHEN id = (SELECT MAX(id) FROM seat) THEN id
        ELSE id+1
    END  AS id,
    student
FROM seat
WHERE mod(id,2) <> 0
ORDER BY id ASC