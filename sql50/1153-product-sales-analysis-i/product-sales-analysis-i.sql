SELECT
    product_name,
    year,
    price
FROM
    sales as s
    LEFT JOIN product as p
        ON s.product_id = p.product_id;