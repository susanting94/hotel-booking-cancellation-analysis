-- Hotel Booking Cancellation Analysis
-- Tool: PostgreSQL
-- Dataset: Hotel Booking Demand

--======================
-- 1. Data cleaning
--======================
-- Convert empty strings in the children column to NULL
-- and change the data type from text to integer.
-- Note: Run this section only on the original, uncleaned table.

ALTER TABLE hotel_bookings
ALTER COLUMN children TYPE TEXT;

UPDATE hotel_bookings
SET children = NULL
WHERE children = '';

ALTER TABLE hotel_bookings
ALTER COLUMN children TYPE INTEGER
USING children::INTEGER;


--======================
-- 2. Data check
--======================

-- 2.1 Check the total number of booking records
SELECT COUNT(*) AS total_bookings
FROM hotel_bookings;

-- 2.2 Preview the first 20 records
SELECT *
FROM hotel_bookings
LIMIT 20;

-- 2.3 Check for missing or negative lead time values
-- and invalid cancellation indicators
SELECT
    COUNT(*) FILTER (WHERE lead_time IS NULL) AS missing_lead_time,
    COUNT(*) FILTER (WHERE lead_time < 0) AS negative_lead_time,
    COUNT(*) FILTER (
        WHERE is_canceled IS NULL
           OR is_canceled NOT IN (0, 1)
    ) AS invalid_cancellation_values
FROM hotel_bookings;


--======================
-- 3. Cancellation Analysis
--======================

-- 3.1 Compare cancellation rates by hotel type
SELECT
    hotel,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_bookings,
    ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY hotel
ORDER BY hotel;

-- 3.2 Explore booking lead time statistics
SELECT
    MIN(lead_time) AS min_lead_time,
    MAX(lead_time) AS max_lead_time,
    ROUND(AVG(lead_time), 2) AS avg_lead_time
FROM hotel_bookings;

-- 3.3 Explore lead time distribution using quartiles
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY lead_time) AS q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY lead_time) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY lead_time) AS q3
FROM hotel_bookings;

-- 3.4 Count bookings across five lead time groups
SELECT
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '181+ days'
    END AS lead_time_group,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY lead_time_group
ORDER BY MIN(lead_time) ASC;

-- 3.5 Calculate cancellation rates by booking lead time
SELECT
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '181+ days'
    END AS lead_time_group,
    COUNT(*) AS total_bookings,

    -- Count canceled bookings
    SUM(is_canceled) AS canceled_bookings,

    -- Calculate cancellation rate (%)
    ROUND(100.0 * SUM(is_canceled) / COUNT(*),2) 
    AS cancellation_rate

FROM hotel_bookings
GROUP BY lead_time_group
ORDER BY MIN(lead_time) ASC;

-- 3.6 Compare lead time cancellation patterns by hotel type
SELECT
    hotel,
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '181+ days'
    END AS lead_time_group,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_bookings,
    ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) 
    AS cancellation_rate
FROM hotel_bookings
GROUP BY hotel, lead_time_group
ORDER BY hotel, MIN(lead_time) ASC;


--======================
-- 4. Market Segment Exploration
--======================

-- 4.1 Identify unique market segments in the dataset
SELECT DISTINCT market_segment
FROM hotel_bookings
ORDER BY market_segment;