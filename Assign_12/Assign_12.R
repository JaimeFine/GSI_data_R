data <- read.csv("Canadian-1970-census.csv")
attach(data)

# 1. To get a sense of the data, generate a scatterplot to examine the 
# association between prestige score and years of education. Briefly describe 
# the form, direction, and strength of the association between the variables. 
# Calculate the correlation.  
plot(
  Prestige.Score, Education.Level, 
  main = "Scatterplot of prestige score and education level",
  xlab = "Prestige score", ylab = "Education level",
  pch = 16, col = "darkorange", cex.lab = 1.1, bg = "darkorange"
)

cor(Prestige.Score, Education.Level)

# 2. Perform a simple linear regression. Generate a residual plot. Assess 
# whether the model assumptions are met. Are there any outliers or influence 
# points?  If so, identify them by ID and comment on the effect of each on the 
# regression.
model_1 <- lm(Education.Level ~ Prestige.Score, data = data)
summary(model_1)
# Assumptions are met.

plot(model_1$fitted.values, model_1$residuals,
     main = "Residual Plot",
     xlab = "Fitted Values", ylab = "Residuals",
     pch = 16, col = "steelblue")
abline(h = 0, lty = 2, col = "gray")

qqnorm(model_1$residuals)
qqline(model_1$residuals, col = "red")
# Residuals are approximately normally distributed.

plot(model_1, which = 4)  # Cook's distance plot
# 41, 53, 54 number are influential.

plot(model_1, which = 5)  # Residuals vs leverage
# 54 is an outlier

# 3. Calculate the least squares regression equation that predicts prestige 
# from education, income and percentage of women. Formally test whether the 
# set of these predictors are associated with prestige at the  = 0.05 level.  
multiple_model <- lm(`Prestige Score` ~ `Education Level` + Income + 
                       `Percent of Workforce`, data = data)
anova(multiple_model)

# 4. If the overall model was significant, summarize the information about the 
# contribution of each variable separately at the same significance level as 
# used for the overall model (no need to do a formal 5-step procedure for each 
# one, just comment on the results of the tests). Provide interpretations for 
# any estimates that were significant.   Calculate 95% confidence intervals 
# where appropriate. 
summary(multiple_model)
confint(multiple_model)


# 5. Generate a residual plot showing the fitted values from the regression 
# against the residuals.  Is the fit of the model reasonable?  Are there any 
# outliers or influence points?  
plot(fitted(multiple_model), resid(multiple_model),
     main = "Fitted vs Residuals",
     xlab = "Fitted Values",
     ylab = "Residuals",
     pch = 16, col = "purple")
abline(h = 0, col = "red")
residuals_std <- rstudent(multiple_model)
which(abs(residuals_std) > 2)
influence <- cooks.distance(multiple_model)
canada[which(abs(residuals_std) > 2 | influence > 4 / nrow(canada)),
       c("Occupational Title", "Prestige Score", "Education Level", "Income")]



