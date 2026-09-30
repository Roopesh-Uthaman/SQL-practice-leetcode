WITH CustomerStats AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_orders,
        SUM(CASE 
            WHEN HOUR(order_timestamp) >= 11 AND HOUR(order_timestamp) < 14 THEN 1
            WHEN HOUR(order_timestamp) >= 18 AND HOUR(order_timestamp) < 21 THEN 1 
            ELSE 0 END) AS peak_orders,
        COUNT(order_rating) AS rated_orders,
        ROUND(AVG(order_rating), 2) AS average_rating
    FROM restaurant_orders
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_orders,
    ROUND((peak_orders * 100.0) / total_orders, 0) AS peak_hour_percentage, 
    average_rating
FROM CustomerStats
WHERE total_orders >= 3
  AND (peak_orders * 1.0 / total_orders) >= 0.6
  AND (rated_orders * 1.0 / total_orders) >= 0.5
  AND average_rating >= 4.0
ORDER BY 
    average_rating DESC, 
    customer_id DESC;