library(readxl)
library(tidyverse)
library(janitor)

# read in data
health <- read.csv("health_metrics.csv")
imd <- read_xlsx("IMD2019.xlsx", sheet = 2) |>
  clean_names()

# fix height and weight columns
health_check_clean <- transform(health,
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
# alt version
health_check_clean <- health_check_clean |>
  transform(
    occupation = tidyr::replace_na(occupation, "Unemployed")
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

# tidy up columns
health_check_clean <- health_check_clean %>%
  rename(imd_rank = index_of_multiple_deprivation_imd_rank,
         imd_decile = index_of_multiple_deprivation_imd_decile,
         local_auth_district_code = local_authority_district_code_2019) %>%
  select(-lsoa_name_2011, -local_authority_district_name_2019,
         -height:-weight)

head(health_check_clean)
