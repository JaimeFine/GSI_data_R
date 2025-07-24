# This is the code for the Assignment 2

credit <- read.csv("Credit.csv", header=TRUE)

# Task 1: Create separate histograms for all quantitative variables and describe the shape of each distribution. 
# This will help understand the underlying patterns and characteristics of the dataset.
par(mfrow = c(3, 3), mar = c(3, 3, 2, 1))

hist(
  credit$Income, main="Income",
  xlab="Income in dollars",
  col="darkgreen",
  freq=FALSE
)

hist(
  credit$Limit, main="Limit",
  xlab="Income in dollars",
  col="darkblue",
  freq=FALSE
)

hist(
  credit$Rating, main="Rating",
  xlab="Income in dollars",
  col="grey",
  freq=FALSE
)

hist(
  credit$Cards, main="Cards",
  xlab="Income in dollars",
  col="darkcyan",
  freq=FALSE
)

hist(
  credit$Age, main="Age",
  xlab="Income in dollars",
  col="darkmagenta",
  freq=FALSE
)

hist(
  credit$Education, main="Education",
  xlab="Income in dollars",
  col="orange",
  freq=FALSE
)

hist(
  credit$Balance, main="Balance",
  xlab="Income in dollars",
  col="white",
  freq=FALSE
)

# Task 2: Generate a pie chart to visualize the ethnic distribution of customers in the dataset. 
# This will enable a quick view of the customer diversity within the dataset.
ethnicity <- c("Asian", "Caucasian", "African American")

pie(table(credit$Ethnicity), main = "Ethnicity Distribution")

# Task 3: Identify any potential outliers in customer income using a boxplot. 
# This will help us understand if there are extreme income values in our dataset, which can affect our analysis.
boxplot(
  credit$Income, main = "Income Boxplot",
  xlab = "Income",
  col = "darkgreen", horizontal=TRUE
)

