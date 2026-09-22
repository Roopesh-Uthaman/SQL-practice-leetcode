WITH RankedReviews AS (
    SELECT 
        p.employee_id, 
        e.name,
        p.rating,
        ROW_NUMBER() OVER (PARTITION BY p.employee_id ORDER BY p.review_date DESC) as rn
    FROM performance_reviews p
    JOIN employees e ON p.employee_id = e.employee_id
),
PivotedReviews AS (
    SELECT 
        employee_id,
        MAX(name) as name,
        COUNT(rn) as review_count,
        MAX(CASE WHEN rn = 1 THEN rating END) as latest_rating,
        MAX(CASE WHEN rn = 2 THEN rating END) as middle_rating,
        MAX(CASE WHEN rn = 3 THEN rating END) as earliest_rating
    FROM RankedReviews
    WHERE rn <= 3
    GROUP BY employee_id
)
SELECT 
    employee_id,
    name,
    (latest_rating - earliest_rating) AS improvement_score
FROM PivotedReviews
WHERE review_count = 3
  AND latest_rating > middle_rating 
  AND middle_rating > earliest_rating
ORDER BY improvement_score DESC, name ASC;