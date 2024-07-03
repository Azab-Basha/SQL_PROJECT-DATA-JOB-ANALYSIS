-- Union and Union ALl
/* combine the result for two or more select statement*/
-- must have the same number of columns and the same data type

SELECT 
    job_title_short,
    company_id,
    job_location
FROM
     jan_jops
UNION
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    feb_jops
UNION
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    mar_jops

-- union all
/* get all results with duplicates */


SELECT 
    job_title_short,
    company_id,
    job_location
FROM
     jan_jops
UNION ALL
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    feb_jops
UNION ALL
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    mar_jops
