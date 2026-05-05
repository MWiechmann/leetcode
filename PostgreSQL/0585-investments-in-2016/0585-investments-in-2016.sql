-- Write your PostgreSQL query statement below
WITH count_tiv_2015 AS (
    SELECT
        tiv_2015,
        COUNT(*) AS cnt
    FROM insurance
    GROUP BY tiv_2015
),
count_loc AS (
    SELECT
        lat || '-' || lon AS loc,
        COUNT(*) AS cnt
    FROM insurance
    GROUP BY loc
)
SELECT ROUND(SUM(i.tiv_2016::numeric),2) AS tiv_2016
FROM insurance AS i
INNER JOIN count_tiv_2015 AS ct15
    ON i.tiv_2015 = ct15.tiv_2015
    AND ct15.cnt > 1
INNER JOIN count_loc AS cl
    ON i.lat||'-'|| lon = cl.loc
    AND cl.cnt = 1