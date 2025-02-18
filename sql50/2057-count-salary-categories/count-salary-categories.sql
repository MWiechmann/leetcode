-- PostgreSQL
WITH categorized AS (
    SELECT
        CASE 
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            WHEN income > 50000 THEN 'High Salary'
            ELSE NULL
        END AS category
    FROM accounts
),
category_list (category) AS (
  VALUES
   ('High Salary'),
   ('Average Salary'),
   ('Low Salary')
)
SELECT
    cl.category,
    COUNT(c.category) AS accounts_count
FROM
    categorized AS c
    FULL JOIN category_list AS cl
        ON c.category = cl.category
GROUP BY cl.category