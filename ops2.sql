-- Case Study 1 (Job Data)

-- (A)-Number of jobs reviewed: Amount of jobs reviewed over time.
-- Your task: Calculate the number of jobs reviewed per hour per day for November 2020?

SELECT 
    DS AS dates, COUNT(job_id) / 24 AS 'Jobs_reviewed/Hour'
FROM
    job_data
WHERE
    MONTHNAME(ds) = 'November'
        AND job_data.event != 'skip'
GROUP BY ds;

-- (ii). If result to include skipped decisions

SELECT 
    DS AS dates, COUNT(job_id) / 24 AS 'Jobs_reviewed/Hour/day'
FROM
    job_data
WHERE
    MONTHNAME(ds) = 'November'
GROUP BY ds;

-- (B). Throughput: It is the no. of events happening per second.
-- Your task: Let’s say the above metric is called throughput. Calculate 7 day rolling average of throughput? 
-- For throughput, do you prefer daily metric or 7-day rolling and why?

SELECT 
    t1.ds,
    COUNT(t1.event) / 3600 AS daily_throughput,
    AVG(t2.throughput) AS rolling_throughput
FROM
    job_data t1
        JOIN
    (SELECT 
        t2.ds, COUNT(t2.event) / 3600 AS throughput
    FROM
        job_data t2
    GROUP BY t2.ds) AS t2 ON t1.ds >= t2.ds - INTERVAL 6 DAY
        AND t1.ds <= t2.ds
GROUP BY t1.ds;

-- (C). Percentage share of each language: Share of each language for different contents.
-- Your task: Calculate the percentage share of each language in the last 30 days?

SELECT
  language,
  COUNT(*) AS count,
  CONCAT(CAST((COUNT(*) / (SELECT COUNT(*) FROM job_data)) * 100 AS DECIMAL(10, 1)), '%') AS percentage
FROM
  job_data
GROUP BY
  language
ORDER BY
  language ASC;


-- (D). Duplicate rows: Rows that have the same value present in them.
-- Your task: Let’s say you see some duplicate rows in the data. How will you display duplicates from the table:

SELECT 
    *
FROM
    job_data
GROUP BY language , ds , job_id , actor_id , event , time_spent , org
HAVING COUNT(*) > 1;




-- Case Study 2 (Investigating metric spike)

-- (A).User Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service.
-- Your task: Calculate the weekly user engagement?
SELECT 
    e.location,
    SUM(CASE
        WHEN e.Weeks = 17 THEN e.User_engagement
    END) AS Week_17,
    SUM(CASE
        WHEN e.Weeks = 18 THEN e.User_engagement
    END) AS Week_18,
    SUM(CASE
        WHEN e.Weeks = 19 THEN e.User_engagement
    END) AS Week_19,
    SUM(CASE
        WHEN e.Weeks = 20 THEN e.User_engagement
    END) AS Week_20,
    SUM(CASE
        WHEN e.Weeks = 21 THEN e.User_engagement
    END) AS Week_21,
    SUM(CASE
        WHEN e.Weeks = 22 THEN e.User_engagement
    END) AS Week_22,
    SUM(CASE
        WHEN e.Weeks = 23 THEN e.User_engagement
    END) AS Week_23,
    SUM(CASE
        WHEN e.Weeks = 24 THEN e.User_engagement
    END) AS Week_24,
    SUM(CASE
        WHEN e.Weeks = 25 THEN e.User_engagement
    END) AS Week_25,
    SUM(CASE
        WHEN e.Weeks = 26 THEN e.User_engagement
    END) AS Week_26,
    SUM(CASE
        WHEN e.Weeks = 27 THEN e.User_engagement
    END) AS Week_27,
    SUM(CASE
        WHEN e.Weeks = 28 THEN e.User_engagement
    END) AS Week_28,
    SUM(CASE
        WHEN e.Weeks = 29 THEN e.User_engagement
    END) AS Week_29,
    SUM(CASE
        WHEN e.Weeks = 30 THEN e.User_engagement
    END) AS Week_30,
    SUM(CASE
        WHEN e.Weeks = 31 THEN e.User_engagement
    END) AS Week_31,
    SUM(CASE
        WHEN e.Weeks = 32 THEN e.User_engagement
    END) AS Week_32,
    SUM(CASE
        WHEN e.Weeks = 33 THEN e.User_engagement
    END) AS Week_33,
    SUM(CASE
        WHEN e.Weeks = 34 THEN e.User_engagement
    END) AS Week_34,
    SUM(CASE
        WHEN e.Weeks = 35 THEN e.User_engagement
    END) AS Week_35,
    SUM(e.User_engagement) AS Total_User_Engagement
FROM
    (SELECT 
        WEEK(occurred_at) AS Weeks,
            location,
            COUNT(user_id) AS User_engagement
    FROM
        events
    WHERE
        event_type = 'engagement'
    GROUP BY Weeks , location WITH ROLLUP) AS e
WHERE
    e.location IS NOT NULL
GROUP BY e.location
ORDER BY e.location;



-- (2)User Growth: Amount of users growing over time for a product.
-- Your task: Calculate the user growth for product?

