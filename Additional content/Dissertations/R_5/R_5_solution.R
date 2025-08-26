# load libraries ----
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(lubridate)
library(sf)
library(stringr)
library(ggiraph)

# create new directory using programming ----
# use if statement to ensure it doesn't exist already

# we made a function called 'create_directory' to do this
create_directory <- function(path, directory_name) {
  
  # all inputs should be a string
  # make sure path string ends with /
  
  if (dir.exists(paste0(path, directory_name))) {
    print("file exists already!")
  } else {
    dir.create(paste0(path, directory_name))
    print(paste0("new directory ", directory_name,
                 " created"))
  }
}

create_directory(path = "Additional content/Dissertations/R_5/data/",
                 directory_name = "data_test")


# download the files and save in a file and folder ----
# using R's programming capabilities for this
# datasets - https://gender-pay-gap.service.gov.uk/viewing/download

# make file names (for loop version)
file_years <- 2017:2024
file_name <- rep(NA, length(file_years))
for (f in seq_along(1:length(file_years))) {
  file_name[f] <- paste0("UK Gender Pay Gap Data - ", 
                      file_years[f], " to ",
                      file_years[f]+1,
                      ".csv")
}

# make file names non-loop version (one of the perks of R!)
file_years <- 2017:2024
file_name <- paste0(paste0("UK Gender Pay Gap Data - ", 
              file_years, " to ",
              file_years+1,
              ".csv"))

# use file names to make download destination for files
pathway = "Additional content/Dissertations/R_5/data/"
download_path <- paste0(pathway, "data_test/", file_name)

# loop through each file on website to download, save, and move on
download_url <- "https://gender-pay-gap.service.gov.uk/viewing/download-data/"

for (data_year in seq_along(1:length(file_years))) {
  if (file.exists(download_path[data_year])) {
    print("file has already been downloaded!")
  } else {
    download.file(
      url = paste0(download_url, file_years[data_year]),
      destfile = download_path[data_year]
    )
  }
}

list.files(
  paste0(
    pathway,
    "data_test/"
  )
)

# load downloaded files into R and combine to one data frame ----

# path to raw data files
path <- "Additional content/Dissertations/R_5/data/raw_data/"

# list files with full path names
list_files <- list.files(
  path = "Additional content/Dissertations/R_5/data/raw_data/",
  full.names = TRUE, 
  pattern = "*.csv"
)

# read in files
load_files <- lapply(list_files, read_csv)

# combine files into a data frame
paygap <- do.call(rbind, load_files)

# initial data cleaning and prep ----
# clean the column names
paygap <- janitor::clean_names(paygap)

# convert to date data type
paygap <- transform(paygap,
          due_date = lubridate::as_datetime(due_date),
          date_submitted = lubridate::as_datetime(date_submitted))

# make company names title case 
paygap$employer_name_clean <- stringr::str_to_title(paygap$employer_name)

# add year and month columns
paygap <- paygap |>
  mutate(year = year(date_submitted))

paygap |>
  summarise(avg_hourly_diff = median(diff_median_hourly_percent, na.rm = TRUE),
            yearly_records = n(),
            .by = year) |>
  arrange(year)

# Add SIC codes to the dataset ----
# download using direct csv link from: https://www.gov.uk/government/publications/standard-industrial-classification-of-economic-activities-sic 
sic_codes <- read.csv("https://assets.publishing.service.gov.uk/media/5a7f8639e5274a2e87db65e1/SIC07_CH_condensed_list_en.csv")

paygap <- paygap %>%
  separate_longer_delim(sic_codes, delim = ",") |>
  mutate(sic_codes = as.integer(sic_codes))

# now join
paygap <- left_join(paygap, sic_codes, by = join_by(sic_codes == SIC.Code))

# subset data to just be education SIC codes ----

paygap_education <- paygap |>
  filter(str_detect(Description, "education"))

unique(paygap_education$Description)

# aggregate by SIC description and year ----

paygap_education_agg <- paygap_education |>
  group_by(Description, year) |>
  summarise(avg_diff = mean(diff_mean_hourly_percent, na.rm = TRUE))

# make gif showing changes in lollipop plot over time ----
# prep data to show colour for degrees which is unis
paygap_gif_df <- paygap_education_agg |>
  mutate(avg_diff = round(avg_diff, 2),
         colour = ifelse(Description %in% c("First-degree level higher education",
                                            "Post-graduate level higher education"),
                         "#d6473f", "black"))

# setup pathways
create_directory(path = "Additional content/Dissertations/R_5/",
                 directory_name = "visuals")
gif_path <- "Additional content/Dissertations/R_5/visuals/"

# setup years to loop over
year_range = range(paygap_gif_df$year, na.rm = TRUE)
years <- seq(year_range[1], year_range[2])

