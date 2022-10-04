---
title: "R Data Wrangling 3 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "04 October, 2022"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: TRUE
    toc_float: TRUE
---

# Objective of workshop

To join together two related datasets, and perform cross tabulation and aggregation using dplyr. 

# What this workshop will cover

In this workshop, the aim is to cover how to perform relational joins, perform cross tabulation, and aggregate data. We will be covering:

-   Relational joining of datasets
-   Cross tabulation
-   Grouping and aggregating your data
-   Rowwise aggregations

------------------------------------------------------------------------

# Introduction to joining data

In previous workshops we have introduced how to combine data frames together that have matching columns using the `rbind` and `cbind` functions. 

Here we will introduce relational (or mutating) joins. This means the data frames are related by common columns, such as a id column, but the rest of the data held is different. These are known as relational data, in that multiple tables of data are related to each other, rather than being stand alone datasets.

In our example we will have a person information data frame, with name and age, and a food information data frame with favourite food and allergies; both data frames have a id column which we can use to join them.


```r
# Make a person information data frame
Person_Info <- data.frame(
  ID = 1:6,
  Name = c("Andrew", "Chloe", "Antony", "Cleopatra", "Zoe", "Nathan"),
  Age = c(28, 26, 19, 35, 21, 42)
  )

Person_Info
```

```
##   ID      Name Age
## 1  1    Andrew  28
## 2  2     Chloe  26
## 3  3    Antony  19
## 4  4 Cleopatra  35
## 5  5       Zoe  21
## 6  6    Nathan  42
```

```r
# Make a food information data frame
Food_Info <- data.frame(
  ID = c(1, 4, 7),
  Fav_Food = c("Pizza", "Pasta con il pesto alla Trapanese", "Egg fried rice"),
  Allergic = c(NA, "Soy", "Shellfish")
)

Food_Info
```

```
##   ID                          Fav_Food  Allergic
## 1  1                             Pizza      <NA>
## 2  4 Pasta con il pesto alla Trapanese       Soy
## 3  7                    Egg fried rice Shellfish
```

The id columns in our datasets above are a unique identifier (also known as a primary key). This means they identify one observation in their own table. You can test this by either using the `duplicated()` function or use the `filter()` function from dplyr or `duplicated()` with `[]` indexing. 

You should get blank data frames as the output. This is good news and means we have no duplicated data. 

```r
# load dplyr
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
# See if a ID appears more than once
Person_Info[duplicated(Person_Info$ID), ]
```

```
## [1] ID   Name Age 
## <0 rows> (or 0-length row.names)
```

```r
# dplyr method
Person_Info %>%
  filter(duplicated(ID))
```

```
## [1] ID   Name Age 
## <0 rows> (or 0-length row.names)
```

Dplyr has several functions for joining data, which are based on SQL syntax:

-   `inner_join` finds matches between both data frames and drops everything else
-   `left_join` includes all of the data from the left data frame, and matches from the right
-   `right_join` includes all of the data from the right data frame, and matches from the left
-   `full_join` includes all data from both data frames

It can be easier to understand what each join does but seeing it visually. The four images below provide visual representation of what happens from each type of join.**To view images, either switch to visual markdown editor, or knit document to html**. See this short blog post on how to use the visual editor - <https://www.rstudio.com/blog/exploring-rstudio-visual-markdown-editor/>

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/inner_join.png?raw=true){width="700"}
![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/left_join.png?raw=true){width="700"}
![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/right_join.png?raw=true){width="700"}
![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/full_join.png?raw=true){width="700"}

The code below is an example of the syntax to join data frames in dplyr. The syntax is the same for the other joins (left, right, and full). `x` is the table on the right. `y` is the table on the left. `by` indicates which column we are joining our datasets with. In this case both have ID so we join using that column. 

```r
# example with an inner join
people_inner_join <- inner_join(x = Person_Info, y = Food_Info, by = "ID")
people_inner_join
```

```
##   ID      Name Age                          Fav_Food Allergic
## 1  1    Andrew  28                             Pizza     <NA>
## 2  4 Cleopatra  35 Pasta con il pesto alla Trapanese      Soy
```

From the output we can see that the inner join has included only data that is in both Person_Info and Food_Info, anything that didn't match was dropped.

Deciding what join to choose depends on the situation and what you want or expect the output to be. Do you want to bring together two datasets and keep everything? Then a full join would suit that best. Do you want to join two datasets and make sure everything in one of the datasets stays? Then use left or right, depending on which dataset you want the information to stay from. 

## Joining data exercise

Now it is your turn to try out some joins! First we will use some data about Star Trek. We have crew, which is information about different crew members. We also have which tv series each crew member was part of. 

Make sure you run this code before attempting the exercise below. 

```r
# crew information
crew <- data.frame(
  crew_number = c(1:6, 9),
  name = c("Jean-Luc Picard", "Spock", "James T. Kirk", "Data", 
           "Kathryn Janeway", "Nyota Uhura", "Beverly Crusher"),
  rank = c("Captain", "Lieutenant Commander", "Captain", "Lieutenant Commander",
           "Captain", "Lieutenant", "Chief Medical Officer"),
  ship = c("USS Enterprise", "USS Enterprise", "USS Enterprise", "USS Enterprise",
           "USS Voyager", "USS Enterprise", "USS Enterprise")
)
crew
```

```
##   crew_number            name                  rank           ship
## 1           1 Jean-Luc Picard               Captain USS Enterprise
## 2           2           Spock  Lieutenant Commander USS Enterprise
## 3           3   James T. Kirk               Captain USS Enterprise
## 4           4            Data  Lieutenant Commander USS Enterprise
## 5           5 Kathryn Janeway               Captain    USS Voyager
## 6           6     Nyota Uhura            Lieutenant USS Enterprise
## 7           9 Beverly Crusher Chief Medical Officer USS Enterprise
```

```r
# tv series information
tv_series <- data.frame(
  crew_number = 1:8,
  series_name = c("The Next Generation", "Original series", "Original series", "The Next Generation",
                  "Voyager", "Original series", "Deep Space Nine", "Discovery"),
  imdb_rating = c(8.7, 8.4, 8.4, 8.7, 7.8, 8.4, 8.1, 7)
)

tv_series
```

```
##   crew_number         series_name imdb_rating
## 1           1 The Next Generation         8.7
## 2           2     Original series         8.4
## 3           3     Original series         8.4
## 4           4 The Next Generation         8.7
## 5           5             Voyager         7.8
## 6           6     Original series         8.4
## 7           7     Deep Space Nine         8.1
## 8           8           Discovery         7.0
```

Using the example for guidance or the dplyr help page <https://dplyr.tidyverse.org/reference/mutate-joins.html>, attempt the following joins:

1) Perform a left join with x as crew and y as tv_series. Assign the result to st_left and print the result
2) Perform a right join with x as crew and y as tv_series. Assign the result to st_left and print the result
3) Perform a inner join with x as crew and y as tv_series. Assign the result to st_left and print the result
4) Perform a full join with x as crew and y as tv_series. Assign the result to st_left and print the result
5) Review the output from each join you have run. How does the output differ from each join? What rows are kept and dropped from different joins? 


```r
# your code here
st_left <- left_join(x = crew, y = tv_series, by = "crew_number")
st_left
```

```
##   crew_number            name                  rank           ship
## 1           1 Jean-Luc Picard               Captain USS Enterprise
## 2           2           Spock  Lieutenant Commander USS Enterprise
## 3           3   James T. Kirk               Captain USS Enterprise
## 4           4            Data  Lieutenant Commander USS Enterprise
## 5           5 Kathryn Janeway               Captain    USS Voyager
## 6           6     Nyota Uhura            Lieutenant USS Enterprise
## 7           9 Beverly Crusher Chief Medical Officer USS Enterprise
##           series_name imdb_rating
## 1 The Next Generation         8.7
## 2     Original series         8.4
## 3     Original series         8.4
## 4 The Next Generation         8.7
## 5             Voyager         7.8
## 6     Original series         8.4
## 7                <NA>          NA
```

```r
st_right <- right_join(x = crew, y = tv_series, by = "crew_number")
st_right
```

```
##   crew_number            name                 rank           ship
## 1           1 Jean-Luc Picard              Captain USS Enterprise
## 2           2           Spock Lieutenant Commander USS Enterprise
## 3           3   James T. Kirk              Captain USS Enterprise
## 4           4            Data Lieutenant Commander USS Enterprise
## 5           5 Kathryn Janeway              Captain    USS Voyager
## 6           6     Nyota Uhura           Lieutenant USS Enterprise
## 7           7            <NA>                 <NA>           <NA>
## 8           8            <NA>                 <NA>           <NA>
##           series_name imdb_rating
## 1 The Next Generation         8.7
## 2     Original series         8.4
## 3     Original series         8.4
## 4 The Next Generation         8.7
## 5             Voyager         7.8
## 6     Original series         8.4
## 7     Deep Space Nine         8.1
## 8           Discovery         7.0
```

```r
st_inner <- inner_join(x = crew, y = tv_series, by = "crew_number")
st_inner
```

```
##   crew_number            name                 rank           ship
## 1           1 Jean-Luc Picard              Captain USS Enterprise
## 2           2           Spock Lieutenant Commander USS Enterprise
## 3           3   James T. Kirk              Captain USS Enterprise
## 4           4            Data Lieutenant Commander USS Enterprise
## 5           5 Kathryn Janeway              Captain    USS Voyager
## 6           6     Nyota Uhura           Lieutenant USS Enterprise
##           series_name imdb_rating
## 1 The Next Generation         8.7
## 2     Original series         8.4
## 3     Original series         8.4
## 4 The Next Generation         8.7
## 5             Voyager         7.8
## 6     Original series         8.4
```

