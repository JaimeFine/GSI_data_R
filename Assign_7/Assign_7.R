library(ggplot2)
library(dplyr)
data <- read.csv("flights-small.csv", header = TRUE)

# TASK 1: BOXPLOT!!!

# Task 1.a: Departure Delay by Day of Week:
data$DAY_OF_WEEK <- factor(data$DAY_OF_WEEK, levels = 1:7,
                           labels = c("Monday", "Tuesday", "Wednesday", "Thursday",
                                      "Friday", "Saturday", "Sunday"))
data_clean <- data %>%
  filter(!is.na(DAY_OF_WEEK), !is.na(DEPARTURE_DELAY))

ggplot(data_clean, aes(x = DAY_OF_WEEK, y = DEPARTURE_DELAY)) +
  geom_boxplot(fill = "darkorange", color = "black") +
  labs(title = "Distribution of Departure Delay", x = "Weekday", y = "Departure Delay")

# Task 1.b: Arrival(Departure) Delay by Airline:
airline.dep.clean <- na.omit(data[, c("AIRLINE", "DEPARTURE_DELAY")])

ggplot(airline.dep.clean, aes(x = AIRLINE, y = DEPARTURE_DELAY, fill = AIRLINE)) +
  geom_boxplot(color = "black") +
  labs(title = "Departure Delay by Airline", x = "Airline", y = "Departure Delay")

# Task 1.c: Taxi-Out Time by Origin Airport:

#  --skip--


# TASK 2: HISTOGRAMS / DISTRIBUTION PLOTS!!!

# Task 2.a: Distribution of Departure Delays:
ggplot(data_clean, aes(x = DEPARTURE_DELAY)) +
  geom_histogram(binwidth = 5, fill = "darkorange", color = "black") +
  labs(
    title = "Distribution of Departure Delays",
    x = "Departure Delay (min)",
    y = "Frequency"
  )

# Task 2.b: Distribution of Flight Distance:
ggplot(data, aes(x = DISTANCE)) +
  geom_histogram(binwidth = 10, fill = "darkorange", color = "black") +
  labs(
    title = "Distribution of Flight Distance",
    x = "Flight Distance (km)",
    y = "Frequency"
  )

# Task 2.c: Distribution of Air Time(Elapse time):
ggplot(data, aes(x = ELAPSED_TIME)) +
  geom_histogram(binwidth = 5, fill = "darkorange", color = "black") +
  labs(
    title = "Distribution of Elapsed Time",
    x = "Elapsed Time (min)",
    y = "Frequency"
  )


# TASK 3: SCATTERPLOTS!!!

# Task 3.a: Distance vs. Air Time(Elapsed time):
data_fit <- data %>%
  filter(!is.na(DISTANCE), !is.na(ELAPSED_TIME))

ggplot(data_fit, aes(x = DISTANCE, y = ELAPSED_TIME)) +
  geom_point(alpha = 0.5, color = "darkorange") +
  labs(
    title = "Flight Distance vs. Elapsed Time",
    x = "Distance (km)",
    y = "Elasped Time (min)"
  )

# Task 3.b: Scheduled Departure vs. Departure Delay:

# --skip--

# Task 3.c: Air Time(Elapsed time) vs. Arrival Delay(Departure delay):
data_suit <- data_clean %>%
  filter(!is.na(ELAPSED_TIME))

ggplot(data_suit, aes(x = ELAPSED_TIME, y = DEPARTURE_DELAY)) +
  geom_point(alpha = 0.5, color = "darkorange") +
  labs(
    title = "Elasped Time vs. Departure Delay",
    x = "Elapsed Time (min)",
    y = "Departure Delay (min)"
  )


# TASK 4: AGGREGATED BAR / LINE CHARTS!!!

# Task 4.a: Number of Cancellations per Month(day of week):
data_cancelled <- data %>%
  filter(CANCELLED == 1) %>%
  group_by(DAY_OF_WEEK) %>%
  summarize(CANCELLED = n())

ggplot(data_cancelled, aes(x = DAY_OF_WEEK, y = CANCELLED)) +
  geom_bar(stat = "identity", fill = "darkorange") +
  geom_text(aes(label = CANCELLED), vjust = - 0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "Cancellations by Day of Week",
    x = "Day of Week",
    y = "Number of Cancellations"
  )

# Task 4.b: Average Departure Delay per Day of Week:
data_avg <- data %>%
  select(DAY_OF_WEEK, DEPARTURE_DELAY) %>%
  group_by(DAY_OF_WEEK) %>%
  summarize(Avg_Dep_Delay = mean(DEPARTURE_DELAY, na.rm = TRUE))

ggplot(data_avg, aes(x = DAY_OF_WEEK, y = Avg_Dep_Delay)) +
  geom_bar(stat = "identity", fill = "darkorange") +
  geom_text(aes(label = sprintf("%.2f", Avg_Dep_Delay)), vjust = - 0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "Average Departure Delay per Day of Week",
    x = "Day of Week",
    y = "Average Departure Delay"
  )

# Task 4.c: Total Flights per Airline:
data_airline <- data %>%
  select(AIRLINE) %>%
  group_by(AIRLINE) %>%
  summarize(NFlight = n())

ggplot(data_airline, aes(x = AIRLINE, y = NFlight)) +
  geom_bar(stat = "identity", aes(fill = AIRLINE)) +
  geom_text(aes(label = NFlight), vjust = - 0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "Total Flight per Airlines",
    x = "Airline",
    y = "Number of Flights"
  )


# TASK 5: HEATMAPS!!!

# Task 5.a: Heatmap of Average Delay by Day and Month:

# --skip--

# Task 5.b: Origin-Destination Delay Matrix:

# --skip--


# TASK 6: TIME SERIES(if not over multiple days)!!!

# Task 6.a: Daily Number of Flights:
data_air_traffic <- data %>%
  group_by(DAY_OF_WEEK) %>%
  summarize(NFlight = n())

ggplot(data_air_traffic, aes(x = DAY_OF_WEEK, y = NFlight, group = 1)) +
  geom_line(color = "darkorange", size = 1.2) +
  geom_point(color = "black", size = 3) +
  labs(
    title = "Flight Volume by Day of Week",
    x = "Day of Week",
    y = "Number of Flights"
  )

# Task 6.b: Daily Average Delay:
ggplot(data_avg, aes(x = DAY_OF_WEEK, y = Avg_Dep_Delay, group = 1)) +
  geom_line(color = "darkorange", size = 1.2) +
  geom_point(color = "black", size = 3) +
  labs(
    title = "Flight Volume by Day of Week",
    x = "Day of Week",
    y = "Average Departure Delay"
  )