WITH weeklymeet AS (
    SELECT 
        employee_id, 
        YEAR(meeting_date) AS meeting_year,
        WEEK(meeting_date, 1) AS week_number,
        SUM(duration_hours) AS total_hours
    FROM meetings
    GROUP BY employee_id, YEAR(meeting_date), WEEK(meeting_date, 1)
),
heavyweek AS (
    SELECT 
        employee_id, 
        COUNT(*) AS meeting_heavy_weeks
    FROM weeklymeet
    WHERE total_hours > 20
    GROUP BY employee_id
    HAVING COUNT(*) >= 2
)
SELECT 
    e.employee_id, 
    e.employee_name, 
    e.department, 
    h.meeting_heavy_weeks
FROM employees e 
JOIN heavyweek h ON e.employee_id = h.employee_id
ORDER BY h.meeting_heavy_weeks DESC, e.employee_name ASC;