```r
st_full <- full_join(x = crew, y = tv_series, by = "crew_number")
st_full
```

```
##   crew_number            name                  rank           ship
## 1           1 Jean-Luc Picard               Captain USS Enterprise
## 2           2           Spock  Lieutenant Commander USS Enterprise
## 3           3   James T. Kirk               Captain USS Enterprise
## 4           4            Data  Lieutenant Commander USS Enterprise
## 5           5 Kathryn Janeway               Captain    USS Voyager
## 6           6     Nyota Uhura            Lieutenant USS Enterprise
## 7           9 Beverly Crusher Chief Medical Officer USS Enterprise
## 8           7            <NA>                  <NA>           <NA>
## 9           8            <NA>                  <NA>           <NA>
##           series_name imdb_rating
## 1 The Next Generation         8.7
## 2     Original series         8.4
## 3     Original series         8.4
## 4 The Next Generation         8.7
## 5             Voyager         7.8
## 6     Original series         8.4
## 7                <NA>          NA
## 8     Deep Space Nine         8.1
## 9           Discovery         7.0
```


# Dealing with common join issues

A common problem when joining data in R is how to perform a join when your key columns don't match. There is a trick to deal with this that comes from SQL; dplyr is based off SQL so this makes sense.

In the *by* argument in the join functions we do something like `by = c("id_number" = "id")`, which in the full function call looks like `left_join(df1, df2, by = c("id_number" = "id"))`. In english this means: I want to join the data tables by id_number from df1, and id from df2. 

It is usually easier to see this as an example. We can use our previous data, with some slight modifications; notice the IDs are different. 

```r
# make our example data again
Person_Info <- data.frame(
  ID_num = seq(1:6),
  Name = c("Andrew", "Chloe", "Antony", "Cleopatra", "Zoe", "Nathan"),
  Age = c(28, 26, 19, 35, 21, 42)
  )

Food_Info <- data.frame(
  ID = c(1, 4, 7),
  Fav_Food = c("Pizza", "Pasta con il pesto alla Trapanese", "Egg fried rice"),
  Allergic = c(NA, "Soy", "Shellfish"), 
  Age = c(28, 35, 39)
)

names(Person_Info)
```

```
## [1] "ID_num" "Name"   "Age"
```

```r
names(Food_Info)
```

```
## [1] "ID"       "Fav_Food" "Allergic" "Age"
```

The order of the variables in the *by* argument is important. `Person_Info` has ID_num, and that is our first table, so that has to go first in the *by* argument. `Food_Info` has ID, and that is our second table, so that has to go second in our the *by* argument.

```r
# join using the col = col trick
food_person <- left_join(Person_Info, Food_Info,
                         by = c("ID_num" = "ID"))

food_person
```

```
##   ID_num      Name Age.x                          Fav_Food Allergic Age.y
## 1      1    Andrew    28                             Pizza     <NA>    28
## 2      2     Chloe    26                              <NA>     <NA>    NA
## 3      3    Antony    19                              <NA>     <NA>    NA
## 4      4 Cleopatra    35 Pasta con il pesto alla Trapanese      Soy    35
## 5      5       Zoe    21                              <NA>     <NA>    NA
## 6      6    Nathan    42                              <NA>     <NA>    NA
```

The result gives you the column name for the first by argument you added, which in this case was ID_num. You can also just rename your columns, but this method is more elegant. 

Another common issue is having the same columns in two tables you're joining. Notice in the last output how we have Age.x and Age.y. This is because it appears in both, so the join adds extra labels. We can fix this by adding `Age` into the *by* argument. 


```r
# add age to by
food_person <- left_join(Person_Info, Food_Info,
                         by = c("ID_num" = "ID", "Age"))

food_person
```

```
##   ID_num      Name Age                          Fav_Food Allergic
## 1      1    Andrew  28                             Pizza     <NA>
## 2      2     Chloe  26                              <NA>     <NA>
## 3      3    Antony  19                              <NA>     <NA>
## 4      4 Cleopatra  35 Pasta con il pesto alla Trapanese      Soy
## 5      5       Zoe  21                              <NA>     <NA>
## 6      6    Nathan  42                              <NA>     <NA>
```

Everything now looks good. There can be lots of little issues when joining up data, and often you will need to do a little bit of cleaning to get the data in a fit state to join up. The exercise below takes you through some of these steps! 

## Dealing with common join issues exercise

For the rest of this workshop you'll be using the imdb data we used in previous workshops. We will also be using the Bechdel Test film data. We will be joining the Bechdel data to the imdb dataset.

The Bechdel test is a measure of the representation of women in fiction. Scoring has three criteria which films are scored on: 1) Film has at least two women in it 2) The two, or more, women talk to each other 3) The two, or more, women talk about something besides a man. Films are scored 0 to 3. They score 0 if they don't meet any of the criteria, and 3 if they meet all of them.

Lets jump in, and load our data using the code provided.


```r
# load libraries
library(readr)
library(dplyr)

# load imdb and bechdel
movies_imdb <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/main/r-data-wrangling-1/data/IMDb%20movies.csv")

bechdel <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/main/r-data-wrangling-1/data/raw_bechdel.csv")

# get glimpse of data
movies_imdb %>% glimpse()
```

```
## Rows: 85,855
## Columns: 21
## $ imdb_title_id         <chr> "tt0000009", "tt0000574", "tt0001892", "tt000210…
## $ title                 <chr> "Miss Jerry", "The Story of the Kelly Gang", "De…
## $ year                  <dbl> 1894, 1906, 1911, 1912, 1911, 1912, 1919, 1913, …
## $ date_published        <chr> "1894-10-09", "26/12/1906", "19/08/1911", "13/11…
## $ genre                 <chr> "Romance", "Biography, Crime, Drama", "Drama", "…
## $ duration              <dbl> 45, 70, 53, 100, 68, 60, 85, 120, 120, 55, 121, …
## $ country               <chr> "USA", "Australia", "Germany, Denmark", "USA", "…
## $ language              <chr> "None", "None", NA, "English", "Italian", "Engli…
## $ director              <chr> "Alexander Black", "Charles Tait", "Urban Gad", …
## $ writer                <chr> "Alexander Black", "Charles Tait", "Urban Gad, G…
## $ production_company    <chr> "Alexander Black Photoplays", "J. and N. Tait", …
## $ actors                <chr> "Blanche Bayliss, William Courtenay, Chauncey De…
## $ description           <chr> "The adventures of a female reporter in the 1890…
## $ avg_vote              <dbl> 5.9, 6.1, 5.8, 5.2, 7.0, 5.7, 6.8, 6.2, 6.7, 5.5…
## $ votes                 <dbl> 154, 589, 188, 446, 2237, 484, 753, 273, 198, 22…
## $ budget                <chr> NA, "$ 2250", NA, "$ 45000", NA, NA, NA, "ITL 45…
## $ usa_gross_income      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ worlwide_gross_income <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ metascore             <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ reviews_from_users    <dbl> 1, 7, 5, 25, 31, 13, 12, 7, 4, 8, 9, 9, 16, 8, N…
## $ reviews_from_critics  <dbl> 2, 7, 2, 3, 14, 5, 9, 5, 1, 1, 9, 28, 7, 23, 4, …
```

```r
bechdel %>% glimpse()
```

```
## Rows: 8,839
## Columns: 5
## $ year    <dbl> 1888, 1892, 1895, 1895, 1896, 1896, 1896, 1896, 1897, 1898, 18…
## $ id      <dbl> 8040, 5433, 6200, 5444, 5406, 5445, 6199, 4982, 9328, 4978, 54…
## $ imdb_id <dbl> 392728, 3, 132134, 14, 131, 223341, 12, 91, 41, 135696, 224240…
## $ title   <chr> "Roundhay Garden Scene", "Pauvre Pierrot", "The Execution of M…
## $ rating  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0,…
```

To join the data we need to do some data cleaning. We have remove the text from the imdb data `imdb_title_id` column so it is in the same format as the bechdel dataset. For example, *tt0000574* should be *574*.

1)  We first need to fix the ids in the movies_imdb dataset. Type the following code to fix the ids: `movies_imdb$imdb_title_id <- parse_number(movies_imdb$imdb_title_id)`. The `parse_number()` function is from the readr library, and removes text from strings, which is exactly what we need in this case
2)  Before joining the data we should test for duplicate ids in both datasets. Using the example above, check the duplicates in the imdb_id column in movies_imdb and bechdel datasets.
3)  We have some duplicates in the bechdel data! Use `filter()`, `duplicated()` and the `!` (not) operator to remove them.
4)  Using the `inner_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
5)  Using the `full_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel_full`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
6)  Have a look at both your newly joined up data frames using head, glimpse or View. Do you notice how when we used inner_join we filtered out all data that isn't in our bechdel test dataset?


```r
# your code here

# fix ids so they match (remove tt and 0's)
movies_imdb$imdb_title_id <- parse_number(movies_imdb$imdb_title_id)

# test for duplicates
movies_imdb %>%
  filter(duplicated(imdb_title_id))
```

```
## # A tibble: 0 × 21
## # … with 21 variables: imdb_title_id <dbl>, title <chr>, year <dbl>,
## #   date_published <chr>, genre <chr>, duration <dbl>, country <chr>,
## #   language <chr>, director <chr>, writer <chr>, production_company <chr>,
## #   actors <chr>, description <chr>, avg_vote <dbl>, votes <dbl>, budget <chr>,
## #   usa_gross_income <chr>, worlwide_gross_income <chr>, metascore <dbl>,
## #   reviews_from_users <dbl>, reviews_from_critics <dbl>
```

```r
bechdel %>%
  filter(duplicated(imdb_id))