SELECT
    WEEK(created_at,1) AS week,
    CONCAT(DATE_FORMAT(MIN(created_at), '%Y-%m-%d'), ' to ', DATE_FORMAT(MAX(created_at), '%Y-%m-%d')) AS Period_of_Week,
    COUNT(*) AS count,
    CONCAT(
        ROUND(
            100 * (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY WEEK(created_at, 1))) / LAG(COUNT(*)) OVER (ORDER BY WEEK(created_at, 1))
        ),
        '%'
    ) AS growth
FROM users
GROUP BY WEEK(created_at, 1)
ORDER BY WEEK(created_at, 1);


-- (3).Weekly Retention: Users getting retained weekly after signing-up for a product.
-- Your task: Calculate the weekly retention of users-sign up cohort?

SELECT
    t.week,
    CONCAT(DATE_FORMAT(MIN(created_at), '%Y-%m-%d'), ' to ', DATE_FORMAT(MAX(created_at), '%Y-%m-%d')) AS Period_of_Week,
    t.total_users,
    CONCAT(
        ROUND(100 * (t.total_users - lag(t.total_users) OVER (ORDER BY t.week)) / lag(t.total_users) OVER (ORDER BY t.week), 2),
        '%'
    ) AS total_users_growth,
    COUNT(DISTINCT u.user_id) AS retained_users,
        CONCAT(
        ROUND(100 * (COUNT(DISTINCT u.user_id) - lag(COUNT(DISTINCT u.user_id)) OVER (ORDER BY t.week)) / lag(COUNT(DISTINCT u.user_id)) OVER (ORDER BY t.week), 2),
        '%'
    ) AS retained_users_growth,
    CONCAT(
        ROUND(100 * COUNT(DISTINCT u.user_id) / t.total_users, 2),
        '%'
    ) AS retention_rate

FROM (
    SELECT
        WEEK(created_at, 1) AS week,
        COUNT(DISTINCT user_id) AS total_users
    FROM users
    GROUP BY week
) AS t
JOIN users u ON WEEK(u.created_at, 1) = t.week AND u.state = 'active'
GROUP BY t.week, t.total_users
ORDER BY t.week;

-- (4).Weekly Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service weekly.
-- Your task: Calculate the weekly engagement per device?

SELECT
    CASE WHEN e.device IS NOT NULL THEN e.device ELSE 'Total' END AS device,
    SUM(CASE WHEN e.Weeks = 17 THEN e.User_engagement END) AS Week_17,
    SUM(CASE WHEN e.Weeks = 18 THEN e.User_engagement END) AS Week_18,
    SUM(CASE WHEN e.Weeks = 19 THEN e.User_engagement END) AS week_19,
    SUM(CASE WHEN e.Weeks = 20 THEN e.User_engagement END) AS week_20,
    SUM(CASE WHEN e.Weeks = 21 THEN e.User_engagement END) AS week_21,
    SUM(CASE WHEN e.Weeks = 22 THEN e.User_engagement END) AS week_22,
    SUM(CASE WHEN e.Weeks = 23 THEN e.User_engagement END) AS week_23,
    SUM(CASE WHEN e.Weeks = 24 THEN e.User_engagement END) AS week_24,
    SUM(CASE WHEN e.Weeks = 25 THEN e.User_engagement END) AS week_25,
    SUM(CASE WHEN e.Weeks = 26 THEN e.User_engagement END) AS week_26,
    SUM(CASE WHEN e.Weeks = 27 THEN e.User_engagement END) AS week_27,
    SUM(CASE WHEN e.Weeks = 28 THEN e.User_engagement END) AS week_28,
    SUM(CASE WHEN e.Weeks = 29 THEN e.User_engagement END) AS week_29,
    SUM(CASE WHEN e.Weeks = 30 THEN e.User_engagement END) AS week_30,
    SUM(CASE WHEN e.Weeks = 31 THEN e.User_engagement END) AS week_31,
    SUM(CASE WHEN e.Weeks = 32 THEN e.User_engagement END) AS week_32,
    SUM(CASE WHEN e.Weeks = 33 THEN e.User_engagement END) AS week_33,
    SUM(CASE WHEN e.Weeks = 34 THEN e.User_engagement END) AS week_34,
    SUM(CASE WHEN e.Weeks = 35 THEN e.User_engagement END) AS week_35,
    SUM(e.User_engagement) AS Total_User_Engagement
FROM (
    SELECT WEEK(occurred_at) AS Weeks, device, COUNT(user_id) AS User_engagement
    FROM events
    WHERE event_type = 'engagement'
    GROUP BY Weeks, device WITH ROLLUP
) AS e
GROUP BY e.device
WITH ROLLUP
ORDER BY device IS NULL, e.device IS NULL, e.device;


-- (5).Email Engagement: Users engaging with the email service.
-- Your task: Calculate the email engagement metrics?

SELECT 
    WEEK(occurred_at) AS Week,
    COUNT(DISTINCT (CASE
            WHEN action = 'sent_weekly_digest' THEN user_id
        END)) AS weekly_digest,
    COUNT(DISTINCT (CASE
            WHEN action = 'sent_reengagement_email' THEN user_id
        END)) AS reengagement_mail,
    COUNT(DISTINCT (CASE
            WHEN action = 'email_open' THEN user_id
        END)) AS opened_email,
    COUNT(DISTINCT (CASE
            WHEN action = 'email_clickthrough' THEN user_id
        END)) AS email_clickthrough
FROM
    email_events
GROUP BY WEEK(occurred_at)
ORDER BY WEEK(occurred_at);