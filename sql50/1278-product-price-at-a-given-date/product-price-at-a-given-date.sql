-- PostgreSQL
-- CTE that just gives us starting price and all product_ids
WITH start_price AS
(
    SELECT DISTINCT
        product_id,
        10 AS start_price
    FROM products
)
-- CTE that gives us the prices changes in the relevant date range
-- also add a column with the date of the latest price change for that product_id
-- (windows function occur after WHERE so we can not filter for the latest price change yet)
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
-- Bring it together:
-- LEFT JOIN start prices and latest_price_change
-- Keep only values that either have no price change at all in the relevant date range
-- (and therefore no entries in latest_price_change)
-- or keep only the row for the latest price change
-- We can build the price from start price and latest price change depending on where the product_id has entries
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