```

```
## # A tibble: 10 × 5
##     year    id imdb_id title                                              rating
##    <dbl> <dbl>   <dbl> <chr>                                               <dbl>
##  1  1956  5938   35279 Saboteur                                                1
##  2  1959   474   53285 Sleeping Beauty                                         3
##  3  1983  4448   86425 Terms of Endearment                                     1
##  4  1997  4381  117056 Ayneh                                                   3
##  5  2011  4907 2043900 Last Call at the Oasis                                  3
##  6  2013  4980 2457282 Puella Magi Madoka Magica the Movie Part III: The…      3
##  7  2014  8702 2180411 Into the Woods                                          3
##  8  2017  9294      NA Wonder Woman                                            3
##  9  2017  9293      NA Wonder Woman                                            3
## 10  2019  9098      NA The Rise Of Skywalker                                   3
```

```r
# remove bechdel duplicates!
bechdel <- bechdel %>%
  filter(!duplicated(imdb_id))

# inner join to keep just the matches
imdb_bechdel <- inner_join(movies_imdb, bechdel, by = c("imdb_title_id" = "imdb_id", "year", "title"))

# full join with everything 
imdb_bechdel_full <- full_join(movies_imdb, bechdel, by = c("imdb_title_id" = "imdb_id", "year", "title")) 

imdb_bechdel %>% glimpse()
```

```
## Rows: 6,080
## Columns: 23
## $ imdb_title_id         <dbl> 574, 2101, 3973, 4972, 6745, 7361, 8443, 8489, 8…
## $ title                 <chr> "The Story of the Kelly Gang", "Cleopatra", "A F…
## $ year                  <dbl> 1906, 1912, 1914, 1915, 1916, 1916, 1917, 1917, …
## $ date_published        <chr> "26/12/1906", "13/11/1912", "04/09/1916", "21/03…
## $ genre                 <chr> "Biography, Crime, Drama", "Drama, History", "Co…
## $ duration              <dbl> 70, 100, 63, 195, 58, 63, 65, 70, 78, 91, 70, 84…
## $ country               <chr> "Australia", "USA", "USA", "USA", "USA", "USA", …
## $ language              <chr> "None", "English", "English", "None", "English",…
## $ director              <chr> "Charles Tait", "Charles L. Gaskill", "Sidney Dr…
## $ writer                <chr> "Charles Tait", "Victorien Sardou", "Marguerite …
## $ production_company    <chr> "J. and N. Tait", "Helen Gardner Picture Players…
## $ actors                <chr> "Elizabeth Tait, John Tait, Norman Campbell, Bel…
## $ description           <chr> "True story of notorious Australian outlaw Ned K…
## $ avg_vote              <dbl> 6.1, 5.2, 5.8, 6.3, 5.7, 6.2, 6.7, 6.4, 6.1, 5.7…
## $ votes                 <dbl> 589, 446, 202, 22213, 479, 349, 1266, 130, 770, …
## $ budget                <chr> "$ 2250", "$ 45000", NA, "$ 100000", NA, NA, NA,…
## $ usa_gross_income      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ worlwide_gross_income <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ metascore             <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ reviews_from_users    <dbl> 7, 25, 6, 368, 7, 13, 16, 3, 9, 12, 6, 19, 14, 8…
## $ reviews_from_critics  <dbl> 7, 3, 3, 97, 1, 5, 13, 3, 5, 4, 1, 11, 21, 78, 6…
## $ id                    <dbl> 1349, 2003, 4457, 1258, 2008, 7004, 1994, 2019, …
## $ rating                <dbl> 1, 2, 2, 2, 3, 3, 3, 2, 3, 0, 3, 3, 3, 0, 3, 3, …
```

```r
imdb_bechdel_full %>% glimpse()
```

```
## Rows: 88,604
## Columns: 23
## $ imdb_title_id         <dbl> 9, 574, 1892, 2101, 2130, 2199, 2423, 2445, 2452…
## $ title                 <chr> "Miss Jerry", "The Story of the Kelly Gang", "De…
## $ year                  <dbl> 1894, 1906, 1911, 1912, 1911, 1912, 1919, 1913, …
## $ date_published        <chr> "1894-10-09", "26/12/1906", "19/08/1911", "13/11…
## $ genre                 <chr> "Romance", "Biography, Crime, Drama", "Drama", "…
## $ duration              <dbl> 45, 70, 53, 100, 68, 60, 85, 120, 120, 55, 121, …
## $ country               <chr> "USA", "Australia", "Germany, Denmark", "USA", "…
## $ language              <chr> "None", "None", NA, "English", "Italian", "Engli…
## $ director              <chr> "Alexander Black", "Charles Tait", "Urban Gad", …
## $ writer                <chr> "Alexander Black", "Charles Tait", "Urban Gad, G…
## $ production_company    <chr> "Alexander Black Photoplays", "J. and N. Tait", …
## $ actors                <chr> "Blanche Bayliss, William Courtenay, Chauncey De…
## $ description           <chr> "The adventures of a female reporter in the 1890…
## $ avg_vote              <dbl> 5.9, 6.1, 5.8, 5.2, 7.0, 5.7, 6.8, 6.2, 6.7, 5.5…
## $ votes                 <dbl> 154, 589, 188, 446, 2237, 484, 753, 273, 198, 22…
## $ budget                <chr> NA, "$ 2250", NA, "$ 45000", NA, NA, NA, "ITL 45…
## $ usa_gross_income      <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ worlwide_gross_income <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ metascore             <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ reviews_from_users    <dbl> 1, 7, 5, 25, 31, 13, 12, 7, 4, 8, 9, 9, 16, 8, N…
## $ reviews_from_critics  <dbl> 2, 7, 2, 3, 14, 5, 9, 5, 1, 1, 9, 28, 7, 23, 4, …
## $ id                    <dbl> NA, 1349, NA, 2003, NA, NA, NA, NA, NA, NA, NA, …
## $ rating                <dbl> NA, 1, NA, 2, NA, NA, NA, NA, NA, NA, NA, NA, NA…
```

For more information on joins in R I'd recommend reading the R for Data Science chapter on relational data: <https://r4ds.had.co.nz/relational-data.html>. To help understand the join lingo, the full join, inner join etc. we just looked at are *mutating joins*. Of particular use, if you are looking at doing joins on your own data, is the join problems section.

# Cross tabulation

You can perform simple cross tabulation very quickly in R with either the base R `table()` function or `count()` from dplyr. Cross tabulation provides frequencies of categorical data.

In the examples we will look at both the `table` and `count` functions for comparison. First, run the example below to see how to get a frequency table of one categorical variable.


```r
# Some made up tourist data
df1 <- data.frame(
  city = factor(sample(c("Manchester", "Cambridge", "Birmingham", "Bristol"), 20, replace = TRUE)),
  tourist_rating = sample(1:5, 20, replace = TRUE)
)

df1
```

```
##          city tourist_rating
## 1     Bristol              3
## 2  Manchester              1
## 3  Birmingham              4
## 4     Bristol              4
## 5     Bristol              2
## 6     Bristol              4
## 7  Manchester              1
## 8   Cambridge              2
## 9  Birmingham              4
## 10 Manchester              5
## 11  Cambridge              2
## 12  Cambridge              3
## 13 Manchester              5
## 14 Manchester              5
## 15  Cambridge              4
## 16  Cambridge              5
## 17  Cambridge              2
## 18  Cambridge              3
## 19  Cambridge              1
## 20 Manchester              2
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 2
## 2    Bristol 4
## 3  Cambridge 8
## 4 Manchester 6
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          2          4          8          6
```

We can expand this by using conditional operators in the count or table functions.


```r
# conditional frequency
df1 %>%
  count(city == "Cambridge")
```

```
##   city == "Cambridge"  n
## 1               FALSE 12
## 2                TRUE  8
```

```r
table(df1$city == "Cambridge")
```

```
## 
## FALSE  TRUE 
##    12     8
```

An additional nice feature of the count function is you can change the name of the filtered column. Notice in the last example we had *city == "Cambridge"* which is hard to read. We can add a variable name with `count(name = variable)`. In the below example we add *is_cambridge* to change the column name to something more readable.


```r
df1 %>%
  count(is_cambridge = city == "Cambridge")
```

```
##   is_cambridge  n
## 1        FALSE 12
## 2         TRUE  8
```

We can also make two way frequency tables to compare two variables next to each other. Notice the difference between the two functions. Count provides the table in a data frame structure, which is easy to work with should you need to, but table is perhaps easier to read initially.


```r
# two way frequency tables
df1 %>%
  count(city, tourist_rating)
```

```
##          city tourist_rating n
## 1  Birmingham              4 2
## 2     Bristol              2 1
## 3     Bristol              3 1
## 4     Bristol              4 2
## 5   Cambridge              1 1
## 6   Cambridge              2 3
## 7   Cambridge              3 2
## 8   Cambridge              4 1
## 9   Cambridge              5 1
## 10 Manchester              1 2
## 11 Manchester              2 1
## 12 Manchester              5 3
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 0 0 0 2 0
##   Bristol    0 1 1 2 0
##   Cambridge  1 3 2 1 1
##   Manchester 2 1 0 0 3
```

We can also apply filtering using count or table functions. With count we use dplyr's filter function, with table we use base r indexing.


```r
df1 %>%
  filter(tourist_rating == 1 | tourist_rating == 5) %>%
  count(city, tourist_rating)
