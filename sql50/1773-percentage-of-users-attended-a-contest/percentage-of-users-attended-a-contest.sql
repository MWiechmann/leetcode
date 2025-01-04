-- PostgreSQL
-- Simple solution: Calculate percentages using counts of registrations and total users

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

/*
-- Trying out alternative solution:
-- Creates attendance matrix (user*event) and tracks perfomance for each with Boolean
-- can then be used to compute attendance
-- less performant and more complex ofc
-- but I found this interesting to try out...
-- also potentially more flexible for other types of analyses

WITH 
    unique_contests AS(
        SELECT DISTINCT contest_id
        FROM register
    ),
    registration_status AS(
        SELECT
            contests.contest_id,
            usr.user_id,
            EXISTS(
                SELECT 1
                FROM register reg
                WHERE
                    usr.user_id = reg.user_id
                    AND contests.contest_id = reg.contest_id
                ) AS user_attended
        FROM
            unique_contests AS contests
            CROSS JOIN users AS usr
    )
SELECT
    contest_id,
    ROUND(AVG(user_attended::int)*100,2) AS percentage
FROM registration_status
GROUP BY contest_id
ORDER BY
    percentage DESC,
    contest_id ASC
;
*/