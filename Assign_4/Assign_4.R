library(dplyr)

data <- read.csv("HoustonAirline.csv", header=TRUE, stringsAsFactors=FALSE)

# Task 1: Number of United Airline Flights in the Dataset
# Determine the number of flights operated by United Airlines in the given dataset.
united.airline <- filter(
  data, UniqueCarrier == "UA"
)

ua.number <- nrow(united.airline)

cat(
  "We have", ua.number, "United Airline flights!"
)

# Task 2: Comparison of United and American Airline Weekend Flights
# Compare the number of United Airlines flights on weekends to the number of American Airlines flights on weekends.
american.airline <- filter(
  data, UniqueCarrier == "AA"
)

aa.number <- nrow(american.airline)

aa.weekends <- filter(
  american.airline, DayOfWeek == 6 | DayOfWeek == 7
)

ua.weekends <- filter(
  united.airline, DayOfWeek == 6 | DayOfWeek == 7
)

cat(
  "UA's weekends flights", nrow(ua.weekends)
)
cat(
  "AA's weekends flights", nrow(aa.weekends)
)

if (nrow(ua.weekends) > nrow(aa.weekends)) {
  print("UA flights on weekends are larger!")
} else if (nrow(ua.weekends) == nrow(aa.weekends)) {
  print("Both flights on weekends are the same!")
} else {
  print("AA flights on weekends are larger!")
}

# Task 3: Largest Departure Delay
# Identify the flight with the longest departure delay in the dataset.
max.delay <- data %>% slice_max(order_by = DepDelay, n = 1)

print("The flight with the longest departure delay flight is:")
print(max.delay)

# Task 4: Shortest Flight
# Determine the flight with the shortest duration in the dataset.
min.airtime <- data %>% slice_min(order_by = AirTime, n = 1)

print("The flight with the shortest duration:")
print(min.airtime)

# Task 5: Longest and Shortest Taxi In Times
# Find the flights with the longest and shortest Taxi In times in the dataset.
max.intaxi <- data %>% slice_max(order_by = TaxiIn, n = 1)
min.intaxi <- data %>% slice_min(order_by = TaxiIn, n = 1)

print("The flights with the longest Taxi In time:")
print(max.intaxi)
print("The flights with the shortest Taxi In time:")
print(min.intaxi)