```

```
##         city tourist_rating n
## 1  Cambridge              1 1
## 2  Cambridge              5 1
## 3 Manchester              1 2
## 4 Manchester              5 3
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 0 0
##   Bristol    0 0
##   Cambridge  1 1
##   Manchester 2 3
```

## Cross tabluation exercise

Using your `imdb_bechdel` data you just made, do the following cross tabulations using dplyr's `count` function. If you have time, you can also do the same with the base r `table` function.

1)  Use count on the rating column in your imdb_bechdel data, which rating has the most results?
2)  Using count on the rating column again, conditionally select ratings greater than 2, and change the column name output to rating_less_two *hint: do this within the count function*.
3)  Create a two way cross tabulation with year and rating columns. Filter for the years 1966 or 1996.


```r
# your code here

# frequency of each value of the bechdel test rating for all data
imdb_bechdel %>%
  count(rating)
```

```
## # A tibble: 4 × 2
##   rating     n
##    <dbl> <int>
## 1      0   519
## 2      1  1440
## 3      2   643
## 4      3  3478
```

```r
table(imdb_bechdel$rating)
```

```
## 
##    0    1    2    3 
##  519 1440  643 3478
```

```r
# Conditional frequency
imdb_bechdel %>%
  count(rating_less_two = rating > 2)
```

```
## # A tibble: 2 × 2
##   rating_less_two     n
##   <lgl>           <int>
## 1 FALSE            2602
## 2 TRUE             3478
```

```r
table(imdb_bechdel$rating > 2)
```

```
## 
## FALSE  TRUE 
##  2602  3478
```

```r
# two way table (with just two years)
imdb_bechdel %>% 
  filter(year == 1966 | year == 1996) %>%
  count(year, rating)
```

```
## # A tibble: 8 × 3
##    year rating     n
##   <dbl>  <dbl> <int>
## 1  1966      0     4
## 2  1966      1    10
## 3  1966      2     2
## 4  1966      3     8
## 5  1996      0     4
## 6  1996      1    23
## 7  1996      2     9
## 8  1996      3    62
```

```r
table(imdb_bechdel$rating, imdb_bechdel$year)[,c("1966", "1996")]
```

```
##    
##     1966 1996
##   0    4    4
##   1   10   23
##   2    2    9
##   3    8   62
```

# Aggregation using grouping

What is aggregation? It is the computation of summary statistics, giving a single output value from several variables.

Frequency tables, like we just use are simple aggregations. They count how many instances of each category you have in your data. You can perform more complicated aggregations by *grouping* your data.

When doing aggregation with dplyr we use the `group_by()` and `summarise()` functions together. We first *group* our data by a categorical variable, in the below example is three groups (A, B, and C). We then call `summarise()` to perform a function on a column in our data, in this case we sum the num1 column. You get a summary table with the sum per group.

You will notice that there are NA values in the num1 column. In order to get our sum function to ignore these we have to add the `na.rm = TRUE` parameter to the `sum()` function.


```r
# make some random data
df2 <- data.frame(
  key = factor(sample(c("A", "B", "C"), 20, replace = TRUE)),
  key2 = factor(sample(c("X", "Y"), 20, replace = TRUE)),
  num1 = sample(c(1:10, NA), 20, replace = TRUE),
  num2 = runif(20, min = 1, max = 10),
  num3 = rnorm(20, mean = 5, sd = 2.5)
)

head(df2)
```

```
##   key key2 num1     num2     num3
## 1   B    Y    4 7.017006 4.455908
## 2   B    X   NA 4.673627 2.598087
## 3   C    Y    7 1.117597 3.914999
## 4   A    Y    3 6.604529 6.239509
## 5   C    Y    1 9.699714 5.664695
## 6   A    X    2 5.377083 1.746045
```

```r
# perform simple grouped aggregation
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1))
```

```
## # A tibble: 3 × 2
##   key    sum1
##   <fct> <int>
## 1 A        NA
## 2 B        NA
## 3 C        21
```

```r
# ignore NAs in sum function
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE))
```

```
## # A tibble: 3 × 2
##   key    sum1
##   <fct> <int>
## 1 A        42
## 2 B        25
## 3 C        21
```

The grouping concept can be a little confusing, and the below illustrations hopefully will help break down the steps, which are as follows:

1)  Group your data by a categorical variable
2)  Split your data by that group. You'll end up with several subsets of data
3)  Perform a function, such as a mean or sum function, based on those split subsets of data
4)  Combine the split subsets back together to make a summary table

![Single group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/Aggregation.png?raw=true){width="600"}

You can also aggregate more than one variable. In the below example, we will run sum on the num1 and num2 variables.


```r
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE))
```

```
## # A tibble: 3 × 3
##   key    sum1  sum2
##   <fct> <int> <dbl>
## 1 A        42  44.5
## 2 B        25  40.7
## 3 C        21  34.2
```

We can take this a bit further by adding the `n()` function, which counts how many of each category in our grouped variable there are. If you want to add in a relative frequency, we can then pipe to a `mutate` function. We then divide our count by the sum of our count.


```r
# adding frequency using n()
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 3 × 5
##   key    sum1  sum2 count_n rel_freq
##   <fct> <int> <dbl>   <int>    <dbl>
## 1 A        42  44.5       8      0.4
## 2 B        25  40.7       6      0.3
## 3 C        21  34.2       6      0.3
```

If you want to extract a single element from an aggregation the `pull()` function is very helpful. It is useful if you make a large aggregation table but only need one column at the moment for a visualisation. You can also add a name from another column, for example we might want to add the key as the name as we did in the example below.


```r
# save our aggregation as agg
agg <- df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))

# extract sum2 column
agg %>%
  pull(sum2)
```

```
## [1] 44.49191 40.69287 34.18836
```

```r
# extract sum2 column and give name
agg %>%
  pull(sum2, key)
```

```
##        A        B        C 
## 44.49191 40.69287 34.18836
```

You can group your data by more than one group. This means when the data is *split*, more subsets are formed for all different possible splits.

![Two group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/Aggregation_twogroup.png?raw=true){width="600"}

To do so, we add an extra categorical column to our `group_by()` function. The ordering of the groups matters. Have a look at both examples with the groups in a different order.


```r
# two group aggregation
df2 %>%
  group_by(key, key2) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## `summarise()` has grouped output by 'key'. You can override using the `.groups`
## argument.
```

```
## # A tibble: 6 × 6
## # Groups:   key [3]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        30 27.4        5    0.625
## 2 A     Y        12 17.1        3    0.375
## 3 B     X         5 17.2        3    0.5  
## 4 B     Y        20 23.5        3    0.5  
## 5 C     X         6  7.61       2    0.333
## 6 C     Y        15 26.6        4    0.667
```

```r
# flip the groups to see the difference
df2 %>%
  group_by(key2, key) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## `summarise()` has grouped output by 'key2'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 6 × 6
## # Groups:   key2 [2]
##   key2  key    sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 X     A        30 27.4        5      0.5
## 2 X     B         5 17.2        3      0.3
## 3 X     C         6  7.61       2      0.2
## 4 Y     A        12 17.1        3      0.3
## 5 Y     B        20 23.5        3      0.3
## 6 Y     C        15 26.6        4      0.4
```

You can manually adjust the grouping structure of the output from your aggregation. By default, dplyr will use just your first grouping variable in the result. You can see this from the output from `rel_freq`. To change this, we use the `.groups` argument. Below are two examples, where we either drop all grouping with "drop" or keep the structure of the grouping with "keep". The default argument is "drop_last", which we what we have seen where only the first grouping is kept in the result.


```r
# adjusting the grouping structure of the result: drop
df2 %>%
  group_by(key, key2) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE),
            count_n = n(), .groups = "drop") %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 6 × 6
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        30 27.4        5     0.25
## 2 A     Y        12 17.1        3     0.15
## 3 B     X         5 17.2        3     0.15
## 4 B     Y        20 23.5        3     0.15
## 5 C     X         6  7.61       2     0.1 
## 6 C     Y        15 26.6        4     0.2
```

```r
# keep
df2 %>%
  group_by(key, key2) %>%
  summarise(sum1 = sum(num1, na.rm = TRUE), 
            sum2 = sum(num2, na.rm = TRUE),
            count_n = n(), .groups = "keep") %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 6 × 6
## # Groups:   key, key2 [6]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        30 27.4        5        1
## 2 A     Y        12 17.1        3        1
## 3 B     X         5 17.2        3        1
## 4 B     Y        20 23.5        3        1
## 5 C     X         6  7.61       2        1
## 6 C     Y        15 26.6        4        1
```

## Aggregation exercise

Using the examples above, we are going to create three aggregations from our `imdb_bechdel` dataset we made earlier in the session.

1)  Group your imdb_bechdel data by rating, and use summarise to find the avg_vote per rating, and the frequency of each group. Use `median()` to calculate the average.
2)  Filter for years greater than 2015 and group by year. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Use `median()` to calculate the average.
3)  Filter for years greater than 2015 and group by year and rating. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Finally, pipe to a mutate function, and calculate the relative frequency of each year. Use `median()` to calculate the average.
4)  Filter for years greater than 2015 and group by rating. Summarise the median reviews_from_users and the median reviews_from_critics. Why are their NA values and how do should you fix them?
5)  Using your code from part 2, use the pull function to extract the avg_duration, and use the year column as the name.


```r
# your code here

# avg_vote by rating
imdb_bechdel %>%
  group_by(rating) %>%
  summarise(avg_vote_rating = median(avg_vote),
            count_n = n()) 
