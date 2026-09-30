SELECT customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING 
    -- 1. Made at least 3 purchase transactions
    SUM(CASE WHEN transaction_type = 'purchase' THEN 1 ELSE 0 END) >= 3 
    
    -- 2. Have been active for at least 30 days
    AND DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30
    
    -- 3. Refund rate is less than 20%
    AND (SUM(CASE WHEN transaction_type = 'refund' THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) < 0.20
ORDER BY customer_id ASC;