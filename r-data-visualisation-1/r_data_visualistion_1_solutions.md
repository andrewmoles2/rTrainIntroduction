---
title: "R Data Visualistion 1 - Data viz with ggplot2"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "08 October, 2021"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: TRUE
    toc_float: TRUE
---

# What this workshop will cover

-   An introduction to the ggplot2 package
-   How to make scatter plots with ggplot2
-   How to make bar plots with ggplot2

## Why this style?

-   Online training is tiring so keeping the sessions to one hour
-   No or limited demonstrations provided in order to provide more real world experience - you have a problem and you look up how to solve it, adapting example code
-   Trainer support to guide through process of learning

## We will be working in pairs:

-   Option to work together on worksheet or to work individually
-   If possible have your camera on and introduce yourself to each other

## What to do when getting stuck:

1)  Ask your team members
2)  Search online:

-   The answer box on the top of Google's results page
-   stackoverflow.com (for task-specific solutions)
-   <https://www.r-bloggers.com/> (topic based tutorials)

3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

------------------------------------------------------------------------

# Introduction

Data visualisation is a way of looking at your data using graphics, which provides a different perspective to your data.

There are a lot of different options for data visualistion with R. You can use the visualisation tools that come with R, ggplot and all its extensions, or for interactive visualisations there is the plotly library.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-visualisation-1/images/ggplot2_exploratory.png?raw=true){width="437"}

In this data visualisation series we will be mainly focussing on ggplot, as well as plotly. While the visualistion tools that come with R are useful, ggplot and plotly are generally easier to use and make great visualisations with. For this tutorial we will be using the below packages: ggplot2, dplyr, readr, janitor. Run the code below to install the packages if you don't have them installed already.


```r
# install packages
install <- c("ggplot2", "dplyr", "readr",
             "janitor", "RColorBrewer",
             "forcats")

install.packages(install)
```

Then we need to load them into our session. Run the code chunk below to load all the libraries you will need.


```r
# load packages
library(ggplot2)
library(dplyr)
library(readr)
library(janitor)
library(RColorBrewer)
library(forcats)
```

# What is ggplot and how does it work?

ggplot2 is a package for producing graphics that works by combining independent components when making graphs, known as layers. This makes ggplot2 both versatile and powerful; you are not limited by a set of options but instead can make novel graphics to suit your needs.

It is also important to note that ggplot can only use data frames. If your data is in another format you will need to transform it into a data frame in order to use ggplot.

In order to understand how the layers work we will first load in some data for our examples. We will use data from the Pokémon games, which was web scraped from <https://pokemondb.net/pokedex/all>.


```r
# load and clean names
pokemon <- read_csv("https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/pokemon.csv") %>%
  clean_names()
# review data
pokemon %>%
  glimpse()
```

```
## Rows: 952
## Columns: 13
## $ number     <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, …
## $ name       <chr> "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmele…
## $ type1      <chr> "Grass", "Grass", "Grass", "Fire", "Fire", "Fire", "Water",…
## $ type2      <chr> "Poison", "Poison", "Poison", NA, NA, "Flying", NA, NA, NA,…
## $ total      <dbl> 318, 405, 525, 309, 405, 534, 314, 405, 530, 195, 205, 395,…
## $ hp         <dbl> 45, 60, 80, 39, 58, 78, 44, 59, 79, 45, 50, 60, 40, 45, 65,…
## $ attack     <dbl> 49, 62, 82, 52, 64, 84, 48, 63, 83, 30, 20, 45, 35, 25, 90,…
## $ defense    <dbl> 49, 63, 83, 43, 58, 78, 65, 80, 100, 35, 55, 50, 30, 50, 40…
## $ sp_atk     <dbl> 65, 80, 100, 60, 80, 109, 50, 65, 85, 20, 25, 90, 20, 25, 4…
## $ sp_def     <dbl> 65, 80, 100, 50, 65, 85, 64, 80, 105, 20, 25, 80, 20, 25, 8…
## $ speed      <dbl> 45, 60, 80, 65, 80, 100, 43, 58, 78, 45, 30, 70, 50, 35, 75…
## $ legendary  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FAL…
## $ generation <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
```

The syntax for ggplot has three key components. The ggplot function call (`ggplot()`), the aesthetics (called `aes()`), and the geometry (called geoms) which refers to scatter, bar, or line plots for example. The next three code chunks break this down.


```r
# call ggplot2 and add data
ggplot(pokemon)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

Notice we just get a grey box. We have just loaded our data into ggplot but not much else! Now lets add the aesthetics and see what happens.

Too add aesthetics we use the `aes()` function within the `ggplot()` function, and specify what our x and y axis will be with column names from our data, sp_atk and sp_def in this case.


```r
# add aesthetics
ggplot(pokemon, aes(x = sp_atk, y = sp_def))
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

It is starting to look more like a visualisation now, we can see the x and y axis labels, but we still have no data points showing. We have to add a geometry for that to happen. Notice the syntax here, we use the `+` icon to add a geometry to ggplot, which in this case is `geom_point()` which makes scatter plots. All geometry functions start with `geom_` and end with the type of geometry such as point, bar, or line.


```r
# pick which geometry
ggplot(pokemon, aes(x = sp_atk, y = sp_def)) +
  geom_point()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

This is the fundamental concept of ggplot, you construct your visualisations in layers, adding geometry layers, and other features as you go.

## what is ggplot exercise

Using the pokemon data, make a scatter plot with *hp* on the x axis and *speed* on the y axis.


```r
# your code here
ggplot(pokemon, aes(x = hp, y = speed)) +
  geom_point()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

# Scatter plots

