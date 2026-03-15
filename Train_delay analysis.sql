create database unique_projects;
use unique_projects;
# Overall Average Delay
SELECT AVG(average_delay_minutes) AS overall_avg_delay
FROM train_delays;
# Total Stations Analyzed
SELECT COUNT(DISTINCT station_name) AS total_stations
FROM train_delays;
# Train Performance
SELECT train_name,
AVG(average_delay_minutes) AS avg_delay
FROM train_delays
GROUP BY train_name
ORDER BY avg_delay DESC
LIMIT 10;
# Delay Category Distribution
SELECT 
    CASE 
        WHEN average_delay_minutes <= 15 THEN 'On Time'
        WHEN average_delay_minutes <= 60 THEN 'Moderate Delay'
        ELSE 'Heavy Delay'
    END AS delay_category,
    COUNT(*) AS total_trains
FROM train_delays
GROUP BY 
    CASE 
        WHEN average_delay_minutes <= 15 THEN 'On Time'
        WHEN average_delay_minutes <= 60 THEN 'Moderate Delay'
        ELSE 'Heavy Delay'
    END;

UPDATE train_delays
SET delay_category = CASE
    WHEN average_delay_minutes <= 15 THEN 'On Time'
    WHEN average_delay_minutes <= 60 THEN 'Moderate Delay'
    ELSE 'Heavy Delay'
END;
# Percentage of Right Time Trains
SELECT AVG(pct_right_time) AS avg_on_time_percentage
FROM train_delays;
# Cancellation / Unknown Status Percentage
SELECT AVG(pct_cancelled_unknown) AS avg_cancelled_percentage
FROM train_delays;
# Route Performance
SELECT station_code,
AVG(average_delay_minutes) AS route_avg_delay
FROM train_delays
GROUP BY station_code
ORDER BY route_avg_delay DESC;
# Train Delay Risk Score
SELECT train_name,
ROUND(AVG(average_delay_minutes)/60, 2) AS avg_delay_hours
FROM train_delays
GROUP BY train_name
ORDER BY avg_delay_hours DESC
LIMIT 10;