--Case Expresion

SELECT 
    job_title_short,
    job_location
FROM
     job_postings_fact;

/* 
lable new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'Local'
- Otherwise 'Onsite'
*/


SELECT 
    job_title_short,
    job_location,
    CASE 
        When job_location = 'Anywhere' THEN 'Remote'
        When job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    End as Location_category
FROM
     job_postings_fact;


SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE 
        When job_location = 'Anywhere' THEN 'Remote'
        When job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    End as Location_category
FROM
     job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY Location_category;     