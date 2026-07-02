


SELECT * FROM companies ;
SELECT * FROM industries ;
SELECT * FROM employee_counts ;
SELECT * FROM company_specialities;
SELECT * FROM job_posts ;
SELECT * FROM jobs_salaries;
SELECT * FROM jobs_benefits ;
SELECT * FROM jobs_skills;
SELECT * FROM skills;


SELECT COUNT(*) AS total_companies   FROM companies;
SELECT COUNT(*) AS total_jobs        FROM job_posts;
SELECT COUNT(*) AS total_salaries    FROM jobs_salaries;
SELECT COUNT(*) AS total_benefits    FROM jobs_benefits;
SELECT COUNT(*) AS total_job_skills  FROM jobs_skills;
SELECT COUNT(*) AS total_skills      FROM skills;
SELECT COUNT(*) AS total_industries  FROM industries;


SELECT
    c.company_id,
    c.company_name,
    c.city,
    c.state,
    c.country,
    i.industry
FROM companies c
JOIN industries i ON c.industry_id = i.industry_id;


SELECT
    i.industry,
    COUNT(c.company_id) AS number_of_companies
FROM industries i
JOIN companies c ON i.industry_id = c.industry_id
GROUP BY i.industry
ORDER BY number_of_companies DESC;


SELECT
    c.company_name,
    c.city,
    c.country
FROM companies c
JOIN industries i ON c.industry_id = i.industry_id
WHERE i.industry LIKE '%Technology%';

SELECT
    c.country,
    i.industry,
    COUNT(c.company_id) AS company_count
FROM companies c
JOIN industries i ON c.industry_id = i.industry_id
GROUP BY c.country, i.industry
ORDER BY c.country, company_count DESC;


SELECT
    c.company_name,
    c.country,
    e.employee_count,
    e.follower_count
FROM companies c
JOIN employee_counts e ON c.company_id = e.company_id
ORDER BY e.employee_count DESC;


SELECT
    c.company_name,
    c.country,
    e.employee_count
FROM companies c
JOIN employee_counts e ON c.company_id = e.company_id
ORDER BY e.employee_count DESC;


SELECT
    c.company_name,
    c.country,
    e.follower_count
FROM companies c
JOIN employee_counts e ON c.company_id = e.company_id
ORDER BY e.follower_count DESC;


SELECT
    c.country,
    COUNT(c.company_id)        AS company_count,
    AVG(e.employee_count)      AS avg_employees,
    SUM(e.employee_count)      AS total_employees
FROM companies c
JOIN employee_counts e ON c.company_id = e.company_id
GROUP BY c.country
ORDER BY total_employees DESC;


SELECT
    c.company_name,
    c.country,
    e.employee_count
FROM companies c
JOIN employee_counts e ON c.company_id = e.company_id
WHERE e.employee_count > 50000
ORDER BY e.employee_count DESC;


SELECT
    c.company_name,
    c.country,
    cs.speciality
FROM companies c
JOIN company_specialities cs ON c.company_id = cs.company_id
ORDER BY c.company_name;


SELECT
    c.company_name,
    c.country,
    COUNT(cs.speciality) AS speciality_count
FROM companies c
JOIN company_specialities cs ON c.company_id = cs.company_id
GROUP BY c.company_name, c.country
ORDER BY speciality_count DESC;


SELECT
    c.company_name,
    c.country,
    cs.speciality
FROM companies c
JOIN company_specialities cs ON c.company_id = cs.company_id
WHERE cs.speciality LIKE '%software%';


SELECT
    cs.speciality,
    COUNT(*) AS company_count
FROM company_specialities cs
JOIN companies c ON cs.company_id = c.company_id
GROUP BY cs.speciality
ORDER BY company_count DESC;

   select j.job_id,
    j.title,
    j.location,
    j.formatted_work_type,
    j.formatted_experience_level,
    j.normalized_salary,
    c.company_name,
    c.city,
    c.state,
    c.country
FROM job_posts j
JOIN companies c ON j.company_id = c.company_id;


SELECT
    c.country,
    COUNT(j.job_id) AS job_count
