-- PostgreSQL
WITH first_order AS (
    SELECT
        customer_id,
        MIN(order_date) AS order_date
    FROM delivery
    GROUP BY
        customer_id
    )
SELECT
    ROUND(
        AVG(CASE
        WHEN d.order_date = d.customer_pref_delivery_date THEN 1
        ELSE 0
        END)*100
    ,2) AS immediate_percentage 
FROM
    delivery as d
    INNER JOIN first_order AS fo
        ON d.customer_id = fo.customer_id
        AND d.order_date = fo.order_date
;