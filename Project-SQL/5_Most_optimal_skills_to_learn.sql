/*
What are the most optimal skills to learn 
    optimal : high demand and high paying
*/
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,	
        skills_dim.skills,
        COUNT(skills) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL AND    
        job_location = 'Anywhere' 
    GROUP BY
        skills_dim.skill_id   
), average_salay AS ( --used to identify another CTE with the same WITH satatement
    SELECT
        skills_job_dim.skill_id,	
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        skills_job_dim.skill_id        
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salay ON 
    skills_demand.skill_id = average_salay.skill_id
ORDER BY demand_count DESC,
    avg_salary DESC
    