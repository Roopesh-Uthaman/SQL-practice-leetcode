with emp as (
    select event_day as 'day', emp_id,
    sum(in_time) as inti, sum(out_time) as outi
    from Employees
    group by event_day,emp_id
)
select day, emp_id, (outi - inti) as total_time
from emp