Scatter plots are for displaying the relationship between two numeric (or quantitative) variables. For each data point, the values of its first variable is represented on the X axis and the second on the Y axis.

To make a scatter plot with ggplot2 we use the `geom_point()` function like you just saw. In order for ggplot to make a scatter plot, the X and Y axis must be numeric.

The plot we just made in the example is okay but it could do with some improving. There are quite a few different ways to change the appearance of a visualisation, lets go through them.

The first thing we will look at is adding some colour! There are a few options for adding colours to your plots. You can add the name, such as red, or you can use a hex code, or you can use a pre-defined palette. To add colour to a scatter plot we use the `colour =` argument.


```r
# colour of points
ggplot(pokemon, aes(x = hp, y = speed)) +
  geom_point(colour = "orange")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

To colour your points by a group (or factor) we have to add the colour argument into the `aes()` function. This allows us to have different colours for different groups, which makes the plot more informative.

In the below example, our data is coloured by if a pokemon is classified as legendary or not.


```r
# colour by factor
ggplot(pokemon, aes(x = hp, y = speed, colour = legendary)) +
  geom_point()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

We get the default ggplot colours which are okay. There are a few different ways of changing the colours, all methods use the `scale_` function in a slightly different way. In the two examples below we have changed the colours using the RColorBrewer package and have set the colours manually.

RColorBrewer comes with a set of palettes for different situations, you can view them by following this link <https://www.r-graph-gallery.com/38-rcolorbrewers-palettes.html>. To use these palettes with ggplot we use the `scale_colour_brewer()` function with an argument for which palette we want to use; in this example we are using Set1.


```r
library(RColorBrewer)
# adjusting colour by factor using RColorBrewer
ggplot(pokemon, aes(x = hp, y = speed, colour = legendary)) +
  geom_point() +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

To make a manual palette, you first make a vector with your colours, to do so it is useful to use a colour picker such as <http://tristen.ca/hcl-picker/#/hlc/6/1/15534C/E2E062> or <https://coolors.co/>. You copy the hex code (code with \# then 6 numbers of letters) and paste it into your vector like you can see in the manual_pal vector below. To add the colour we use `scale_colour_manual()` function, and set the values to our manual palette.


```r
# adjusting colour by factor using manual palette
manual_pal <- c("#90C0F8", "#EA964E")

ggplot(pokemon, aes(x = hp, y = speed, colour = legendary)) +
  geom_point() +
  scale_colour_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

It is sometimes helpful to view the palette before using it. We can use the scales package for this, which is installed when you install ggplot2. We provide the `show_col()` function with the palette we want to view and it returns a grid view of the colours. In the example we look at Set1 from RColorBrewer and the manual palette we just used.


```r
# load scales
library(scales)
```

```
## 
## Attaching package: 'scales'
```

```
## The following object is masked from 'package:readr':
## 
##     col_factor
```

```r
# view palettes
show_col(RColorBrewer::brewer.pal(n = 8, name = "Set1"))
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
show_col(manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-12-2.png)<!-- -->

As well as changing the colour of the points, you can change their shape, size, and transparency (alpha). Just like with colour, we can define the size, shape or transparency either in the `aes()` function or in a `geom_` function. By adding them to the `geom_` function we manually change them. If we use them in `aes()` we have to associate the size/shape/alpha with a variable.

See the below example, first we manually set the size and alpha. In the second example we set the size to be defined by the total column in our pokemon data, and manually set the alpha.


```r
# manually set size and alpha
ggplot(pokemon, aes(x = hp, y = speed, colour = legendary)) +
  geom_point(size = 5, alpha = 0.6) +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```r
# manually set alpha, size by total
ggplot(pokemon, aes(x = hp, y = speed, colour = legendary, size = total)) +
  geom_point(alpha = 0.6) +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-13-2.png)<!-- -->

To manually change the shape and replace the circles, we give the shape argument a number. Each number represents a shape, letter, or number; by default ggplot uses shape number 19. We can change the shape to a square for example by using the number 15.


```r
# default shape number
ggplot(pokemon, aes(x = hp, y = speed, colour = legendary, size = total)) +
  geom_point(alpha = 0.6, shape = 19) +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
# shape number for squares
ggplot(pokemon, aes(x = hp, y = speed, colour = legendary, size = total)) +
  geom_point(alpha = 0.6, shape = 15) +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-14-2.png)<!-- -->

View the image with the visual markdown editor to see what number represents what shape, letter, or number.

![](images/shapes.png){width="800" height="900"}

Finally we can add a title and save our plot! We've done two things in order to achieve this. To add a title, and change axis labels, we have used the `labs()` function. We add arguments for what we want to change, such as `title = "Pokemon Hit Points vs Speed"`. To change the legend labels we use colour and size, as we used these to define our legend in the `aes()` function.

To save the plot we assign our code to a variable, then we use the `ggsave()` function, which requires what you want to call the file and the file extension (e.g. plot.PNG or plot.JPG), then the ggplot object we created. Run the example below, and you should get a hp_vs_speed.PNG file where your Rmd file is saved. You can also adjust the size of the image saved using the width and height arguments.


```r
# save plot to a variable
hp_vs_speed <- ggplot(pokemon, aes(x = hp, y = speed, colour = legendary, size = total)) +
  geom_point(alpha = 0.6, shape = 15) +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Pokemon Hit Points vs Speed",
       subtitle = "Taken from pokemondb.net",
       x = "Hit Points",
       y = "Speed",
       colour = "Legenary pokemon?",
       size = "Total stats")

hp_vs_speed
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

```r
# save plot
ggsave("hp_vs_speed.PNG", hp_vs_speed)
```

```
## Saving 7 x 5 in image
```

```r
# save with defined width and height
ggsave("hp_vs_speed.PNG", hp_vs_speed,
       width = 7, height = 4.5)
