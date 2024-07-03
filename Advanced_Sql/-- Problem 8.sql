-- Problem 8
/*
Find job posting form the first quarter that have a salary greater than $70K
- Combine jop posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job posting with an average yearly salary > $70,000
*/
SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM
        jan_jops
    UNION ALL
    SELECT *
    FROM
        feb_jops
    UNION ALL
    SELECT *
    FROM
        mar_jops
) AS quarter1_job_posting
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY 
    salary_year_avg DESC