FROM job_posts j
JOIN companies c ON j.company_id = c.company_id
GROUP BY c.country
ORDER BY job_count DESC;


SELECT
    j.title,
    j.location,
    j.formatted_work_type,
    j.normalized_salary,
    c.company_name
FROM job_posts j
JOIN companies c ON j.company_id = c.company_id
WHERE c.country = 'US';


SELECT
    c.country,
    COUNT(j.job_id)            AS job_count,
    AVG(j.normalized_salary)   AS avg_salary,
    MIN(j.normalized_salary)   AS min_salary,
    MAX(j.normalized_salary)   AS max_salary
FROM job_posts j
JOIN companies c ON j.company_id = c.company_id
WHERE j.normalized_salary IS NOT NULL
GROUP BY c.country
ORDER BY avg_salary DESC;


SELECT
    c.country,
    COUNT(j.job_id) AS remote_job_count
FROM job_posts j
JOIN companies c ON j.company_id = c.company_id
WHERE j.remote_allowed = 1
GROUP BY c.country
ORDER BY remote_job_count DESC;


SELECT
    j.job_id,
    j.title,
    j.location,
    j.formatted_work_type,
    j.normalized_salary,
    c.company_name,
    c.country,
    i.industry
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id;


SELECT
    i.industry,
    COUNT(j.job_id) AS job_count
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
GROUP BY i.industry
ORDER BY job_count DESC;


SELECT
    i.industry,
    COUNT(j.job_id)          AS job_count,
    AVG(j.normalized_salary) AS avg_salary,
    MIN(j.normalized_salary) AS min_salary,
    MAX(j.normalized_salary) AS max_salary
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
WHERE j.normalized_salary IS NOT NULL
GROUP BY i.industry
ORDER BY avg_salary DESC;


SELECT
    i.industry,
    COUNT(j.job_id) AS remote_jobs
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
WHERE j.remote_allowed = 1
GROUP BY i.industry
ORDER BY remote_jobs DESC;


SELECT
    i.industry,
    COUNT(j.job_id) AS fulltime_jobs
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
WHERE j.formatted_work_type = 'Full-time'
GROUP BY i.industry
ORDER BY fulltime_jobs DESC;


SELECT
    i.industry,
    j.formatted_experience_level,
    COUNT(j.job_id) AS job_count
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
GROUP BY i.industry, j.formatted_experience_level
ORDER BY i.industry, job_count DESC;


SELECT
    i.industry,
    j.formatted_experience_level,
    AVG(j.normalized_salary) AS avg_salary,
    COUNT(j.job_id)          AS job_count
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
WHERE j.normalized_salary IS NOT NULL
GROUP BY i.industry, j.formatted_experience_level
ORDER BY i.industry, avg_salary DESC;


SELECT
    i.industry,
    COUNT(j.job_id) AS job_count
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
GROUP BY i.industry
HAVING COUNT(j.job_id) > 1000
ORDER BY job_count DESC;



SELECT
    j.job_id,
    j.title,
    j.company_name,
    j.location,
    j.formatted_experience_level,
    s.min_salary,
    s.max_salary,
    s.annual_salary,
    s.pay_period,
    s.currency
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
ORDER BY s.annual_salary DESC;


SELECT
    j.title,
    j.company_name,
    j.location,
    s.annual_salary,
    s.pay_period
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
ORDER BY s.annual_salary DESC;


SELECT
    j.formatted_work_type,
    COUNT(j.job_id)       AS job_count,
    AVG(s.annual_salary)  AS avg_salary,
    MIN(s.annual_salary)  AS min_salary,
    MAX(s.annual_salary)  AS max_salary
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
GROUP BY j.formatted_work_type
ORDER BY avg_salary DESC;


SELECT
    j.formatted_experience_level,
    COUNT(j.job_id)       AS job_count,
    AVG(s.annual_salary)  AS avg_salary,
    MIN(s.annual_salary)  AS min_salary,
    MAX(s.annual_salary)  AS max_salary
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
GROUP BY j.formatted_experience_level
ORDER BY avg_salary DESC;


SELECT
    j.remote_allowed,
    COUNT(j.job_id)       AS job_count,
    AVG(s.annual_salary)  AS avg_salary
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
GROUP BY j.remote_allowed;


