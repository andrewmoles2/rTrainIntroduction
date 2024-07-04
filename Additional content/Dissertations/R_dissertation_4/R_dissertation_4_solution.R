library(tidyverse)
library(broom)
library(stargazer)
library(easystats)

health <- read_csv("health_metrics_cleaned.csv")

# imd vs blood pressure
bp_imd_t <- stats::t.test(imd_decile ~ factor(blood_pressure), data = health)
bp_imd_t

# compare means of location
hackney <- subset(health, location == "Hackney")
westminster <- subset(health, location == "Westminster")

loc_imd <- t.test(hackney$imd_decile, westminster$imd_decile)
loc_imd

# anova
health$location <- factor(health$location)
loc_anova <- aov(imd_decile ~ location, data = health)
summary(loc_anova)
TukeyHSD(loc_anova)

# linear regression
lm_mod <- lm(imd_decile ~ whr, data = health)
summary(lm_mod)

# multiple linear regression
# change reference point to city of london - the highest imd decile average
health$location <- factor(health$location, levels = c("City of London","Camden","Hackney",
                                                      "Islington","Lambeth","Southwark", 
                                                      "Tower Hamlets","Westminster"))

lm_mod_1 <- lm(imd_decile ~ location + bmi + whr + age, data = health)
summary(lm_mod_1)

# reporting examples
report(lm_mod)
broom::tidy(loc_imd)
stargazer(lm_mod, type = 'text', title = "IMD Decile regression results")
