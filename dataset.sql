USE prtkintern;

-- Windows Function

SELECT 
    js.seeker_id,
    js.name AS applicant_name,
    COUNT(a.application_id) OVER (PARTITION BY js.seeker_id) AS total_applications
FROM job_seekers js
LEFT JOIN applications a ON js.seeker_id = a.seeker_id;

SELECT 
    j.job_id,
    j.title,
    COUNT(a.application_id) AS application_count,
    RANK() OVER (ORDER BY COUNT(a.application_id) DESC) AS popularity_rank
FROM jobs j
LEFT JOIN applications a ON j.job_id = a.job_id
GROUP BY j.job_id, j.title;

-- SubQuries

SELECT name
FROM job_seekers
WHERE seeker_id IN (
    SELECT seeker_id
    FROM applications
    WHERE status = 'Offer'
);

SELECT title
FROM jobs
WHERE job_id NOT IN (
    SELECT job_id
    FROM applications
);

-- Common Table Expressions (CTEs)

WITH CompanyApplications AS (
    SELECT 
        c.company_id,
        c.company_name,
        COUNT(a.application_id) AS total_applications
    FROM companies c
    LEFT JOIN jobs j ON c.company_id = j.company_id
    LEFT JOIN applications a ON j.job_id = a.job_id
    GROUP BY c.company_id, c.company_name
)
SELECT * FROM CompanyApplications;

WITH StatusCounts AS (
    SELECT 
        a.status,
        COUNT(*) AS count_status
    FROM applications a
    GROUP BY a.status
)
SELECT 
    status,
    count_status,
    ROUND(count_status * 100.0 / SUM(count_status) OVER (), 2) AS percentage
FROM StatusCounts;