```

```
## # A tibble: 4 × 3
##   rating avg_vote_rating count_n
##    <dbl>           <dbl>   <int>
## 1      0             6.8     519
## 2      1             6.8    1440
## 3      2             6.8     643
## 4      3             6.6    3478
```

```r
# avg_vote and duration by year
(year_vote <- imdb_bechdel %>%
  filter(year > 2015) %>%
  group_by(year) %>%
  summarise(avg_vote_year = median(avg_vote),
            avg_duration = median(duration),
            count_n = n()))  
```

```
## # A tibble: 5 × 4
##    year avg_vote_year avg_duration count_n
##   <dbl>         <dbl>        <dbl>   <int>
## 1  2016          6.5          106      241
## 2  2017          6.4          105      196
## 3  2018          6.55         106      164
## 4  2019          6.5          106.     164
## 5  2020          6.5          102.      44
```

```r
# avg_vote and duration by year and rating
imdb_bechdel %>%
  filter(year > 2015) %>%
  group_by(year, rating) %>%
  summarise(avg_vote_year = median(avg_vote),
            avg_duration = median(duration),
            count_n = n()) %>%
  mutate(rel_freq = round(count_n / sum(count_n), 2))
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 20 × 6
## # Groups:   year [5]
##     year rating avg_vote_year avg_duration count_n rel_freq
##    <dbl>  <dbl>         <dbl>        <dbl>   <int>    <dbl>
##  1  2016      0          6.2          103       15     0.06
##  2  2016      1          6.7          106       52     0.22
##  3  2016      2          6.25         103       28     0.12
##  4  2016      3          6.5          106.     146     0.61
##  5  2017      0          6.2          101       13     0.07
##  6  2017      1          6.6          113       37     0.19
##  7  2017      2          6.1          102.      16     0.08
##  8  2017      3          6.4          104      130     0.66
##  9  2018      0          6             85        9     0.05
## 10  2018      1          6.75         111       24     0.15
## 11  2018      2          6.6          116       17     0.1 
## 12  2018      3          6.5          106.     114     0.7 
## 13  2019      0          7.2          115        9     0.05
## 14  2019      1          6.7          117       37     0.23
## 15  2019      2          6.8          109       13     0.08
## 16  2019      3          6.3          102      105     0.64
## 17  2020      0          6.65         102        2     0.05
## 18  2020      1          6.5          104        5     0.11
## 19  2020      2          5.2          109        1     0.02
## 20  2020      3          6.5          102.      36     0.82
```

```r
# avg reviews from users and critics per bechdel rating
imdb_bechdel %>%
  filter(year > 2015) %>%
  group_by(rating) %>%
  summarise(avg_user_review = median(reviews_from_users, na.rm = TRUE),
            avg_critic_review = median(reviews_from_critics, na.rm = TRUE))
```

```
## # A tibble: 4 × 3
##   rating avg_user_review avg_critic_review
##    <dbl>           <dbl>             <dbl>
## 1      0            122.              85.5
## 2      1            267              148  
## 3      2            288              199  
## 4      3            234              161
```

```r
# extract just avg_duration
year_vote %>%
  pull(avg_duration, year)
```

```
##  2016  2017  2018  2019  2020 
## 106.0 105.0 106.0 106.5 102.5
```

# Rowwise aggregation

So far we have performed operations (functions) over columns, but sometimes you want to perform operations by rows. For example, you might want to find the average value for each row of several columns in a data frame.

Performing row based aggregation in r can be done with either one of these two functions: dplyr's `rowwise()` or base r's `rowMeans()`.

In the below examples we are using `rowwise()` with `summarise()`, just like we did with `group_by` and `summarise`. You get a total average back for each row in your dataset.


```r
head(df2)
```

```
##   key key2 num1     num2     num3
## 1   B    Y    4 7.017006 4.455908
## 2   B    X   NA 4.673627 2.598087
## 3   C    Y    7 1.117597 3.914999
## 4   A    Y    3 6.604529 6.239509
## 5   C    Y    1 9.699714 5.664695
## 6   A    X    2 5.377083 1.746045
```

```r
# rowwise on selected columns
df2 %>%
  rowwise() %>%
  summarise(total_avg = mean(c(num1, num2, num3), na.rm = TRUE))
```

```
## # A tibble: 20 × 1
##    total_avg
##        <dbl>
##  1      5.16
##  2      3.64
##  3      4.01
##  4      5.28
##  5      5.45
##  6      3.04
##  7      5.90
##  8      5.46
##  9      4.94
## 10      7.73
## 11      5.28
## 12      6.58
## 13      5.37
## 14      4.54
## 15      4.56
## 16      5.27
## 17      6.53
## 18      4.68
## 19      6.78
## 20      3.12
```

```r
# rowwise using c_across
df2 %>%
  rowwise() %>%
  summarise(total_avg = mean(c_across(num1:num3), na.rm = TRUE)) 
```

```
## # A tibble: 20 × 1
##    total_avg
##        <dbl>
##  1      5.16
##  2      3.64
##  3      4.01
##  4      5.28
##  5      5.45
##  6      3.04
##  7      5.90
##  8      5.46
##  9      4.94
## 10      7.73
## 11      5.28
## 12      6.58
## 13      5.37
## 14      4.54
## 15      4.56
## 16      5.27
## 17      6.53
## 18      4.68
## 19      6.78
## 20      3.12
```

If you want to add that total column to your data you use `mutate` instead of summarise. This is the most useful functionally of doing rowwise operations, as it allows you to calculate for each row a summary across several columns.


```r
# Adding the aggregation as a new column 
df2 %>%
  rowwise() %>%
  mutate(total_avg = mean(c_across(num1:num3), na.rm = TRUE))
```

```
## # A tibble: 20 × 6
## # Rowwise: 
##    key   key2   num1  num2   num3 total_avg
##    <fct> <fct> <int> <dbl>  <dbl>     <dbl>
##  1 B     Y         4  7.02  4.46       5.16
##  2 B     X        NA  4.67  2.60       3.64
##  3 C     Y         7  1.12  3.91       4.01
##  4 A     Y         3  6.60  6.24       5.28
##  5 C     Y         1  9.70  5.66       5.45
##  6 A     X         2  5.38  1.75       3.04
##  7 A     X         6  5.83  5.87       5.90
##  8 C     X         5  4.37  7.01       5.46
##  9 C     X         1  3.25 10.6        4.94
## 10 B     Y        10  9.79  3.39       7.73
## 11 A     Y         9  3.79  3.05       5.28
## 12 A     Y        NA  6.70  6.46       6.58
## 13 A     X        10  5.20  0.916      5.37
## 14 B     Y         6  6.73  0.893      4.54
## 15 B     X         1  6.76  5.92       4.56
## 16 C     Y         1  9.26  5.57       5.27
## 17 C     Y         6  6.50  7.08       6.53
## 18 B     X         4  5.72  4.32       4.68
## 19 A     X        10  4.16  6.17       6.78
## 20 A     X         2  6.84  0.527      3.12
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`.


```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2       num3 total_avg
## 1    B    Y    4 7.017006  4.4559085  5.157638
## 2    B    X   NA 4.673627  2.5980867  3.635857
## 3    C    Y    7 1.117597  3.9149993  4.010865
## 4    A    Y    3 6.604529  6.2395087  5.281346
## 5    C    Y    1 9.699714  5.6646948  5.454803
## 6    A    X    2 5.377083  1.7460447  3.041042
## 7    A    X    6 5.826693  5.8667119  5.897802
## 8    C    X    5 4.365590  7.0126537  5.459415
## 9    C    X    1 3.247873 10.5777617  4.941878
## 10   B    Y   10 9.790315  3.3899993  7.726771
## 11   A    Y    9 3.791455  3.0480933  5.279850
## 12   A    Y   NA 6.695145  6.4619445  6.578545
## 13   A    X   10 5.198460  0.9159286  5.371463
## 14   B    Y    6 6.729186  0.8926093  4.540599
## 15   B    X    1 6.764630  5.9240034  4.562878
## 16   C    Y    1 9.256806  5.5670166  5.274608
## 17   C    Y    6 6.500775  7.0811242  6.527300
## 18   B    X    4 5.718105  4.3158313  4.677979
## 19   A    X   10 4.155518  6.1719896  6.775836
## 20   A    X    2 6.843024  0.5274814  3.123502
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric)), na.rm = TRUE))
```

```
##    key key2 num1     num2       num3 total_avg
## 1    B    Y    4 7.017006  4.4559085  5.157638
## 2    B    X   NA 4.673627  2.5980867  3.635857
## 3    C    Y    7 1.117597  3.9149993  4.010865
## 4    A    Y    3 6.604529  6.2395087  5.281346
## 5    C    Y    1 9.699714  5.6646948  5.454803
## 6    A    X    2 5.377083  1.7460447  3.041042
## 7    A    X    6 5.826693  5.8667119  5.897802
## 8    C    X    5 4.365590  7.0126537  5.459415
## 9    C    X    1 3.247873 10.5777617  4.941878
## 10   B    Y   10 9.790315  3.3899993  7.726771
## 11   A    Y    9 3.791455  3.0480933  5.279850
## 12   A    Y   NA 6.695145  6.4619445  6.578545
## 13   A    X   10 5.198460  0.9159286  5.371463
## 14   B    Y    6 6.729186  0.8926093  4.540599
## 15   B    X    1 6.764630  5.9240034  4.562878
## 16   C    Y    1 9.256806  5.5670166  5.274608
## 17   C    Y    6 6.500775  7.0811242  6.527300
## 18   B    X    4 5.718105  4.3158313  4.677979
## 19   A    X   10 4.155518  6.1719896  6.775836
## 20   A    X    2 6.843024  0.5274814  3.123502
```

If you want to do a sum calculation, you should use the `rowSums()` function.


```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2       num3 total_sum
## 1    B    Y    4 7.017006  4.4559085 15.472914
## 2    B    X   NA 4.673627  2.5980867  7.271714
## 3    C    Y    7 1.117597  3.9149993 12.032596
## 4    A    Y    3 6.604529  6.2395087 15.844038
## 5    C    Y    1 9.699714  5.6646948 16.364409
## 6    A    X    2 5.377083  1.7460447  9.123127
## 7    A    X    6 5.826693  5.8667119 17.693405
## 8    C    X    5 4.365590  7.0126537 16.378244
## 9    C    X    1 3.247873 10.5777617 14.825634
## 10   B    Y   10 9.790315  3.3899993 23.180314
## 11   A    Y    9 3.791455  3.0480933 15.839549
## 12   A    Y   NA 6.695145  6.4619445 13.157090
## 13   A    X   10 5.198460  0.9159286 16.114388
## 14   B    Y    6 6.729186  0.8926093 13.621796
## 15   B    X    1 6.764630  5.9240034 13.688633
## 16   C    Y    1 9.256806  5.5670166 15.823823
## 17   C    Y    6 6.500775  7.0811242 19.581899
## 18   B    X    4 5.718105  4.3158313 14.033936
## 19   A    X   10 4.155518  6.1719896 20.327507
## 20   A    X    2 6.843024  0.5274814  9.370505
```

## Rowwise aggregation exercise

In this exercise you will be debugging my code to get it running! We are going to sum the reviews_from_users and reviews_from_critics column, to make a new column called total_reviews. We want the total reviews for each row of films from before 1930.

You have to debug the code for both the rowwise method and the rowSums/rowMeans method.


```r
# rowwise method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users, rating) %>%
  mutate(total_reviews = sum(c_across(reviews_from_users:reviews_from_critics), na.rm = TRUE))