```

## Scatter plots exercise

For the exercises in this workshop we will use data from the Olympics that includes all Olympic games from 1896 through to 2016. More information on the dataset can be found here <https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-07-27/readme.md>. Run the code provided to load the libraries and data into R.

We will make two scatter plots from the Olympics data. For both plots we will use dplyr to filter the information we are interested in.

1)  Make a scatter plot of Olympic gymnasts heights (x axis) and weights (y axis).

-   Change the colour and shape arguments to tell us what sex the gymnasts are.
-   Change the colour palette by making a manual one or using RColorBrewer.
-   Be sure to give your plot a title, and save your plot.

*hint: you will need to filter for sport == "Gymnastics"*

2)  Make a scatter plot of the age (y axis) of gymnastic medal winners by year (x axis). You should filter out all gymnasts who did not win a medal. *hint: use filter(!is.na(medal)) to remove non-medal winning gymnasts*

-   Colour your plot by medal.
-   Make a manual colour palette and colour the medals by their colour.
-   Use shape to tell us what sex the gymnasts were.
-   Be sure to give your plot a title, and save your plot.

*hint: the medal order will be wrong (you'll want gold, silver, bronze), change it to the right order using factor levels on the medal column, e.g. factor(olymics\$medal, levels = c("Gold", "Silver", "Bronze")*

*hint: the hex codes for gold, silver and bronze are: "\#FFD700", "\#C0C0C0", "\#CD7F32"*


```r
# make sure libraries are loaded
library(readr)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

# load in data
olympics <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-27/olympics.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   id = col_double(),
##   name = col_character(),
##   sex = col_character(),
##   age = col_double(),
##   height = col_double(),
##   weight = col_double(),
##   team = col_character(),
##   noc = col_character(),
##   games = col_character(),
##   year = col_double(),
##   season = col_character(),
##   city = col_character(),
##   sport = col_character(),
##   event = col_character(),
##   medal = col_character()
## )
```

```r
olympics %>% glimpse()
```

```
## Rows: 271,116
## Columns: 15
## $ id     <dbl> 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, …
## $ name   <chr> "A Dijiang", "A Lamusi", "Gunnar Nielsen Aaby", "Edgar Lindenau…
## $ sex    <chr> "M", "M", "M", "M", "F", "F", "F", "F", "F", "F", "M", "M", "M"…
## $ age    <dbl> 24, 23, 24, 34, 21, 21, 25, 25, 27, 27, 31, 31, 31, 31, 33, 33,…
## $ height <dbl> 180, 170, NA, NA, 185, 185, 185, 185, 185, 185, 188, 188, 188, …
## $ weight <dbl> 80, 60, NA, NA, 82, 82, 82, 82, 82, 82, 75, 75, 75, 75, 75, 75,…
## $ team   <chr> "China", "China", "Denmark", "Denmark/Sweden", "Netherlands", "…
## $ noc    <chr> "CHN", "CHN", "DEN", "DEN", "NED", "NED", "NED", "NED", "NED", …
## $ games  <chr> "1992 Summer", "2012 Summer", "1920 Summer", "1900 Summer", "19…
## $ year   <dbl> 1992, 2012, 1920, 1900, 1988, 1988, 1992, 1992, 1994, 1994, 199…
## $ season <chr> "Summer", "Summer", "Summer", "Summer", "Winter", "Winter", "Wi…
## $ city   <chr> "Barcelona", "London", "Antwerpen", "Paris", "Calgary", "Calgar…
## $ sport  <chr> "Basketball", "Judo", "Football", "Tug-Of-War", "Speed Skating"…
## $ event  <chr> "Basketball Men's Basketball", "Judo Men's Extra-Lightweight", …
## $ medal  <chr> NA, NA, NA, "Gold", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
```

```r
# your code here

# all gymnastics by weight and height ----
gym_wt_vs_h <- olympics %>%
  filter(sport == "Gymnastics") %>%
  ggplot(aes(x = height, y = weight, colour = sex, shape = sex)) +
  geom_point(size = 3) +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Olympic Gymnasts weights and heights",
       subtitle = "Coloured by gender")

gym_wt_vs_h
```

```
## Warning: Removed 8381 rows containing missing values (geom_point).
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

```r
ggsave("gym_wt_vs_h.PNG", gym_wt_vs_h)
```

```
## Saving 7 x 5 in image
```

```
## Warning: Removed 8381 rows containing missing values (geom_point).
```

```r
# age of medal winners per year ----
# filter commands and factor levels
gym_age_medal <- olympics %>%
  filter(sport == "Gymnastics" & !is.na(medal)) %>%
  mutate(medal = factor(medal, levels = c("Gold", "Silver", "Bronze")))

# make manual medal colours
medal_colours <- c("#FFD700", "#C0C0C0", "#CD7F32")

age_medel <- ggplot(gym_age_medal, aes(x = year, y = age, colour = medal, shape = sex)) +
  geom_point(size = 2.5) +
  scale_colour_manual(values = medal_colours) +
  labs(title = "Age of Gymnastic medal winners by year",
       x = "Year of olympics",
       y = "Age of medal winner")

age_medel
```

