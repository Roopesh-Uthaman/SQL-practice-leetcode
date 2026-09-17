WITH RunningWeight AS (
    SELECT 
        person_name,
        weight,
        turn,
        SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
)
SELECT person_name 
FROM RunningWeight
WHERE total_weight <= 1000
ORDER BY turn DESC
LIMIT 1;