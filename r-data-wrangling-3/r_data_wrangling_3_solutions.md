---
title: "R Data Wrangling 8 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "23 August, 2021"
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

-   Relational joining of datasets
-   Cross tabulation
-   Grouping and aggregating your data
-   Rowwise aggregations

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

# Joining data

In previous workshops we have introduced how to combine data frames together that have matching columns using the `rbind` and `cbind` functions. Here we will introduce relational (or mutating) joins. This means the data frames are related by common columns, such as a id column, but the rest of the data held is different. These are known as relational data, in that multiple tables of data are related to each other, rather than being stand alone datasets.

In our example we will have a person information data frame, with name and age, and a food information data frame with favourite food and allergies; both data frames have a id column which we can use to join them.


```r
# Make a person information data frame
Person_Info <- data.frame(
  ID_num = seq(1:6),
  Name = c("Andrew", "Chloe", "Antony", "Cleopatra", "Zoe", "Nathan"),
  Age = c(28, 26, 19, 35, 21, 42)
  )

Person_Info
```

```
##   ID_num      Name Age
## 1      1    Andrew  28
## 2      2     Chloe  26
## 3      3    Antony  19
## 4      4 Cleopatra  35
## 5      5       Zoe  21
## 6      6    Nathan  42
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

The id columns in our datasets above are a unique identifier (also known as a primary key). This means they identify one observation in their own table. You can test this by either using the `duplicated()` function or use the `filter()` function from dplyr. With `duplicated()` you should get back a blank dataset (we used `[]` indexing), and with `filter()` + `duplicated()` method you should get the same.


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
Person_Info[duplicated(Person_Info$ID_num), ]
```

```
## [1] ID_num Name   Age   
## <0 rows> (or 0-length row.names)
```

```r
# dplyr method
Person_Info %>%
  filter(duplicated(ID_num))
```

```
## [1] ID_num Name   Age   
## <0 rows> (or 0-length row.names)
```

Dplyr has several functions for joining data, which are based on SQL syntax:

-   `inner_join` finds matches between both data frames
-   `left_join` includes all of the data from the left data frame, and matches from the right
-   `right_join` includes all of the data from the right data frame, and matches from the left
-   `full_join` includes all data from both data frames

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-3/images/inner_join.png?raw=true){width="700"}

*To view images, either switch to visual markdown editor, or knit document to html*

First, we can have a look at what a inner join looks like. Try and run the code below.


```r
inner_join(Person_Info, Food_Info)
```

```
## Error: `by` must be supplied when `x` and `y` have no common variables.
## ℹ use by = character()` to perform a cross-join.
```

This doesn't work because our column names for our data frames do not match! This is a common error and is easy to fix with the rename function.

In the example below, we rename the ID column, then we use the `inner_join()` function again.


```r
# fix the id column name to match
Person_Info <- Person_Info %>%
  rename(ID = ID_num)

