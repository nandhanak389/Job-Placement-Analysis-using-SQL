create database job;
use job;
select * from job_placement;
alter table job_placement  rename to placement;
alter table placement rename column years_of_experience to yo_Exp;
alter table placement rename column  placement_status to status ;
alter table placement rename  column college_name  to c_name;
select* from placement;
# job plcaement qus

-- 1 what is the max age of candidates in the job placement database?
select max(age) from placement;

-- 2.How many unique educational streams are represented in the job placement records?
select count(distinct stream) from placement;

-- 3.How many candidates have exactly 3 years of experience?
select * from placement where yo_Exp =3;
select count(*)as 3_yo_experience from placement where yo_Exp=3;

-- 4.What are the details of job placements for Computer Science students, sorted by highest to lowest salary?
select * from placement where stream='Computer Science' order by salary desc;

-- 5.What are the details of candidates who got placed, sorted by highest to lowest salary?
select * from placement where status='Placed' order by salary desc;

-- 6.	How many candidates have been successfully placed?
select count(*)as placed from placement where status='Placed';

-- 7.	What are the job placement details sorted by the least to most years of experience?
select * from placement where status='Placed' order by yo_Exp;

-- 8.	What are the job placement details sorted first by highest to lowest years of experience and then by highest to lowest salary?
select * from placement order by yo_Exp desc, salary desc;

-- 9.	What are the job placement details sorted alphabetically by college name?
select * from placement order by c_name asc;

-- 10.What are the details (age, stream, years of experience, salary) of candidates whose years of experience are greater than the minimum experience in the dataset and have a salary of 60,000?
select age, stream, yo_Exp, salary from placement where salary=60000 and  yo_Exp>(select min(yo_Exp) from placement);

-- 11.	What are the names, ages, streams, and years of experience of placed candidates who belong to the Computer Science stream?
select name, age, stream, yo_Exp from placement where stream ='Computer Science' and status ='Placed';

-- 12.	What are the names, ages, and streams of candidates older than 25 who have not been placed?
select  name, age, stream from placement where age >25 and status ='Not Placed';

-- 13.	What are all the details of job placements?
select * from placement;

-- 14.	What are the names, ages, and salaries of female candidates earning more than 50,000?
select name,age,salary from placement where gender='Female' and salary> 50000;

-- 15.	What are the names, ages, streams, and salaries of candidates, along with their salary range categorized as 'Low Salary' (below 25,000), 'Medium Salary' (25,000 to 50,000), and 'High Salary' (above 50,000)?
select name,age,salary, stream, 
case
when salary <25000
then "Low Salary"
when salary between 25001 and  50000
then 'Medium Salary'
when salary > 50000
then 'High Salary'
else " Not defined"
end as salary_range
from placement ;
-- 16.	What are the names, genders, streams, ages, and years of experience of candidates, along with their job position categorized as 'Fresher' (≤1 year), 'Junior' (<2 years), and 'Senior' (≥2 years)?
select name,gender ,stream,age,yo_Exp,
case
when yo_Exp <=1
then 'Fresher'
when yo_Exp <2
then "Junior"
when yo_Exp >=2
then 'Senior'
else"Unknown"
end as position_experience
from placement ;
-- 17.	What is the average salary for each educational stream?
select stream,avg(salary) from placement group by stream;

-- 18.	How many candidates belong to each educational stream?
select stream, count(*) candidates from placement group by stream;

-- 19.	How many candidates have been placed in each educational stream?
select stream , count(*)  placed from placement where status='Placed' group by stream;

-- 20.	How many candidates have different years of experience?
select yo_Exp, count(*) candidates_by_exp from placement group by yo_Exp;

-- 21.	How many candidates are placed and not placed?
select status,count(*) count from placement group by status;

-- 22.	How many candidates are there in each gender category?
select gender,count(*) count from placement group by gender;

-- 23.	What is the average years of experience for placed and not placed candidates?
select status,avg(yo_Exp)   from placement  group by status;

-- 24.	What are the maximum and minimum years of experience for each educational stream?
select stream,max(yo_Exp) Max_Experience, min(yo_Exp)Min_Experience from placement group by stream;

-- 25.	What are the highest, lowest, and average salaries for each educational stream?
select stream , max(salary)Max_salary,min(salary)Min_salary,avg(salary) from placement group by stream;

-- 26.	What are the salaries of candidates from the Computer Science stream?
select salary from placement where stream ='Computer Science';

-- 27.	Which candidates have a salary higher than at least one candidate from the Computer Science stream?
select *
FROM placement
WHERE salary > ANY (SELECT salary FROM placement WHERE stream = 'Computer Science');

-- 28.	Which candidates from streams other than Computer Science have a salary higher than at least one candidate from the Computer Science stream?
select *
FROM placement
WHERE  stream<> 'Computer Science'and salary > ANY (SELECT salary FROM placement WHERE stream = 'Computer Science');
-- 29.	Which candidates from streams other than Information Technology have more years of experience than at least one candidate from the Information Technology stream?
select *
FROM placement
WHERE  stream<> 'Information Technology'and yo_Exp > ANY (SELECT yo_Exp FROM placement WHERE stream = 'Information Technology');

-- 30.	What is the average years of experience for placed and not placed candidates?
select status,avg(yo_Exp)   from placement  group by status;

-- 31.	Which streams have more than 10 placed candidates?
select stream , count(*) AS Placed_Candidates from placement where status='Placed' group by stream having count(*)>10;
-- 32.	Which streams have at least one candidate with a salary greater than 60,000?
select stream from placement where salary>60000 group by stream;
-- 33.	Which streams have at least one candidate with a salary less than 60,000?
select stream from placement where salary<60000 group by stream;
-- 34.	Which streams have more than 10 placed candidates for each level of experience, sorted by years of experience?

