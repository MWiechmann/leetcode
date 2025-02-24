-- PostgreSQL
SELECT
    CASE
        WHEN mod(id,2) = 0 THEN id-1
        WHEN (mod(id,2) <> 0) AND id = (SELECT MAX(id) FROM seat) THEN id
        ELSE id+1
    END  AS id,
    student
FROM seat
ORDER BY id ASC