```
## Warning: Removed 69 rows containing missing values (geom_point).
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-16-2.png)<!-- -->

```r
ggsave("age_medel.PNG", age_medel)
```

```
## Saving 7 x 5 in image
```

```
## Warning: Removed 69 rows containing missing values (geom_point).
```

# Quirks of ggplot2

There are a few quirks to be aware of when using ggplot2 and you'll see a few of them when you look for examples online. In order to aid with this, we can have a look at a few of them!

The first quirk is piping data into ggplot, where you do not need to add your data into the `ggplot()` function as it is piped in. The main advantage of this approach is you can string together some data cleaning and then pipe the results straight into ggplot.


```r
# piping data into ggplot
pokemon %>%
  ggplot(aes(x = sp_atk, y = sp_def)) +
  geom_point()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

```r
# piping with filter
pokemon %>%
  filter(type1 == "Fire") %>%
  ggplot(aes(x = sp_atk, y = sp_def)) +
  geom_point()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-17-2.png)<!-- -->

The second quirk is adding aesthetics into a `geom_` function rather than the `ggplot()` function.


```r
# adding aesthetics into the geom_ call
ggplot(pokemon) +
  geom_point(aes(x = sp_atk, y = sp_def))
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

The third quirk is you can also add the data into the `geom_` function. When doing so you have to have `data =` otherwise you will get an error.


```r
# adding data and aesthetics into the geom_ call
ggplot() +
  geom_point(data = pokemon, aes(x = sp_atk, y = sp_def))
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

The fourth quirk relates to the second and third, in that you can add aesthetics into a `geom_` function more than once. You might occasionally come across this for more complex visualisations.

In the example we will add the average of our x and y variables. First we make a summary table that has the averages of both axis's, using `summarise()` from dplyr. Then we add two `geom_point()` functions, one with the pokemon data, and one with our summary table data.


```r
# why adding aesthetics into the geom_ call
# calculate mean of sp_atk and sp_def
avg_sp <- pokemon %>%
  summarise(
    avg_sp_atk = mean(sp_atk, na.rm = TRUE),
    avg_sp_def = mean(sp_def, na.rm = TRUE))

avg_sp
```

```
## # A tibble: 1 × 2
##   avg_sp_atk avg_sp_def
##        <dbl>      <dbl>
## 1       71.3       70.7
```

```r
# add average sp_atk and sp_def as black point
ggplot() +
  geom_point(data = pokemon, 
             aes(x = sp_atk, y = sp_def), 
             colour = "orange",
             size = 2.5) +
  geom_point(data = avg_sp, 
             aes(x = avg_sp_atk, y = avg_sp_def),
             size = 2.5)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

The last quirk we will look at is adding to a ggplot visualisation after you have assigned it a name. This is very common in tutorials and on Stack Overflow. A good use of this is to build a base of the x and y you want to use and test out different geometries.


```r
# saving plot then adding to it
p <- ggplot(pokemon, aes(x = sp_atk, y = sp_def))

p
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

```r
p + geom_point()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-21-2.png)<!-- -->

```r
p + geom_line()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-21-3.png)<!-- -->

# Quirks of ggplot2 exercise

Make a visualisation of USA athletes ages vs heights, showing the difference between the genders using colour. When making your visualisation try to

-   Pipe the olympics data to a filter function and select all USA athletes
-   Pipe to a ggplot function
-   Add a geom_point function and add the aesthetics there rather than in `ggplot()`


```r
olympics %>%
  filter(noc == "USA") %>%
  ggplot() +
  geom_point(aes(age, height, colour = sex)) +
  scale_colour_brewer(palette = "Set2")
```

```
## Warning: Removed 4030 rows containing missing values (geom_point).
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

# Bar plots with counts

Bar plots are used to show relationships between a numerical and categorical variable. The categorical variable is usually on the x axis, and the y axis is usually a frequency count.

By default, bar plots with ggplot only require an x or y axis. From that they make a frequency count of that variable. See the example below. First we use ggplot to make a bar plot to count the number of pokemon added in each generation. Then we do the same thing with dplyr to make a aggregate table, ggplot is taking this aggregate table and making into a plot for us!

It is important to make sure your x axis in a bar plot is a factor, as this helps ggplot to order the axis as you expect.


```r
# make generation a factor
pokemon$generation <- factor(pokemon$generation)

# default bar plot
ggplot(pokemon, aes(x = generation)) +
  geom_bar()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

```r
# dplyr aggregate equivalent
pokemon %>%
  count(generation)
```

```
## # A tibble: 8 × 2
##   generation     n
##   <fct>      <int>
## 1 1            151
## 2 2             99
## 3 3            141
## 4 4            115
## 5 5            165
## 6 6             84
## 7 7             99
## 8 8             98
```

To add colour to your bar plot we use the fill argument rather than colour. This can be confusing, and sometimes if you forget, just try both till the colours look right! To add our fill manually we add the fill command to our `geom_bar()` function.


```r
# manually add fill colour
ggplot(pokemon, aes(generation)) +
  geom_bar(fill = "purple")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

Just like with the scatter plot, we can colour our plot by a variable by putting the fill argument within the `aes()` function. The below example also shows the equivalent when doing aggregation using dplyr.


```r
# bar plot with colour by variable
ggplot(pokemon, aes(x = generation, fill = legendary)) +
  geom_bar()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

```r
# dplyr aggregate equivalent
pokemon %>%
  count(generation, legendary)
