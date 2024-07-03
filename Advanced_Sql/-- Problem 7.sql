-- Problem 7
/*
Find the count of the number of remote job per skill
- Dsiplay the top 5 skills by their demand in remote jobs
- Include skill ID, name and the count of postings requiring the skill
*/

-- My Solution
 WITH skills_Per_job AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        job_id
    FROM 
        skills_dim
    INNER JOIN skills_job_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
)

SELECT
    skill_id,
    skills,
    COUNT(job_postings_fact.job_id) AS number_of_jobs
FROM 
    skills_Per_job
INNER JOIN job_postings_fact ON skills_Per_job.job_id = job_postings_fact.job_id
WHERE
     job_location = 'Anywhere' AND
     job_title_short = 'Data Analyst'
GROUP BY
     skills_Per_job.skill_id, skills_Per_job.skills
ORDER BY
     number_of_jobs DESC
LIMIT 5;



-- LUKE solution
WITH remote_job_skills AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_work_from_home = TRUE AND
        job_title_short = 'Data Analyst'
    GROUP BY skill_id
)

SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    skill_count
FROM
     remote_job_skills
INNER JOIN skills_dim ON skills_dim.skill_id = remote_job_skills.skill_id   
ORDER BY skill_count DESC
LIMIT 5;
