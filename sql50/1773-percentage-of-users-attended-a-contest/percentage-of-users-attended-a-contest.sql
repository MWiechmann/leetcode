-- PostgreSQL
/*
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
*/

-- Trying out alternative solution:
WITH 
    unique_contests AS(
        SELECT DISTINCT contest_id
        FROM register
    ),
    individual_user_atendance AS(
        SELECT
            uc.contest_id,
            us.user_id,
            EXISTS(
                SELECT 1
                FROM register AS re
                WHERE
                    us.user_id=re.user_id
                    AND uc.contest_id = re.contest_id
                ) AS user_attended
        FROM
            unique_contests AS uc
            CROSS JOIN users AS us
    )
SELECT
    contest_id,
    ROUND(AVG(user_attended::int)*100,2) AS percentage
FROM individual_user_atendance
GROUP BY contest_id
ORDER BY
    percentage DESC,
    contest_id ASC
;