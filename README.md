# Chief-of-Operations-in-Transportation-Domain--Business-Request

## Overview
This repository contains a collection of SQL queries created to address various business requests. These queries are designed for data analysis, reporting, and decision-making, tailored to specific scenarios such as identifying trends, calculating metrics, and generating insights.

## Table of Contents
1. [Queries Included](#queries-included)
2. [Database Structure](#database-structure)
3. [Usage Instructions](#usage-instructions)
4. [Contributing](#contributing)

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


## Usage Instructions
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/your-username/repository-name.git
   ```

2. Navigate to the repository directory:
   ```bash
   cd repository-name
   ```

3. Import the database schema and data into your SQL environment.

4. Execute the desired SQL scripts using your preferred SQL client.

## Contributing
Contributions are welcome! If you have additional queries or improvements to suggest, please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-branch-name
   ```
3. Make your changes and commit them:
   ```bash
   git commit -m "Describe your changes"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-branch-name
   ```
5. Open a pull request in the original repository.

---

For any issues or questions, please open an issue in the repository. Happy querying!

