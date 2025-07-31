library(dplyr)
library(ggplot2)
library(gridExtra)

data <- read.csv("data.csv")

# (1) Summarize the data by whether children participated in the meal preparation 
# or not. Use an appropriately labelled table to show the results. Also include
# a graphical presentation that shows the distribution of calories for participants
# vs. non-participants. Describe the shape of each distribution and comment on 
# the similarity (or lack thereof) between the distributions in each population.
participant <- data %>%
  filter(Participant == "1")
non_participant <- data %>%
  filter(Participant == "0")

aggregate(CalorieIntake ~ Participant, data, summary)

p1 <- ggplot(participant, aes(x = CalorieIntake)) +
  geom_histogram(binwidth = 25, fill = "darkorange", color = "black") +
  labs(
    title = "The Distribution of Calorie Intake for Participants",
    x = "Calorie Intake in cal",
    y = "Frequency"
  )

p2 <- ggplot(non_participant, aes(x = CalorieIntake)) +
  geom_histogram(binwidth = 25, fill = "darkorange", color = "black") +
  labs(
    title = "The Distribution of Calorie Intake for Non-Participants",
    x = "Calorie Intake in cal",
    y = "Frequency"
  )

grid.arrange(p1, p2, ncol = 1)

# (2) Does the mean calorie consumption for those who participated in the meal 
# preparation differ from 425? Formally test at the level using the 5 steps 
# outlined in the module.

# Step 1: State the hypothesis:
# H0: mu = 425 (calorie intake for participants in the meal preparation is 425)
# H1: mu != 425 (calorie intake for participants in the meal preparation isn't 425)

# Step 2: Choose the significance level:
# alpha = 0.05

# Step 3: Compute the test statistic:
# Perform one-sample t-test:
t.test(data$CalorieIntake[data$Participant == 1], mu = 425)

# Step 4: Decision rule:
# Compare the p_value with the alpha

# Step 5: Conclusion:
# Failed to reject the null hypothesis!
print(
  "There is insufficient evidence to conclude that the mean calorie intake differs from 425."
)

# (3) Calculate a 90% confidence interval for the mean calorie intake for participants 
# in the meal preparation. Interpret the confidence interval.
sample_mean = mean(participant$CalorieIntake)
sample_sd = sd(participant$CalorieIntake)
sample_size = nrow(participant)
df <- sample_size - 1
t_critical <- qt(0.95, df)
margin_error <- t_critical * (sample_sd / sqrt(sample_size))

CI_lower <- sample_mean - margin_error
CI_upper <- sample_mean + margin_error

c(CI_lower, CI_upper)

cat(
  "We are 90% confident that the true mean calorie intake for participants in the",
  "meal preparation falls between",
  CI_lower, "and", CI_upper, "calories."
)

# (4) Formally test whether or not participants consumed more calories than 
# non-participants at the level using the 5 steps outlined in the module.
# AND
# (5) Are the assumptions of the test used in (4) met? How do you know?

# Step 1: State the hypothesis:
# H0: mu1 = mu2 (the mean of calorie intake for both categories are the same)
# H0: mu1 > mu2 (the mean of participant is bigger than non-participant)

# Step 2: Choose the significance level:
# alpha = 0.05

# Step 3: Compute the test statistic:
t.test(participant, non_participant, alternative = "greater", var.equal = FALSE)

# Step 4: Decision rule:
# Compare the p_value with alpha

# Conclusion:
# Failed to reject the null hypothesis!
cat(
  "At the 0.05 significance level, we failed to reject the null hypothesis.",
  "The p-value was greater than 0.05, indicating that the observed difference",
  "in calorie intake between participants and non-participants is not",
  "statistically significant. Thus, we do not have sufficient evidence to",
  "conclude that participants consumed more calories than non-participants."
)