/* =====================================================================
   Cyclistic / Divvy Trip Data — Script Used in Exploring the Data
   ---------------------------------------------------------------------
   Purpose: This script was used in various steps of exploring the data
   to confirm accuracy and completeness, and to identify changes to be
   made during the cleaning process.

   Scope: Understand data completeness and quality, examine data types,
   check for duplicates, check if data is in the right format, and
   confirm sufficiency for analysis.
   ===================================================================== */

-- check data types across columns
SELECT column_name, data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
AND table_name = 'divvy_tripdata_consolidated';

-- validate if missing values exist on all columns
SELECT COUNT(*) - COUNT(ride_id) ride_id,
COUNT(*) - COUNT(rideable_type) rideable_type,
COUNT(*) - COUNT(started_at) started_at,
COUNT(*) - COUNT(ended_at) ended_at,
COUNT(*) - COUNT(start_station_name) start_station_name,
COUNT(*) - COUNT(start_station_id) start_station_id,
COUNT(*) - COUNT(end_station_name) end_station_name,
COUNT(*) - COUNT(end_station_id) end_station_id,
COUNT(*) - COUNT(start_lat) start_lat,
COUNT(*) - COUNT(start_lng) start_lng,
COUNT(*) - COUNT(end_lat) end_lat,
COUNT(*) - COUNT(end_lng) end_lng,
COUNT(*) - COUNT(member_casual) member_casual
FROM divvy_tripdata_consolidated;

-- check ride_id column for duplicates
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM divvy_tripdata_consolidated;

-- confirm date range matches expected scope (April 2025 - March 2026)
SELECT MIN(started_at) AS earliest_ride, MAX(started_at) AS latest_ride
FROM divvy_tripdata_consolidated;

-- identify rows with negative ride duration (ended_at before started_at)
SELECT COUNT(*) AS negative_duration_rows
FROM divvy_tripdata_consolidated
WHERE ended_at < started_at;

-- verify information on rideable_type column for type of bike used
SELECT rideable_type, member_casual, COUNT(ride_id) AS ride_count
FROM divvy_tripdata_consolidated
GROUP BY rideable_type, member_casual;

-- ride counts by rideable_type only
SELECT rideable_type, COUNT(ride_id) AS ride_id_count
FROM divvy_tripdata_consolidated
GROUP BY rideable_type;

-- spot check started_at and ended_at columns
SELECT TOP 10 started_at, ended_at
FROM divvy_tripdata_consolidated;

-- identify rows where ride duration longer than a day 
SELECT COUNT(*) AS longer_than_a_day
FROM divvy_tripdata_consolidated
WHERE DATEDIFF(MINUTE, started_at, ended_at) >= 1440;

-- identify rows where rides were less than a minute 
SELECT COUNT(*) AS less_than_a_minute
FROM divvy_tripdata_consolidated
WHERE DATEDIFF(MINUTE, started_at, ended_at) <= 1;

-- determine if any missing values in start_station_name
SELECT DISTINCT start_station_name
FROM divvy_tripdata_consolidated
ORDER BY start_station_name;

-- determine if start_station_name are missing values 
SELECT COUNT(ride_id) AS rows_with_start_station_null
FROM divvy_tripdata_consolidated
WHERE start_station_name IS NULL OR start_station_id IS NULL;

-- identify if there are missing values in end_station_name
SELECT DISTINCT end_station_name
FROM divvy_tripdata_consolidated
ORDER BY end_station_name;

-- determine if end_station_name missing values 
SELECT COUNT(ride_id) AS rows_with_null_end_station
FROM divvy_tripdata_consolidated
WHERE end_station_name IS NULL OR end_station_id IS NULL;

-- identify start_lat, start_lng with missing values 
SELECT COUNT(ride_id) AS rows_with_null_start_loc
FROM divvy_tripdata_consolidated
WHERE start_lat IS NULL OR start_lng IS NULL;

-- identify end_lat, end_lng with missing values 
SELECT COUNT(ride_id) AS rows_with_null_end_loc
FROM divvy_tripdata_consolidated
WHERE end_lat IS NULL OR end_lng IS NULL;

-- member_casual column check - 2 unique values
-- some cells contain leading and trailing quotation marks, to remove.
SELECT DISTINCT member_casual, COUNT(member_casual) AS no_of_trips
FROM divvy_tripdata_consolidated
GROUP BY member_casual;
