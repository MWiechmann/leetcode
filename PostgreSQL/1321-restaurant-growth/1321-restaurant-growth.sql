-- PostgreSQL
WITH totals_day AS (
    SELECT
        visited_on,
        SUM(amount) AS total_amnt
    FROM customer
    GROUP BY visited_on
),
moving_averages AS (
    SELECT
        visited_on,
        SUM(total_amnt) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            )
        AS amount,
        ROUND(AVG(total_amnt) OVER (
                ORDER BY visited_on
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                ),
        2) AS average_amount,
        ROW_NUMBER() OVER(ORDER BY visited_on) AS rn
    FROM totals_day
)
SELECT
    visited_on,
    amount,
    average_amount
FROM moving_averages
WHERE rn >= 7