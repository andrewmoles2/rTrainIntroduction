---
title: "R Workshop 8 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "30 July, 2021"
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
# load dplyr
library(dplyr)

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

The id columns in our datasets above are a unique identifier (also known as a primary key). This means they identify one observation in their own table. You can test this by either using the `duplicated()` function or use the `count()` function from dplyr (more on this function later in this workshop). With `duplicated()` you should get back a blank dataset (we used `[]` indexing), and with `count()` + `filter()` method you should get the same.


```r
# See if and ID appears more than once
Person_Info[duplicated(Person_Info$ID_num), ]
```

```
## [1] ID_num Name   Age   
## <0 rows> (or 0-length row.names)
```

```r
# count method
Person_Info %>% 
  count(ID_num) %>%
  filter(n > 1)
```

```
## [1] ID_num n     
## <0 rows> (or 0-length row.names)
```

Dplyr has several functions for joining data, which are based on SQL:

-   `inner_join` finds matches between both data frames
-   `left_join` includes all of the data from the left data frame, and matches from the right
-   `right_join` includes all of the data from the right data frame, and matches from the left
-   `full_join` includes all data from both data frames

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop8/images/1.jpg?raw=true){width="600"}

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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop8/images/3.jpg?raw=true){width="600"}


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

The right join is the opposite of the left join. We get everything from Food_Info, and just the matches from Person_Info. Again, anything that doesn't match is given NA.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop8/images/4.jpg?raw=true){width="600"}


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

Finally, the full join brings all the data of both data frames together. Anything that doesn't match is given NA.We can see quite clearly here that despite there being a person who wasn't in the `Person_Info` data frame, their data has been joined up as it was in the `Fav_food` data frame, with Na's given for Name and Age. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop8/images/2.jpg?raw=true){width="600"}


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
movies_imdb <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop6/data/IMDb%20movies.csv")

bechdel <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop6/data/raw_bechdel.csv")

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
3)  Using the `inner_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
4)  Using the `full_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel_full`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
5)  Have a look at both your newly joined up data frames using head, glimpse or View. Do you notice how when we used inner_join we filtered out all data that isn't in our bechdel test dataset?


```r
# your code here

# use rename to change imdb_title_id to imdb_id
movies_imdb %>%
  rename(imdb_id = imdb_title_id) -> movies_imdb

# fix ids so they match (remove tt and 0's)
movies_imdb$imdb_id <- parse_number(movies_imdb$imdb_id)

# inner join to keep just the matches
imdb_bechdel <- inner_join(movies_imdb, bechdel, by = c("imdb_id", "title", "year"))

# full join with everything 
imdb_bechdel_full <- full_join(movies_imdb, bechdel, by = c("imdb_id", "title", "year")) 

imdb_bechdel %>% glimpse()
```

```
## Rows: 6,084
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
## Rows: 88,614
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

In the examples we will look at both the `table` and `count` functions for comparison. First, run the example below to see how to get a frequency table of one categorial variable.


```r
# Some made up tourist data
df1 <- data.frame(
  city = factor(sample(c("Manchester", "Cambridge", "Birmingham", "Bristol"), 20, replace = TRUE)),
  tourist_rating = sample(1:5, 20, replace = TRUE)
)

head(df1)
```

```
##         city tourist_rating
## 1  Cambridge              2
## 2    Bristol              4
## 3    Bristol              5
## 4 Manchester              4
## 5 Birmingham              4
## 6    Bristol              4
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 5
## 2    Bristol 7
## 3  Cambridge 5
## 4 Manchester 3
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          5          7          5          3
```

We can expand this by using conditional operators in the count or table functions.


```r
# conditional frequency
df1 %>%
  count(city == "Cambridge")
```

```
##   city == "Cambridge"  n
## 1               FALSE 15
## 2                TRUE  5
```

```r
table(df1$city == "Cambridge")
```

```
## 
## FALSE  TRUE 
##    15     5
```

We can also make two way frequency tables to compare two variables next to each other. Notice the difference between the two functions. Count provides the table in a data frame structure, which is easy to work with should you need to, but table is perhaps easier to read initially.


```r
# two way frequency tables
df1 %>%
  count(city, tourist_rating)
```

