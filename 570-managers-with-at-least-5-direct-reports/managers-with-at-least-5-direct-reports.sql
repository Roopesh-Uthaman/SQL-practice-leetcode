SELECT e1.name
FROM Employee e1
JOIN Employee e2
ON e1.id = e2.managerId
group by e1.name,e1.id
HAVING COUNT(e2.id) >= 5;