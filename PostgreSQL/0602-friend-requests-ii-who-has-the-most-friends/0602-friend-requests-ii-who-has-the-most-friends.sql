-- Write your PostgreSQL query statement below
WITH friends AS (
    SELECT
    requester_id AS id,
    accepter_id AS friend
    FROM requestaccepted

    UNION ALL

    SELECT
    accepter_id AS id,
    requester_id AS friend
    FROM requestaccepted
)
SELECT
    id,
    COUNT(*) AS num
FROM friends
GROUP BY id
ORDER BY COUNT(*) DESC
LIMIT 1