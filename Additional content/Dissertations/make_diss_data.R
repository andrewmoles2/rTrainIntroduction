library(PostcodesioR)
library(tidyverse)
library(writexl)
library(readxl)
library(PostcodesioR)
#random_postcode("SE1")$codes$lsoa

# create randomly generated GP health check dataset ----
make_health_check <- function(n = 500, 
                              year = 2023, 
                              seed = 2023) {
  
  set.seed(seed)
  
  index <- sample(1:nrow(ukbabynames::ukbabynames), size = n, replace = TRUE)
  uk_sample <- ukbabynames::ukbabynames[index, ]
  name <- uk_sample$name |> stringr::str_to_title()
  sex <- uk_sample$sex
  n_people <- length(name)
  z1_boroughs <- c("Camden", "City of London", "Westminster", 
                   "Southwark", "Lambeth", "Tower Hamlets",
                   "Islington", "Hackney")
  age <- round(runif(n_people, min = 16, max = 80), 0)
  #age <- round(rnorm(n_people, mean = 30, sd = 15), 0)
  heights_m <- rnorm(n_people, mean = 1.65, sd = 0.15)
  heights_ft <- rnorm(n_people, mean = 5.7, sd = 0.25)
  heights_cm <- rnorm(n_people, mean = 165, sd = 15)
  weights_kg <- rnorm(n_people, mean = 65, sd = 12.5)
  #weights_pounds <- rnorm(n_people, mean = 165, sd = 20)
  weights_stone <- rnorm(n_people, mean = 10.5, sd = 1.5)
  occupation <- c("Education", "Finance", "Office support/administration", 
                  "Construction", "Tech", "Health", "Research", 
                  "Hospitality", "Service", "Legal", 
                  "Arts and Entertainment", "Law enforcement", 
                  "Management", "Business", "Applied Sciences", 
                  "Sport", "Goverment", "Sales", "Transport", 
                  "Trades", "Agriculture" ,"Production")
  # generates occupations, some with two (15% of respondents)
  results <- replicate(n_people, {
    if (sample(1:n_people, 1) > n_people * (85 / 100)) {
      paste0("[", sample(occupation, 1), ", ", sample(occupation, 1), "]")
    } else {
      sample(occupation, 1)
    }
  }, simplify = TRUE)
  # adds a small amount of NA values to occupation and age
  results[sample(1:n_people, n_people - n_people * (99 / 100))] <- NA
  age[sample(1:n_people, n_people - n_people * (99 / 100))] <- NA
  
  health_check <- data.frame(
    name = name,
    sex = sex,
    age = age,
    location = sample(x = z1_boroughs, size = n_people, replace = TRUE),
    height = round(sample(c(heights_cm, heights_ft, heights_m), size = n_people, replace = TRUE), 2),
    weight = round(sample(c(weights_kg, weights_stone), size = n_people, replace = TRUE), 2),
    waist = round(rnorm(n_people, mean = 80, sd = 5), 2),
    hip = round(rnorm(n_people, mean = 95, sd = 5), 2),
    systolic_pressure = round(rnorm(n_people, mean = 120, sd = 15), 0),
    diastolic_pressure = round(rnorm(n_people, mean = 80, sd = 8), 0),
    year_checked = rep(year, n_people),
    occupation = results
  )
  
  return(health_check)
  
}

# test
make_health_check()[1:5, ]
make_health_check(year = 2024, seed = 2024)[1:5, ]

# Make second dataset for joining is IMD2019 ----
# prep here for randomly pulling values and adding to dataset. 
imd <- read_xlsx("Additional content/Dissertations/R_dissertation_2/IMD2019.xlsx", sheet = 2) |>
  janitor::clean_names()

match_table <- c("Camden", "City of London", "Westminster", 
                 "Southwark", "Lambeth", "Tower Hamlets",
                 "Islington", "Hackney")

imd_central <- imd |>
  filter(local_authority_district_name_2019 %in% match_table)

# create and save datasets ----
# making a few health check datasets joined together
df1 <- make_health_check(n = sample(400:750, 1))
df2 <- make_health_check(n = sample(400:750, 1), year = 2024, seed = 2024)
df3 <- make_health_check(n = sample(400:750, 1), year = 2022, seed = 2022)
df4 <- make_health_check(n = sample(400:750, 1), year = 2021, seed = 2021)
df5 <- make_health_check(n = sample(400:750, 1), year = 2020, seed = 2020)

df <- rbind(df1, df2, df3, df4, df5)