SELECT
    j.title,
    j.company_name,
    j.location,
    j.formatted_experience_level,
    s.annual_salary
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
WHERE s.annual_salary > 100000
ORDER BY s.annual_salary DESC;


SELECT
    s.pay_period,
    COUNT(*)              AS record_count,
    AVG(s.annual_salary)  AS avg_annual_salary
FROM jobs_salaries s
JOIN job_posts j ON s.job_id = j.job_id
GROUP BY s.pay_period
ORDER BY avg_annual_salary DESC;



SELECT
    j.job_id,
    j.title,
    j.company_name,
    b.type AS benefit
FROM job_posts j
JOIN jobs_benefits b ON j.job_id = b.job_id
ORDER BY j.job_id;


SELECT
    b.type        AS benefit,
    COUNT(*)      AS frequency
FROM jobs_benefits b
JOIN job_posts j ON b.job_id = j.job_id
GROUP BY b.type
ORDER BY frequency DESC;


SELECT
    j.company_name,
    COUNT(DISTINCT b.type)  AS benefit_types_count
FROM job_posts j
JOIN jobs_benefits b ON j.job_id = b.job_id
GROUP BY j.company_name
ORDER BY benefit_types_count DESC;


SELECT
    b.type        AS benefit,
    COUNT(DISTINCT b.job_id)  AS jobs_offering_it
FROM jobs_benefits b
GROUP BY b.type
ORDER BY jobs_offering_it DESC;


SELECT
    j.title,
    j.company_name,
    j.location,
    b.type AS benefit
FROM job_posts j
JOIN jobs_benefits b ON j.job_id = b.job_id
WHERE b.type = 'Medical insurance';


SELECT
    j.title,
    j.company_name,
    j.location
FROM job_posts j
JOIN jobs_benefits b ON j.job_id = b.job_id
WHERE b.type = '401(k)';

-- 8.7 Benefits offered by remote jobs
SELECT
    b.type       AS benefit,
    COUNT(*)     AS frequency
FROM job_posts j
JOIN jobs_benefits b ON j.job_id = b.job_id
WHERE j.remote_allowed = 1
GROUP BY b.type
ORDER BY frequency DESC;



SELECT
    j.job_id,
    j.title,
    j.company_name,
    sk.skill_name
FROM job_posts j
JOIN jobs_skills js ON j.job_id     = js.job_id
JOIN skills      sk ON js.skill_abr = sk.skill_abr;


SELECT
    sk.skill_name,
    COUNT(*) AS demand_count
FROM jobs_skills js
JOIN skills sk ON js.skill_abr = sk.skill_abr
GROUP BY sk.skill_name
ORDER BY demand_count DESC;


SELECT
    sk.skill_name,
    COUNT(*) AS demand_count
FROM job_posts j
JOIN jobs_skills js ON j.job_id     = js.job_id
JOIN skills      sk ON js.skill_abr = sk.skill_abr
WHERE j.formatted_work_type = 'Full-time'
GROUP BY sk.skill_name
ORDER BY demand_count DESC;


SELECT
    sk.skill_name,
    COUNT(*) AS demand_count
FROM job_posts j
JOIN jobs_skills js ON j.job_id     = js.job_id
JOIN skills      sk ON js.skill_abr = sk.skill_abr
WHERE j.remote_allowed = 1
GROUP BY sk.skill_name
ORDER BY demand_count DESC;


SELECT
    j.formatted_experience_level,
    sk.skill_name,
    COUNT(*) AS demand_count
FROM job_posts j
JOIN jobs_skills js ON j.job_id     = js.job_id
JOIN skills      sk ON js.skill_abr = sk.skill_abr
GROUP BY j.formatted_experience_level, sk.skill_name
ORDER BY j.formatted_experience_level, demand_count DESC;


SELECT
    j.job_id,
    j.title,
    j.company_name,
    COUNT(js.skill_abr) AS skill_count
FROM job_posts j
JOIN jobs_skills js ON j.job_id = js.job_id
GROUP BY j.job_id, j.title, j.company_name
ORDER BY skill_count DESC;