# Inner join (just the id matches)
inner_join(Person_Info, Food_Info)
```

```
## Joining, by = "ID"
```

```
##   ID      Name Age                          Fav_Food Allergic
## 1  1    Andrew  28                             Pizza     <NA>
## 2  4 Cleopatra  35 Pasta con il pesto alla Trapanese      Soy
```

The inner join has included only data that is in both Person_Info and Food_Info, anything that didn't match was dropped.

You can specify what columns you are joining the data, using the `by` argument. The `by` argument we use in the example below is for manually selecting the columns to join the datasets by. It is good practice to specify which columns you are joining your data by as it will help you understand your data better.


```r
# Specifying what we are joining by
inner_join(Person_Info, Food_Info, by = "ID")
```

```
##   ID      Name Age                          Fav_Food Allergic
## 1  1    Andrew  28                             Pizza     <NA>
## 2  4 Cleopatra  35 Pasta con il pesto alla Trapanese      Soy
```

Next up is the left join, which includes all data from our Person_Info data frame and matches from the Food_Info data frame, anything that doesn't match is scored as a NA.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-3/images/left_join.png?raw=true){width="700"}


```r
# left join 
left_join(Person_Info, Food_Info, by = "ID")
```

```
##   ID      Name Age                          Fav_Food Allergic
## 1  1    Andrew  28                             Pizza     <NA>
## 2  2     Chloe  26                              <NA>     <NA>
## 3  3    Antony  19                              <NA>     <NA>
## 4  4 Cleopatra  35 Pasta con il pesto alla Trapanese      Soy
## 5  5       Zoe  21                              <NA>     <NA>
## 6  6    Nathan  42                              <NA>     <NA>
```

The right join is the opposite of the left join. We get everything from Food_Info, and just the matches from Person_Info. Again, anything that doesn't match is given NA. Notice this is the first time that id 7 has appeared as it is not in the Person_Info data.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-3/images/right_join.png?raw=true){width="700"}


```r
# right join
right_join(Person_Info, Food_Info, by = "ID")
```

```
##   ID      Name Age                          Fav_Food  Allergic
## 1  1    Andrew  28                             Pizza      <NA>
## 2  4 Cleopatra  35 Pasta con il pesto alla Trapanese       Soy
## 3  7      <NA>  NA                    Egg fried rice Shellfish
```

Finally, the full join brings all the data of both data frames together. Anything that doesn't match is given NA. We can see quite clearly here that despite there being a person who wasn't in the `Person_Info` data frame, their data has been joined up as it was in the `Fav_food` data frame, with Na's given for Name and Age.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-3/images/full_join.png?raw=true){width="700"}


```r
# full join
full_join(Person_Info, Food_Info, by = "ID")
```

```
##   ID      Name Age                          Fav_Food  Allergic
## 1  1    Andrew  28                             Pizza      <NA>
## 2  2     Chloe  26                              <NA>      <NA>
## 3  3    Antony  19                              <NA>      <NA>
## 4  4 Cleopatra  35 Pasta con il pesto alla Trapanese       Soy
## 5  5       Zoe  21                              <NA>      <NA>
## 6  6    Nathan  42                              <NA>      <NA>
## 7  7      <NA>  NA                    Egg fried rice Shellfish
```

Deciding on the correct join to use depends on what you are aiming to do. An inner join is useful if you wanted to subset your data down to only matched data across the two tables. A full join is useful for keeping all your data together and ensures no data is lost in the joining process.

## Joining data exercise

For this workshop you'll be using the imdb data we used in the previous workshop and we will also be using the Bechdel Test flim data. We will be joining the Bechdel data to the imdb dataset.

The Bechdel test is a measure of the representation of women in fiction. Scoring has three criteria which films are scored on: 1) Film has at least two women in it 2) The two, or more, women talk to each other 3) The two, or more, women talk about something besides a man. Films are scored 0 to 3. They score 0 if they don't meet any of the criteria, and 3 if they meet all of them.

Lets jump in, and load our data using the code provided.


```r
# load libraries
library(readr)
library(dplyr)

# load imdb and bechdel
movies_imdb <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/r-data-wrangling-1/data/IMDb%20movies.csv")

bechdel <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/r-data-wrangling-1/data/raw_bechdel.csv")

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

To join the data we have to make sure the IDs we will be using to join the data match. With these two datasets we have two issues we need to fix before we join the datasets. First, we change the column name in the movie_imdb dataset so it matches that of the bechdel data. We also have to remove the text from the imdb data `imdb_title_id` column so it is in the same format as the bechdel dataset. For example, *tt0000574* should be *574*.

1)  Using the `rename` function, change the `imdb_title_id` column in movies_imdb to `imdb_id`. Make sure to save the result back to movies_imdb
2)  We now need to fix the ids in the movies_imdb dataset. Type the following code to fix the ids: `movies_imdb$imdb_id <- parse_number(movies_imdb$imdb_id)`. The `parse_number()` function is from the readr library, and removes text from strings, which is exactly what we need in this case
3)  Before joining the data we should test for duplicate ids in both datasets. Using the example above, check the duplicates in the imdb_id column in movies_imdb and bechdel datasets.
4)  We have some duplicates in the bechdel data! Use `filter()`, `duplicated()` and the `!` (not) operator to remove them.
5)  Using the `inner_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
6)  Using the `full_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel_full`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
7)  Have a look at both your newly joined up data frames using head, glimpse or View. Do you notice how when we used inner_join we filtered out all data that isn't in our bechdel test dataset?


```r
# your code here

