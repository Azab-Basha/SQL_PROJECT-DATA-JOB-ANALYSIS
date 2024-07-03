--Subqueries and CTEs

/* we can actually do what we have done by creating a new tab
to see job posting in Jan with one query using subquery*/
/* 
the term "subquery" (sometimes spelled "sub-query") refers to a query
nested within another query. It's also known as an inner query or nested query.

A subquery can appear in various parts of an SQL statement:

--In SELECT statements: A subquery can be used within the SELECT statement to 
retrieve data as a column or as a value for comparison.

Example:

sql
Copy code
SELECT column1, (SELECT MAX(column2) FROM table2) AS max_value
FROM table1;

--In FROM clause: Here, the subquery acts as a derived table, providing a set of rows
that the outer query operates on.

Example:

sql
Copy code
SELECT *
FROM (SELECT column1, column2 FROM table1) AS subtable
WHERE column1 > 10;

--In WHERE clause: A subquery in the WHERE clause is used to filter rows based on some condition.

Example:

sql
Copy code
SELECT column1, column2
FROM table1
WHERE column1 IN (SELECT column1 FROM table2 WHERE column2 > 100);

--In INSERT, UPDATE, or DELETE statements: Subqueries can also be used to determine 
which rows to insert, update, or delete based on the result of the subquery.

Example (UPDATE):

sql
Copy code
UPDATE table1
SET column1 = (SELECT MAX(column2) FROM table2)
WHERE id = 1;
In essence, a subquery allows you to nest queries within each other,
enabling more complex and specific data retrieval or manipulation operations.
*/

----------------------------------------------------


/*CTE stands for Common Table Expression in SQL. It's a temporary result set that you can
reference within a SELECT, INSERT, UPDATE, or DELETE statement. CTEs were introduced in SQL
Server 2005 and are supported by various relational database management systems 
(RDBMS) such as PostgreSQL, MySQL (since version 8.0), and Oracle (since version 12c).

Here are some key characteristics and uses of CTEs:

Syntax: In SQL, a CTE is defined using the WITH clause followed by a name for 
the CTE and a query that defines it. The CTE is then referenced like a table
within subsequent parts of the SQL statement.

Example:

sql
Copy code
WITH CTE_name AS (
    SELECT column1, column2
    FROM table1
    WHERE condition
)
SELECT *
FROM CTE_name
WHERE column2 > 100;

--Recursive CTEs: CTEs can be recursive, meaning they can reference themselves in the definition. 
--Recursive CTEs are used for hierarchical queries or to traverse hierarchical data structures.

Example of a recursive CTE:

sql
Copy code
WITH RECURSIVE CTE_hierarchy AS (
    SELECT emp_id, emp_name, manager_id
    FROM employees
    WHERE emp_id = 1
    UNION ALL
    SELECT e.emp_id, e.emp_name, e.manager_id
    FROM employees e
    INNER JOIN CTE_hierarchy c ON e.manager_id = c.emp_id
)
SELECT * FROM CTE_hierarchy;

Benefits: CTEs offer several advantages, such as improving readability of complex 
queries by breaking them into logical sections, reducing repetition of subqueries, 
and simplifying the process of debugging and maintenance.

Scope: A CTE exists only for the duration of the query in which it's defined.
Once the query execution completes, the CTE ceases to exist.

CTEs provide a powerful way to write more modular and maintainable SQL queries, 
especially when dealing with complex data manipulations, hierarchical data structures,
or when you need to reuse a subquery multiple times within the same SQL statement.
*/
SELECT * FROM (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS January_jobs;


-- using CTE

with January_jobs AS ( 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT * FROM January_jobs

SELECT
    company_id,
    job_no_degree_mention
FROM 
    job_postings_fact
WHERE 
    job_no_degree_mention = True;

-- using subquery to get the companhy name 
-- with no mentioned degree
SELECT name FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention = True
);

/* find the companies that have the most job openings
- get the total number of the job posting per company id
- return the totla number of jobs with the company name 
*/

-- first step get the job count for each company-id
with company_jop_count as(
SELECT 
    company_id,
    COUNT(*) job_per_company
FROM 
    job_postings_fact
GROUP BY 
    company_id
ORDER BY
     job_per_company DESC
)

SELECT * FROM company_jop_count


-- second step make a LEFT join with company_dim 

with company_jop_count as(
    SELECT 
        company_id,
        COUNT(*) job_per_company
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_jop_count.job_per_company
FROM
     company_dim 
LEFT JOIN company_jop_count on company_jop_count.company_id = company_dim.company_id
ORDER BY job_per_company DESC



/* WE DID A Left JOIN TO ENUSRE THAT WE GOT 
ALL COMPANIES NAMES IN CASE THERE IS NOT JOB 
POSTING IN THE OTHER TABLE 

*/

