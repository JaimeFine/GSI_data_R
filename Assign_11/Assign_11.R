library(dplyr)
library(ggplot2)
library(gridExtra)
heart <- read.csv("heart.csv", header = TRUE)

# Task 1: Summarize the data by each feature. Use an appropriately labelled 
# table to show the results. Also include a graphical presentation that shows 
# the distribution of Cholesterol  for participants vs. non-participants. 
# Describe the shape of each distribution. Use R to calculate the quantities 
# and generate the visual summaries. (2 points)
summary_table <- summary(heart)
print(summary_table)

participant <- heart %>%
  filter(target == "1")

non_participant <- heart %>%
  filter(target == "1")


p1 <- ggplot(participant, aes(x = chol)) +
  geom_histogram(binwidth = 5, fill = "darkorange", color = "black") +
  labs(
    title = "The Distribution of Cholestrol for Participants",
    x = "Serum Cholestoral in mg/dl",
    y = "Frequency"
  )

p2 <- ggplot(non_participant, aes(x = chol)) +
  geom_histogram(binwidth = 5, fill = "darkorange", color = "black") +
  labs(
    title = "The Distribution of Cholestrol for Non-Participants",
    x = "Serum Cholestoral in mg/dl",
    y = "Frequency"
  )

grid.arrange(p1, p2, ncol = 1)

# Task 2: Does the mean cholesterol level is less than 250? Formally test at the
# alpha = 0.05 level using the 5 steps outlined in the last lecture. (6 points)
if (mean(heart$chol) < 250) {
  print("The mean of cholesterol level is less than 250!")
} else {
  print("The mean of cholesterol level is not less than 250!")
}

# Step 1: Set up the hypotheses and select alpha level:
# H0: Mean cholesterol is equal between groups
# H1: Mean cholesterol is different
alpha <- 0.05

# Step 2: Select the appropriate test statistic:
# We are using the independent samples t-test
test_result <- t.test(participant$chol, non_participant$chol)

# Step 3: State the decision rule:
# If p-value < alpha, reject H0

# Step 4: Compute the test statistic and associated p-value:
test_p <- test_result$p.value
print(test_result)

# Step 5: State the conclusion
if (test_p < alpha) {
  cat("The p-value:", test_p, "is less than alpha:", alpha, "\n")
  print("Reject the null hypothesis.")
  print("Mean cholesterol levels differ between groups.")
} else {
  cat("The p-value:", test_p, "is greater than alpha:", alpha, "\n")
  print("Fail to reject the null hypothesis.")
  print("Mean cholesterol levels are equal between groups.")
}

# Task 3: Calculate a 90% confidence interval for the mean cholesterol. 
# Interpret the confidence interval. 
sample.mean <- mean(heart$chol)
sample.sd <- sd(heart$chol)
sample.size <- nrow(heart)
df <- sample.size - 1
t.critical <- qt(0.95, df)

margin.error <- t.critical * (sample.sd / sqrt(sample.size))

conf.inter.lower <- sample.mean - margin.error
conf.inter.upper <- sample.mean + margin.error

cat(
  "We are 90% confident that the true mean cholesterol level falls between",
  conf.inter.lower, "and", conf.inter.upper, "mg/dl."
)

# Task 4: Formally test that resting blood pressure level is less than 130 at 
# the alpha = 0.05 level using the 5 steps outlined in our last class. 
# Task 4: Formally test that resting blood pressure level is less than 130
# using the 5-step hypothesis testing approach at α = 0.05

# Step 1: State the Hypotheses
# H0 (null hypothesis): The mean resting blood pressure μ ≥ 130
# H1 (alternative hypothesis): The mean resting blood pressure μ < 130

# Step 2: Set the Significance Level
# Significance level (alpha) is set to 0.05

# Step 3: Compute the Test Statistic
bp_test <- t.test(heart$trestbps, mu = 130, alternative = "less")

# Step 4: Make a Decision
# Compare the p-value to alpha:
# If p-value < 0.05, reject H0
# If p-value ≥ 0.05, fail to reject H0

# Step 5: State the Conclusion
# Interpret the result in context:
# If H0 is rejected, conclude there is significant evidence
# that the mean resting blood pressure is less than 130

# Output the test results
cat("Test statistic (t):", bp_test$statistic, "\n")
cat("Degrees of freedom:", bp_test$parameter, "\n")
cat("P-value:", bp_test$p.value, "\n")
cat("Confidence Interval:", bp_test$conf.int, "\n")
cat("Sample mean:", bp_test$estimate, "\n")

# Task 5: Calculate a 95% confidence interval for the resting blood pressure.  
# Interpret the confidence interval. 
trestbps.mean <- mean(heart$trestbps)
trestbps.sd <- sd(heart$trestbps)
t.critical.trestbps <- qt(0.975, df)

margin.error.trestbps <- t.critical.trestbps * (trestbps.sd / sqrt(sample.size))

conf.inter.lower.bps <- trestbps.mean - margin.error.trestbps
conf.inter.upper.bps <- trestbps.mean + margin.error.trestbps

cat(
  "We are 90% confident that the true mean resting blood pressure falls between",
  conf.inter.lower.bps, "and", conf.inter.upper.bps, "mmHg."
)

# Task 6: Are the cholesterol level of the two groups with target 1 or 0 different? 
# (Is it bigger, less or equal?) 
t.test(heart$chol[heart$target==1], heart$chol[heart$target==0])

# Task 7: Are resting blood pressure level of the two groups with target 1 or 0 
# different?  (Is it bigger, less or equal?) 
t.test(heart$trestbps[heart$target==1], heart$trestbps[heart$target==0])

# Task 8: Are the fasting blood sugar level of the two groups with target 1 or 0 
# different?  (Is it bigger, less or equal?) 
t.test(heart$fbs[heart$target==1], heart$fbs[heart$target==0])

# Task 9: Are the maximum heart rate level of the two groups with target 1 or 0 
# different?  (Is it bigger, less or equal?) 
t.test(heart$thalach[heart$target==1], heart$thalach[heart$target==0])
