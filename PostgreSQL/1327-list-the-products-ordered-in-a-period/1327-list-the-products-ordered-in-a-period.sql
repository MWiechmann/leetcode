-- Write your PostgreSQL query statement below
SELECT
    p.product_name,
    SUM(o.unit) AS unit    
FROM orders AS o
INNER JOIN products AS p
    ON o.product_id = p.product_id
WHERE o.order_date >= DATE '2020-02-01'
  AND o.order_date <  DATE '2020-03-01'
GROUP BY o.product_id, p.product_name
HAVING SUM(o.unit) >= 100