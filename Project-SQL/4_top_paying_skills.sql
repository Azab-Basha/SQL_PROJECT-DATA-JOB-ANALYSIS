-- What are the top skills based on salary
/*
- Look at the average salary associated with each skill for data analyst postions
- DFcuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for data analyst and 
    helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT	
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
    --job_location = 'Anywhere'
GROUP BY
    skills        
ORDER BY
    avg_salary DESC


/* Round() Function used to set the number of digits after the 
    decimal point i our case zero means round zero digits 
*/

/*ere's a breakdown of the results for top paying skills for Data Analysts:
- High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase),
 machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation
  of data processing and predictive modeling capabilities.
- Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) 
indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation 
and efficient data pipeline management.
- Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP)
 underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly 
 boosts earning potential in data analytics.

*/
