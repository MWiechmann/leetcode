-- PostgreSQL
WITH
    first_login AS (
        SELECT
            player_id,
            MIN(event_date) AS first_login_date
        FROM activity
        GROUP BY
            player_id
    ),
    day_after_first_login AS (
        SELECT
            player_id,
            first_login_date+1 AS day_after_first
        FROM first_login
    )
SELECT
    ROUND(
        COUNT(a.player_id)::NUMERIC
        /(SELECT COUNT(DISTINCT player_id) FROM activity)::NUMERIC 
    ,2) AS fraction
FROM
    activity AS a
    INNER JOIN first_login as fl
        ON a.player_id = fl.player_id
    INNER JOIN day_after_first_login as dafl
        ON a.player_id = dafl.player_id
WHERE
    a.event_date = dafl.day_after_first