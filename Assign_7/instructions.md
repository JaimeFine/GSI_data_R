Data Visualization

library(dplyr)

library(ggplot2) 

 

flights.file  <- "https://www.cs.utexas.edu/~kiat/datasets/flights.csv"
flights <- read.csv(flights.file, stringsAsFactors = FALSE)

Note: it is a very large dataset, it can take up to 5 min to download the file and read it in your R program. 

If you have issues with this large file, you can alternatively use this file 

 

"https://www.cs.utexas.edu/~kiat/datasets/flights-small.csv.bz2 "

Uncompressed file : "https://www.cs.utexas.edu/~kiat/datasets/flights-small.csv"


The dataset has the following values: 

 |-- YEAR: integer (nullable = true)
 |-- MONTH: integer (nullable = true)
 |-- DAY: integer (nullable = true)
 |-- DAY_OF_WEEK: integer (nullable = true)
 |-- AIRLINE: string (nullable = true)
 |-- FLIGHT_NUMBER: integer (nullable = true)
 |-- TAIL_NUMBER: string (nullable = true)
 |-- ORIGIN_AIRPORT: string (nullable = true)
 |-- DESTINATION_AIRPORT: string (nullable = true)
 |-- SCHEDULED_DEPARTURE: integer (nullable = true)
 |-- DEPARTURE_TIME: integer (nullable = true)
 |-- DEPARTURE_DELAY: integer (nullable = true)
 |-- TAXI_OUT: integer (nullable = true)
 |-- WHEELS_OFF: integer (nullable = true)
 |-- SCHEDULED_TIME: integer (nullable = true)
 |-- ELAPSED_TIME: integer (nullable = true)
 |-- AIR_TIME: integer (nullable = true)
 |-- DISTANCE: integer (nullable = true)
 |-- WHEELS_ON: integer (nullable = true)
 |-- TAXI_IN: integer (nullable = true)
 |-- SCHEDULED_ARRIVAL: integer (nullable = true)
 |-- ARRIVAL_TIME: integer (nullable = true)
 |-- ARRIVAL_DELAY: integer (nullable = true)
 |-- DIVERTED: integer (nullable = true)
 |-- CANCELLED: integer (nullable = true)
 |-- CANCELLATION_REASON: string (nullable = true)
 |-- AIR_SYSTEM_DELAY: integer (nullable = true)
 |-- SECURITY_DELAY: integer (nullable = true)
 |-- AIRLINE_DELAY: integer (nullable = true)
 |-- LATE_AIRCRAFT_DELAY: integer (nullable = true)
 |-- WEATHER_DELAY: integer (nullable = true)

Create at least two of the following Visualization Ideas,

or create your own visualization idea using ggplot2 package. 

You can create facets using any of the categorical variables like Airlines, or Seasons. 

 

1. Boxplot
a. Departure Delay by Day of Week
x-axis: DAY_OF_WEEK (1=Monday, 7=Sunday) y-axis: DEPARTURE_DELAY Plot: Boxplot
Insight: See if certain days consistently have higher delays (e.g., Mondays).

b. Arrival Delay by Airline
x-axis: AIRLINE y-axis: ARRIVAL_DELAY Plot: Boxplot
Insight: Identify which airlines are generally more punctual or delayed.

c. Taxi-Out Time by Origin Airport
x-axis: ORIGIN_AIRPORT (filter to top 10 airports by traffic) y-axis: TAXI_OUT Plot: Boxplot
Insight: Airports with congestion issues will show higher median taxi-out times.

1. Histograms / Distribution Plots
a. Distribution of Departure Delays
x-axis: DEPARTURE_DELAY (bins) y-axis: Frequency Plot: Histogram
Insight: Understand how common short vs. long delays are.

b. Distribution of Flight Distance
x-axis: DISTANCE y-axis: Frequency Plot: Histogram
Insight: Visualize the most frequent flight ranges (e.g., short-haul vs. long-haul).

c. Distribution of Air Time
x-axis: AIR_TIME y-axis: Frequency Plot: Histogram (optionally faceted by airline)
Insight: Look for patterns in how long flights tend to take.

3. Scatterplots
a. Distance vs. Air Time
x-axis: DISTANCE y-axis: AIR_TIME Plot: Scatterplot
Insight: Expect a linear trend — deviations may indicate airspace congestion or routing issues.

b. Scheduled Departure vs. Departure Delay
x-axis: SCHEDULED_DEPARTURE y-axis: DEPARTURE_DELAY Plot: Scatterplot (maybe smoothed line)
Insight: Check if certain times of day have consistently higher delays.

c. Air Time vs. Arrival Delay
x-axis: AIR_TIME y-axis: ARRIVAL_DELAY Plot: Scatterplot
Insight: See if longer flights recover from delays more often than shorter ones.

4. Aggregated Bar/Line Charts
a. Number of Cancellations per Month
x-axis: MONTH y-axis: COUNT where CANCELLED == 1 Plot: Bar chart
Insight: Identify seasonal trends in cancellations.

b. Average Departure Delay per Day of Week
x-axis: DAY_OF_WEEK y-axis: Average(DEPARTURE_DELAY) Plot: Line or bar chart
Insight: Detect weekly rhythm of airport congestion or staffing.

c. Total Flights per Airline
x-axis: AIRLINE y-axis: COUNT(FLIGHT_NUMBER) Plot: Bar chart
Insight: See which airlines operate the most flights.

5. Heatmaps
a. Heatmap of Average Delay by Day and Month
x-axis: DAY y-axis: MONTH Color: Average(ARRIVAL_DELAY) Plot: Heatmap
Insight: Identify hot spots for delays during specific days of the year.

b. Origin-Destination Delay Matrix
x-axis: ORIGIN_AIRPORT (top 10) y-axis: DESTINATION_AIRPORT (top 10) Color: Average(DEPARTURE_DELAY) Plot: Heatmap
Insight: Discover problematic airport pairs.

6. Time Series (if over multiple years)
a. Daily Number of Flights
x-axis: Date (constructed from YEAR, MONTH, DAY) y-axis: COUNT(FLIGHT_NUMBER) Plot: Line chart
Insight: Monitor trends in air traffic volume over time.

b. Daily Average Delay
x-axis: Date y-axis: Mean(DEPARTURE_DELAY or ARRIVAL_DELAY) Plot: Line chart
Insight: Track delay trends, detect disruptions due to weather, holidays, etc.
