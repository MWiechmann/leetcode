WITH timeout_count AS (
        SELECT
            user_id,
            COUNT(user_id) AS timeouts
        FROM confirmations
        WHERE action = 'timeout'
        GROUP BY user_id 
    ),
    confirmed_count AS (
        SELECT
            user_id,
            COUNT(user_id) AS confirmations
        FROM confirmations
        WHERE action = 'confirmed'
        GROUP BY user_id 
    )
SELECT
    s.user_id,
    CASE -- confirmation_rate
    /* When user never made any requests (cc.confirmations = NULL)
    or made requests, but did not receive any confirmation (cc.confirmations = 0)
    confirmation_rate should be zero. Otherwise, we'll compute the rate. */
            WHEN ISNULL(cc.confirmations,0) = 0 THEN 0
            ELSE ROUND(CAST(cc.confirmations AS FLOAT)/CAST((cc.confirmations + ISNULL(tc.timeouts,0)) AS FLOAT),2)
            END AS confirmation_rate
FROM
    signups as s
    LEFT JOIN timeout_count AS tc
        ON s.user_id = tc.user_id
    LEFT JOIN confirmed_count as cc
        ON s.user_id = cc.user_id
;