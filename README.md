# DATA-ANALYSIS-WITH-COMPLEX-QUERIES
*COMPANY :* CODETECH IT SOLUTION

*NAME :* WALKE PRATIK BABU

*INTERN ID :* CTIS4099

*DOMAIN :* SQL

*DURATION :* 4 WEEEKS

*MENTOR :* NEELA SANTHOSH KUMAR

The Data Analysis task focuses on writing complex SQL queries to extract deeper insights from the prtkintern database. While simple queries can retrieve basic information, advanced techniques such as window functions, subqueries, and common table expressions (CTEs) allow us to perform analytical operations, trend analysis, and multi‑step logic that are essential in real‑world data scenarios.

1. Window Functions
Window functions enable calculations across sets of rows related to the current row, without collapsing results into a single aggregate. They are particularly useful for ranking, running totals, and moving averages.
Example: Ranking job seekers by number of applications
SELECT 
    seeker_id,
    COUNT(application_id) AS total_applications,
    RANK() OVER (ORDER BY COUNT(application_id) DESC) AS rank_position
FROM applications
GROUP BY seeker_id;


This query counts applications per job seeker and assigns a rank based on activity. It helps identify the most active candidates.

2. Subqueries
Subqueries allow us to nest queries inside others, enabling filtering or calculations that depend on intermediate results.
Example: Find job seekers who applied to jobs in the “IT” industry

SELECT name, email
FROM job_seekers
WHERE seeker_id IN (
    SELECT seeker_id
    FROM applications a
    JOIN jobs j ON a.job_id = j.job_id
    JOIN companies c ON j.company_id = c.company_id
    WHERE c.industry = 'IT'
);


Here, the inner query identifies seekers who applied to IT jobs, and the outer query retrieves their details.

3. Common Table Expressions (CTEs)
CTEs provide a way to structure complex queries into readable, reusable blocks. They are especially useful for multi‑step analysis.
Example: Calculate application conversion rates

WITH total_applications AS (
    SELECT seeker_id, COUNT(*) AS applied_count
    FROM applications
    GROUP BY seeker_id
),
successful_applications AS (
    SELECT seeker_id, COUNT(*) AS success_count
    FROM applications
    WHERE status = 'Accepted'
    GROUP BY seeker_id
)
SELECT 
    t.seeker_id,
    t.applied_count,
    s.success_count,
    (s.success_count * 100.0 / t.applied_count) AS conversion_rate
FROM total_applications t
LEFT JOIN successful_applications s
ON t.seeker_id = s.seeker_id;


This query calculates how many applications each seeker submitted, how many were successful, and their success rate. It provides actionable insights into candidate performance.

4. Analytical Use Cases
- Trend Analysis: Using window functions to track application volume over time.
- Filtering with Subqueries: Identifying companies with no applications.
- Multi‑Step Logic with CTEs: Breaking down complex metrics like conversion rates or job fill times.
