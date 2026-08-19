/* =====================================================================
   Cyclistic / Divvy Trip Data — Script Used in Cleaning of the trip data
   ---------------------------------------------------------------------
   Purpose: I used this script in the process of cleaning the trip based
   on issues found during exploration. This was done to prepare the data
   for analysis.

   Scope: This process included checking for incorrect or missing values,
   inconsistent formats, handling data type issues, and checking for
   outliers.

   ===================================================================== */

-- Create the new table
CREATE TABLE dbo.divvy_tripdata_cleaned(
    ride_id nvarchar(50),
    rideable_type nvarchar(20),
    started_at datetime2(7),
    ended_at datetime2(7),
    ride_length INT,
    day_of_week char(3),
    month char(3),
    start_station_name nvarchar(70),
    end_station_name nvarchar(70),
    start_lat float,
    start_lng float,
    end_lat float,
    end_lng float,
    member_casual nvarchar(10)
);


-- Insert data into the new table
WITH cleaned AS (
    SELECT
        REPLACE(a.ride_id, '"', '') AS ride_id,
        REPLACE(a.rideable_type, '"', '') AS rideable_type,
        TRY_CONVERT(datetime2, REPLACE(a.started_at, '"', ''), 120) AS started_at,
        TRY_CONVERT(datetime2, REPLACE(a.ended_at, '"', ''), 120) AS ended_at,
        REPLACE(a.start_station_name, '"', '') AS start_station_name,
        REPLACE(a.end_station_name, '"', '') AS end_station_name,
        a.start_lat, a.start_lng, a.end_lat, a.end_lng,
        REPLACE(a.member_casual, '"', '') AS member_casual
    FROM divvy_tripdata_consolidated a
)
INSERT INTO dbo.[divvy_tripdata_cleaned] (
    ride_id, rideable_type, started_at, ended_at,
    ride_length, day_of_week, month,
    start_station_name, end_station_name,
    start_lat, start_lng, end_lat, end_lng, member_casual)
SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    DATEDIFF(MINUTE, started_at, ended_at) AS ride_length,
    CASE DATEPART(WEEKDAY, started_at)
      WHEN 1 THEN 'Sun' WHEN 2 THEN 'Mon' WHEN 3 THEN 'Tue'
      WHEN 4 THEN 'Wed' WHEN 5 THEN 'Thu' WHEN 6 THEN 'Fri'
      WHEN 7 THEN 'Sat'
    END AS day_of_week,
    CASE DATEPART(MONTH, started_at)
      WHEN 1 THEN 'Jan' WHEN 2 THEN 'Feb' WHEN 3 THEN 'Mar'
      WHEN 4 THEN 'Apr' WHEN 5 THEN 'May' WHEN 6 THEN 'Jun'
      WHEN 7 THEN 'Jul' WHEN 8 THEN 'Aug' WHEN 9 THEN 'Sep'
      WHEN 10 THEN 'Oct' WHEN 11 THEN 'Nov' WHEN 12 THEN 'Dec'
    END AS month,
    start_station_name,
    end_station_name,
    start_lat, start_lng, end_lat, end_lng,
    member_casual
FROM cleaned
WHERE
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    started_at IS NOT NULL AND
    ended_at IS NOT NULL AND
    start_lat IS NOT NULL AND
    start_lng IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    DATEDIFF(MINUTE, started_at, ended_at) > 1 AND
    DATEDIFF(MINUTE, started_at, ended_at) < 1440;


-- Set "ride_id" as the primary key for the new table and removed rows:

ALTER TABLE divvy_tripdata_cleaned
ADD PRIMARY KEY (ride_id);

SELECT COUNT(ride_id) AS no_of_rows
FROM dbo.[divvy_tripdata_cleaned];