SELECT
    j.formatted_work_type,
    AVG(skill_per_job.skill_count) AS avg_skills_required
FROM job_posts j
JOIN (
    SELECT job_id, COUNT(*) AS skill_count
    FROM jobs_skills
    GROUP BY job_id
) AS skill_per_job ON j.job_id = skill_per_job.job_id
GROUP BY j.formatted_work_type
ORDER BY avg_skills_required DESC;


SELECT
    j.title,
    j.company_name,
    j.location,
    j.formatted_experience_level,
    sk.skill_name
FROM job_posts j
JOIN jobs_skills js ON j.job_id     = js.job_id
JOIN skills      sk ON js.skill_abr = sk.skill_abr
WHERE sk.skill_name = 'Finance';


SELECT
    i.industry,
    sk.skill_name,
    COUNT(*) AS demand_count
FROM industries i
JOIN companies   c  ON i.industry_id = c.industry_id
JOIN job_posts   j  ON c.company_id  = j.company_id
JOIN jobs_skills js ON j.job_id      = js.job_id
JOIN skills      sk ON js.skill_abr  = sk.skill_abr
GROUP BY i.industry, sk.skill_name
ORDER BY i.industry, demand_count DESC;



SELECT
    j.job_id,
    j.title,
    j.location,
    j.formatted_work_type,
    j.formatted_experience_level,
    j.remote_allowed,
    j.views,
    j.applies,
    c.company_name,
    c.city,
    c.country,
    i.industry,
    s.annual_salary,
    s.min_salary,
    s.max_salary,
    s.pay_period
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_salaries s ON j.job_id      = s.job_id;


SELECT
    j.job_id,
    j.title,
    c.company_name,
    c.country,
    i.industry,
    sk.skill_name,
    s.annual_salary
FROM job_posts j
JOIN companies     c  ON j.company_id  = c.company_id
JOIN industries    i  ON c.industry_id = i.industry_id
JOIN jobs_salaries s  ON j.job_id      = s.job_id
JOIN jobs_skills   js ON j.job_id      = js.job_id
JOIN skills        sk ON js.skill_abr  = sk.skill_abr;


SELECT
    j.job_id,
    j.title,
    c.company_name,
    c.country,
    i.industry,
    b.type AS benefit,
    s.annual_salary
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_salaries s ON j.job_id      = s.job_id
JOIN jobs_benefits b ON j.job_id      = b.job_id;


SELECT
    c.country,
    i.industry,
    COUNT(j.job_id)       AS job_count,
    AVG(s.annual_salary)  AS avg_salary
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_salaries s ON j.job_id      = s.job_id
GROUP BY c.country, i.industry
ORDER BY c.country, avg_salary DESC;

SELECT
    c.country,
    sk.skill_name,
    COUNT(*) AS demand_count
FROM job_posts j
JOIN companies   c  ON j.company_id  = c.company_id
JOIN jobs_skills js ON j.job_id      = js.job_id
JOIN skills      sk ON js.skill_abr  = sk.skill_abr
GROUP BY c.country, sk.skill_name
ORDER BY c.country, demand_count DESC;


SELECT
    i.industry,
    b.type       AS benefit,
    COUNT(*)     AS frequency
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_benefits b ON j.job_id      = b.job_id
GROUP BY i.industry, b.type
ORDER BY i.industry, frequency DESC;


SELECT
    i.industry,
    j.remote_allowed,
    COUNT(j.job_id)       AS job_count,
    AVG(s.annual_salary)  AS avg_salary
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_salaries s ON j.job_id      = s.job_id
GROUP BY i.industry, j.remote_allowed
ORDER BY i.industry;


SELECT
    c.company_name,
    c.country,
    i.industry,
    COUNT(j.job_id) AS job_count,
    AVG(s.annual_salary)  AS avg_salary
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_salaries s ON j.job_id      = s.job_id
GROUP BY c.company_name, c.country, i.industry
HAVING COUNT(j.job_id) >= 3
ORDER BY avg_salary DESC;

SELECT
    j.formatted_experience_level,
    sk.skill_name,
    COUNT(*)             AS demand_count,
    AVG(s.annual_salary) AS avg_salary
