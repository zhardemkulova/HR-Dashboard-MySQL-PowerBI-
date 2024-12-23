
-- QUESTIONS
-- 1. What is the gender breakdown of employees in the company?
SELECT gender, count(*) as count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY gender;
-- 2. What is race/ethnicity breakdown employees in the company?
SELECT race, count(*) as count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count DESC;
-- 3. What is the age distribution of employees in the company?
SELECT 
	min(age) AS youngest,
	max(age) AS oldest
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'; 

SELECT 
	CASE
		WHEN age>= 18 AND age<=24 THEN '18-24'
        WHEN age>= 25 AND age<=34 THEN '25-34'
        WHEN age>= 35 AND age<=44 THEN '35-44'
        WHEN age>= 45 AND age<=54 THEN '45-54'
        WHEN age>= 55 AND age<=64 THEN '55-64'
        ELSE '65+'
	END as age_group, count(*) count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT 
	CASE
		WHEN age>= 18 AND age<=24 THEN '18-24'
        WHEN age>= 25 AND age<=34 THEN '25-34'
        WHEN age>= 35 AND age<=44 THEN '35-44'
        WHEN age>= 45 AND age<=54 THEN '45-54'
        WHEN age>= 55 AND age<=64 THEN '55-64'
        ELSE '65+'
	END as age_group,gender, count(*) count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. What is the average length of employment for employee who have been terminated?
SELECT 
	round(avg(datediff(termdate,hire_date))/365,0) as avg_len_emp
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00'AND age>=18;

-- 6.How does the gender distribution vary across departments and job titles?
SELECT department, gender,count(*) count
FROM hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY department,gender
ORDER BY 1;

-- 7. What is the distribution of job titles across company?
SELECT jobtitle, count(*) count
From hr
WHERE age>=18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which departments has highest turnover rate?
select * from hr;
SELECT department,
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
	SELECT department,
    count(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate<= curdate() THEN 1 ELSE 0 END) as terminated_count
    FROM hr
    WHERE age>=18 
    group by department
    ) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, count(*) count
FROM hr
WHERE age>=18 and termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
	year,
    hires,
    terminations,
    hires-terminations AS net_change,
    round((hires-terminations)/hires*100,2) as net_ch_perc
FROM (
	SELECT 
		YEAR(hire_date) as year,
        count(*) as hires,
        sum(CASE WHEN termdate <> '0000-00-00'AND termdate<= curdate() THEN 1 else 0 end ) as terminations
	FROM hr
    WHERE age>=18
    GROUP BY year) as subquery
ORDER BY year;

-- 11. What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
FROM hr
WHERE termdate<= curdate() and termdate <> '0000-00-00' AND age>=18
group by department;

    
    