```

```
## # A tibble: 16 × 3
##    generation legendary     n
##    <fct>      <lgl>     <int>
##  1 1          FALSE       146
##  2 1          TRUE          5
##  3 2          FALSE        94
##  4 2          TRUE          5
##  5 3          FALSE       128
##  6 3          TRUE         13
##  7 4          FALSE       100
##  8 4          TRUE         15
##  9 5          FALSE       145
## 10 5          TRUE         20
## 11 6          FALSE        75
## 12 6          TRUE          9
## 13 7          FALSE        69
## 14 7          TRUE         30
## 15 8          FALSE        82
## 16 8          TRUE         16
```

Notice in the above example that the bars by default were stacked on top of each other. We have two other options for changing this with either a dodge setting (sit next to each other) or a fill setting (stacked and standarised). To change this we use the position argument within `geom_bar()`.


```r
# dodge bars
ggplot(pokemon, aes(x = generation, fill = legendary)) +
  geom_bar(position = "dodge")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-26-1.png)<!-- -->

```r
# filled bars
ggplot(pokemon, aes(x = generation, fill = legendary)) +
  geom_bar(position = "fill")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-26-2.png)<!-- -->

A useful thing to change with bar plots is to *flip* your coordinates. This is particularly useful if your x axis contains text. In the example below we will use the type1 variable as our x axis to see the difference. When we don't flip the coordinates, the x axis is hard to read.


```r
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

```r
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-27-2.png)<!-- -->

To change our colours we use the `scale_fill_` function. This is very similar to what we did with scatter plots except we are using fill this time, rather than colour.


```r
# change fill with RColorBrewer
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-28-1.png)<!-- -->

```r
# change fill with manual palette
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-28-2.png)<!-- -->

Currently our plots have the default ggplot theme which has a grey background. We can change this by setting a new theme. To do so you use `theme_` and select a theme which works best.


```r
# change theme to black and white
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal) +
  theme_bw()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

```r
# change theme to dark
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal) +
  theme_dark()
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-29-2.png)<!-- -->

Adding a theme to each plot can be tiring, so instead you can set a theme for all your plots by using the `theme_set()` function. Usually you set the theme before you make any of your visualisations. Now we have changed the theme to black and white, all our plots from now on will have a black and white theme.


```r
# set global theme
theme_set(theme_bw())

# see result
ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

It is often useful and helpful to arrange the values by their rank or size. There are options to do this with base R, but the `forcats` library from the tidyverse makes arranging and ordering functions very straightforward.

We will use the `fct_infreq()` function, which means factors in frequency, in effect ordering our factors by the frequency they appear. There are two approaches. First we use the `fct_infreq()` function within ggplot, or second we arrange our factor outside ggplot. Outside of ggplot is usually better as you have more control and it make your ggplot code easier to read.


```r
# load forcats
library(forcats)

# arrange by frequency within ggplot
ggplot(pokemon, aes(x = fct_infreq(type1), fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-31-1.png)<!-- -->

```r
# arrange by frequency outside ggplot
pokemon$type1 <- fct_infreq(pokemon$type1)

ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-31-2.png)<!-- -->

We can also reverse the ordering by putting putting our `fct_infreq()` function inside a `fct_rev()` function (stands for factor reverse).


```r
# arrange by frequency (descending)
pokemon$type1 <- fct_rev(fct_infreq(pokemon$type1))

ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-32-1.png)<!-- -->

More information on the forcats package can be found here: <https://forcats.tidyverse.org/index.html>

Finally, let's save and label our example bar plot.


```r
# save and label
count_type1 <- ggplot(pokemon, aes(x = type1, fill = legendary)) +
  geom_bar() + 
  coord_flip() +
  scale_fill_manual(values = manual_pal) +
  labs(title = "Frequency of each Pokemon type",
       subtitle = "Coloured by if legendary or not",
       y = "Frequency of Pokemon type",
       x = "Type of Pokemon",
       fill = "Legendary pokemon?")

count_type1
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-33-1.png)<!-- -->

```r
ggsave("count_type1.PNG", count_type1)
```

```
## Saving 7 x 5 in image
```

## Bar plots with counts exercise

Using the examples above, make a visualisation of the frequency of ski jump medal winners per country (team) from the Olympics dataset.

Try to include:

-   Setting a new theme using `theme_set()`\
-   Order the x axis by the frequency in reverse order\
-   Colour the medals like we did in the last exercise\
-   Decide if position stack, dodge or fill work best with this visualisation\
-   Add a title and labels\
-   Save your visualisation


```r
# your code here

theme_set(theme_minimal())

# filter commands & change factor levels and order
ski_jump_medal <- olympics %>%
  filter(sport == "Ski Jumping" & !is.na(medal)) %>%
  mutate(team = fct_rev(fct_infreq(team)),
         medal = factor(medal, levels = c("Gold", "Silver", "Bronze")))

# make manual medal colours
medal_colours <- c("#FFD700", "#C0C0C0", "#CD7F32")

# ski jumping
ski_jump_medal_p <- ggplot(ski_jump_medal, aes(x = team, fill = medal)) +
  geom_bar(position = "stack") + 
  scale_fill_manual(values = medal_colours) + 
  coord_flip() + 
  labs(title = "Frequency of ski jumping medal winners by each country",
       subtitle = "Coloured by medal",
       x = "Competing country",
       y = "Frequency of Medals")

ski_jump_medal_p
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-34-1.png)<!-- -->

```r
# save
ggsave("ski_jump_medal_p.PNG", ski_jump_medal_p)
```

```
## Saving 7 x 5 in image
```

# Bar plots with other statistics

A very useful function of bar plots is to show a group average instead of frequency. There are two approaches to showing a group average in a bar plot.

The first route is aggregate your dataset, then add it into your bar plot as shown in the example below. We first use `group_by()` and `summarise()` from dplyr to find an average, in this case the average total statistics by pokemon generation.

We then put this data into ggplot. The difference from a normal bar plot is we provide a y axis (our calculated average), and add `stat = "identity"` to the `geom_bar()` function.

This is a great approach as it is easy to see what is happening at each step, making it simple to identify issues and make changes if needed.


```r
# group and summarise to make average
avg_total_gen <- pokemon %>%
  group_by(generation) %>%
  summarise(avg_total = mean(total, na.rm = TRUE))

