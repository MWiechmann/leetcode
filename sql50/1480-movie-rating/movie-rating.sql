-- PostgreSQL
WITH top_rater AS (
    SELECT
        u.name,
        COUNT(movie_id)
    FROM 
        movierating AS mr
        INNER JOIN users as u
            ON mr.user_id = u.user_id
    GROUP BY u.name
    ORDER BY COUNT(movie_id) DESC, u.name ASC
    LIMIT 1
),
top_movie AS (
    SELECT
        m.title,
        AVG(mr.rating)
    FROM
        movierating AS mr
        INNER JOIN movies AS m
            ON mr.movie_id = m.movie_id
    WHERE EXTRACT('month' from  created_at) = 2
    and EXTRACT('year' from created_at)=2020
    GROUP BY m.title 
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
)
SELECT name as results
FROM top_rater
UNION ALL
SELECT title AS results
FROM top_movie