

library(tidyverse)

health <- read_csv("health_metrics_cleaned.csv")

# summary ----
summary(health)
table(health$location)
table(health$blood_pressure)
table(health$bmi_risk)
table(health$whr_risk)

# distribution ----
ggplot(health, aes(x = systolic_pressure)) +
  geom_histogram()

# distribution between groups ----
ggplot(health, aes(x=imd_decile)) +
  geom_histogram(bins = 10, colour = "black") +
  scale_x_continuous(breaks = 1:10)

ggplot(health, aes(x = imd_decile, y = location)) +
  geom_boxplot() +
  scale_x_continuous(breaks = 1:10)

ggplot(health, aes(x=imd_decile)) +
  geom_histogram(bins = 10, colour = "black") +
  scale_x_continuous(breaks = 1:10) +
  facet_wrap(~location)

# counts and ranking of categorical data ----
# basic bar
ggplot(health, aes(y = bmi_risk)) +
  geom_bar()

# add sex to gain more insights
ggplot(health, aes(y = bmi_risk, fill = sex)) +
  geom_bar(position = "dodge")

# average rankings ----
# find average imd decile per location
health %>%
  group_by(location) %>%
  summarise(avg_imd_decile = mean(imd_decile, na.rm = TRUE)) %>%
  ggplot(aes(x = avg_imd_decile, y = fct_reorder(location, avg_imd_decile))) +
  geom_col() +
  labs(x = "Average IMD decile",
       y = "London boroughs")

# relationships and correlations ----
# remove missing value for calculation
health_no_na <- na.omit(health)

# correlation matrix
corr_mat <- health_no_na %>%
  select(age, waist, hip, height_m:whr, imd_rank:imd_decile) %>%
  cor()
corr_mat
# optional heatmap
#heatmap(corr_mat, Rowv = NA, Colv = NA)

# scatterplots with lm
library(patchwork)

imd_r <- ggplot(health, aes(x = imd_rank, y = bmi)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

weight <- ggplot(health, aes(x = weight_kg, y = bmi)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

height <- ggplot(health, aes(x = height_m, y = bmi)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

whr <- ggplot(health, aes(x = whr, y = bmi)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

imd_r + weight + height + whr

# final task ----
health_occupation <- health %>%
  mutate(occupation = str_remove(occupation, "\\["),
         occupation = str_remove(occupation, "\\]")) %>%
  separate_longer_delim(occupation, delim = ",") %>%
  mutate(occupation = str_squish(occupation))

occupation_comp <- c("Arts and Entertainment", "Education", "Research", "Health")

final_plot <- health_occupation %>%
  mutate(bmi_risk = factor(bmi_risk, levels = c("Underweight", "Healthy", "Overweight"))) %>%
  filter(occupation %in% occupation_comp) %>%
  ggplot(aes(x = bmi, y = imd_decile)) +
  geom_point(aes(colour = bmi_risk)) +
  geom_smooth(method = "lm", se = FALSE, colour = "grey55") +
  facet_wrap(vars(occupation)) +
  scale_colour_manual(values = c('#26547c','#ef476f','#ffd166')) +
  scale_y_continuous(breaks = seq(1,10,1)) + 
  labs(title = "Is BMI effected by deprivation in different by occupations? ",
       y = "Index of Multiple Deprivation Decile", x = "bmi",
       colour = "bmi risk") +
  theme_minimal(base_size = 12, base_family = "Avenir") +
  theme(legend.position = "bottom",
        plot.title.position = "plot")
final_plot