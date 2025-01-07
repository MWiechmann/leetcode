-- PostgreSQL
/*
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
*/
WITH ranked_orders AS (
    SELECT
        customer_id,
        RANK() OVER (PARTITION BY customer_id ORDER BY order_date ASC) as order_rank,
        order_date,
        customer_pref_delivery_date
    FROM delivery
)
SELECT
    ROUND(
        AVG(CASE
        WHEN order_date = customer_pref_delivery_date THEN 1
        ELSE 0
        END)*100
    ,2) AS immediate_percentage 
FROM ranked_orders
WHERE
    order_rank = 1;