FROM job_posts j
JOIN jobs_skills   js ON j.job_id      = js.job_id
JOIN skills        sk ON js.skill_abr  = sk.skill_abr
JOIN jobs_salaries s  ON j.job_id      = s.job_id
GROUP BY j.formatted_experience_level, sk.skill_name
ORDER BY j.formatted_experience_level, demand_count DESC;

SELECT
    c.company_name,
    c.country,
    i.industry,
    e.employee_count,
    e.follower_count,
    COUNT(j.job_id) AS open_positions
FROM companies c
JOIN industries i ON c.industry_id = i.industry_id
JOIN employee_counts e  ON c.company_id  = e.company_id
JOIN job_posts  j  ON c.company_id  = j.company_id
GROUP BY c.company_name, c.country, i.industry, e.employee_count, e.follower_count
ORDER BY open_positions DESC;

SELECT
    j.job_id,
    j.title,
    c.company_name,
    i.industry,
    s.annual_salary,
    COUNT(DISTINCT b.type)   AS benefit_count,
    COUNT(DISTINCT js.skill_abr) AS skill_count
FROM job_posts j
JOIN companies     c  ON j.company_id  = c.company_id
JOIN industries    i  ON c.industry_id = i.industry_id
JOIN jobs_salaries s  ON j.job_id      = s.job_id
JOIN jobs_benefits b  ON j.job_id      = b.job_id
JOIN jobs_skills   js ON j.job_id      = js.job_id
GROUP BY j.job_id, j.title, c.company_name, i.industry, s.annual_salary
ORDER BY s.annual_salary DESC;

SELECT
    i.industry,
    AVG(s.annual_salary)     AS avg_salary,
    COUNT(DISTINCT b.type)   AS benefit_types
FROM job_posts j
JOIN companies     c ON j.company_id  = c.company_id
JOIN industries    i ON c.industry_id = i.industry_id
JOIN jobs_salaries s ON j.job_id      = s.job_id
JOIN jobs_benefits b ON j.job_id      = b.job_id
GROUP BY i.industry
ORDER BY avg_salary DESC;

SELECT
    i.industry,
    COUNT(j.job_id) AS job_count
FROM job_posts j
JOIN companies  c ON j.company_id  = c.company_id
JOIN industries i ON c.industry_id = i.industry_id
GROUP BY i.industry
HAVING COUNT(j.job_id) > 500
ORDER BY job_count DESC;


SELECT
    c.company_name,
    c.country,
    AVG(s.annual_salary) AS avg_salary
FROM job_posts j
JOIN companies     c ON j.company_id = c.company_id
JOIN jobs_salaries s ON j.job_id     = s.job_id
GROUP BY c.company_name, c.country
HAVING AVG(s.annual_salary) > 90000
ORDER BY avg_salary DESC;


SELECT
    sk.skill_name,
    COUNT(*) AS demand_count
FROM jobs_skills js
JOIN skills sk ON js.skill_abr = sk.skill_abr
GROUP BY sk.skill_name
HAVING COUNT(*) > 3000
ORDER BY demand_count DESC;


SELECT
    country,
    COUNT(*) AS company_count
FROM companies
GROUP BY country
HAVING COUNT(*) > 50
ORDER BY company_count DESC;


SELECT
    j.formatted_work_type,
    AVG(s.annual_salary) AS avg_salary,
    COUNT(j.job_id)      AS job_count
FROM job_posts j
JOIN jobs_salaries s ON j.job_id = s.job_id
GROUP BY j.formatted_work_type
HAVING AVG(s.annual_salary) > 70000
ORDER BY avg_salary DESC;

SELECT
    formatted_experience_level,
    COUNT(*) AS job_count
FROM job_posts
GROUP BY formatted_experience_level
HAVING COUNT(*) > 5000
ORDER BY job_count DESC;

SELECT
    c.company_name,
    COUNT(DISTINCT b.type) AS benefit_types
FROM companies c
JOIN job_posts j ON c.company_id = j.company_id
JOIN jobs_benefits b ON j.job_id = b.job_id
GROUP BY c.company_name
HAVING COUNT(DISTINCT b.type) > 2
ORDER BY benefit_types DESC;


