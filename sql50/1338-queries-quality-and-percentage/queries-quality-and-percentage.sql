-- PostgreSQL
/*
WITH cnt_poor_qual AS(
    SELECT
        query_name,
        COUNT(query_name) AS count_poor_query_qual
    FROM queries
    WHERE (rating) < 3 GROUP BY query_name
)
SELECT
    q.query_name,
    ROUND(
        AVG(q.rating::NUMERIC/q.position::NUMERIC)
        ,2) AS quality,
    ROUND(
        COALESCE(
            (cpq.count_poor_query_qual::NUMERIC/COUNT(q.query_name)::NUMERIC)*100
            ,0)
        ,2) AS poor_query_percentage 
FROM
    queries AS q
    LEFT JOIN cnt_poor_qual AS cpq
        ON q.query_name = cpq.query_name
GROUP BY
    q.query_name,
    cpq.count_poor_query_qual;
*/

SELECT
    q.query_name,
    ROUND(
        AVG(
            rating::NUMERIC/position::NUMERIC
        )
        ,2) AS quality,
    ROUND(
        AVG(
                CASE
                    WHEN rating < 3 THEN 1
                    ELSE 0
                    END
            )*100
    ,2) AS poor_query_percentage 
      
FROM
    queries AS q
GROUP BY query_name;