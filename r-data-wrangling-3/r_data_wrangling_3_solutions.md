---
title: "R Data Wrangling 3 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "18 October, 2021"
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
## 1     Bristol              2
## 2  Manchester              3
## 3  Birmingham              4
## 4  Birmingham              4
## 5   Cambridge              3
## 6     Bristol              1
## 7  Manchester              3
## 8     Bristol              4
## 9  Manchester              2
## 10  Cambridge              2
## 11    Bristol              4
## 12    Bristol              2
## 13  Cambridge              5
## 14 Birmingham              4
## 15  Cambridge              4
## 16 Manchester              3
## 17 Manchester              5
## 18 Manchester              2
## 19 Birmingham              1
## 20 Birmingham              1
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 5
## 2    Bristol 5
## 3  Cambridge 4
## 4 Manchester 6
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          5          5          4          6
```

We can expand this by using conditional operators in the count or table functions.


```r
# conditional frequency
df1 %>%
  count(city == "Cambridge")
```

```
##   city == "Cambridge"  n
## 1               FALSE 16
## 2                TRUE  4
```

```r
table(df1$city == "Cambridge")
```

```
## 
## FALSE  TRUE 
##    16     4
```

An additional nice feature of the count function is you can change the name of the filtered column. Notice in the last example we had *city == "Cambridge"* which is hard to read. We can add a variable name with `count(name = variable)`. In the below example we add *is_cambridge* to change the column name to something more readable.  

```r
df1 %>%
  count(is_cambridge = city == "Cambridge")
```

```
##   is_cambridge  n
## 1        FALSE 16
## 2         TRUE  4
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
## 2  Birmingham              4 3
## 3     Bristol              1 1
## 4     Bristol              2 2
## 5     Bristol              4 2
## 6   Cambridge              2 1
## 7   Cambridge              3 1
## 8   Cambridge              4 1
## 9   Cambridge              5 1
## 10 Manchester              2 2
## 11 Manchester              3 3
## 12 Manchester              5 1
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 2 0 0 3 0
##   Bristol    1 2 0 2 0
##   Cambridge  0 1 1 1 1
##   Manchester 0 2 3 0 1
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
## 2    Bristol              1 1
## 3  Cambridge              5 1
## 4 Manchester              5 1
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 2 0
##   Bristol    1 0
##   Cambridge  0 1
##   Manchester 0 1
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
## 1   B    X    3 4.840341 6.537661
## 2   A    X   10 3.689698 3.823437
## 3   C    X    1 3.980127 3.379389
## 4   C    Y    1 4.558162 5.417566
## 5   B    X    7 6.629630 7.034601
## 6   A    X   10 2.763922 2.416974
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
## 2 B        23
## 3 C        27
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
## 1 A        44
## 2 B        23
## 3 C        27
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
## 1 A        44  29.4
## 2 B        23  29.9
## 3 C        27  48.4
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
## 1 A        44  29.4       7     0.35
## 2 B        23  29.9       5     0.25
## 3 C        27  48.4       8     0.4
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
## [1] 29.43862 29.86060 48.41116
```

```r
# extract sum2 column and give name
agg %>%
  pull(sum2, key)
