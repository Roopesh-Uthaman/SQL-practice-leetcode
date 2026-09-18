select u.name, sum(t.amount) as balance
from users u join transactions t 
on u.account = t.account
group by u.name, t.account
having sum(t.amount) > 10000