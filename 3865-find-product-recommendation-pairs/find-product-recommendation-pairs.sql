select 
p1.product_id as product1_id,
p2.product_id as product2_id,
p3.category as product1_category,
p4.category as product2_category,
count(distinct p1.user_id) as customer_count
from ProductPurchases p1
join ProductPurchases p2
on p1.user_id = p2.user_id and p1.product_id < p2.product_id
join ProductInfo p3 on p1.product_id = p3.product_id
join ProductInfo p4 on p2.product_id = p4.product_id
group by product1_id, product2_id, product1_category, product2_category
having count(distinct p1.user_id) >=3
ORDER BY 
customer_count DESC, product1_id ASC, product2_id ASC