```

```
## Error in `mutate()`:
## ! Problem while computing `total_reviews =
##   sum(c_across(reviews_from_users:reviews_from_critics), na.rm = TRUE)`.
## Caused by error in `chr_as_locations()`:
## ! Can't subset columns that don't exist.
## ✖ Column `reviews_from_critics` doesn't exist.
```

```r
# rowSums method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users, rating) %>%
  mutate(total_reviews = sum(across(reviews_from_users:reviews_from_critics)))
```

```
## Error in `mutate()`:
## ! Problem while computing `total_reviews =
##   sum(across(reviews_from_users:reviews_from_critics))`.
## Caused by error in `across()`:
## ! Can't subset columns that don't exist.
## ✖ Column `reviews_from_critics` doesn't exist.
```


```r
# answer for solutions

# rowwise method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users:reviews_from_critics, rating) %>%
  rowwise() %>%
  mutate(total_reviews = sum(c_across(reviews_from_users:reviews_from_critics), na.rm = TRUE))
```

```
## # A tibble: 70 × 8
## # Rowwise: 
##    title         year duration avg_vote reviews_from_us… reviews_from_cr… rating
##    <chr>        <dbl>    <dbl>    <dbl>            <dbl>            <dbl>  <dbl>
##  1 The Story o…  1906       70      6.1                7                7      1
##  2 Cleopatra     1912      100      5.2               25                3      2
##  3 A Florida E…  1914       63      5.8                6                3      2
##  4 The Birth o…  1915      195      6.3              368               97      2
##  5 Gretchen th…  1916       58      5.7                7                1      3
##  6 Snow White    1916       63      6.2               13                5      3
##  7 The Poor Li…  1917       65      6.7               16               13      3
##  8 Raffles, th…  1917       70      6.4                3                3      2
##  9 Rebecca of …  1917       78      6.1                9                5      3
## 10 A Romance o…  1917       91      5.7               12                4      0
## # … with 60 more rows, and 1 more variable: total_reviews <dbl>
```

```r
# rowSums method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users:reviews_from_critics, rating) %>%
  mutate(total_reviews = rowSums(across(reviews_from_users:reviews_from_critics), na.rm = TRUE))
```

```
## # A tibble: 70 × 8
##    title         year duration avg_vote reviews_from_us… reviews_from_cr… rating
##    <chr>        <dbl>    <dbl>    <dbl>            <dbl>            <dbl>  <dbl>
##  1 The Story o…  1906       70      6.1                7                7      1
##  2 Cleopatra     1912      100      5.2               25                3      2
##  3 A Florida E…  1914       63      5.8                6                3      2
##  4 The Birth o…  1915      195      6.3              368               97      2
##  5 Gretchen th…  1916       58      5.7                7                1      3
##  6 Snow White    1916       63      6.2               13                5      3
##  7 The Poor Li…  1917       65      6.7               16               13      3
##  8 Raffles, th…  1917       70      6.4                3                3      2
##  9 Rebecca of …  1917       78      6.1                9                5      3
## 10 A Romance o…  1917       91      5.7               12                4      0
## # … with 60 more rows, and 1 more variable: total_reviews <dbl>
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_eflc2yj4pcryc62?coursename=R%20Data%20Wrangling%203:%20Joining%20and%20aggregation%C2%A0&topic=R&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Ev72JK9UjRhMgv0YHNkJZHsBjGHzydNtK5aBqHgc4Otr4g?e=FcSbDl&prog=DS&version=21-22>

The solutions we be available from a link at the end of the survey.

# Individual coding challenge

For the individual coding challenge you will be making the output of your aggregations more presentable! We will do this using the excellent `kableExtra` package, which makes very nice tables.

First, install the kableExtra package.


```r
# install kableExtra
install.packages("kableExtra")
```

1)  Using your imdb_bechdel dataset, group by year
2)  Pipe to a summarise, and work out the average rating (bechdel), average vote, and the frequency (using n())
3)  Pipe to a filter, filtering for your average vote to be greater than 7 and your frequency (count) to be greater than 20
4)  Now pipe the output to `kbl()`
5)  Finally, pipe that to `kable_minimal(full_width = F)`. You should now have a nice table!
6)  Play around with different kable styles. Try out the following: `kable_classic(full_width = F)`, `kable_classic2(full_width = F)` and `kable_paper(full_width = F)`

See the kableExtra vignette for more examples to test out: <https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html>


```r
library(kableExtra)
```

```
## 
## Attaching package: 'kableExtra'
```

```
## The following object is masked from 'package:dplyr':
## 
##     group_rows
```

```r
# your code here
imdb_bechdel %>%
  group_by(year) %>%
  summarise(avg_bechdel = round(mean(rating),2),
            avg_vote_year = round(mean(avg_vote),2),
            count_n = n()) %>%
  filter(avg_vote_year > 7 & count_n > 20) %>%
  kbl() %>%
  kable_minimal(full_width = F)
```

<table class=" lightable-minimal" style='font-family: "Trebuchet MS", verdana, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> avg_bechdel </th>
   <th style="text-align:right;"> avg_vote_year </th>
   <th style="text-align:right;"> count_n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1939 </td>
   <td style="text-align:right;"> 2.27 </td>
   <td style="text-align:right;"> 7.24 </td>
   <td style="text-align:right;"> 26 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1940 </td>
   <td style="text-align:right;"> 2.00 </td>
   <td style="text-align:right;"> 7.23 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1941 </td>
   <td style="text-align:right;"> 2.18 </td>
   <td style="text-align:right;"> 7.17 </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1946 </td>
   <td style="text-align:right;"> 1.76 </td>
   <td style="text-align:right;"> 7.20 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1954 </td>
   <td style="text-align:right;"> 1.75 </td>
   <td style="text-align:right;"> 7.22 </td>
   <td style="text-align:right;"> 24 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1957 </td>
   <td style="text-align:right;"> 1.40 </td>
   <td style="text-align:right;"> 7.20 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1963 </td>
   <td style="text-align:right;"> 1.88 </td>
   <td style="text-align:right;"> 7.02 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1964 </td>
   <td style="text-align:right;"> 1.62 </td>
   <td style="text-align:right;"> 7.09 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1968 </td>
   <td style="text-align:right;"> 1.96 </td>
   <td style="text-align:right;"> 7.12 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1971 </td>
   <td style="text-align:right;"> 1.89 </td>
   <td style="text-align:right;"> 7.08 </td>
   <td style="text-align:right;"> 35 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1973 </td>
   <td style="text-align:right;"> 1.60 </td>
   <td style="text-align:right;"> 7.20 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1976 </td>
   <td style="text-align:right;"> 1.76 </td>
   <td style="text-align:right;"> 7.07 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1979 </td>
   <td style="text-align:right;"> 1.75 </td>
   <td style="text-align:right;"> 7.26 </td>
   <td style="text-align:right;"> 32 </td>
  </tr>
</tbody>
</table>

As a fun extra, you can use `paste` to change a percentage to a string. This is useful if you are exporting your results as a report. See below for how to do this, using one of our examples from earlier.


```r
library(kableExtra)

# fun extra, change your frequency to a percentage
df2 %>%
  group_by(key, key2) %>%
  summarise(sum = sum(num1, na.rm = TRUE), 
            count_n = n()) %>%
  mutate(rel_freq = paste0(round(100 * count_n/sum(count_n), 0), "%")) %>%
  kbl() %>%
  kable_paper(full_width = F)
```

```
## `summarise()` has grouped output by 'key'. You can override using the `.groups`
## argument.
```

