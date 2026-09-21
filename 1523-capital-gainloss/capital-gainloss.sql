SELECT 
    stock_name,
    SUM(
        CASE operation
            WHEN 'Sell' THEN price
            WHEN 'Buy' THEN -price
            ELSE 0
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;