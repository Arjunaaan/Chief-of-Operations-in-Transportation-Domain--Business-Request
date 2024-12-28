# Chief-of-Operations-in-Transportation-Domain--Business-Request

## Overview
This repository contains a collection of SQL queries created to address various business requests. These queries are designed for data analysis, reporting, and decision-making, tailored to specific scenarios such as identifying trends, calculating metrics, and generating insights.

## Table of Contents
1. [Queries Included](#queries-included)
2. [Database Structure](#database-structure)

## Queries Included
The repository includes SQL scripts to solve the following business requests:

1. **City-Level Repeat Passenger Trip Frequency Report**
   - Calculates the percentage distribution of repeat passengers by trip counts (2 to 10 trips) for each city.

2. **Top and Bottom Cities by New Passengers**
   - Identifies the top 3 and bottom 3 cities based on the total number of new passengers.

3. **Monthly and Overall Repeat Passenger Rate**
   - Computes the monthly repeat passenger rate and overall repeat passenger rate for each city.

4. **City and Month with Highest Revenue**
   - Determines the month with the highest revenue for each city and its percentage contribution to the city's total revenue.

5. **City-level Fare and Trip Summary Report**
   - Assess Trip Volume,pricing Efficiency, and each city contribution to overall trip count

## Database Structure
The queries are written for a database with the following key tables:

- **`fact_trips`**: Contains detailed trip-level data, including fare amount, distance traveled, and passenger type.
- **`dim_city`**: Stores metadata about cities, including city IDs and names.
- **`dim_date`**: Provides calendar-related details such as month names and start dates of months.
- **`fact_passenger_summary`**: Aggregates passenger data at the city and month level, including total passengers and repeat passengers.
- **`dim_repeat_trip_distribution`**: Tracks repeat passenger counts by trip frequency for each city and month.