# print result
avg_total_gen
```

```
## # A tibble: 8 × 2
##   generation avg_total
##   <fct>          <dbl>
## 1 1               408.
## 2 2               406.
## 3 3               408.
## 4 4               450.
## 5 5               435.
## 6 6               439.
## 7 7               459.
## 8 8               446.
```

```r
# add to bar plot with stat identity
ggplot(avg_total_gen, aes(x = generation, y = avg_total)) +
  geom_bar(stat = "identity")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-35-1.png)<!-- -->

The other approach is to use the `stat_summary()` function to perform the same plot. The difference from a normal bar plot is we again provide the y axis but provide the variable we want to aggregate, total in this case. We then call `stat_summary()` and add two arguments, the function we want to use and what type of geometry to use; we've used mean and bar.

While this is less code, which is a good thing, it is hard to understand the steps taken to make the summary.


```r
ggplot(pokemon, aes(x = generation, y = total)) +
  stat_summary(fun = "mean", geom = "bar")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-36-1.png)<!-- -->

We can also add error bars to our plots to help us understand how precise our average measure is. To add error bars it is generally easier to use the group_by and summarise approach. We will look at two types of error bars, the standard deviation and the standard error of the mean.

The standard deviation indicates how close sample values are to the average of all data points, and the accuracy of the average. The standard error of the mean is the discrepancy of the sample mean and the true mean, telling you the accuracy of the sample mean.

To calculate, we do the same aggregation as we did before but add sd (standard deviation) to the summarise function and calculate the sem (standard error of the mean) in a mutate function.


```r
# group and summarise to make average and sd per group
avg_total_gen <- pokemon %>%
  group_by(generation) %>%
  summarise(avg_total = mean(total, na.rm = TRUE),
            sd = sd(total, na.rm = TRUE)) %>%
  mutate(sem = sd/sqrt(length(sd)))

# print result
avg_total_gen
```

```
## # A tibble: 8 × 4
##   generation avg_total    sd   sem
##   <fct>          <dbl> <dbl> <dbl>
## 1 1               408.  99.9  35.3
## 2 2               406. 112.   39.7
## 3 3               408. 117.   41.2
## 4 4               450. 115.   40.7
## 5 5               435. 108.   38.2
## 6 6               439. 116.   40.9
## 7 7               459. 123.   43.6
## 8 8               446. 125.   44.3
```

To add error bars we use the `geom_errorbar()` function, which requires two arguments within an `aes()` function, the `ymin` and `ymax`. To find `ymin` or `ymax` we plus or minus our avg_total (y axis value) by the sd/sem.


```r
# adding standard deviation error bars
ggplot(avg_total_gen, aes(x = generation, y = avg_total)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = avg_total-sd, ymax = avg_total+sd)) +
  labs(title = "Average Pokemon total statistics by generation",
       subtitle = "Error bars indicate standard deviation")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-38-1.png)<!-- -->

```r
# adding standard error bars
ggplot(avg_total_gen, aes(x = generation, y = avg_total)) +
  geom_bar(stat = "identity") +
  geom_errorbar(aes(ymin = avg_total-sem, ymax = avg_total+sem)) +
  labs(title = "Average Pokemon total statistics by generation",
       subtitle = "Error bars indicate standard error of the mean")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-38-2.png)<!-- -->

You can edit the look of the error bars, such as making them narrower and changing the colour. See the example below on how to do this. We've also changed the colour of the bars too.


```r
ggplot(avg_total_gen, aes(x = generation, y = avg_total)) +
  geom_bar(stat = "identity", fill = "orange") +
  geom_errorbar(aes(ymin = avg_total-sem, ymax = avg_total+sem), width = 0.3, colour = "darkblue") +
  labs(title = "Average Pokemon total statistics by generation",
       subtitle = "Error bars indicate standard error of the mean")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-39-1.png)<!-- -->

If you want to add error bars to bar plots with different groupings on the x axis we need to made a few subtle changes, the main change is we need to have a dodge bar chart.

First we will re run our avg_total_gen aggregation and add another column to our group_by. We then pre-define how wide the bars and error bars should be. Instead of using `position = "dodge"` we use our dodge variable we just made, and add the fill to be legendary (our second grouping).


```r
# group by legendary as well
avg_total_gen <- pokemon %>%
  group_by(generation, legendary) %>%
  summarise(avg_total = mean(total, na.rm = TRUE),
            sd = sd(total, na.rm = TRUE)) %>%
  mutate(sem = sd/sqrt(length(sd)))
```

```
## `summarise()` has grouped output by 'generation'. You can override using the `.groups` argument.
```

```r
# pre-define the dodge position
dodge <- position_dodge(width = 0.8)

ggplot(avg_total_gen, aes(x = generation, y = avg_total, fill = legendary)) +
  geom_bar(stat = "identity", position = dodge) +
  geom_errorbar(aes(ymin = avg_total-sem, ymax = avg_total+sem), position = dodge, width = 0.3) +
  labs(title = "Average Pokemon total statistics by generation",
       subtitle = "Error bars indicate standard error of the mean") +
  scale_fill_manual(values = manual_pal)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-40-1.png)<!-- -->

## Bar plots with other statistics exercise

Using the examples above and the Olympics dataset, make a visualisation of the average age (mean or median) of GBR (Great Britain) medal winners by medal type and gender, making sure to

-   show the difference between male and female athletes using colours
-   show error bars for either standard deviation or standard error of the mean
-   colour, label and save your visualisation

*hint: don't forgot to use dodge `<- position_dodge(width = 0.8)`*


```r
# your code here