# use rename to change imdb_title_id to imdb_id
movies_imdb <- movies_imdb %>%
  rename(imdb_id = imdb_title_id) 

# fix ids so they match (remove tt and 0's)
movies_imdb$imdb_id <- parse_number(movies_imdb$imdb_id)

# test for duplicates
movies_imdb %>%
  filter(duplicated(imdb_id))
```

```
## # A tibble: 0 × 21
## # … with 21 variables: imdb_id <dbl>, title <chr>, year <dbl>,
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
imdb_bechdel <- inner_join(movies_imdb, bechdel, by = c("imdb_id", "title", "year"))

# full join with everything 
imdb_bechdel_full <- full_join(movies_imdb, bechdel, by = c("imdb_id", "title", "year")) 

imdb_bechdel %>% glimpse()
```

```
## Rows: 6,080
## Columns: 23
## $ imdb_id               <dbl> 574, 2101, 3973, 4972, 6745, 7361, 8443, 8489, 8…
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
## $ imdb_id               <dbl> 9, 574, 1892, 2101, 2130, 2199, 2423, 2445, 2452…
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
## 1  Birmingham              5
## 2  Birmingham              2
## 3   Cambridge              1
## 4  Manchester              4
## 5     Bristol              4
## 6     Bristol              4
## 7  Birmingham              2
## 8  Manchester              4
## 9     Bristol              5
## 10  Cambridge              1
## 11 Birmingham              4
## 12 Manchester              4
## 13  Cambridge              5
## 14 Birmingham              2
## 15 Birmingham              2
## 16    Bristol              5
## 17 Manchester              3
## 18    Bristol              1
## 19 Birmingham              1
## 20    Bristol              3
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 7
## 2    Bristol 6
## 3  Cambridge 3
## 4 Manchester 4
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          7          6          3          4
```

We can expand this by using conditional operators in the count or table functions.


```r
# conditional frequency
df1 %>%
  count(city == "Cambridge")
```

```
##   city == "Cambridge"  n
## 1               FALSE 17
## 2                TRUE  3
```

```r
table(df1$city == "Cambridge")
```

```
## 
## FALSE  TRUE 
##    17     3
```

We can also make two way frequency tables to compare two variables next to each other. Notice the difference between the two functions. Count provides the table in a data frame structure, which is easy to work with should you need to, but table is perhaps easier to read initially.


```r
# two way frequency tables
df1 %>%
  count(city, tourist_rating)
```

```
##          city tourist_rating n
## 1  Birmingham              1 1
## 2  Birmingham              2 4
## 3  Birmingham              4 1
## 4  Birmingham              5 1
## 5     Bristol              1 1
## 6     Bristol              3 1
## 7     Bristol              4 2
## 8     Bristol              5 2
## 9   Cambridge              1 2
## 10  Cambridge              5 1
## 11 Manchester              3 1
## 12 Manchester              4 3
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 1 4 0 1 1
##   Bristol    1 0 1 2 2
##   Cambridge  2 0 0 0 1
##   Manchester 0 0 1 3 0
```

We can also apply filtering using count or table functions. With count we use dplyr's filter function, with table we use base r indexing.


```r
df1 %>%
  filter(tourist_rating == 1 | tourist_rating == 5) %>%
  count(city, tourist_rating)
```

```
##         city tourist_rating n
## 1 Birmingham              1 1
## 2 Birmingham              5 1
## 3    Bristol              1 1
## 4    Bristol              5 2
## 5  Cambridge              1 2
## 6  Cambridge              5 1
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 1 1
##   Bristol    1 2
##   Cambridge  2 1
##   Manchester 0 0
```

## Cross tabluation exercise

Using your `imdb_bechdel` data you just made, do the following cross tabulations using dplyr's `count` function. If you have time, you can also do the same with the base r `table` function.

1)  Use count on the rating column in your imdb_bechdel data, which rating has the most results?
2)  Using count on the rating column again, conditionally select ratings greater than 2 *hint: try and do this within the count function*.
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
  count(rating > 2)
```

