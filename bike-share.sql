 -- merging ALL the files.

SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202004-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202005-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202006-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202007-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202009-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202010-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202011-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202012-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202101-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202102-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202103-divvy-tripdata`
UNION ALL
SELECT
  *EXCEPT(start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng)
FROM
  `t-dragon-369617.BikeSharing.202104-divvy-tripdata` 

-- After code was run,table was saved as divvy-trip-data.
-- Adding new columns, ride_length (Calculating the length OF each ride) and day_of_week (calculating the day OF the week that each ride started).

SELECT
  *,
  (ended_at-started_at) AS ride_length,
  EXTRACT(dayofweek
  FROM
    started_at) AS day_of_week
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data` 

-- Cleaning Process...... 
-- Checking if there any null values.
  .
SELECT
  *
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data`
WHERE
  ride_id IS NULL
  OR rideable_type IS NULL
  OR started_at IS NULL
  OR ended_at IS NULL
  OR member_casual IS NULL 
  
  
-- Checking if there is any misspelled value in rideable_type column.

SELECT
  DISTINCT rideable_type
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data` 
  

-- Same FOR member_casual column.

SELECT
  DISTINCT member_casual
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data`


-- Analyze...
-- 1) Number of trips completed by each user type

SELECT
  member_casual,
  COUNT(*) AS number_of_trips
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data`
GROUP BY
  member_casual

-- 2) avg of ride_length for each user type

SELECT
  member_casual,
  ROUND(EXTRACT(hour
    FROM
      AVG(ride_length))*60 + EXTRACT(minute
    FROM
      AVG(ride_length)) + EXTRACT(second
    FROM
      AVG(ride_length))/60,2) AS avg_time_in_min
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data`
GROUP BY
  member_casual


-- 3) Bike preference by user type

SELECT
  member_casual,
  rideable_type,
  COUNT(rideable_type) AS number_of_bike_types
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data`
GROUP BY
  member_casual,
  rideable_type
ORDER BY
  number_of_bike_types desc


-- 4) Mode of day_of_week

SELECT
  member_casual,
  CASE day_of_week
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
  ELSE
  'Saturday'
END
  AS day,
  COUNT(day_of_week) AS mode_of_day
FROM
  `t-dragon-369617.BikeShare.divvy-trip-data`
GROUP BY
  member_casual,
  day