<table class=" lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> key </th>
   <th style="text-align:left;"> key2 </th>
   <th style="text-align:right;"> sum </th>
   <th style="text-align:right;"> count_n </th>
   <th style="text-align:left;"> rel_freq </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 62% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 38% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 33% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
</tbody>
</table>

# Individual coding challenge 2

In this coding challenge we will be bringing everything in this workshop together. We will join up two datasets, preform an aggregation, then visualise the results in a table. 

Data for this coding challenge comes from tidytuesday, information on the data can be found here: https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-09-14/readme.md 

We are aiming to compare some popular performer statistics such as weeks on the chart, and danceability of their music. 

1) load in the billboard csv from this url: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv
2) load in the audio_features csv from this url: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/audio_features.csv
3) have a look at your data using glimpse, View or other functions. Do you see anyway of joining these two datasets?
4) use an inner join to join the datasets by song_id, song, and performer. Save the result as `billboard_features`
5) Review the outcome of the join to make sure it worked correctly
6) filter your joined data (`billboard_features`) to keep only the following performers: Ed Sheeran, Adele, Taylor Swift, Ariana Grande, Bruno Mars, The Weeknd, Billie Eilish, Lady Gaga
7) convert the `spotify_track_duration_ms` column to minutes as a new column called `duration_mins`
8) find the averages (mean) for each performer of the following columns: duration_mins, weeks_on_chart, danceability, energy
9) arrange your result in descending order based on the average weeks on the chart
10) save result as `billboard_agg`


```r
library(dplyr)

# your code here

# load in data
billboard <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv')
```

```
## Rows: 327895 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (5): url, week_id, song, performer, song_id
## dbl (5): week_position, instance, previous_week_position, peak_position, wee...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
audio_features <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/audio_features.csv')
```

```
## Rows: 29503 Columns: 22
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (7): song_id, performer, song, spotify_genre, spotify_track_id, spotify...
## dbl (14): spotify_track_duration_ms, danceability, energy, key, loudness, mo...
## lgl  (1): spotify_track_explicit
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
# look at data to help decide on join
billboard %>% glimpse()
```

```
## Rows: 327,895
## Columns: 10
## $ url                    <chr> "http://www.billboard.com/charts/hot-100/1965-0…
## $ week_id                <chr> "7/17/1965", "7/24/1965", "7/31/1965", "8/7/196…
## $ week_position          <dbl> 34, 22, 14, 10, 8, 8, 14, 36, 97, 90, 97, 97, 9…
## $ song                   <chr> "Don't Just Stand There", "Don't Just Stand The…
## $ performer              <chr> "Patty Duke", "Patty Duke", "Patty Duke", "Patt…
## $ song_id                <chr> "Don't Just Stand TherePatty Duke", "Don't Just…
## $ instance               <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
## $ previous_week_position <dbl> 45, 34, 22, 14, 10, 8, 8, 14, NA, 97, 90, 97, 9…
## $ peak_position          <dbl> 34, 22, 14, 10, 8, 8, 8, 8, 97, 90, 90, 90, 90,…
## $ weeks_on_chart         <dbl> 4, 5, 6, 7, 8, 9, 10, 11, 1, 2, 3, 4, 5, 6, 1, …
```

```r
audio_features %>% glimpse()
```

```
## Rows: 29,503
## Columns: 22
## $ song_id                   <chr> "-twistin'-White Silver SandsBill Black's Co…
## $ performer                 <chr> "Bill Black's Combo", "Augie Rios", "Andy Wi…
## $ song                      <chr> "-twistin'-White Silver Sands", "¿Dònde Està…
## $ spotify_genre             <chr> "[]", "['novelty']", "['adult standards', 'b…
## $ spotify_track_id          <chr> NA, NA, "3tvqPPpXyIgKrm4PR9HCf0", "1fHHq3qHU…
## $ spotify_track_preview_url <chr> NA, NA, "https://p.scdn.co/mp3-preview/cef48…
## $ spotify_track_duration_ms <dbl> NA, NA, 166106, 172066, 211066, 208186, 2055…
## $ spotify_track_explicit    <lgl> NA, NA, FALSE, FALSE, FALSE, FALSE, TRUE, FA…
## $ spotify_track_album       <chr> NA, NA, "The Essential Andy Williams", "Comp…
## $ danceability              <dbl> NA, NA, 0.154, 0.588, 0.759, 0.613, NA, 0.64…
## $ energy                    <dbl> NA, NA, 0.185, 0.672, 0.699, 0.764, NA, 0.68…
## $ key                       <dbl> NA, NA, 5, 11, 0, 2, NA, 2, NA, NA, 7, NA, 1…
## $ loudness                  <dbl> NA, NA, -14.063, -17.278, -5.745, -6.509, NA…
## $ mode                      <dbl> NA, NA, 1, 0, 0, 1, NA, 0, NA, NA, 1, NA, 0,…
## $ speechiness               <dbl> NA, NA, 0.0315, 0.0361, 0.0307, 0.1360, NA, …
## $ acousticness              <dbl> NA, NA, 0.91100, 0.00256, 0.20200, 0.05270, …
## $ instrumentalness          <dbl> NA, NA, 2.67e-04, 7.45e-01, 1.31e-04, 0.00e+…
## $ liveness                  <dbl> NA, NA, 0.1120, 0.1450, 0.4430, 0.1970, NA, …
## $ valence                   <dbl> NA, NA, 0.150, 0.801, 0.907, 0.417, NA, 0.95…
## $ tempo                     <dbl> NA, NA, 83.969, 121.962, 92.960, 160.015, NA…
## $ time_signature            <dbl> NA, NA, 4, 4, 4, 4, NA, 4, NA, NA, 4, NA, 4,…
## $ spotify_track_popularity  <dbl> NA, NA, 38, 11, 77, 73, 61, 40, NA, NA, 31, …
```

```r
billboard_features <- inner_join(billboard, audio_features, 
                                 by = c("song_id", "song", "performer"))

# review joined data
billboard_features %>% glimpse()
```

```
## Rows: 330,208
## Columns: 29
## $ url                       <chr> "http://www.billboard.com/charts/hot-100/196…
## $ week_id                   <chr> "7/17/1965", "7/24/1965", "7/31/1965", "8/7/…
## $ week_position             <dbl> 34, 22, 14, 10, 8, 8, 14, 36, 97, 90, 97, 97…
## $ song                      <chr> "Don't Just Stand There", "Don't Just Stand …
## $ performer                 <chr> "Patty Duke", "Patty Duke", "Patty Duke", "P…
## $ song_id                   <chr> "Don't Just Stand TherePatty Duke", "Don't J…
## $ instance                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
## $ previous_week_position    <dbl> 45, 34, 22, 14, 10, 8, 8, 14, NA, 97, 90, 97…
## $ peak_position             <dbl> 34, 22, 14, 10, 8, 8, 8, 8, 97, 90, 90, 90, …
## $ weeks_on_chart            <dbl> 4, 5, 6, 7, 8, 9, 10, 11, 1, 2, 3, 4, 5, 6, …
## $ spotify_genre             <chr> "['deep adult standards']", "['deep adult st…
## $ spotify_track_id          <chr> "1YhNCQ3XOdTCZgubfX8PgB", "1YhNCQ3XOdTCZgubf…
## $ spotify_track_preview_url <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ spotify_track_duration_ms <dbl> 163160, 163160, 163160, 163160, 163160, 1631…
## $ spotify_track_explicit    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FA…
## $ spotify_track_album       <chr> "Lost Hits Of The 60's (All Original Artists…
## $ danceability              <dbl> 0.574, 0.574, 0.574, 0.574, 0.574, 0.574, 0.…
## $ energy                    <dbl> 0.256, 0.256, 0.256, 0.256, 0.256, 0.256, 0.…
## $ key                       <dbl> 7, 7, 7, 7, 7, 7, 7, 7, NA, NA, NA, NA, NA, …
## $ loudness                  <dbl> -15.044, -15.044, -15.044, -15.044, -15.044,…
## $ mode                      <dbl> 1, 1, 1, 1, 1, 1, 1, 1, NA, NA, NA, NA, NA, …
## $ speechiness               <dbl> 0.0298, 0.0298, 0.0298, 0.0298, 0.0298, 0.02…
## $ acousticness              <dbl> 0.610, 0.610, 0.610, 0.610, 0.610, 0.610, 0.…
## $ instrumentalness          <dbl> 7.70e-05, 7.70e-05, 7.70e-05, 7.70e-05, 7.70…
## $ liveness                  <dbl> 0.1000, 0.1000, 0.1000, 0.1000, 0.1000, 0.10…
## $ valence                   <dbl> 0.568, 0.568, 0.568, 0.568, 0.568, 0.568, 0.…
## $ tempo                     <dbl> 82.331, 82.331, 82.331, 82.331, 82.331, 82.3…
## $ time_signature            <dbl> 3, 3, 3, 3, 3, 3, 3, 3, NA, NA, NA, NA, NA, …
## $ spotify_track_popularity  <dbl> 21, 21, 21, 21, 21, 21, 21, 21, NA, NA, NA, …
```

```r
# aggregate
# filter out selected performers
billboard_agg <- billboard_features %>%
  filter(performer == "Ed Sheeran" | performer == "Adele" | performer == "Taylor Swift" | performer == "Ariana Grande" | performer == "Bruno Mars" | performer == "The Weeknd" | performer == "Billie Eilish"| performer == "Lady Gaga") %>%
  mutate(duration_mins = spotify_track_duration_ms/60000) %>%
  group_by(performer) %>%
  summarise(
    avg_duration_mins = round(mean(duration_mins, na.rm = TRUE), 2),
    avg_weeks_on_chart = round(mean(weeks_on_chart, na.rm = TRUE), 2),
    avg_danceability = round(mean(danceability, na.rm = TRUE), 2),
    avg_energy = round(mean(energy, na.rm = TRUE), 2)
    ) %>%
  ungroup() %>%
  arrange(desc(avg_weeks_on_chart))

billboard_agg
```

