-- PostgreSQ
-- We have a trianlge if the sum of the two smaller sides is larger than the largest side
SELECT
    *,
    CASE
        WHEN GREATEST(x, y, z) < (x + y + z) - GREATEST(x, y, z)
            THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM triangle