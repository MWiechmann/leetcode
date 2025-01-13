-- PostgreSQL
SELECT
    customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM product)

/*
-- Alternative solution using correlated subquery
-- Computationally more involved ofc, but wante to practice those
SELECT customer_id
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Product p
    WHERE p.product_key NOT IN (
        SELECT product_key
        FROM Customer c2
        WHERE c2.customer_id = c.customer_id
    )
)
*/