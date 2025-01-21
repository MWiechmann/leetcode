-- PostgreSQL
WITH start_price AS
(
    SELECT DISTINCT
        product_id,
        10 AS start_price
    FROM products
)
, latest_price_change AS
(
    SELECT
        product_id,
        new_price,
        change_date,
        MAX(change_date) OVER (PARTITION BY product_id) AS latest_change_date
    FROM products
    WHERE
        change_date <= '2019-08-16'
)
SELECT
    sp.product_id,
    CASE
        WHEN lpc.product_id IS NULL THEN sp.start_price
        ELSE lpc.new_price
        END AS price
FROM start_price AS sp
    LEFT JOIN latest_price_change AS lpc
        ON sp.product_id = lpc.product_id
WHERE
    lpc.product_id IS NULL
    OR lpc.change_date = lpc.latest_change_date