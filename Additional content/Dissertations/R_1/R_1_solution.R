# BMI calculation ----
94/(1.95^2)
# Waist to Hip calculation ----
90/107

# Using variables ----
# prepare variables
andrew_height <- 1.95
andrew_weight <- 94
seb_height <- 1.71
seb_weight <- 68

# do calculations and print
andrew_bmi <- andrew_weight/(andrew_height^2)
andrew_bmi
seb_bmi <- seb_weight/(seb_height^2)
seb_bmi

# make nice string
paste0("Andrew has a BMI of ", andrew_bmi, ", and Seb has a BMI of ", seb_bmi)

# numbers are long, we can use a function to round...
paste0("Andrew has a BMI of ", round(andrew_bmi, 2), ", and Seb has a BMI of ", round(seb_bmi, 2))

# Using vectors ----
family_names <- c("Andrew", "Sam (Mum)", "Jules (Dad)", "Ash", "Robin")
family_heights <- c(1.95, 5.09, 1.65, 1.91, 186)
family_weights <- c(94, 9.135, 9.6075, 89, 81)

# number index method
family_heights[2] <- family_heights[2] * 0.3048
family_heights[5] <- family_heights[5] / 100
family_weights[2:3] <- family_weights[2:3] * 6.35029318

family_heights
family_weights

# conditional index method 1 using numeric conditions
family_heights <- c(1.95, 5.09, 1.65, 1.91, 186)
family_weights <- c(94, 9.135, 9.6075, 89, 81)

family_heights[family_heights > 7] <- family_heights[family_heights > 7] / 100
family_heights[family_heights > 3 & family_heights < 7] <- family_heights[family_heights > 3 & family_heights < 7] * 0.3048
family_weights[family_weights < 40] <- family_weights[family_weights < 40] * 6.35029318

# conditional index method 2 using names
family_heights <- c(1.95, 5.09, 1.65, 1.91, 186)
family_weights <- c(94, 9.135, 9.6075, 89, 81)
names(family_heights) <- family_names # add names to the vector
names(family_weights) <- family_names 

family_heights[names(family_heights) == "Sam (Mum)"] <- family_heights[names(family_heights) == "Sam (Mum)"] * 0.3048
family_heights[names(family_heights) == "Robin"] <- family_heights[names(family_heights) == "Robin"] / 100
family_weights[names(family_weights) == "Sam (Mum)" | names(family_weights) == "Jules (Dad)"] <- 
  family_weights[names(family_weights) == "Sam (Mum)" | names(family_weights) == "Jules (Dad)"] * 6.35029318

# BMI calculation + average
family_bmi <- family_weights/(family_heights^2)
avg_bmi <- mean(family_bmi)

family_bmi
avg_bmi

# Using data frames ----
family_data <- data.frame(
  family_names,
  family_heights,
  family_weights,
  family_bmi
)

family_data

write.csv(
  # data we are writing out
  family_data,
  # where we are saving the data
  "Additional content/Dissertations/R_dissertation_1/family_data.csv",
  # removing index/row labels
  row.names = FALSE)

summary(family_data)
str(family_data)

hist(family_data$family_bmi, 
     col = "purple4",
     main = "Histogram of family bmi",
     xlab = "BMI")

