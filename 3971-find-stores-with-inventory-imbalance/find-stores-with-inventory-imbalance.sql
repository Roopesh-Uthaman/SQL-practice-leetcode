with filterstore as (
    select store_id
    from inventory
    group by store_id
    having count(product_name) > 2
),
InRank as (
    SELECT store_id, product_name, quantity,
    ROW_NUMBER() OVER (partition by store_id order by price desc) as Exp_Pro,
    ROW_NUMBER() OVER (partition by store_id order by price asc) as Cheap_pro
    from inventory
    where store_id in (SELECT store_id FROM filterstore)
),
Extremes as (
    SELECT 
        e.store_id,
        e.product_name AS most_exp_product,
        e.quantity AS exp_qty,
        c.product_name AS cheapest_product,
        c.quantity AS cheap_qty
    FROM InRank e
    JOIN InRank c ON e.store_id = c.store_id
    WHERE e.Exp_Pro = 1 AND c.Cheap_pro = 1
)
SELECT 
    s.store_id, 
    s.store_name, 
    s.location,
    ex.most_exp_product, 
    ex.cheapest_product, 
    ROUND(ex.cheap_qty / ex.exp_qty, 2) AS imbalance_ratio
FROM Extremes ex
JOIN stores s ON ex.store_id = s.store_id
WHERE ex.exp_qty < ex.cheap_qty
ORDER BY imbalance_ratio DESC, s.store_name ASC;