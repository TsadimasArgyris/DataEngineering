#---------------------------------------------------#
# Purpose     Data Engineering Homework 1
#
# Author      Tsadimas Anargyros
#
# Date        May 2024
#---------------------------------------------------#
getwd()
# Load necessary libraries
library(ggplot2)

# Load the data
data <- read.csv("Weights_and_Heights_Data.csv")
data
# Plot the scatter plot
ggplot(data, aes(x = Weight, y = Height)) +
  geom_point() +
  labs(title = "Scatter Plot of Height vs Weight",
       x = "Weight (kg)",
       y = "Height (cm)") +
  theme_minimal()

# Perform simple linear regression
model <- lm(Height ~ Weight, data = data)
summary(model)

# Extract parameter estimates and their standard errors
params <- summary(model)$coefficients
params_df <- data.frame(
  Parameter = rownames(params),
  Estimate = params[, "Estimate"],
  StdError = params[, "Std. Error"]
)

# Save the parameters to a CSV file
sample_size <- nrow(data)
date_str <- format(Sys.Date(), "%Y%m%d")
output_filename <- sprintf("params_%s_n%d.csv", date_str, sample_size)
write.csv(params_df, file = output_filename, row.names = FALSE)