```
##          city tourist_rating n
## 1  Birmingham              1 2
## 2  Birmingham              4 2
## 3  Birmingham              5 1
## 4     Bristol              1 2
## 5     Bristol              2 2
## 6     Bristol              4 2
## 7     Bristol              5 1
## 8   Cambridge              1 2
## 9   Cambridge              2 2
## 10  Cambridge              3 1
## 11 Manchester              2 1
## 12 Manchester              4 1
## 13 Manchester              5 1
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 2 0 0 2 1
##   Bristol    2 2 0 2 1
##   Cambridge  2 2 1 0 0
##   Manchester 0 1 0 1 1
```

We can also apply filtering using count or table functions. With count we use dplyr's filter function, with table we use base r indexing.


```r
df1 %>%
  filter(tourist_rating == 1 | tourist_rating == 5) %>%
  count(city, tourist_rating)
```

```
##         city tourist_rating n
## 1 Birmingham              1 2
## 2 Birmingham              5 1
## 3    Bristol              1 2
## 4    Bristol              5 1
## 5  Cambridge              1 2
## 6 Manchester              5 1
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 2 1
##   Bristol    2 1
##   Cambridge  2 0
##   Manchester 0 1
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
## # A tibble: 4 x 2
##   rating     n
##    <dbl> <int>
## 1      0   519
## 2      1  1441
## 3      2   643
## 4      3  3481
```

```r
table(imdb_bechdel$rating)
```

```
## 
##    0    1    2    3 
##  519 1441  643 3481
```

```r
# Conditional frequency
imdb_bechdel %>%
  count(rating > 2)
```

```
## # A tibble: 2 x 2
##   `rating > 2`     n
##   <lgl>        <int>
## 1 FALSE         2603
## 2 TRUE          3481
```

```r
table(imdb_bechdel$rating > 2)
```

```
## 
## FALSE  TRUE 
##  2603  3481
```

```r
# two way table (with just two years)
imdb_bechdel %>% 
  filter(year == 1966 | year == 1996) %>%
  count(year, rating)
```

```
## # A tibble: 8 x 3
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


```r
# make some random data
df2 <- data.frame(
  key = factor(sample(c("A", "B", "C"), 20, replace = TRUE)),
  key2 = factor(sample(c("X", "Y"), 20, replace = TRUE)),
  num1 = sample(1:10, 20, replace = TRUE),
  num2 = runif(20, min = 1, max = 10),
  num3 = rnorm(20, mean = 5, sd = 2.5)
)