```

```
##        A        B        C 
## 29.43862 29.86060 48.41116
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
## 1 A     X        38 23.4        6    0.857
## 2 A     Y         6  5.99       1    0.143
## 3 B     X        17 13.1        3    0.6  
## 4 B     Y         6 16.7        2    0.4  
## 5 C     X         7 18.7        3    0.375
## 6 C     Y        20 29.7        5    0.625
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
## 1 X     A        38 23.4        6    0.5  
## 2 X     B        17 13.1        3    0.25 
## 3 X     C         7 18.7        3    0.25 
## 4 Y     A         6  5.99       1    0.125
## 5 Y     B         6 16.7        2    0.25 
## 6 Y     C        20 29.7        5    0.625
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
## 1 A     X        38 23.4        6     0.3 
## 2 A     Y         6  5.99       1     0.05
## 3 B     X        17 13.1        3     0.15
## 4 B     Y         6 16.7        2     0.1 
## 5 C     X         7 18.7        3     0.15
## 6 C     Y        20 29.7        5     0.25
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
## 1 A     X        38 23.4        6        1
## 2 A     Y         6  5.99       1        1
## 3 B     X        17 13.1        3        1
## 4 B     Y         6 16.7        2        1
## 5 C     X         7 18.7        3        1
## 6 C     Y        20 29.7        5        1
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
## 1   B    X    3 4.840341 6.537661
## 2   A    X   10 3.689698 3.823437
## 3   C    X    1 3.980127 3.379389
## 4   C    Y    1 4.558162 5.417566
## 5   B    X    7 6.629630 7.034601
## 6   A    X   10 2.763922 2.416974
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
##  1      4.79
##  2      5.84
##  3      2.79
##  4      3.66
##  5      6.89
##  6      5.06
##  7      6.23
##  8      4.23
##  9      2.69
## 10      5.20
## 11      3.76
## 12      3.77
## 13      5.08
## 14      2.66
## 15      4.83
## 16      5.26
## 17      7.46
## 18      5.67
## 19      7.14
## 20      5.36
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
##  1      4.79
##  2      5.84
##  3      2.79
##  4      3.66
##  5      6.89
##  6      5.06
##  7      6.23
##  8      4.23
##  9      2.69
## 10      5.20
## 11      3.76
## 12      3.77
## 13      5.08
## 14      2.66
## 15      4.83
## 16      5.26
## 17      7.46
## 18      5.67
## 19      7.14
## 20      5.36
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
##  1 B     X         3  4.84  6.54       4.79
##  2 A     X        10  3.69  3.82       5.84
##  3 C     X         1  3.98  3.38       2.79
##  4 C     Y         1  4.56  5.42       3.66
##  5 B     X         7  6.63  7.03       6.89
##  6 A     X        10  2.76  2.42       5.06
##  7 B     Y         5  7.43  6.27       6.23
##  8 A     X        NA  3.34  5.13       4.23
##  9 A     X         1  3.29  3.77       2.69
## 10 C     Y         2  8.12  5.48       5.20
## 11 C     X         5  6.38 -0.107      3.76
## 12 C     Y         4  1.96  5.34       3.77
## 13 A     Y         6  5.99  3.24       5.08
## 14 B     X         7  1.65 -0.669      2.66
## 15 C     X         1  8.34  5.14       4.83
## 16 A     X         8  6.23  1.55       5.26
## 17 C     Y         6  8.84  7.54       7.46
## 18 A     X         9  4.13  3.86       5.67
## 19 C     Y         7  6.22  8.20       7.14
## 20 B     Y         1  9.30  5.79       5.36
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`.


```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2       num3 total_avg
## 1    B    X    3 4.840341  6.5376606  4.792667
## 2    A    X   10 3.689698  3.8234365  5.837711
## 3    C    X    1 3.980127  3.3793890  2.786505
## 4    C    Y    1 4.558162  5.4175657  3.658576
## 5    B    X    7 6.629630  7.0346010  6.888077
## 6    A    X   10 2.763922  2.4169737  5.060298
## 7    B    Y    5 7.432053  6.2664064  6.232820
## 8    A    X   NA 3.339042  5.1291433  4.234093
## 9    A    X    1 3.289649  3.7701009  2.686583
## 10   C    Y    2 8.123734  5.4836552  5.202463
## 11   C    X    5 6.380033 -0.1068932  3.757713
## 12   C    Y    4 1.963375  5.3388622  3.767413
## 13   A    Y    6 5.991976  3.2412580  5.077745
## 14   B    X    7 1.654920 -0.6687658  2.662051
## 15   C    X    1 8.343054  5.1375060  4.826853
## 16   A    X    8 6.229716  1.5548812  5.261532
## 17   C    Y    6 8.838672  7.5405737  7.459749
## 18   A    X    9 4.134621  3.8606189  5.665080
## 19   C    Y    7 6.224006  8.2020885  7.142032
## 20   B    Y    1 9.303656  5.7866719  5.363443
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric)), na.rm = TRUE))
```

```
##    key key2 num1     num2       num3 total_avg
## 1    B    X    3 4.840341  6.5376606  4.792667
## 2    A    X   10 3.689698  3.8234365  5.837711
## 3    C    X    1 3.980127  3.3793890  2.786505
## 4    C    Y    1 4.558162  5.4175657  3.658576
## 5    B    X    7 6.629630  7.0346010  6.888077
## 6    A    X   10 2.763922  2.4169737  5.060298
## 7    B    Y    5 7.432053  6.2664064  6.232820
## 8    A    X   NA 3.339042  5.1291433  4.234093
## 9    A    X    1 3.289649  3.7701009  2.686583
## 10   C    Y    2 8.123734  5.4836552  5.202463
## 11   C    X    5 6.380033 -0.1068932  3.757713
## 12   C    Y    4 1.963375  5.3388622  3.767413
## 13   A    Y    6 5.991976  3.2412580  5.077745
## 14   B    X    7 1.654920 -0.6687658  2.662051
## 15   C    X    1 8.343054  5.1375060  4.826853
## 16   A    X    8 6.229716  1.5548812  5.261532
## 17   C    Y    6 8.838672  7.5405737  7.459749
## 18   A    X    9 4.134621  3.8606189  5.665080
## 19   C    Y    7 6.224006  8.2020885  7.142032
## 20   B    Y    1 9.303656  5.7866719  5.363443
```

If you want to do a sum calculation, you should use the `rowSums()` function.


```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2       num3 total_sum
## 1    B    X    3 4.840341  6.5376606 14.378001
## 2    A    X   10 3.689698  3.8234365 17.513134
## 3    C    X    1 3.980127  3.3793890  8.359516
## 4    C    Y    1 4.558162  5.4175657 10.975728
## 5    B    X    7 6.629630  7.0346010 20.664231
## 6    A    X   10 2.763922  2.4169737 15.180895
## 7    B    Y    5 7.432053  6.2664064 18.698459
## 8    A    X   NA 3.339042  5.1291433  8.468185
## 9    A    X    1 3.289649  3.7701009  8.059750
## 10   C    Y    2 8.123734  5.4836552 15.607389
## 11   C    X    5 6.380033 -0.1068932 11.273140
## 12   C    Y    4 1.963375  5.3388622 11.302238
## 13   A    Y    6 5.991976  3.2412580 15.233234
## 14   B    X    7 1.654920 -0.6687658  7.986154
## 15   C    X    1 8.343054  5.1375060 14.480560
## 16   A    X    8 6.229716  1.5548812 15.784597
## 17   C    Y    6 8.838672  7.5405737 22.379246
## 18   A    X    9 4.134621  3.8606189 16.995240
## 19   C    Y    7 6.224006  8.2020885 21.426095
## 20   B    Y    1 9.303656  5.7866719 16.090328
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

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_eflc2yj4pcryc62?coursename=R Data Wrangling 3: Joining and aggregation &topic=R&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Ev72JK9UjRhMgv0YHNkJZHsBjGHzydNtK5aBqHgc4Otr4g?e=FcSbDl&prog=DS&version=21-22>

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
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> 86% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 60% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 40% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 38% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 62% </td>
  </tr>