gbr_medalists <- olympics %>%
  filter(noc == "GBR" & !is.na(medal)) %>%
  group_by(medal, sex) %>%
  summarise(avg_age = median(age, na.rm = TRUE),
            sd = sd(age, na.rm = TRUE)) %>%
  mutate(sem = sd/sqrt(length(sd)),
         medal = factor(medal, levels = c("Gold", "Silver", "Bronze")))
```

```
## `summarise()` has grouped output by 'medal'. You can override using the `.groups` argument.
```

```r
dodge <- position_dodge(width = 0.8)

ggplot(gbr_medalists, aes(x = medal, y = avg_age, fill = sex)) +
  geom_bar(stat = "identity", position = dodge) +
  geom_errorbar(aes(ymin = avg_age-sem, ymax = avg_age+sem), position = dodge, width = 0.3) +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Average age of GBR medalists by medal type and gender",
       subtitle = "Error bar indicates SEM")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-41-1.png)<!-- -->

```r
gbr_medals <- ggplot(gbr_medalists, aes(x = medal, y = avg_age, fill = sex)) +
  geom_bar(stat = "identity", position = dodge) +
  geom_errorbar(aes(ymin = avg_age-sd, ymax = avg_age+sd), position = dodge, width = 0.3) +
  scale_fill_brewer(palette = "Set3") +
  labs(title = "Average age of GBR medalists by medal type and gender",
       subtitle = "Error bar indicates SD")

gbr_medals
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-41-2.png)<!-- -->

```r
ggsave("gbr_medals.PNG", gbr_medals)
```

```
## Saving 7 x 5 in image
```

# Beyond bar plots

Bar plots are not the only option to view aggregated data, and there are some sources that suggest bar plots are less than ideal for any visualisation other than showing the frequency of a continuous variable. See <https://paulvanderlaken.com/2018/12/17/avoid-bar-plots-for-continuous-data-do-this-instead/> for details on this.

Fortunately, there are alternatives, such as box plots which will be covered in the second data visualisation workshop, or we can use scatter plots! Scatter plots allow us to see all the data and we can add on an average, the best of both worlds.

In order to recreate what we just did with bar plots with scatter plots we can either use both `geom_point()` and `stat_summary()`, or make a summary table and add that using a second `geom_point()` function. First, lets just plot the data as a scatter plot, making the points larger and more transparent. Lowering the transparency (alpha) is important in these plots as darker colours indicate a higher density of data points.


```r
ggplot(pokemon, aes(x = generation, y = total)) +
  geom_point(size = 5, alpha = .33)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-42-1.png)<!-- -->

Now we can add the `stat_summary()` function. We are going to use the mean, the geom is point, and the shape is a the `-` symbol (number 95); we will also make the shape larger so we can see it easier.


```r
# using stat_summary
ggplot(pokemon, aes(x = generation, y = total)) +
  geom_point(size = 5, alpha = .33) +
  stat_summary(fun = mean, geom = "point",
               shape = 95, size = 20)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-43-1.png)<!-- -->

If we use the summary table option we first make a summary table with `group_by()` and `summarise()`. Then we add two `geom_point()` functions. The first has the pokemon data and our x and y axis. The second is our summary table, with the same x axis and the `avg_total` as the y axis. 

```r
# summary table option
gen_avg_total <- pokemon %>%
  group_by(generation) %>%
  summarise(avg_total = mean(total, na.rm = TRUE))

gen_avg_total
```

```
## # A tibble: 8 × 2
##   generation avg_total
##   <fct>          <dbl>
## 1 1               408.
## 2 2               406.
## 3 3               408.
## 4 4               450.
## 5 5               435.
## 6 6               439.
## 7 7               459.
## 8 8               446.
```

```r
ggplot() +
  geom_point(data = pokemon,
             aes(x = generation, y = total),
             size = 5, alpha = .33) +
  geom_point(data = gen_avg_total,
             aes(x = generation, y = avg_total),
             shape = 95, size = 20)
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-44-1.png)<!-- -->

Either option works well, but for the rest of the examples we will use the `stat_summary()` option as it is less code. 

Now we have all our data so we can see the number of points for each group, and we can see the average per group!

Finally, we can add colour by our grouped variable (legendary) and change the colour palette. Just like with the bar plots we can adjust the positioning from stack to dodge. The examples below show both stack and dodge versions.

```r
# position stacked
ggplot(pokemon, aes(x = generation, y = total, colour = legendary)) +
  geom_point(size = 5, alpha = 0.3) + 
  stat_summary(fun = mean, geom = "point",
               shape = 95, size = 20) +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-45-1.png)<!-- -->

```r
# position dodge
dodge <- position_dodge(width = 0.8)

ggplot(pokemon, aes(x = generation, y = total, colour = legendary)) +
  geom_point(size = 5, alpha = 0.3, position = dodge) + 
  stat_summary(fun = mean, geom = "point",
               shape = 95, size = 20,
               position = dodge) +
  scale_colour_brewer(palette = "Set1")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-45-2.png)<!-- -->

## Beyond bar plots exercise

Recreate your last visualisation, average age (mean or median) of GBR (Great Britain) medal winners by medal type and gender, using the `geom_point()` and `stat_summary()` method detailed above.


