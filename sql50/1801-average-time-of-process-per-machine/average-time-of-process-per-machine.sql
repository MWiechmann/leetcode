WITH activity_start AS
    (
        SELECT *
        FROM activity
        WHERE activity_type = 'start'
    ),
    activity_end AS
    (
      SELECT *
        FROM activity
        WHERE activity_type = 'end'  
    )
SELECT
    activity_start.machine_id,
    ROUND(SUM(activity_end.timestamp - activity_start.timestamp)
        /COUNT(activity_start.process_id),3)
        AS processing_time
FROM 
    activity_start
    INNER JOIN activity_end
        ON activity_start.machine_id = activity_end.machine_id
        AND activity_start.process_id = activity_end.process_id
GROUP BY
    activity_start.machine_id
;