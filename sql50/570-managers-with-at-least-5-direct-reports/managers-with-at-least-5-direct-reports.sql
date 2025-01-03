SELECT
    e_copy.name
FROM
    employee as e
    INNER JOIN employee as e_copy
        ON e.managerId = e_copy.id
GROUP BY
    e_copy.name,
    e_copy.id
HAVING
    COUNT(e.managerId) >= 5
;