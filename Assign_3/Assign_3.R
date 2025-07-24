customers <- read.csv("Credit.csv", header=TRUE)

# Task 1: Calculate the median income for male and female customers in the dataset. 
# Is there a difference between the two groups in this sample dataset?
female.customers <- customers[customers$Gender == "Female", ]
male.customers <- customers[customers$Gender == " Male", ]

female.median <- median(female.customers$Income)
male.median <- median(male.customers$Income)

female.median
male.median

# Task 2: Create separate histograms showing the income distribution for male and female customers. 
# Compare the two histograms and interpret your findings.
par(mfrow = c(1, 2))

hist(
  female.customers$Income,
  main = "Income of Female Customers",
  xlab = "Income",
  col = "darkred",
  freq = FALSE
)

hist(
  male.customers$Income,
  main = "Income of Male Customers",
  xlab = "Income",
  col = "darkblue",
  freq = FALSE
)

# Task 3: Do different ethnic groups in the dataset have different average education levels?
asian <- customers[customers$Ethnicity == "Asian", ]
african.american <- customers[customers$Ethnicity == "African American", ]
caucasian <- customers[customers$Ethnicity == "Caucasian", ]

asian.edu <- mean(asian$Education)
african.american.edu <- mean(african.american$Education)
caucasian.edu <- mean(caucasian$Education)

asian.edu
african.american.edu
caucasian.edu

# Task 3.1: Do Students have higher number of Education years? 
student.customers <- customers[customers$Student == "Yes", ]
adult.customers <- customers[customers$Student == "No", ]

student.edu <- mean(student.customers$Education)
adult.edu <- mean(adult.customers$Education)

student.edu
adult.edu

# Task 3.2: Do People with more that 10 years of education have a higher balance on their account?
longedu.customers <- customers[customers$Education > 10, ]
shortedu.customers <- customers[customers$Education <= 10, ]

longedu.balance <- mean(longedu.customers$Balance)
shortedu.balance <- mean(shortedu.customers$Balance)

longedu.balance
shortedu.balance

# Task 4: Do people older than 50 years have a higher average income compared to the rest of the dataset?
old.customers <- customers[customers$Age > 50, ]
young.customers <- customers[customers$Age <= 50, ]

old.income <- mean(old.customers$Income)
young.income <- mean(young.customers$Income)

old.income
young.income

# Task 5: Do people younger than 30 years old have more credit cards on average?
old.cus.cards <- customers[customers$Age > 30, ]
young.cus.cards <- customers[customers$Age <= 30, ]

old.cards <- mean(old.cus.cards$Cards)
young.cards <- mean(young.cus.cards$Cards)

old.cards
young.cards

# Task 6: Do different ethnic groups have different average incomes?
asian.income <- mean(asian$Income)
african.american.income <- mean(african.american$Income)
caucasian.income <- mean(caucasian$Income)

asian.income
african.american.income
caucasian.income