</tbody>
</table>

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
##   Group.1     num1     num2     num3
## 1       A 7.333333 4.205518 3.399487
## 2       B 4.600000 5.972120 4.991315
## 3       C 3.375000 6.051395 5.049093
```

```r
# two group aggregate
aggregate(df2[, c("num1", "num2", "num3")], 
          by = list(df2$key, df2$key2), 
          FUN = mean, na.rm = TRUE)
```

```
##   Group.1 Group.2     num1     num2     num3
## 1       A       X 7.600000 3.907775 3.425859
## 2       B       X 5.666667 4.374963 4.301165
## 3       C       X 2.333333 6.234405 2.803334
## 4       A       Y 6.000000 5.991976 3.241258
## 5       B       Y 3.000000 8.367854 6.026539
## 6       C       Y 4.000000 5.941590 6.396549
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
## 1:   B      5.0 6.629630 6.266406
## 2:   A      8.5 3.689698 3.770101
## 3:   C      3.0 6.302020 5.378214
```

```r
# by key and key 2 (num 1 >= 10)
df2[num1 >= 5, .(avg_num2 = median(num2, na.rm = TRUE),
                 avg_num3 = median(num3, na.rm = TRUE)), by = c("key", "key2")]
```

```
##    key key2 avg_num2   avg_num3
## 1:   A    X 3.912159  3.1202051
## 2:   B    X 4.142275  3.1829176
## 3:   B    Y 7.432053  6.2664064
## 4:   C    X 6.380033 -0.1068932
## 5:   A    Y 5.991976  3.2412580
## 6:   C    Y 7.531339  7.8713311
```

If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>.
