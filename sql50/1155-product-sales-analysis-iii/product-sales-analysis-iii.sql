-- PostgreSQL
WITH sales_first_year_per_product AS (
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM sales
    GROUP BY product_id
)
SELECT
    s.product_id,
    sfy.first_year,
    s.quantity,
    s.price
FROM 
    sales AS s
    INNER JOIN sales_first_year_per_product AS sfy
        ON s.product_id = sfy.product_id
        AND s.year = sfy.first_year