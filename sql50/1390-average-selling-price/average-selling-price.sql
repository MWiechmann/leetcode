SELECT
    p.product_id,
    COALESCE(
        ROUND(
        (SUM(us.units * p.price)::NUMERIC
        /SUM(us.units)::NUMERIC)
        ,2
        ),0
    )AS average_price
FROM
    prices as p
    LEFT JOIN unitssold as us
        ON p.product_id = us.product_id
        AND us.purchase_date >= p.start_date
        AND us.purchase_date <= p.end_date
GROUP BY
    p.product_id
;