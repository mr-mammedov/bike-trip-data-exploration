# bike-trip-data-exploration
## Background

I am a junior data analyst, working in the marketing analyst team at
Cyclistic, a bike-share company in Chicago. The director of marketing
believes the company’s future success depends on maximizing the number
of annual memberships. Therefore, your team wants to understand how
casual riders and annual members use Cyclistic bikes differently. From
these insights, your team will design a new marketing strategy to
convert casual riders into annual members

***Dataset***: Cyclistic’s historical data is
[*here*](https://divvy-tripdata.s3.amazonaws.com/index.html) (I will use
12 months of the data. From 2020.04 to 2021.04).

Each dataset has same columns:

-   RIDE\_ID: A unique id for each ride.

-   RIDEABLE\_TYPE: The type of bike used in the ride.

-   STARTED\_AT: Starting time stamp of the ride.

-   ENDED\_AT: Ending time stamp of the ride.

-   START\_STATION\_NAME: Starting station name.

-   START\_STATION\_ID: Starting station numeric id.

-   END\_STATION\_NAME: Ending station name.

-   END\_STATION\_ID: Ending station numeric id.

-   START\_LAT: Latitude of starting station.

-   START\_LNG: Longitude of starting station.

-   END\_LAT: Latitude of ending station.

-   END\_LNG: Longitude of ending station.

-   MEMBER\_CASUAL: Defines whether the customer is a “member” or a
    “casual”.

The process divided into 6 stages: **Ask, Prepare, Process, Analyze,
Share, Act.**

**Ask**: in this stage, going to find problems that should be solved
(understand purpose of the analyze).

**Prepare**: Understanding how data is generated and collected.

**Process**: in this step, checking the data for errors, choosing right
tools, documenting the cleaning process.

**Analyze**: starting to answer the questions.

**Share**: sharing insights using visualization tools.

**Act**: giving recommendations based on insights.

Let’s get started…

### **Ask**:

I will answer to this question:

1.  How do annual members and casual riders use Cyclistic bikes
    differently?

In order to answer this question, we need to find:

1.  avg of **ride\_length** for each user type

2.  Number of **trips** completed by each user type

3.  **Bike preference** by user type

4.  Mode of **day\_of\_week**


### **Prepare**:

I will use Cyclistic’s historical trip data to analyze and find trends
and this data is enough to answer the questions.


### **Process**:

I will use **BigQuery** (because Spreadsheets are not suitable for large
data) for analysis, **Looker Studio** for Visualization.

Combined all the datasets and removed columns that will not be used in
my analysis.

    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202004-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202005-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202006-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202007-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202009-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202010-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202011-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202012-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202101-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202102-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.202103-divvy-tripdata`
    UNION ALL
    SELECT
      *EXCEPT(start_station_name,start_station_id,end_station_name,
        end_station_id,start_lat,start_lng,end_lat,end_lng)
    FROM
      `t-dragon-369617.BikeSharing.2021004-divvy-tripdata`

Added new columns, named as **ride\_length** (Calculating the length of
each ride) and **day\_of\_week** (calculate the day of the week that
each ride started).

    SELECT
    *,
    (ended_at-started_at) as ride_length,
    extract(dayofweek from started_at) as day_of_week
    FROM `t-dragon-369617.BikeShare.divvy-trip-data`

Cleaning Process…

Checking if there any **null** values.

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

Checking if there is any misspelled value in **rideable\_type** column.

    SELECT
    DISTINCT rideable_type
    FROM `t-dragon-369617.BikeShare.divvy-trip-data`

Same for **member\_casual** column.

    SELECT
    DISTINCT member_casual
    FROM `t-dragon-369617.BikeShare.divvy-trip-data`


### **Analyze**:

**1)** Number of **trips** completed by each user type

    SELECT
      member_casual,
      COUNT(*) AS number_of_trips
    FROM
      `t-dragon-369617.BikeShare.divvy-trip-data`
    GROUP BY
      member_casual

**2)** avg of **ride\_length** for each user type

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

**3)** Bike preference by user type

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

**4)** Mode of **day\_of\_week**

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


### **Share:**

#### **1)** Number of **trips** completed by each user type

![num-of-trips](https://user-images.githubusercontent.com/85357838/204800190-d36230e3-1bb1-409e-8f7c-f13120d6ece3.png)


#### **2)** avg of **ride\_length** for each user type

![avg-ride-length](https://user-images.githubusercontent.com/85357838/204800216-78460e90-4405-49d7-aadc-95b4cc89b64d.png)


#### **3)** Bike preference by user type

![bike-preference](https://user-images.githubusercontent.com/85357838/204800322-5af96098-ca50-43b3-adb4-c332b1ea2aa0.png)


#### **4)** Mode of **day\_of\_week**

![mode-of-day](https://user-images.githubusercontent.com/85357838/204800378-e423ac61-bcd0-4174-ae7d-1c2c512ae4bf.png)


### **Act:**

Casual riders prefer to take longer trips (average 44 minutes) compared
to members (average 17 minutes).

Casual riders prefer bikes to use on the weekends

#### Recommendation:

-   This data shows casual riders how they could save more money in the
    a long run by becoming a member instead of paying for rides based on
    trip duration.

-   Develop a weekend membership plan.

