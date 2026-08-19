-- ==================================================================
-- Cyclistic / Divvy Trip Data — Data Analysis Script
-- ------------------------------------------------------------------
-- Purpose: Analyze the cleaned dataset to answer: How do annual
-- members and casual riders use Cyclistic bikes differently?
-- ==================================================================

-- summary stats: mean/max ride_length, mode of day_of_week
SELECT
    AVG(CAST(ride_length AS DECIMAL(10,2))) AS mean_ride_length,
    MAX(ride_length) AS max_ride_length
FROM dbo.[divvy_tripdata_cleaned];

SELECT TOP 1 day_of_week, COUNT(*) AS trip_count
FROM dbo.[divvy_tripdata_cleaned]
GROUP BY day_of_week
ORDER BY trip_count DESC;

-- member vs. casual rides ride count comparison (KPI)
-- KPI created directly in Tableau

-- bike type used by riders
SELECT member_casual, rideable_type, COUNT(*) AS total_trips
FROM dbo.[divvy_tripdata_cleaned]
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips;

-- number of trips per month (chronological order)
SELECT month, member_casual, COUNT(ride_id) AS total_trips
FROM dbo.[divvy_tripdata_cleaned]
GROUP BY month, member_casual
ORDER BY
    member_casual,
    CASE month
        WHEN 'Jan' THEN 1 WHEN 'Feb' THEN 2 WHEN 'Mar' THEN 3
        WHEN 'Apr' THEN 4 WHEN 'May' THEN 5 WHEN 'Jun' THEN 6
        WHEN 'Jul' THEN 7 WHEN 'Aug' THEN 8 WHEN 'Sep' THEN 9
        WHEN 'Oct' THEN 10 WHEN 'Nov' THEN 11 WHEN 'Dec' THEN 12
    END;

-- number of trips per day of week (chronological order, Sun-Sat)
SELECT day_of_week, member_casual, COUNT(ride_id) AS total_trips
FROM dbo.[divvy_tripdata_cleaned]
GROUP BY day_of_week, member_casual
ORDER BY
    member_casual,
    CASE day_of_week
        WHEN 'Sun' THEN 1 WHEN 'Mon' THEN 2 WHEN 'Tue' THEN 3
        WHEN 'Wed' THEN 4 WHEN 'Thu' THEN 5 WHEN 'Fri' THEN 6
        WHEN 'Sat' THEN 7
    END;

-- number of trips per hour (chronological order, 12 AM-11 PM)
SELECT
    FORMAT(started_at, 'hh tt') AS hour_of_day_am_pm,
    member_casual,
    COUNT(ride_id) AS total_trips
FROM dbo.[divvy_tripdata_cleaned]
GROUP BY
    FORMAT(started_at, 'hh tt'),
    member_casual
ORDER BY
    member_casual,
    CASE
        WHEN FORMAT(started_at, 'tt') = 'AM' THEN 0 ELSE 1
    END,
    CAST(FORMAT(started_at, 'hh') AS INT) % 12;

-- average ride_length per day of week (chronological order, Sun-Sat)
SELECT day_of_week, member_casual, AVG(CAST(ride_length AS DECIMAL(10,2))) AS avg_ride_duration
FROM dbo.[divvy_tripdata_cleaned]
GROUP BY day_of_week, member_casual
ORDER BY
    member_casual,
    CASE day_of_week
        WHEN 'Sun' THEN 1 WHEN 'Mon' THEN 2 WHEN 'Tue' THEN 3
        WHEN 'Wed' THEN 4 WHEN 'Thu' THEN 5 WHEN 'Fri' THEN 6
        WHEN 'Sat' THEN 7
    END;