```
## # A tibble: 2 × 2
##   `rating > 2`     n
##   <lgl>        <int>
## 1 FALSE         2602
## 2 TRUE          3478
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
##   key key2 num1     num2       num3
## 1   B    Y    4 1.613935 5.18074927
## 2   A    X    1 9.774821 8.20840168
## 3   A    X    9 5.827327 8.42197382
## 4   B    X   10 3.749499 0.02495855
## 5   C    Y    8 8.393858 5.80268901
## 6   B    Y    6 4.518576 7.17399024
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
## 1 A        39
## 2 B        43
## 3 C        42
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
## 1 A        39
## 2 B        43
## 3 C        42
```

The grouping concept can be a little confusing, and the below illustrations hopefully will help break down the steps, which are as follows:

1)  Group your data by a categorical variable
2)  Split your data by that group. You'll end up with several subsets of data
3)  Perform a function, such as a mean or sum function, based on those split subsets of data
4)  Combine the split subsets back together to make a summary table

![Single group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-3/images/Aggregation.png?raw=true){width="600"}

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
## 1 A        39  31.5
## 2 B        43  31.0
## 3 C        42  44.8
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
## 1 A        39  31.5       6     0.3 
## 2 B        43  31.0       7     0.35
## 3 C        42  44.8       7     0.35
```

You can group your data by more than one group. This means when the data is *split*, more subsets are formed for all different possible splits.

![Two group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-3/images/Aggregation_twogroup.png?raw=true){width="600"}

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
## `summarise()` has grouped output by 'key'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 × 6
## # Groups:   key [3]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        29 29.9        5    0.833
## 2 A     Y        10  1.59       1    0.167
## 3 B     X        27 20.3        4    0.571
## 4 B     Y        16 10.7        3    0.429
## 5 C     X        32 33.8        5    0.714
## 6 C     Y        10 11.1        2    0.286
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
## `summarise()` has grouped output by 'key2'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 × 6
## # Groups:   key2 [2]
##   key2  key    sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 X     A        29 29.9        5    0.357
## 2 X     B        27 20.3        4    0.286
## 3 X     C        32 33.8        5    0.357
## 4 Y     A        10  1.59       1    0.167
## 5 Y     B        16 10.7        3    0.5  
## 6 Y     C        10 11.1        2    0.333
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
## 1 A     X        29 29.9        5     0.25
## 2 A     Y        10  1.59       1     0.05
## 3 B     X        27 20.3        4     0.2 
## 4 B     Y        16 10.7        3     0.15
## 5 C     X        32 33.8        5     0.25
## 6 C     Y        10 11.1        2     0.1
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
## 1 A     X        29 29.9        5        1
## 2 A     Y        10  1.59       1        1
## 3 B     X        27 20.3        4        1
## 4 B     Y        16 10.7        3        1
## 5 C     X        32 33.8        5        1
## 6 C     Y        10 11.1        2        1
```

## Aggregation exercise

Using the examples above, we are going to create three aggregations from our `imdb_bechdel` dataset we made earlier in the session.

1)  Group your imdb_bechdel data by rating, and use summarise to find the avg_vote per rating, and the frequency of each group. Use `median()` to calculate the average.
2)  Filter for years greater than 2015 and group by year. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Use `median()` to calculate the average.
3)  Filter for years greater than 2015 and group by year and rating. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Finally, pipe to a mutate function, and calculate the relative frequency of each year. Use `median()` to calculate the average.
4)  Filter for years greater than 2015 and group by rating. Summarise the median reviews_from_users and the median reviews_from_critics. Why are their NA values and how do should you fix them?


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
imdb_bechdel %>%
  filter(year > 2015) %>%
  group_by(year) %>%
  summarise(avg_vote_year = median(avg_vote),
            avg_duration = median(duration),
            count_n = n())  
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
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
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

