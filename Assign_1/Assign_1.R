# Task -1  Save the data to a CSV file and read into R for analysis.
dataset <- read.csv("dataset.csv", header=FALSE)

# Task - 2 Make a histogram of the duration of days of hospital stays.  
# Ensure the histogram is labelled appropriately.  Use a width of 1 day.  
# Describe the shape center and spread of the data.  
# Are there any outliers?
hist(dataset$V1,
     breaks = seq(min(dataset$V1), max(dataset$V1), by = 1),
     main = "COVID-19 Hospital Stay Durations",
     xlab = "Duration of Hospital Stay (Days)",
     ylab = "Number of Patients",
     col = "black",
     border = "white")

# Task - 3 Find the mean, median, standard deviation, first and third quartiles, minimum and maximum of the durations of hospital stay in the sample. 

# Summarize these values in a table that you create in your report. Describe the values.

# - Given the shape of the distribution, what is the best single number summary of the center of the distribution?
  
#   What is the best single number summary of the spread of the distribution?
mean_val <- mean(dataset$V1)
median_val <- median(dataset$V1)
sd_val <- sd(dataset$V1)
quantiles <- quantile(dataset$V1)
min_val <- min(dataset$V1)
max_val <- max(dataset$V1)

summary_table <- data.frame(
  Statistic = c("Mean", "Median", "Std. Dev", "Q1", "Q3", "Min", "Max"),
  Value = c(mean_val, median_val, sd_val, quantiles[2], quantiles[4], min_val, max_val)
)

print(summary_table)

# Task  - 4:  Make a Boxplot of the duration of days of hospital stays.  Ensure the Boxplot is labelled appropriately.
boxplot(dataset$V1,
        main = "COVID-19 Hospital Stay Durations",
        ylab = "Duration (Days)",
        col = "darkgreen",
        horizontal = TRUE)

