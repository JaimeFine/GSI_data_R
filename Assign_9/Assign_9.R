library(ggplot2)

# (1) Save the data to a excel or CSV file and read into R for analysis. (2 points)
stay <- read.csv("stay.csv", header = FALSE)

# (2) Make a histogram of the duration of days of hospital stays.  
# Ensure the histogram is labelled appropriately. Use a width of 1 day.  
# Describe the shape center and spread of the data. Are there any outliers? (7 points)
ggplot(stay, aes(x = V1)) +
  geom_histogram(binwidth = 1, fill = "darkorange", color = "black") +
  labs(
    title = "Duration of Days of Hospital Stays",
    x = "Duration in Days",
    y = "Frequency"
  )

# (3) Find the mean, median, standard deviation, first and third quartiles, minimum and 
# maximum of the duration of hospital stays in the sample.  Summarize these values in a 
# table that you create in EXCEL or WORD. In other words, do *not* simply copy and paste
# R output. Given the shape of the distribution, what is the best single number summary 
# of the center of the distribution?  What is the best single number summary of the spread 
# of the distribution? (6 points)
mean <- mean(stay$V1)
median <- median(stay$V1)
sd <- sd(stay$V1)
quantile <- quantile(stay$V1, probs = c(0.25, 0.75))
min <- min(stay$V1)
max <- max(stay$V1)

summary(stay)

#  (4) Assume that the literature on this topic suggests that the distribution of days
# of hospital stay are normally distributed with a mean of 5 and a standard deviation of 3.
# Use R to determine the probabilities below based on the normal distribution:
sug_mean <- 5
sug_sd <- 3

# (a) What percentage of patients are in the hospital for less than a week? (2 points)
less_week <- round(pnorm(7, sug_mean, sug_sd) * 100, digits = 2)
less_week_format <- paste0(less_week, "%")
cat(
  "The percentage of patients are in the hospital for less than a week is",
  less_week_format
)

# (b) Recent publications have indicated that hyper virulent strains of C. Difficulties are 
# on the rise. Such strains are associated with poor outcomes, including extended hospital
#stays. An investigator is interested in showing that the average hospital stay durations 
# have increased versus published literature. He has a sample of 10 patients from his 
# hospital. If the published data are consistent with the truth, what is the probability 
# that the sample mean in his sample will be greater than 7 days? (3 points)
n <- 10
sample_mean <- 7

sem <- sug_sd / sqrt(n)
z <- (sample_mean - sug_mean) / sem
p_value <- 1 - pnorm(z)
prob <- paste0(round(p_value * 100, digits = 2), "%")

cat(
  "The probability that the sample mean in his sample will be greater than 7 days is", prob
)