for (i in years) {
  p <- paygap_gif_df |>
    filter(year == i) |>
    ggplot(aes(y = reorder(Description, avg_diff), x = avg_diff, colour = colour)) +
    geom_point(size = 8.5) +
    geom_segment(aes(y = Description, yend = Description, 
                     x = 0, xend = avg_diff),
                 linewidth = 2,
                 lineend = "round") +
    geom_text(aes(label = avg_diff), colour = "white", size = 2.5) +
    labs(x = "Yearly average difference in hourly pay",
         y = "",
         title = "Gender paygap changes in educational institutions since 2017",
         subtitle = paste0("Year: ", i)) +
    scale_y_discrete(labels = scales::label_wrap(20)) +
    scale_x_continuous(limits = c(0, 25), breaks = seq(0, 25, 5)) +
    scale_colour_identity() +
    theme_minimal(base_size = 13, base_family = "Avenir") +
    theme(
      plot.title.position = "plot"
    )
  print(p)
  
  ggsave(paste0(gif_path, "he_paygap_", i, ".png"), dpi = 320, bg = "white",
         units = "px", width = 2500, height = 3000, device = ragg::agg_png
  )
}

# use magick to save gif
# helpful blog here: https://www.waltermuskovic.com/2021/02/20/making-gifs-in-r/
library(magick)

list.files(
  path = gif_path,
  full.names = TRUE,
  pattern = "*.png"
) |>
  lapply(X = _, image_read) |>
  image_join() |>
  image_animate(fps = 1) |>
  image_write(path = paste0(gif_path, "he_paygap.gif"))


# make a dumbbell plot from this data showing 2018 to 2023 ----
paygap_ed_agg_wide <- paygap_education_agg |>
  filter(year %in% c(2018, 2023)) |>
  pivot_wider(names_from = year, values_from = avg_diff,
              names_prefix = "year_") |>
  mutate(year_2018 = round(year_2018, 3),
         year_2023 = round(year_2023, 3)) |>
  mutate(
    txt_18 = str_wrap(paste0("Ave pay diff for " ,Description, " in 2018: ", year_2018),
                      width = 30),
    txt_23 = str_wrap(paste0("Ave pay diff for " ,Description, " in 2023: ", year_2023),
                      width = 30)
  )

paygap_db <- ggplot(paygap_ed_agg_wide,
       aes(y = reorder(Description, year_2018))) +
  geom_point_interactive(aes(x = year_2018, colour = "2018",
                             tooltip = txt_18, data_id = year_2018),
                         size = 7) +
  geom_point_interactive(aes(x = year_2023, colour = "2023",
                             tooltip = txt_23, data_id = year_2023),
                         size = 7) +
  #geom_point(aes(x = year_2018, colour = "2018"), size = 7) +
  #geom_point(aes(x = year_2023, colour = "2023"), size = 7) +
  geom_segment(aes(yend = Description, x = year_2018, xend = year_2023), 
               colour = "grey40", linewidth = 1.2,
               arrow = arrow(type = "closed",
                             length = unit(0.09, "inches"))) +
  scale_y_discrete(labels = scales::label_wrap(30)) +
  scale_x_continuous(limits = c(0, 25), breaks = seq(0, 25, 5)) +
  scale_colour_manual(name = "Year of report",
                      values = c("2018" = "steelblue",
                                 "2023"= "orange")) +
  labs(x = "Yearly average difference in hourly pay",
       y = "",
       title = "How has the gender pay gap changed from 2018-2023 in\nvarious educational institutions?",
       subtitle = "Score of 0 means equality in men and womans pay
Positive scores means men are paid more
Negative score means woman are paid more") +
  theme_minimal(base_size = 12, base_family = "Avenir") +
  theme(
    panel.border = element_blank(),
    legend.position = "bottom",
    plot.title.position = "plot"
  )
paygap_db

# * save as png ----
create_directory("Additional content/Dissertations/R_5/visuals/",
                 "interactive")

ggsave(plot = paygap_db, filename = "Additional content/Dissertations/R_5/visuals/interactive/paygap_dumbbell.png", 
       dpi = 320, bg = "white", units = "px", width = 2750, height = 3000, 
       device = ragg::agg_png
)

css_default_hover <- girafe_css_bicolor(primary = "#E2DBAA", secondary = "#ABB3E2")
set_girafe_defaults(opts_hover = opts_hover(css = css_default_hover),
                    opts_sizing = opts_sizing(rescale = TRUE, width = .7))

paygap_db_int <- girafe(ggobj = paygap_db, fonts = list("Arial"), 
       options = list(opts_toolbar(position = "bottom")),
       pointsize = 10,
       width_svg = 8,
       height_svg = 7)
paygap_db_int

# * save as interactive html ---- 
# note we can add these figures to websites, apps, and dashboards
htmlwidgets::saveWidget(
  file = "Additional content/Dissertations/R_5/visuals/interactive/paygap_dumbbell.html",
  paygap_db_int
)

# test LSE - https://info.lse.ac.uk/staff/divisions/equity-diversity-and-inclusion/EDI-objectives-data-and-research/Gender-pay-gap

