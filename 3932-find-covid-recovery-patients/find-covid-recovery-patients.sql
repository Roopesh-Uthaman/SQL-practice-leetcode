with FirstPositive as (
    select patient_id,min(test_date) as first_pos_date
    from covid_tests
    where result = 'Positive'
    group by patient_id
),
Recovery as (
    select fp.patient_id,fp.first_pos_date,min(ct.test_date) as first_neg_date
    from FirstPositive fp join covid_tests ct
    on fp.patient_id = ct.patient_id
    and ct.result = 'Negative'
    and ct.test_date > first_pos_date
    group by fp.patient_id,fp.first_pos_date
)
select p.patient_id,p.patient_name,p.age,
datediff(r.first_neg_date,r.first_pos_date) as recovery_time
from Recovery r join patients p
on p.patient_id = r.patient_id
order by recovery_time ASC, p.patient_name ASC