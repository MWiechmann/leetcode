SELECT
    uni.unique_id,
    e.name
FROM
    employees as e
    LEFT JOIN employeeUNI as uni
        ON e.id = uni.id;