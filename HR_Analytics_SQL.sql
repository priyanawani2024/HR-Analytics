create database hr_analytics;
use hr_analytics;

-- Finding total no. of records..
select count(*) from employee_data;
---------------------------------------------------------------------------------------------------------------------------------------

-- Finding out how many employees still work in the company..
select Attrition, count(*) as working_status from employee_data group by Attrition;
-- Out of 1480 total employees 238 are currently working in the company. 
---------------------------------------------------------------------------------------------------------------------------------------

-- Finding out the maximum salary in each department... 
select Department, max(MonthlyIncome) as highest_salary, round(avg(Age),0) as avg_age_group from employee_data 
group by Department order by highest_salary desc; 
-- As per the analysis R&D department secures the highest salary in the company.. 
---------------------------------------------------------------------------------------------------------------------------------------

-- Gender distribution of the employees currently working in the company
select gender, count(gender) as no_of_males_females from employee_data where Attrition = 'Yes' group by gender 
order by no_of_males_females desc;
-- There are 151 Males and 87 Females currently working in the company.. 
---------------------------------------------------------------------------------------------------------------------------------------
-- Find out the top performers in the company whose performance ratings are > 4
select count(ï»¿EmpID) as top_performing_employees, Attrition from employee_data where PerformanceRating > 3 
group by Attrition;
-- We currently have 37 top performing employees whose performance rating is more than 3.. 

-- Lets categorize the currently working employees based on their performance ratings.. 1-2 (Average), 2-3 (Good), > 3 (Hardworking)


select ï»¿EmpID, PerformanceRating, Age,
case 
when PerformanceRating < 1 then 'Poor'
when PerformanceRating > 1 and PerformanceRating <= 2 then 'Average'
when PerformanceRating > 2 and PerformanceRating <= 3 then 'Good'
else 'Hardworking' 
end 
employee_ranking
from employee_data
where Attrition = 'Yes'

-- Overall the performance matrics of the employee is good to hardworking. 

select * from 
(select ï»¿EmpID, PerformanceRating, Age, JobRole, 
case 
when PerformanceRating < 1 then 'Poor'
when PerformanceRating > 1 and PerformanceRating <= 2 then 'Average'
when PerformanceRating > 2 and PerformanceRating <= 3 then 'Good'
else 'Hardworking' 
end 
employee_ranking
from employee_data
where Attrition = 'Yes') tbl1 
where employee_ranking = 'Hardworking'

-- Identifying the hardworking employees for promotions and loyalty bonuses.. 
---------------------------------------------------------------------------------------------------------------------------------------
-- Years at company... 

-- We have created and labeled the currently working employees on the bases of seniority or years_of_working_in_the_company.. 
-- Also stored the table in view.. 
create view v1 as 
(select ï»¿EmpID, Age, Department, Gender, JobSatisfaction, MaritalStatus, MonthlyIncome, OverTime, 
case 
when TotalWorkingYears = 0 and TotalWorkingYears <=2 then "Newcommers"
when TotalWorkingYears > 2 and TotalWorkingYears <=5 then "Old_Employees"
when TotalWorkingYears > 5 and TotalWorkingYears <=10 then "Senior_Employees"
when TotalWorkingYears > 10 and TotalWorkingYears <=20 then "Very_Senior_Employees"
else "Loyal_Employees" end employee_category
from employee_data
where Attrition = 'Yes');

select count(ï»¿EmpID), department from employee_data where Attrition = 'Yes' group by department;

select count(ï»¿EmpID) as employee_count, employee_category, department from v1 group by employee_category, department
order by employee_count desc;

-- Most No. Of loyal employees are in the R&D department, second position is sales and third is HR. 

select min(Age) as min_age, max(Age) as max_age, round(avg(Age),0) as avg_age, department,
salaryslab, count(ï»¿EmpID) as total_employees from employee_data where Attrition = 'Yes'
group by department, salaryslab; 
---------------------------------------------------------------------------------------------------------------------------------------
-- Finding out the post of employees and yearsofworking earning 15k+

select Age, Department, EducationField, JobRole, Gender, YearsAtCompany, PerformanceRating, MonthlyIncome from employee_data 
where salaryslab = '15k+' and attrition = 'Yes';
---------------------------------------------------------------------------------------------------------------------------------------













