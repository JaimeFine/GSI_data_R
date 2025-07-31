library(dplyr)
people <- read.csv("people.csv", header = TRUE)

# Task 1: Calculate the mean, median, first and third quartiles (Q1 and Q3),
# and standard deviation of height and weight for the individuals in the dataset.
mean_height <- mean(people$height)
mean_weight <- mean(people$weight)

median_height <- median(people$height)
median_weight <- median(people$weight)

quantile_height <- quantile(people$height, probs = c(0.25, 0.75))
quantile_weight <- quantile(people$weight, probs = c(0.25, 0.75))

sd_height <- sd(people$height)
sd_weight <- sd(people$weight)

list(
  Mean_Height = mean_height,
  Median_Height = median_height,
  Q1_Height = quantile_height[1],
  Q3_Height = quantile_height[2],
  SD_Height = sd_height,
  
  Mean_Weight = mean_weight,
  Median_Weight = median_weight,
  Q1_Weight = quantile_weight[1],
  Q3_Weight = quantile_weight[2],
  SD_Weight = sd_weight
)

# Task 2: Generate histograms to visualize the distribution of height and
# weight for the individuals in the dataset.
par(mfrow = c(1, 2))

hist(
  people$weight, main = "Weight Histogram",
  xlab = "Weight in Kilograms",
  col = "darkgreen"
)

hist(
  people$height, main = "Height Histogram",
  xlab = "Height in Centieters",
  col = "darkorange"
)

# Task 3: Identify any potential outliers in the dataset for weight.
par(mfrow = c(1, 1))

box <- boxplot(
  people$weight, main = "Weight Boxplot",
  col = "darkcyan", horizontal = TRUE,
  xlab = "Weight in Kilograms"
)
cat("There are", length(box$out), "numbers of outliers.\n")
cat("Outliers are:", box$out)

# Assuming that the height and weight data follow a normal distribution with the mean
# and standard deviation calculated from the dataset, perform the following calculations:

# Task 4: Determine the percentage of individuals taller than 150 cm.
tall.dude <- people %>%
  filter(height > 150)

percentage.tall <- nrow(tall.dude) / nrow(people) * 100
paste0(percentage.tall, "%")

# Task 5: Calculate the percentage of individuals with a weight between 60 kg and 100 kg.
fit.dude <- people %>%
  filter(weight >= 60) %>%
  filter(weight <= 100)

percentage.fit <- nrow(fit.dude) / nrow(people) * 100
paste0(percentage.fit, "%")

# Task 6: Identify the weight range that encompasses 60% of the individuals.
quantile.weight <- quantile(people$weight, probs = c(0.2, 0.8))
cat("60% of individuals have weights between", round(quantile.weight[1], 2),
    "kg and", round(quantile.weight[2], 2), "kg.")

# Task 7: Calculate the height above which 1% of the individuals are taller.
super.tall <- quantile(people$height, probs = 0.99)
cat("Only 1% people are taller than", round(super.tall, 2), ".")

# Task 8: Determine the weight below which 0.05% of the individuals weigh less.
super.light <- quantile(people$weight, probs = 0.05)
cat("Only 0.05% people are lighter than", round(super.light, 2), ".")

# Task 9: Compute the BMI for each individual in the dataset and classify those
# with a BMI greater than 30 as obese.
people$BMI <- people$weight / ((people$height / 100) ^ 2)
summary(people$BMI)

obese <- people %>%
  filter(BMI > 30)
summary(obese$BMI)
print("People obese are")
print(obese)