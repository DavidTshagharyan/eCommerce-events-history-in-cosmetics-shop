-- 1 Session-level features
CREATE TABLE session_features AS
SELECT
    user_session,
    user_id,
    MIN(event_time) AS session_start,
    MAX(event_time) AS session_end,
    EXTRACT(EPOCH FROM (MAX(event_time) - MIN(event_time))) / 60 AS session_duration_min,
    COUNT(*) FILTER (WHERE event_type = 'view') AS views,
    COUNT(*) FILTER (WHERE event_type = 'cart') AS carts,
    COUNT(*) FILTER (WHERE event_type = 'remove_from_cart') AS removes,
    COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchases,
    COUNT(DISTINCT product_id) AS unique_products_viewed,
    COUNT(DISTINCT category_id) AS unique_categories_viewed,
    SUM(price) FILTER (WHERE event_type = 'purchase') AS session_revenue,
    CASE WHEN COUNT(*) FILTER (WHERE event_type = 'purchase') > 0 
         THEN 1 ELSE 0 END AS converted
FROM events_clean
GROUP BY user_session, user_id;


-- 2 User-level features
CREATE TABLE user_features AS
SELECT
    user_id,
    MIN(event_time) AS first_seen,
    MAX(event_time) AS last_seen,
    EXTRACT(DAY FROM (DATE '2020-03-01' - MAX(event_time))) AS recency_days,
    COUNT(DISTINCT user_session) AS frequency_sessions,
    COUNT(*) FILTER (WHERE event_type = 'purchase') AS total_purchases,
    COALESCE(SUM(price) FILTER (WHERE event_type = 'purchase'), 0) AS monetary_total,
    COUNT(*) FILTER (WHERE event_type = 'view') AS total_views,
    COUNT(*) FILTER (WHERE event_type = 'cart') AS total_carts,
    COUNT(DISTINCT category_id) AS unique_categories,
    COUNT(DISTINCT product_id) AS unique_products,
    CASE WHEN COUNT(*) FILTER (WHERE event_type = 'purchase') > 0 
         THEN 1 ELSE 0 END AS is_buyer
FROM events_clean
GROUP BY user_id;


-- Checking
SELECT COUNT(*) FROM session_features;
SELECT * FROM session_features LIMIT 10;

SELECT COUNT(*) FROM user_features;
SELECT * FROM user_features LIMIT 10;


-- Feature Engineering: Session-level and User-level aggregations

-- 1. Session-level features (for funnel analysis)
CREATE TABLE session_features AS
SELECT
    ...
;

-- 2. User-level features (for RFM/segmentation/ML)
CREATE TABLE user_features AS
SELECT
    ...
;

-- 3. Fix NULL revenue (no purchase = 0 revenue, not NULL)
UPDATE session_features 
SET session_revenue = 0 
WHERE session_revenue IS NULL;