# Rowwise aggregation

So far we have performed operations (functions) over columns, but sometimes you want to perform operations by rows. For example, you might want to find the average value for each row of several columns in a data frame.

Performing row based aggregation in r can be done with either one of these two functions: dplyr's `rowwise()` or base r's `rowMeans()`.

In the below examples we are using `rowwise()` with `summarise()`, just like we did with `group_by` and `summarise`. You get a total average back for each row in your dataset.


```r
head(df2)
```

```
##   key key2 num1     num2       num3
## 1   B    Y    4 1.613935 5.18074927
## 2   A    X    1 9.774821 8.20840168
## 3   A    X    9 5.827327 8.42197382
## 4   B    X   10 3.749499 0.02495855
## 5   C    Y    8 8.393858 5.80268901
## 6   B    Y    6 4.518576 7.17399024
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
##  1      3.60
##  2      6.33
##  3      7.75
##  4      4.59
##  5      7.40
##  6      5.90
##  7      6.94
##  8      7.58
##  9      5.26
## 10      6.46
## 11      3.36
## 12      6.86
## 13      7.34
## 14      3.10
## 15      4.89
## 16      3.22
## 17      6.30
## 18      4.50
## 19      6.29
## 20      8.35
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
##  1      3.60
##  2      6.33
##  3      7.75
##  4      4.59
##  5      7.40
##  6      5.90
##  7      6.94
##  8      7.58
##  9      5.26
## 10      6.46
## 11      3.36
## 12      6.86
## 13      7.34
## 14      3.10
## 15      4.89
## 16      3.22
## 17      6.30
## 18      4.50
## 19      6.29
## 20      8.35
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
##    key   key2   num1  num2    num3 total_avg
##    <fct> <fct> <int> <dbl>   <dbl>     <dbl>
##  1 B     Y         4  1.61  5.18        3.60
##  2 A     X         1  9.77  8.21        6.33
##  3 A     X         9  5.83  8.42        7.75
##  4 B     X        10  3.75  0.0250      4.59
##  5 C     Y         8  8.39  5.80        7.40
##  6 B     Y         6  4.52  7.17        5.90
##  7 C     X         4  8.38  8.44        6.94
##  8 C     X         8  6.35  8.38        7.58
##  9 B     Y         6  4.59  5.20        5.26
## 10 B     X         9  3.03  7.34        6.46
## 11 B     X         5  5.35 -0.269       3.36
## 12 C     X         8  7.72  4.86        6.86
## 13 A     X         5  9.02  7.98        7.34
## 14 C     Y         2  2.66  4.63        3.10
## 15 A     X         5  3.90  5.77        4.89
## 16 C     X         2  4.14  3.52        3.22
## 17 A     Y        10  1.59  7.32        6.30
## 18 A     X         9  1.37  3.13        4.50
## 19 B     X         3  8.12  7.75        6.29
## 20 C     X        10  7.18  7.88        8.35
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`.


```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2        num3 total_avg
## 1    B    Y    4 1.613935  5.18074927  3.598228
## 2    A    X    1 9.774821  8.20840168  6.327741
## 3    A    X    9 5.827327  8.42197382  7.749767
## 4    B    X   10 3.749499  0.02495855  4.591486
## 5    C    Y    8 8.393858  5.80268901  7.398849
## 6    B    Y    6 4.518576  7.17399024  5.897522
## 7    C    X    4 8.381430  8.44150740  6.940979
## 8    C    X    8 6.346992  8.37967764  7.575556
## 9    B    Y    6 4.587826  5.19869959  5.262175
## 10   B    X    9 3.032591  7.34029502  6.457629
## 11   B    X    5 5.354897 -0.26949754  3.361800
## 12   C    X    8 7.720172  4.85706068  6.859077
## 13   A    X    5 9.024092  7.98157098  7.335221
## 14   C    Y    2 2.659585  4.63129632  3.096960
## 15   A    X    5 3.897670  5.76588388  4.887851
## 16   C    X    2 4.141525  3.51673229  3.219419
## 17   A    Y   10 1.591093  7.32167102  6.304255
## 18   A    X    9 1.370226  3.12725200  4.499159
## 19   B    X    3 8.123998  7.75306485  6.292354
## 20   C    X   10 7.181327  7.88194406  8.354424
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric)), na.rm = TRUE))
```

