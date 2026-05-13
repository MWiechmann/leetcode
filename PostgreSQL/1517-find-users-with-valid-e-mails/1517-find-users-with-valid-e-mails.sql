-- Write your PostgreSQL query statement below
SELECT *
FROM users
WHERE mail ~ '^[a-zA-Z][\w\d_\.-]*@leetcode\.com$'