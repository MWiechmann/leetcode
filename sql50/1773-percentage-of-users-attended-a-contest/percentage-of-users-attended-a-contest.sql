-- PostgreSQL
SELECT
    contest_id,
    ROUND(
        COUNT(user_id)::NUMERIC
        /(SELECT COUNT(user_id) FROM users)::NUMERIC
        ,4
    )*100 AS percentage
FROM
    register
GROUP BY contest_id
ORDER BY
    percentage DESC,
    contest_id ASC
;