```
##    key key2 num1     num2        num3 total_avg
## 1    B    Y    4 1.613935  5.18074927  3.598228
## 2    A    X    1 9.774821  8.20840168  6.327741
## 3    A    X    9 5.827327  8.42197382  7.749767
## 4    B    X   10 3.749499  0.02495855  4.591486
## 5    C    Y    8 8.393858  5.80268901  7.398849
## 6    B    Y    6 4.518576  7.17399024  5.897522
## 7    C    X    4 8.381430  8.44150740  6.940979
## 8    C    X    8 6.346992  8.37967764  7.575556
## 9    B    Y    6 4.587826  5.19869959  5.262175
## 10   B    X    9 3.032591  7.34029502  6.457629
## 11   B    X    5 5.354897 -0.26949754  3.361800
## 12   C    X    8 7.720172  4.85706068  6.859077
## 13   A    X    5 9.024092  7.98157098  7.335221
## 14   C    Y    2 2.659585  4.63129632  3.096960
## 15   A    X    5 3.897670  5.76588388  4.887851
## 16   C    X    2 4.141525  3.51673229  3.219419
## 17   A    Y   10 1.591093  7.32167102  6.304255
## 18   A    X    9 1.370226  3.12725200  4.499159
## 19   B    X    3 8.123998  7.75306485  6.292354
## 20   C    X   10 7.181327  7.88194406  8.354424
```

If you want to do a sum calculation, you should use the `rowSums()` function.


```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2        num3 total_sum
## 1    B    Y    4 1.613935  5.18074927 10.794685
## 2    A    X    1 9.774821  8.20840168 18.983222
## 3    A    X    9 5.827327  8.42197382 23.249300
## 4    B    X   10 3.749499  0.02495855 13.774457
## 5    C    Y    8 8.393858  5.80268901 22.196547
## 6    B    Y    6 4.518576  7.17399024 17.692566
## 7    C    X    4 8.381430  8.44150740 20.822937
## 8    C    X    8 6.346992  8.37967764 22.726669
## 9    B    Y    6 4.587826  5.19869959 15.786526
## 10   B    X    9 3.032591  7.34029502 19.372886
## 11   B    X    5 5.354897 -0.26949754 10.085399
## 12   C    X    8 7.720172  4.85706068 20.577232
## 13   A    X    5 9.024092  7.98157098 22.005663
## 14   C    Y    2 2.659585  4.63129632  9.290881
## 15   A    X    5 3.897670  5.76588388 14.663554
## 16   C    X    2 4.141525  3.51673229  9.658258
## 17   A    Y   10 1.591093  7.32167102 18.912764
## 18   A    X    9 1.370226  3.12725200 13.497478
## 19   B    X    3 8.123998  7.75306485 18.877063
## 20   C    X   10 7.181327  7.88194406 25.063271
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
## Error: Problem with `mutate()` column `total_reviews`.
## ℹ `total_reviews = sum(c_across(reviews_from_users:reviews_from_critics), na.rm = TRUE)`.
## x Can't subset columns that don't exist.
## x Column `reviews_from_critics` doesn't exist.
```

```r
# rowSums method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users, rating) %>%
  mutate(total_reviews = sum(across(reviews_from_users:reviews_from_critics)))
```