# add lsoa information - make sure it matches location
lsoa_code <- ifelse(df$location == match_table[1], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[1], ]$lsoa_code_2011,
                                       size = nrow(df[df$location == match_table[1],]), replace = TRUE),
       ifelse(df$location == match_table[2], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[2], ]$lsoa_code_2011,
                                                    size = nrow(df[df$location == match_table[2],]), replace = TRUE),
              ifelse(df$location == match_table[3], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[3], ]$lsoa_code_2011,
                                                           size = nrow(df[df$location == match_table[3],]), replace = TRUE),
                     ifelse(df$location == match_table[4], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[4], ]$lsoa_code_2011,
                                                                  size = nrow(df[df$location == match_table[4],]), replace = TRUE),
                            ifelse(df$location == match_table[5], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[5], ]$lsoa_code_2011,
                                                                         size = nrow(df[df$location == match_table[5],]), replace = TRUE),
                                   ifelse(df$location == match_table[6], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[6], ]$lsoa_code_2011,
                                                                                size = nrow(df[df$location == match_table[6],]), replace = TRUE),
                                          ifelse(df$location == match_table[7], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[7], ]$lsoa_code_2011,
                                                                                       size = nrow(df[df$location == match_table[7],]), replace = TRUE),
                                                 ifelse(df$location == match_table[8], sample(imd_central[imd_central$local_authority_district_name_2019 == match_table[8], ]$lsoa_code_2011,
                                                                                              size = nrow(df[df$location == match_table[8],]), replace = TRUE), "Unknown"))))))))

df$lsoa_code <- lsoa_code

df <- df |>
  select(name:location, lsoa_code, everything())

# write out data for students to use
write.csv(df, "Additional content/Dissertations/R_dissertation_2/health_metrics.csv", row.names = FALSE)


# cleaned data for comparison and goal ----
# tidy up the weights and heights - weights should be kg and heights to be m
# if height is > 8 assume it is cm and divide by 100
# if height is > 4 and < 8 assume it is in feet and times by 0.3048
# if weight is < 25 assume in stone so divide by 0.1575
health_check_clean <- transform(df,
                                height_m = ifelse(height > 8, height / 100,
                                                  ifelse(height > 4 & height < 8, 
                                                         height * 0.3048, 
                                                         height)),
                                weight_kg = ifelse(weight < 25, weight / 0.1575, weight)
)
# make new columns in the health check dataset with your calculations for each person (BMI, WHR, Blood pressure)
health_check_clean <- transform(health_check_clean,
                                bmi = weight_kg/(height_m ^ 2),
                                whr = waist/hip,
                                blood_pressure = ifelse(systolic_pressure >= 140 & diastolic_pressure >= 90, "high bp",
                                                        ifelse(systolic_pressure <= 90 & diastolic_pressure <= 60, "low bp", "normal"))
)

# rename NA values in occupation as "unemployed"
health_check_clean <- health_check_clean |>
  transform(
    occupation = ifelse(is.na(occupation), "Unemployed", occupation)
  )

# bmi and whr ranges
health_check_clean <- health_check_clean |>
  mutate(
    bmi_risk = case_when(
      bmi > 25 ~ "Overweight",
      bmi < 18.5 ~ "Underweight",
      .default = "Healthy"
    ),
    whr_risk = case_when(
      whr < 0.81 & sex == "F" ~ "Low risk",
      whr < 0.960 & sex == "M" ~ "Low risk",
      whr >= 0.810 & whr <= 0.850 & sex == "F" ~ "Moderate risk",
      whr >= 0.960 & whr <= 1.00 & sex == "M" ~ "Moderate risk",
      whr > 0.85 & sex == "F" ~ "High risk",
      whr > 0.99 & sex == "M" ~ "High risk",
      .default = "Unknown"
    )
  )

# join data using lsoa information
health_check_clean <- health_check_clean |>
  left_join(imd, by = join_by("lsoa_code" == "lsoa_code_2011"))

# tidy up column names
health_check_clean <- health_check_clean %>%
  rename(imd_rank = index_of_multiple_deprivation_imd_rank,
         imd_decile = index_of_multiple_deprivation_imd_decile,
         local_auth_district_code = local_authority_district_code_2019) %>%
  select(-lsoa_name_2011, -local_authority_district_name_2019,
         -height:-weight)

# write out csv
write.csv(health_check_clean, "Additional content/Dissertations/R_dissertation_2/health_metrics_cleaned.csv", row.names = FALSE)


