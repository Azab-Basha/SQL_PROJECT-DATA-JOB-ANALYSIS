-- problem 6
/* 
create three tables
jan 2023 jobs
feb 2023 jobs 
mar 2023 jobs */
--jan
CREATE table Jan_jops AS
SELECT *
    FROM job_postings_fact
WHERE EXTRACT (MONTH FROM job_posted_date) = 1;

--feb
CREATE table feb_jops AS
SELECT *
    FROM job_postings_fact
WHERE EXTRACT (MONTH FROM job_posted_date) = 2;

--mar
CREATE table mar_jops AS
SELECT *
    FROM job_postings_fact
WHERE EXTRACT (MONTH FROM job_posted_date) = 3;

