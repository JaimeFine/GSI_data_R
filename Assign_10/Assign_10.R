library(dplyr)
library(ggplot2)
library(gridExtra)

heart_data <- read.csv("heart.csv", header = TRUE)

# Task 1: Summarize the data by each feature. Use an appropriately labelled 
# table to show the results. Also include a graphical presentation that shows 
# the distribution of Cholesterol  for participants vs. non-participants. 
# Describe the shape of each distribution. Use R to calculate the quantities 
# and generate the visual summaries. (2 points)
summary_table <- summary(heart_data)
print(summary_table)

participant <- heart_data %>%
  filter(target == "1")

non_participant <- heart_data %>%
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

# Task 2: Does the mean cholestoral level is less than 250? Formally test at the
# alpha = 0.05 level using the 5 steps outlined in the last lecture. (6 points)
if (mean(heart_data$chol) < 250) {
  print("The mean of cholestrol level is less than 250!")
} else {
  print("The mean of cholestrol level is not less than 250!")
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






