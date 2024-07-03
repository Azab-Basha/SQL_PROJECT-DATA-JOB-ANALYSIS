-- DATE KEYWORD
--SELECT '2023-02-19'::DATE;
SELECT 
    job_title_short AS titel,
    job_location AS location,
    job_posted_date AS date_time
FROM 
    job_postings_fact
LIMIT 5;

/* this will bring date as a timestamp 
if we want to get only the date we can
specify it with adding a double colons :: date 
and it will brings onlt the date */

SELECT 
    job_title_short AS titel,
    job_location AS location,
    job_posted_date::DATE AS date
FROM 
    job_postings_fact
LIMIT 5;
-- AT TIME ZONE KEYWORD

SELECT 
    job_title_short AS titel,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date
FROM 
    job_postings_fact
LIMIT 5;


-- YOU CAN CHECK THE POSTGRES DOCUMENTATION TO FIGURE OUT DIFFERENT TIME ZONES

-- EXTRACT KEYWORD

SELECT 
    job_title_short AS titel,
    job_location AS location,
    job_posted_date AS date_time,
    EXTRACT (MONTH FROM job_posted_date) AS MONTH,
    EXTRACT (YEAR FROM job_posted_date) AS YEAR,
    EXTRACT (DAY FROM job_posted_date) AS DAY
FROM 
    job_postings_fact
LIMIT 5;

/* WE CAN USE THIS FOR DOING QUERIES AND ANAYSIS USING SQL
FOR EXAMPLE IN THE JOB POSTING COLUMN WE WANT TO SEE WHICH 
MONTH OF THE YEAR THERE IS THE MOST TREDIING JOP POSTING 
AMONG 
WE WILL WRITE A QUIERY TO COUNT THE NUMBER OF THE JOB POSTING
AND EXTRACT THE MONTH TO COMPARE THEN WE WILL DO A GROUP BY 
THE MONTH AND WE CAN GO EVEN FURTHER AND MAKE A MORE COMPLICATED AND
DETAILED QURIES*/

SELECT 
    COUNT(job_id) AS jop_posted_count,
    EXTRACT (MONTH FROM job_posted_date) AS MONTH
FROM
     job_postings_fact
GROUP BY
    MONTH;

-- WE CAN DO THIS FOR A SPESIFIC JOP

SELECT 
    COUNT(job_id) AS jop_posted_count,
    EXTRACT (MONTH FROM job_posted_date) AS MONTH
FROM
     job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    MONTH
ORDER BY jop_posted_count DESC;

/* we can look up at the data we got and see that the jop posting 
trend was at the most higher level at the beging of the year at jan
and the least was aroud the middle of it at may */