```r
# your code here

dodge <- position_dodge(width = 0.8)

gbr_medals_point <- olympics %>%
  filter(noc == "GBR" & !is.na(medal)) %>%
  mutate(medal = factor(medal, levels = c("Gold", "Silver", "Bronze"))) %>%
  ggplot(aes(x = medal, y = age, colour = sex)) +
  geom_point(position = dodge, alpha = 0.6, size = 5) +
  stat_summary(fun = mean, geom = "point",
               shape = 95, size = 25,
               position = dodge, alpha = 0.6) +
  scale_colour_brewer(palette = "Set2") +
  labs(title = "Average age of GBR medalists by medal type and gender")

gbr_medals_point
```

```
## Warning: Removed 103 rows containing non-finite values (stat_summary).
```

```
## Warning: Removed 103 rows containing missing values (geom_point).
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-46-1.png)<!-- -->

```r
ggsave("gbr_medals_point.PNG", gbr_medals_point)
```

```
## Saving 7 x 5 in image
```

```
## Warning: Removed 103 rows containing non-finite values (stat_summary).

## Warning: Removed 103 rows containing missing values (geom_point).
```

# Final task

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

*add survey here*

The solutions we be available from a link at the end of the survey.

# Individual coding challenge

For the individual coding challenge we will be using the food consumption data from tidy tuesday: <https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-02-18/readme.md>.

Use what we have covered in this workshop to make two visualisations of this dataset:

-   A scatter plot showing consumption and co2 emissions for a selected country (e.g. UK or France)
-   A bar plot of average co2 emissions per food category. Display just six countries to compare, such as UK, France, Germany etc. and colour them.

Use some of the tips we used and showed to make the visualisations have labels, colours and look appealing. Try and have some fun with it! =)


```r
food_consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   country = col_character(),
##   food_category = col_character(),
##   consumption = col_double(),
##   co2_emmission = col_double()
## )
```

```r
food_consumption %>%
  glimpse()
```

```
## Rows: 1,430
## Columns: 4
## $ country       <chr> "Argentina", "Argentina", "Argentina", "Argentina", "Arg…
## $ food_category <chr> "Pork", "Poultry", "Beef", "Lamb & Goat", "Fish", "Eggs"…
## $ consumption   <dbl> 10.51, 38.66, 55.48, 1.56, 4.36, 11.39, 195.08, 103.11, …
## $ co2_emmission <dbl> 37.20, 41.53, 1712.00, 54.63, 6.96, 10.46, 277.87, 19.66…
```

```r
# your code here

# uk food consumption
uk_co2_food <- food_consumption %>%
  filter(country == "United Kingdom") %>%
  ggplot(aes(consumption, co2_emmission, colour = food_category)) + 
  geom_point(size = 5, alpha = 0.9) +
  scale_colour_brewer(palette = "Set3") +
  labs(title = "UK food consumption vs co2 emissions by food category")

uk_co2_food
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-47-1.png)<!-- -->

```r
ggsave("uk_co2_food.PNG", uk_co2_food)
```

```
## Saving 7 x 5 in image
```

```r
# EU avg_c02 emissions by food type
sel_countries <- c("United Kingdom", "Germany", "France",
                   "Spain", "Italy", "Netherlands")

eu_avg_co2 <- food_consumption %>%
  group_by(food_category, country) %>%
  summarise(avg_co2 = mean(co2_emmission)) %>%
  filter(country %in% sel_countries) %>%
  ggplot(aes(food_category, avg_co2, fill = country)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Average EU country co2 emissions by food category")
```

```
## `summarise()` has grouped output by 'food_category'. You can override using the `.groups` argument.
```

```r
eu_avg_co2
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-47-2.png)<!-- -->

```r
ggsave("eu_avg_co2.PNG", eu_avg_co2)
```

```
## Saving 7 x 5 in image
```

```r
# food category averages
avg_food_cat <- food_consumption %>%
  ggplot(aes(food_category, co2_emmission, colour = food_category)) +
  geom_point(size = 5, alpha = 0.6) +
  stat_summary(fun = mean, geom = "point",
               shape = 108, size = 10) + 
  coord_flip() +
  scale_colour_brewer(palette = "Set3") +
  labs(title = "Average co2 emissions of food categories")

avg_food_cat
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-47-3.png)<!-- -->

```r
ggsave("avg_food_cat.PNG", avg_food_cat)
```

```
## Saving 7 x 5 in image
```

------------------------------------------------------------------------

# Understanding which visualisation to use and when

Sometimes it can be hard to know where to start with a visualisation. A great first starting point is understanding the options depending on the data types you have available. This website gives lots of information and visual guides on this process: <https://www.data-to-viz.com/>

# Seeing what others have done with this data

The Olympics data we used for the exercises today is from the Tidy Tuesday GitHub repository. Tidy Tuesday is a social data visualisation challenge that happens every week and is a great way of learning about data viz.

The the link below to see what others have done and posted about using the Olympics data. Use it to get some ideas on what else you can try and do or get some inspiration from others. <https://twitter.com/search?lang=en&q=%23tidytuesday%20olympics&src=typed_query>

# Fun extra

As a fun extra you can manually determine shapes in your visualisation using `scale_shape_manual()`. We've also removed the guide which was unnecessary by using `guide = "none"`. 

In the example below, as our x axis is generation from 1 to 8, we can make generation 1 have a shape of the number 1 and so on. 

```r
ggplot(pokemon, aes(x = generation, y = total, shape = generation)) +
  geom_point(size = 5, alpha = .33) +
  stat_summary(fun = mean, geom = "point",
               shape = 95, size = 20) +
  scale_shape_manual(values = c(49:56),
                     guide = "none")
```

![](r_data_visualistion_1_solutions_files/figure-html/unnamed-chunk-48-1.png)<!-- -->