```
## Error: Problem with `mutate()` column `total_reviews`.
## ℹ `total_reviews = sum(across(reviews_from_users:reviews_from_critics))`.
## x Can't subset columns that don't exist.
## x Column `reviews_from_critics` doesn't exist.
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
##    title        year duration avg_vote reviews_from_use… reviews_from_cr… rating
##    <chr>       <dbl>    <dbl>    <dbl>             <dbl>            <dbl>  <dbl>
##  1 The Story …  1906       70      6.1                 7                7      1
##  2 Cleopatra    1912      100      5.2                25                3      2
##  3 A Florida …  1914       63      5.8                 6                3      2
##  4 The Birth …  1915      195      6.3               368               97      2
##  5 Gretchen t…  1916       58      5.7                 7                1      3
##  6 Snow White   1916       63      6.2                13                5      3
##  7 The Poor L…  1917       65      6.7                16               13      3
##  8 Raffles, t…  1917       70      6.4                 3                3      2
##  9 Rebecca of…  1917       78      6.1                 9                5      3
## 10 A Romance …  1917       91      5.7                12                4      0
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
##    title        year duration avg_vote reviews_from_use… reviews_from_cr… rating
##    <chr>       <dbl>    <dbl>    <dbl>             <dbl>            <dbl>  <dbl>
##  1 The Story …  1906       70      6.1                 7                7      1
##  2 Cleopatra    1912      100      5.2                25                3      2
##  3 A Florida …  1914       63      5.8                 6                3      2
##  4 The Birth …  1915      195      6.3               368               97      2
##  5 Gretchen t…  1916       58      5.7                 7                1      3
##  6 Snow White   1916       63      6.2                13                5      3
##  7 The Poor L…  1917       65      6.7                16               13      3
##  8 Raffles, t…  1917       70      6.4                 3                3      2
##  9 Rebecca of…  1917       78      6.1                 9                5      3
## 10 A Romance …  1917       91      5.7                12                4      0
## # … with 60 more rows, and 1 more variable: total_reviews <dbl>
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

**Add survey link here**

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
## `summarise()` has grouped output by 'key'. You can override using the `.groups` argument.
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
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 83% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 57% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 71% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
</tbody>
</table>

------------------------------------------------------------------------

# Other options for aggregation

We have used dplyr for aggregation here, but there are two other options: the base r `aggregate()` function, or using the data.table package. We have shown some examples here so you are able to compare.

First, we have a look at the base r `aggregate()` function. The main disadvantage of `aggregate` over dplyr is you have less control. It runs an aggregate across your whole dataset, which causes a lot of NA values for all your non-numerical variables. This might be what you want occasionally, but not all the time!


```r
# one group aggregate 
aggregate(df2, by = list(df2$key), FUN = mean, na.rm = TRUE)
```

```
##   Group.1 key key2     num1     num2     num3
## 1       A  NA   NA 6.500000 5.247538 6.804459
## 2       B  NA   NA 6.142857 4.425903 4.628894
## 3       C  NA   NA 6.000000 6.403555 6.215844
```

```r
# two group aggregate
aggregate(df2, by = list(df2$key, df2$key2), FUN = mean, na.rm = TRUE)
```

```
##   Group.1 Group.2 key key2      num1     num2     num3
## 1       A       X  NA   NA  5.800000 5.978827 6.701016
## 2       B       X  NA   NA  6.750000 5.065246 3.712205
## 3       C       X  NA   NA  6.400000 6.754289 6.615384
## 4       A       Y  NA   NA 10.000000 1.591093 7.321671
## 5       B       Y  NA   NA  5.333333 3.573446 5.851146
## 6       C       Y  NA   NA  5.000000 5.526721 5.216993
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
## 1:   B        6 4.518576 5.198700
## 2:   A        7 4.862498 7.651621
## 3:   C        8 7.181327 5.802689
```

```r
# by key and key 2 (num 1 >= 10)
df2[num1 >= 5, .(avg_num2 = median(num2, na.rm = TRUE),
                 avg_num3 = median(num3, na.rm = TRUE)), by = c("key", "key2")]
```

```
##    key key2 avg_num2   avg_num3
## 1:   A    X 4.862498 6.87372743
## 2:   B    X 3.749499 0.02495855
## 3:   C    Y 8.393858 5.80268901
## 4:   B    Y 4.553201 6.18634491
## 5:   C    X 7.181327 7.88194406
## 6:   A    Y 1.591093 7.32167102
```

If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>.
