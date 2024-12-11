-- Business Req 1 : City-level Fare and Trip Summary Report
Use trips_db;

SELECT 
	c.city_name, 
    COUNT(trip_id) as Total_trips, 
    SUM(f.fare_amount)/SUM(f.distance_travelled_km) as avg_fare_per_km, 
    SUM(f.fare_amount)/count(f.trip_id) as average_fare_per_trip, 
    ROUND(
		(COUNT(f.trip_id)* 100 / 
        (SELECT COUNT(trip_id) FROM fact_trips)), 
        2
    ) AS pct_contribution
FROM 
	fact_trips f
INNER JOIN 
	dim_city c on c.city_id = f.city_id
GROUP BY 
	city_name;

------------------------------------------------------------------------
-- Business Req 2 : Monthly City-level Trips Targer Performance Report

Use targets_db;

SELECT c.city_name,monthname(f.month),total_passengers as actual_trips, m.total_target_trips,
	Case
		WHEN total_passengers > total_target_trips THEN "Above Target"
        WHEN total_passengers <= total_target_trips THEN "Below Target"
	END AS performance_status,
    ROUND(
    ((f.total_passengers - m.total_target_trips) / m.total_target_trips)*100,2) as pct_difference 
FROM 
	trips_db.fact_passenger_summary f 
INNER JOIN
	trips_db.dim_city c on f.city_id = c.city_id
INNER JOIN 
	targets_db.monthly_target_trips m on m.city_id = f.city_id AND m.month = f.month;

------------------------------------------------------------------------
-- Business Req 3 :City-Level Repeat Passenger Trip Frequency Report

SELECT 
    c.city_name,
    ROUND(SUM(CASE WHEN d.trip_count = '2-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `2-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '3-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `3-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '4-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `4-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '5-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `5-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '6-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `6-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '7-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `7-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '8-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `8-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '9-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `9-Trips`,
    ROUND(SUM(CASE WHEN d.trip_count = '10-Trips' THEN d.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(d.repeat_passenger_count), 2) AS `10-Trips`
FROM 
    trips_db.dim_repeat_trip_distribution d
INNER JOIN 
    trips_db.dim_city c ON d.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    c.city_name;
------------------------------------------------------------------------------
-- Business Req 4 :Identify Cities with Highest and Lowest Total New passengers

(
    SELECT 
        city_name,
        SUM(new_passengers) AS total_new_passengers,
        'Top 3' AS city_category
    FROM 
        trips_db.fact_passenger_summary f
    INNER JOIN 
        trips_db.dim_city c ON c.city_id = f.city_id
    GROUP BY 
        city_name
    ORDER BY 
        total_new_passengers DESC
    LIMIT 3
)
UNION
(
    SELECT 
        city_name,
        SUM(new_passengers) AS total_new_passengers,
        'Bottom 3' AS city_category
    FROM 
        trips_db.fact_passenger_summary f
    INNER JOIN 
        trips_db.dim_city c ON c.city_id = f.city_id
    GROUP BY 
        city_name
    ORDER BY 
        total_new_passengers ASC
    LIMIT 3
)
ORDER BY 
    total_new_passengers DESC;
------------------------------------------------------------------------
-- Business Req 5 : Identify Monthly with Higest Revenue for Each City

WITH CityMonthlyRev AS (
	select
		c.city_name,
        d.month_name,
        sum(fare_amount) as revenue
	From
		fact_trips f 
	inner join 
		dim_city c on c.city_id = f.city_id
	inner join
		dim_date d on d.date = f.date
	Group by 
		c.city_name,d.month_name
),
CityTotalRevenue AS (
	select
		city_name,
        sum(revenue) as total_revenue
	from
		CityMonthlyRev
	Group by
		city_name
)
select
	cmr.city_name,
    cmr.month_name as highest_revenue_month,
    cmr.revenue,
    ROUND((cmr.revenue * 100 / ctr.total_revenue),2) AS perct_contri
FROM
	CityMonthlyRev cmr
Inner join
	CityTotalRevenue ctr on cmr.city_name = ctr.city_name
WHERE
	cmr.revenue = (
		select
			MAX(revenue)
		From
			CityMonthlyRev
		Where
			city_name = cmr.city_name
	)
Order by
	cmr.city_name;
    
----------------------------------------------------
-- Business Req 6 : Repeat Passenger Rate Analysis :

WITH MonthlyStats AS (
    SELECT 
        c.city_name,
        d.month_name AS month,
        SUM(f.total_passengers) AS total_passengers,
        SUM(f.repeat_passengers) AS repeat_passengers,
        ROUND(SUM(f.repeat_passengers) * 100.0 / SUM(f.total_passengers), 2) AS monthly_repeat_passenger_rate
    FROM 
        fact_passenger_summary f
    INNER JOIN 
        dim_city c ON c.city_id = f.city_id
    INNER JOIN 
        dim_date d ON d.start_of_month = f.month
    GROUP BY 
        c.city_name, d.month_name
),
CityStats AS (
	Select
		city_name,
        sum(f.total_passengers) as total_passengers,
        sum(f.repeat_passengers) as repeat_passengers,
        ROUND(SUM(f.repeat_passengers) * 100.0 / SUM(f.total_passengers), 2) AS city_repeat_passenger_rate
	from 
		fact_passenger_summary f
	inner join
    dim_city c ON c.city_id = f.city_id
    group by
	city_name
)
Select 
	m.city_name,
    m.month,
    m.total_passengers,
    m.repeat_passengers,
    m.monthly_repeat_passenger_rate,
    c.city_repeat_passenger_rate
from 
	MonthlyStats m 
inner join
	CityStats c 
on m.city_name = c.city_name
ORDER BY 
    m.city_name, m.month;
        
	