WITH weather_copy AS (
    SELECT
        *,
        DATEADD(DAY,1,recordDate) AS next_day
    FROM weather
)
SELECT
    w.id as Id
FROM
    weather as w
    INNER JOIN weather_copy as wc
        ON w.recordDate = wc.next_day
WHERE
    w.temperature > wc.temperature
;