head(df2)
```

```
##   key key2 num1     num2     num3
## 1   A    X    9 3.833797 5.492343
## 2   A    X    8 8.810564 2.105761
## 3   A    X   10 6.373963 5.469746
## 4   A    Y    5 1.616742 6.268939
## 5   A    X    6 1.471477 3.800797
## 6   B    Y    3 1.251584 6.668901
```

```r
# perform simple grouped aggregation
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1))
```

```
## # A tibble: 3 x 2
##   key    sum1
##   <fct> <int>
## 1 A        67
## 2 B        29
## 3 C        22
```

The grouping concept can be a little confusing, and the below illustrations hopefully will help break down the steps, which are as follows:

1)  Group your data by a categorical variable
2)  Split your data by that group. You'll end up with several subsets of data
3)  Perform a function, such as a mean or sum function, based on those split subsets of data
4)  Combine the split subsets back together to make a summary table

![Single group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop8/images/Aggregation.png?raw=true){width="600"}

You can also aggregate more than one variable. In the below example, we will run sum on the num1 and num2 variables.


```r
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1), sum2 = sum(num2))
```

```
## # A tibble: 3 x 3
##   key    sum1  sum2
##   <fct> <int> <dbl>
## 1 A        67  52.9
## 2 B        29  39.5
## 3 C        22  12.8
```

We can take this a bit further by adding the `n()` function, which counts how many of each category in our grouped variable there are. If you want to add in a relative frequency, we can then pipe to a `mutate` function. We then divide our count by the sum of our count.


```r
# adding frequency using n()
df2 %>%
  group_by(key) %>%
  summarise(sum1 = sum(num1), sum2 = sum(num2),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 3 x 5
##   key    sum1  sum2 count_n rel_freq
##   <fct> <int> <dbl>   <int>    <dbl>
## 1 A        67  52.9      10     0.5 
## 2 B        29  39.5       7     0.35
## 3 C        22  12.8       3     0.15
```

You can group your data by more than one group. This means when the data is *split*, more subsets are formed for all different possible splits.

![Two group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop8/images/Aggregation_twogroup.png?raw=true){width="600"}

To do so, we add an extra categorical column to our `group_by()` function. The ordering of the groups matters. Have a look at both examples with the groups in a different order.


```r
# two group aggregation
df2 %>%
  group_by(key, key2) %>%
  summarise(sum1 = sum(num1), sum2 = sum(num2),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## `summarise()` has grouped output by 'key'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 x 6
## # Groups:   key [3]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        34 23.3        5    0.5  
## 2 A     Y        33 29.6        5    0.5  
## 3 B     X        23 30.6        5    0.714
## 4 B     Y         6  8.89       2    0.286
## 5 C     X        12 11.1        2    0.667
## 6 C     Y        10  1.65       1    0.333
```

```r
# flip the groups to see the difference
df2 %>%
  group_by(key2, key) %>%
  summarise(sum1 = sum(num1), sum2 = sum(num2),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## `summarise()` has grouped output by 'key2'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 x 6
## # Groups:   key2 [2]
##   key2  key    sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 X     A        34 23.3        5    0.417
## 2 X     B        23 30.6        5    0.417
## 3 X     C        12 11.1        2    0.167
## 4 Y     A        33 29.6        5    0.625
## 5 Y     B         6  8.89       2    0.25 
## 6 Y     C        10  1.65       1    0.125
```

You can manually adjust the grouping structure of the output from your aggregation. By default, dplyr will use just your first grouping variable in the result. You can see this from the output from `rel_freq`. To change this, we use the `.groups` argument. Below are two examples, where we either drop all grouping with "drop" or keep the structure of the grouping with "keep". The default argument is "drop_last", which we what we have seen where only the first grouping is kept in the result.


```r
# adjusting the grouping structure of the result: drop
df2 %>%
  group_by(key, key2) %>%
  summarise(sum1 = sum(num1), sum2 = sum(num2),
            count_n = n(), .groups = "drop") %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 6 x 6
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        34 23.3        5     0.25
## 2 A     Y        33 29.6        5     0.25
## 3 B     X        23 30.6        5     0.25
## 4 B     Y         6  8.89       2     0.1 
## 5 C     X        12 11.1        2     0.1 
## 6 C     Y        10  1.65       1     0.05
```

```r
# keep
df2 %>%
  group_by(key, key2) %>%
  summarise(sum1 = sum(num1), sum2 = sum(num2),
            count_n = n(), .groups = "keep") %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 6 x 6
## # Groups:   key, key2 [6]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        34 23.3        5        1
## 2 A     Y        33 29.6        5        1
## 3 B     X        23 30.6        5        1
## 4 B     Y         6  8.89       2        1
## 5 C     X        12 11.1        2        1
## 6 C     Y        10  1.65       1        1
```

## Aggregation exercise

Using the examples above, we are going to create three aggregations from our `imdb_bechdel` dataset we made earlier in the session.

1)  Group your imdb_bechdel data by rating, and use summarise to find the avg_vote per rating, and the frequency of each group. Use `median()` to calculate the average.
2)  Filter for years greater than 2015 and group by year. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Use `median()` to calculate the average.
3)  Filter for years greater than 2015 and group by year and rating. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Finally, pipe to a mutate function, and calculate the relative frequency of each year. Use `median()` to calculate the average.


```r
# your code here

# avg_vote by rating
imdb_bechdel %>%
  group_by(rating) %>%
  summarise(avg_vote_rating = median(avg_vote),
            count_n = n()) 
```

```
## # A tibble: 4 x 3
##   rating avg_vote_rating count_n
##    <dbl>           <dbl>   <int>
## 1      0             6.8     519
## 2      1             6.8    1441
## 3      2             6.8     643
## 4      3             6.6    3481
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
## # A tibble: 5 x 4
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
## # A tibble: 20 x 6
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

# Rowwise aggregation

So far we have performed operations (functions) over columns, but sometimes you want to perform operations by rows. For example, you might want to find the average value for each row of several columns in a data frame.

Performing row based aggregation in r can be done with either one of these two functions: dplyr's `rowwise()` or base r's `rowMeans()`.

In the below examples we are using `rowwise()` with `summarise()`, just like we did with `group_by` and `summarise`. You get a total average back for each row in your dataset.


```r
# rowwise on selected columns
df2 %>%
  rowwise() %>%
  summarise(total_avg = mean(c(num1, num2, num3)))
```

```
## `summarise()` has ungrouped output. You can override using the `.groups` argument.
```

```
## # A tibble: 20 x 1
##    total_avg
##        <dbl>
##  1      6.11
##  2      6.31
##  3      7.28
##  4      4.30
##  5      3.76
##  6      3.64
##  7      4.70
##  8      6.47
##  9      7.45
## 10      3.52
## 11      2.67
## 12      6.34
## 13      4.76
## 14      5.46
## 15      5.68
## 16      4.41
## 17      5.14
## 18      6.74
## 19      5.28
## 20      7.64
```

```r
# rowwise using c_across
df2 %>%
  rowwise() %>%
  summarise(total_avg = mean(c_across(num1:num3)))
```

```
## `summarise()` has ungrouped output. You can override using the `.groups` argument.
```

```
## # A tibble: 20 x 1
##    total_avg
##        <dbl>
##  1      6.11
##  2      6.31
##  3      7.28
##  4      4.30
##  5      3.76
##  6      3.64
##  7      4.70
##  8      6.47
##  9      7.45
## 10      3.52
## 11      2.67
## 12      6.34
## 13      4.76
## 14      5.46
## 15      5.68
## 16      4.41
## 17      5.14
## 18      6.74
## 19      5.28
## 20      7.64
```

If you want to add that total column to your data you use `mutate` instead of summarise. This is the most useful functionally of doing rowwise operations, as it allows you to calculate for each row a summary across several columns.


```r
# Adding the aggregation as a new column 
df2 %>%
  rowwise() %>%
  mutate(total_avg = mean(c_across(num1:num3)))
```

```
## # A tibble: 20 x 6
## # Rowwise: 
##    key   key2   num1  num2  num3 total_avg
##    <fct> <fct> <int> <dbl> <dbl>     <dbl>
##  1 A     X         9  3.83 5.49       6.11
##  2 A     X         8  8.81 2.11       6.31
##  3 A     X        10  6.37 5.47       7.28
##  4 A     Y         5  1.62 6.27       4.30
##  5 A     X         6  1.47 3.80       3.76
##  6 B     Y         3  1.25 6.67       3.64
##  7 B     X         6  3.52 4.60       4.70
##  8 B     X         6  9.97 3.43       6.47
##  9 A     Y         7  9.98 5.38       7.45
## 10 A     Y         8  1.65 0.900      3.52
## 11 A     X         1  2.80 4.20       2.67
## 12 C     X         9  2.93 7.10       6.34
## 13 B     X         3  6.21 5.07       4.76
## 14 B     X         7  3.26 6.12       5.46
## 15 B     Y         3  7.64 6.41       5.68
## 16 B     X         1  7.63 4.61       4.41
## 17 C     X         3  8.19 4.23       5.14
## 18 A     Y         7  6.54 6.67       6.74
## 19 C     Y        10  1.65 4.20       5.28
## 20 A     Y         6  9.85 7.07       7.64
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`.


```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3))))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    A    X    9 3.833797 5.4923433  6.108713
## 2    A    X    8 8.810564 2.1057606  6.305442
## 3    A    X   10 6.373963 5.4697461  7.281236
## 4    A    Y    5 1.616742 6.2689385  4.295227
## 5    A    X    6 1.471477 3.8007970  3.757425
## 6    B    Y    3 1.251584 6.6689007  3.640161
## 7    B    X    6 3.516193 4.5970842  4.704426
## 8    B    X    6 9.974871 3.4339198  6.469597
## 9    A    Y    7 9.978964 5.3843776  7.454447
## 10   A    Y    8 1.652662 0.9001167  3.517593
## 11   A    X    1 2.799167 4.1968852  2.665351
## 12   C    X    9 2.927278 7.1045031  6.343927
## 13   B    X    3 6.214589 5.0737776  4.762789
## 14   B    X    7 3.256857 6.1241765  5.460344
## 15   B    Y    3 7.641521 6.4093589  5.683626
## 16   B    X    1 7.633456 4.6057817  4.413079
## 17   C    X    3 8.194139 4.2280647  5.140735
## 18   A    Y    7 6.544883 6.6705415  6.738475
## 19   C    Y   10 1.654105 4.1965769  5.283561
## 20   A    Y    6 9.845496 7.0655102  7.637002
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric))))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    A    X    9 3.833797 5.4923433  6.108713
## 2    A    X    8 8.810564 2.1057606  6.305442
## 3    A    X   10 6.373963 5.4697461  7.281236
## 4    A    Y    5 1.616742 6.2689385  4.295227
## 5    A    X    6 1.471477 3.8007970  3.757425
## 6    B    Y    3 1.251584 6.6689007  3.640161
## 7    B    X    6 3.516193 4.5970842  4.704426
## 8    B    X    6 9.974871 3.4339198  6.469597
## 9    A    Y    7 9.978964 5.3843776  7.454447
## 10   A    Y    8 1.652662 0.9001167  3.517593
## 11   A    X    1 2.799167 4.1968852  2.665351
## 12   C    X    9 2.927278 7.1045031  6.343927
## 13   B    X    3 6.214589 5.0737776  4.762789
## 14   B    X    7 3.256857 6.1241765  5.460344
## 15   B    Y    3 7.641521 6.4093589  5.683626
## 16   B    X    1 7.633456 4.6057817  4.413079
## 17   C    X    3 8.194139 4.2280647  5.140735
## 18   A    Y    7 6.544883 6.6705415  6.738475
## 19   C    Y   10 1.654105 4.1965769  5.283561
## 20   A    Y    6 9.845496 7.0655102  7.637002
```

If you want to do a sum calculation, you should use the `rowSums()` function.


```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3))))
```

```
##    key key2 num1     num2      num3 total_sum
## 1    A    X    9 3.833797 5.4923433 18.326140
## 2    A    X    8 8.810564 2.1057606 18.916325
## 3    A    X   10 6.373963 5.4697461 21.843709
## 4    A    Y    5 1.616742 6.2689385 12.885680
## 5    A    X    6 1.471477 3.8007970 11.272274
## 6    B    Y    3 1.251584 6.6689007 10.920484
## 7    B    X    6 3.516193 4.5970842 14.113277
## 8    B    X    6 9.974871 3.4339198 19.408790
## 9    A    Y    7 9.978964 5.3843776 22.363342
## 10   A    Y    8 1.652662 0.9001167 10.552779
## 11   A    X    1 2.799167 4.1968852  7.996052
## 12   C    X    9 2.927278 7.1045031 19.031781
## 13   B    X    3 6.214589 5.0737776 14.288367
## 14   B    X    7 3.256857 6.1241765 16.381033
## 15   B    Y    3 7.641521 6.4093589 17.050879
## 16   B    X    1 7.633456 4.6057817 13.239238
## 17   C    X    3 8.194139 4.2280647 15.422204
## 18   A    Y    7 6.544883 6.6705415 20.215424
## 19   C    Y   10 1.654105 4.1965769 15.850682
## 20   A    Y    6 9.845496 7.0655102 22.911007
```

## Rowwise aggregation exercise

In this exercise you will be debugging my code to get it running! We are going to sum the User_reviews and Critic_reviews column, to make a new column called total_reviews. We want the total reviews for each row of films from before 1930.

You have to debug the code for both the rowwise method and the rowSums/rowMeans method.


```r
# rowwise method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users, rating) %>%
  mutate(total_reviews = sum(c_across(reviews_from_users:reviews_from_critics), na.rm = TRUE))

# rowSums method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users, rating) %>%
  mutate(total_reviews = sum(across(reviews_from_users:reviews_from_critics)))
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
## # A tibble: 70 x 8
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
## # A tibble: 70 x 8
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
  summarise(sum = sum(num1), count_n = n()) %>%
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
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 71% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 33% </td>
  </tr>
</tbody>
</table>

------------------------------------------------------------------------

## Other options for aggregation

We have used dplyr for aggregation here, but there are two other options: the base r `aggregate()` function, or using the data.table package. We have shown some examples here so you are able to compare.

First, we have a look at the base r `aggregate()` function. The main disadvantage of `aggregate` over dplyr is you have less control. It runs an aggregate across your whole dataset, which causes a lot of NA values for all your non-numerical variables. This might be what you want occasionally, but not all the time!


```r
# aggregate by rating
aggregate(imdb_bechdel, by = list(imdb_bechdel$rating), FUN = mean)
```

```
##   Group.1   imdb_id title     year date_published genre duration country
## 1       0  981035.7    NA 1988.420             NA    NA 102.1946      NA
## 2       1 1115337.0    NA 1996.729             NA    NA 108.1124      NA
## 3       2 1059395.0    NA 1991.974             NA    NA 107.5708      NA
## 4       3 1448443.7    NA 1999.162             NA    NA 105.4392      NA
##   language director writer production_company actors description avg_vote
## 1       NA       NA     NA                 NA     NA          NA 6.749326
## 2       NA       NA     NA                 NA     NA          NA 6.725954
## 3       NA       NA     NA                 NA     NA          NA 6.663142
## 4       NA       NA     NA                 NA     NA          NA 6.483625
##       votes budget usa_gross_income worlwide_gross_income metascore
## 1  91214.68     NA               NA                    NA        NA
## 2 121127.70     NA               NA                    NA        NA
## 3  92324.09     NA               NA                    NA        NA
## 4  79685.94     NA               NA                    NA        NA
##   reviews_from_users reviews_from_critics       id rating
## 1                 NA                   NA 4350.973      0
## 2                 NA                   NA 4385.918      1
## 3                 NA                   NA 4587.362      2
## 4                 NA                   NA 4625.983      3
```

The other main contester is `data.table`. `data.table` is a great package for data manipulation, mostly because it is very fast. When it comes to loading in data, subsetting, joining data, and doing aggregations, `data.table` is the best option if you have a lot of data! The syntax for `data.table` is similar to base r, using the square brackets.

In order to run this example you will have to have data.table installed.


```r
#install.packages("data.table")

# load in data.table
library(data.table)

# make your data a data table object
setDT(imdb_bechdel)

# aggregate by rating for vote and duration
imdb_bechdel[, .(avg_vote_rating = median(avg_vote),
                 avg_duration = median(duration)), by = "rating"]
```

```
##    rating avg_vote_rating avg_duration
## 1:      1             6.8          105
## 2:      2             6.8          104
## 3:      3             6.6          102
## 4:      0             6.8           99
```

```r
# by year and rating (> 2015)
imdb_bechdel[year > 2015, .(avg_vote_rating = median(avg_vote),
                 avg_duration = median(duration)), by = c("year","rating")]
```

```
##     year rating avg_vote_rating avg_duration
##  1: 2019      3            6.30        102.0
##  2: 2017      3            6.40        104.0
##  3: 2017      1            6.60        113.0
##  4: 2016      1            6.70        106.0
##  5: 2016      0            6.20        103.0
##  6: 2017      2            6.10        102.5
##  7: 2019      1            6.70        117.0
##  8: 2016      3            6.50        106.5
##  9: 2020      3            6.50        101.5
## 10: 2020      1            6.50        104.0
## 11: 2019      0            7.20        115.0
## 12: 2017      0            6.20        101.0
## 13: 2018      3            6.50        105.5
## 14: 2016      2            6.25        103.0
## 15: 2020      0            6.65        102.0
## 16: 2019      2            6.80        109.0
## 17: 2018      1            6.75        111.0
## 18: 2018      2            6.60        116.0
## 19: 2018      0            6.00         85.0
## 20: 2020      2            5.20        109.0
```

If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>.

Check out the data carpentry page for more ideas on grouping and aggregation:
<https://datacarpentry.org/R-ecology-lesson/03-dplyr.html>