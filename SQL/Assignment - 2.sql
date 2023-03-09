-- 1
alter table hr_employee add primary key(EmployeeID);

-- 2 
SELECT count(COLUMN_NAME) as shape
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'hr_employee' 

union all

select count(*) as RowNum from hr_employee;

-- 3
select Department,count(department) as NumEmployee, count(department)/max(EmployeeID)*100 as percentage from hr_employee group by Department;


-- 4
select department , gender , count(gender) from hr_employee group by Department,gender order by Department,gender;


-- 5
select JobRole, count(*) as workforce from hr_employee group by JobRole;


-- 6
select age_group,count(age_group)as distribution from (select 
	case
		when age < 25 then "<25"
        when age > 40 then ">40"
        else "25-40"
	end as age_Group
from hr_employee) as t group by age_group;


-- 7
select MaritalStatus,count(MaritalStatus) as mostFrequent from hr_employee group by MaritalStatus  order by count(MaritalStatus) desc limit 1;


-- 8
select JobSatisfaction,count(JobSatisfaction)/max(EmployeeID)*100 as percent from hr_employee group by JobSatisfaction order by percent desc;


-- 9
select BusinessTravel,count(BusinessTravel)/max(EmployeeID)*100 as percent from hr_employee group by BusinessTravel order by percent desc;


-- 10
select sum(attrition01)/count(attrition01)*100 as attrition_rate,Department from (
select department,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by Department
order by attrition_rate desc limit 1;


-- 11
select sum(attrition01)/count(attrition01)*100 as attrition_rate,JobRole from (
select JobRole,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by JobRole
order by attrition_rate desc limit 1;


-- 12
SELECT CASE WHEN YearsSinceLastPromotion >= 2 AND joblevel <= 2 THEN 'high chances'
            WHEN YearsSinceLastPromotion >= 5 AND joblevel <= 5 THEN 'medium chances'
            ELSE 'low chances'
       END AS promotion_chances,
       COUNT(*) AS num_employees,
       ROUND(COUNT(*) / (SELECT COUNT(*) FROM hr_employee) * 100, 2) AS promotion_rate
FROM hr_employee
GROUP BY promotion_chances
ORDER BY num_employees DESC;


-- 13
select sum(attrition01)/count(attrition01)*100 as attrition_rate,MaritalStatus from (
select MaritalStatus,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by MaritalStatus
order by attrition_rate desc ;


-- 14
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count,Education from (
select Education,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by Education
order by attrition_rate desc ;


-- 15
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count,BusinessTravel from (
select BusinessTravel,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by BusinessTravel
order by attrition_rate desc ;


-- 16
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count,JobInvolvement from (
select JobInvolvement,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by JobInvolvement;


-- 17
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count,JobSatisfaction from (
select JobSatisfaction,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by JobSatisfaction
order by attrition_rate desc ;


-- 18
select 
(
select JobSatisfaction from (
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count,JobSatisfaction from (
select JobSatisfaction,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by JobSatisfaction
order by attrition_rate desc limit 1) as JobSatisfactionTbl
) as JobSatisfaction,

(
select maritalstatus from (
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count, maritalstatus from (
select maritalstatus ,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by maritalstatus 
order by attrition_rate desc limit 1) as maritalstatusriTbl
) as maritalstatus,

(
select businesstravel from (
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count, businesstravel from (
select businesstravel,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by businesstravel
order by attrition_rate desc limit 1) as businesstravelTbl
) as businesstravel,

(
select joblevel from (
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count, joblevel from (
select joblevel ,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by joblevel 
order by attrition_rate desc limit 1) as joblevelTbl
) as joblevel,

(
select education from (
select sum(attrition01)/count(attrition01)*100 as attrition_rate,sum(attrition01) as attrition_count, education from (
select education ,
case
	when attrition = "Yes" then 1
    else 0
end as attrition01
from hr_employee) as t
group by education 
order by attrition_rate desc limit 1) as educationTbl
) as education from hr_employee limit 1;



-- 19
select * from hr_employee 
	where Workex > 10 and BusinessTravel = "Travel_Frequently" and WorkLifeBalance  = "Good" and JobSatisfaction = "High";


-- 20
select MaritalStatus,count(WorkLifeBalance) from hr_employee where Performance_Rating like "O%" and WorkLifeBalance like "Better" group by MaritalStatus order by count(WorkLifeBalance) desc;
