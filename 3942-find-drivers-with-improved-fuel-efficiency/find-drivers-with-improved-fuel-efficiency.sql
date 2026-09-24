WITH FirstHalf AS (
    SELECT 
        driver_id, 
        AVG(distance_km / fuel_consumed) AS first_half_avg
    FROM trips
    WHERE trip_date <= '2023-06-30'
    GROUP BY driver_id
),
SecondHalf AS (
    SELECT 
        driver_id, 
        AVG(distance_km / fuel_consumed) AS second_half_avg
    FROM trips
    WHERE trip_date >= '2023-07-01'
    GROUP BY driver_id
)
SELECT 
    d.driver_id, 
    d.driver_name, 
    ROUND(f.first_half_avg, 2) AS first_half_avg, 
    ROUND(s.second_half_avg, 2) AS second_half_avg, 
    ROUND(s.second_half_avg - f.first_half_avg, 2) AS efficiency_improvement
FROM drivers d
JOIN FirstHalf f ON d.driver_id = f.driver_id
JOIN SecondHalf s ON d.driver_id = s.driver_id
WHERE s.second_half_avg > f.first_half_avg
ORDER BY efficiency_improvement DESC, d.driver_name ASC;