```
## # A tibble: 8 × 5
##   performer     avg_duration_mins avg_weeks_on_chart avg_danceability avg_energy
##   <chr>                     <dbl>              <dbl>            <dbl>      <dbl>
## 1 Ed Sheeran                 4.13               20.8             0.69       0.54
## 2 Adele                      4.19               18.9             0.59       0.61
## 3 Bruno Mars                 3.69               17.9             0.71       0.67
## 4 The Weeknd                 4.03               17.8             0.58       0.63
## 5 Billie Eilish              3.27               15.0             0.63       0.33
## 6 Taylor Swift               3.81               13.4             0.61       0.66
## 7 Lady Gaga                  4.13               12.0             0.68       0.74
## 8 Ariana Grande              3.26               10.8             0.67       0.62
```

If you've managed to do the above challenge this code should produce a nice table for you. If you want to learn how to play around and edit this table, the documentation for gt can be found here: https://gt.rstudio.com/. 

First we make sure gt is installed. 

```r
install.packages("gt")
```
Then we can run the below code. 

```r
# make into a nice visual table
library(gt)

billboard_agg %>% 
  gt() %>%
  tab_header(title = "Famous pop artists song statistics") %>%
  tab_style(style = list(cell_fill(color = "#E8DDFC")), 
            locations = cells_body(columns = avg_duration_mins,
                                   rows = avg_duration_mins > 4)) %>%
  cols_align(align = "center")
```

```{=html}
<div id="jyvsqxsnwc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jyvsqxsnwc .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#jyvsqxsnwc .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jyvsqxsnwc .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jyvsqxsnwc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jyvsqxsnwc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jyvsqxsnwc .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jyvsqxsnwc .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#jyvsqxsnwc .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#jyvsqxsnwc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jyvsqxsnwc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jyvsqxsnwc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#jyvsqxsnwc .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#jyvsqxsnwc .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#jyvsqxsnwc .gt_from_md > :first-child {
  margin-top: 0;
}

#jyvsqxsnwc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jyvsqxsnwc .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#jyvsqxsnwc .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#jyvsqxsnwc .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#jyvsqxsnwc .gt_row_group_first td {
  border-top-width: 2px;
}

#jyvsqxsnwc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jyvsqxsnwc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jyvsqxsnwc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jyvsqxsnwc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jyvsqxsnwc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jyvsqxsnwc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jyvsqxsnwc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jyvsqxsnwc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jyvsqxsnwc .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jyvsqxsnwc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jyvsqxsnwc .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jyvsqxsnwc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jyvsqxsnwc .gt_left {
  text-align: left;
}

#jyvsqxsnwc .gt_center {
  text-align: center;
}

#jyvsqxsnwc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jyvsqxsnwc .gt_font_normal {
  font-weight: normal;
}

#jyvsqxsnwc .gt_font_bold {
  font-weight: bold;
}

#jyvsqxsnwc .gt_font_italic {
  font-style: italic;
}

#jyvsqxsnwc .gt_super {
  font-size: 65%;
}

#jyvsqxsnwc .gt_two_val_uncert {
  display: inline-block;
  line-height: 1em;
  text-align: right;
  font-size: 60%;
  vertical-align: -0.25em;
  margin-left: 0.1em;
}

#jyvsqxsnwc .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#jyvsqxsnwc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jyvsqxsnwc .gt_slash_mark {
  font-size: 0.7em;
  line-height: 0.7em;
  vertical-align: 0.15em;
}

#jyvsqxsnwc .gt_fraction_numerator {
  font-size: 0.6em;
  line-height: 0.6em;
  vertical-align: 0.45em;
}

#jyvsqxsnwc .gt_fraction_denominator {
  font-size: 0.6em;
  line-height: 0.6em;
  vertical-align: -0.05em;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="5" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Famous pop artists song statistics</th>
    </tr>
    
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">performer</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">avg_duration_mins</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">avg_weeks_on_chart</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">avg_danceability</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">avg_energy</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_center">Ed Sheeran</td>
<td class="gt_row gt_center" style="background-color: #E8DDFC;">4.13</td>
<td class="gt_row gt_center">20.77</td>
<td class="gt_row gt_center">0.69</td>
<td class="gt_row gt_center">0.54</td></tr>
    <tr><td class="gt_row gt_center">Adele</td>
<td class="gt_row gt_center" style="background-color: #E8DDFC;">4.19</td>
<td class="gt_row gt_center">18.89</td>
<td class="gt_row gt_center">0.59</td>
<td class="gt_row gt_center">0.61</td></tr>
    <tr><td class="gt_row gt_center">Bruno Mars</td>
<td class="gt_row gt_center">3.69</td>
<td class="gt_row gt_center">17.91</td>
<td class="gt_row gt_center">0.71</td>
<td class="gt_row gt_center">0.67</td></tr>
    <tr><td class="gt_row gt_center">The Weeknd</td>
<td class="gt_row gt_center" style="background-color: #E8DDFC;">4.03</td>
<td class="gt_row gt_center">17.80</td>
<td class="gt_row gt_center">0.58</td>
<td class="gt_row gt_center">0.63</td></tr>
    <tr><td class="gt_row gt_center">Billie Eilish</td>
<td class="gt_row gt_center">3.27</td>
<td class="gt_row gt_center">15.05</td>
<td class="gt_row gt_center">0.63</td>
<td class="gt_row gt_center">0.33</td></tr>
    <tr><td class="gt_row gt_center">Taylor Swift</td>
<td class="gt_row gt_center">3.81</td>
<td class="gt_row gt_center">13.39</td>
<td class="gt_row gt_center">0.61</td>
<td class="gt_row gt_center">0.66</td></tr>
    <tr><td class="gt_row gt_center">Lady Gaga</td>
<td class="gt_row gt_center" style="background-color: #E8DDFC;">4.13</td>
<td class="gt_row gt_center">11.95</td>
<td class="gt_row gt_center">0.68</td>
<td class="gt_row gt_center">0.74</td></tr>
    <tr><td class="gt_row gt_center">Ariana Grande</td>
<td class="gt_row gt_center">3.26</td>
<td class="gt_row gt_center">10.77</td>
<td class="gt_row gt_center">0.67</td>
<td class="gt_row gt_center">0.62</td></tr>
  </tbody>
  
  
</table>
</div>
```


------------------------------------------------------------------------

# Other options for aggregation

We have used dplyr for aggregation here, but there are two other options: the base r `aggregate()` function, or using the data.table package. We have shown some examples here so you are able to compare.

First, we have a look at the base r `aggregate()` function. The main disadvantage to aggregate over dplyr is it is harder to read.


```r
# one group aggregate 
aggregate(df2[, c("num1", "num2", "num3")], 
          by = list(df2$key), 
          FUN = mean, na.rm = TRUE)
```

```
##   Group.1 num1     num2     num3
## 1       A  6.0 5.561488 3.872213
## 2       B  5.0 6.782145 3.596073
## 3       C  3.5 5.698059 6.636375
```

```r
# two group aggregate
aggregate(df2[, c("num1", "num2", "num3")], 
          by = list(df2$key, df2$key2), 
          FUN = mean, na.rm = TRUE)
```

```
##   Group.1 Group.2     num1     num2     num3
## 1       A       X 6.000000 5.480155 3.045631
## 2       B       X 2.500000 5.718787 4.279307
## 3       C       X 3.000000 3.806732 8.795208
## 4       A       Y 6.000000 5.697043 5.249849
## 5       B       Y 6.666667 7.845502 2.912839
## 6       C       Y 3.750000 6.643723 5.556959
```

The other main contester is `data.table`. `data.table` is a great package for data manipulation, mostly because it is very fast. When it comes to loading in data, subsetting, joining data, and doing aggregations, `data.table` is the best option if you have a lot of data! The syntax for `data.table` is similar to base r, using the square brackets.

In order to run this example you will have to have data.table installed.


```r
install.packages("data.table")
```

To explain the data.table code, we have to transform our imdb_bechdel dataset into a data.table object. The data.table syntax is similar to the base r indexing `[row_index , coloum_index]` but it has extra features like being able to add a `by` argument for aggregation. For those familiar with Python, this is similar to how you would aggregate with the Pandas library (which was designed based on R syntax).


```r
# load in data.table
library(data.table)

# make your data a data table object
setDT(df2)

# aggregate by key
df2[, .(avg_num1 = median(num1, na.rm = TRUE),
        avg_num2 = median(num2, na.rm = TRUE),
        avg_num3 = median(num3, na.rm = TRUE)), by = "key"]
```

```
##    key avg_num1 avg_num2 avg_num3
## 1:   B        4 6.746908 3.852915
## 2:   C        3 5.433183 6.338674
## 3:   A        6 5.601888 4.457403
```

```r
# by key and key 2 (num 1 >= 10)
df2[num1 >= 5, .(avg_num2 = median(num2, na.rm = TRUE),
                 avg_num3 = median(num3, na.rm = TRUE)), by = c("key", "key2")]
```

```
##    key key2 avg_num2 avg_num3
## 1:   C    Y 3.809186 5.498062
## 2:   A    X 5.198460 5.866712
## 3:   C    X 4.365590 7.012654
## 4:   B    Y 8.259751 2.141304
## 5:   A    Y 3.791455 3.048093
```

If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>.
