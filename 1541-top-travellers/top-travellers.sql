select u.name, ifnull(sum(r.distance),0) as travelled_distance
from rides r right join users u 
on r.user_id = u.id
group by r.user_id,u.name
order by travelled_distance desc, name asc