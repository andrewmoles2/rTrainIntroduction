---
title: "R Data Wrangling 3 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "03 December, 2021"
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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/inner_join.png?raw=true){width="700"}

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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/left_join.png?raw=true){width="700"}


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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/right_join.png?raw=true){width="700"}


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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-data-wrangling-3/images/full_join.png?raw=true){width="700"}


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

To join the data we have to make sure the IDs we will be using to join the data match. With these two datasets we have two issues we need to fix before we join the datasets. First, we change the column name in the movie_imdb dataset so it matches that of the bechdel data. We also have to remove the text from the imdb data `imdb_title_id` column so it is in the same format as the bechdel dataset. For example, *tt0000574* should be *574*.

1)  We first need to fix the ids in the movies_imdb dataset. Type the following code to fix the ids: `movies_imdb$imdb_title_id <- parse_number(movies_imdb$imdb_title_id)`. The `parse_number()` function is from the readr library, and removes text from strings, which is exactly what we need in this case
2)  Using the `rename` function, change the `imdb_title_id` column in movies_imdb to `imdb_id`. Make sure to save the result back to movies_imdb
3)  Before joining the data we should test for duplicate ids in both datasets. Using the example above, check the duplicates in the imdb_id column in movies_imdb and bechdel datasets.
4)  We have some duplicates in the bechdel data! Use `filter()`, `duplicated()` and the `!` (not) operator to remove them.
5)  Using the `inner_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
6)  Using the `full_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel_full`. You can do this using the `by` argument with imdb_id, title, and year columns, or you can let the function do this for you
7)  Have a look at both your newly joined up data frames using head, glimpse or View. Do you notice how when we used inner_join we filtered out all data that isn't in our bechdel test dataset?


```r
# your code here
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
## 1   Cambridge              3
## 2  Manchester              2
## 3  Manchester              4
## 4     Bristol              5
## 5  Birmingham              3
## 6   Cambridge              2
## 7     Bristol              1
## 8     Bristol              1
## 9     Bristol              4
## 10 Manchester              1
## 11  Cambridge              3
## 12 Manchester              2
## 13  Cambridge              4
## 14    Bristol              1
## 15    Bristol              1
## 16 Manchester              1
## 17  Cambridge              1
## 18 Birmingham              3
## 19 Birmingham              3
## 20    Bristol              4
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 3
## 2    Bristol 7
## 3  Cambridge 5
## 4 Manchester 5
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          3          7          5          5
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

An additional nice feature of the count function is you can change the name of the filtered column. Notice in the last example we had *city == "Cambridge"* which is hard to read. We can add a variable name with `count(name = variable)`. In the below example we add *is_cambridge* to change the column name to something more readable.


```r
df1 %>%
  count(is_cambridge = city == "Cambridge")
```

```
##   is_cambridge  n
## 1        FALSE 15
## 2         TRUE  5
```

We can also make two way frequency tables to compare two variables next to each other. Notice the difference between the two functions. Count provides the table in a data frame structure, which is easy to work with should you need to, but table is perhaps easier to read initially.


```r
# two way frequency tables
df1 %>%
  count(city, tourist_rating)
```

```
##          city tourist_rating n
## 1  Birmingham              3 3
## 2     Bristol              1 4
## 3     Bristol              4 2
## 4     Bristol              5 1
## 5   Cambridge              1 1
## 6   Cambridge              2 1
## 7   Cambridge              3 2
## 8   Cambridge              4 1
## 9  Manchester              1 2
## 10 Manchester              2 2
## 11 Manchester              4 1
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 0 0 3 0 0
##   Bristol    4 0 0 2 1
##   Cambridge  1 1 2 1 0
##   Manchester 2 2 0 1 0
```

We can also apply filtering using count or table functions. With count we use dplyr's filter function, with table we use base r indexing.


```r
df1 %>%
  filter(tourist_rating == 1 | tourist_rating == 5) %>%
  count(city, tourist_rating)
```

```
##         city tourist_rating n
## 1    Bristol              1 4
## 2    Bristol              5 1
## 3  Cambridge              1 1
## 4 Manchester              1 2
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 0 0
##   Bristol    4 1
##   Cambridge  1 0
##   Manchester 2 0
```

## Cross tabluation exercise

Using your `imdb_bechdel` data you just made, do the following cross tabulations using dplyr's `count` function. If you have time, you can also do the same with the base r `table` function.

1)  Use count on the rating column in your imdb_bechdel data, which rating has the most results?
2)  Using count on the rating column again, conditionally select ratings greater than 2, and change the column name output to rating_less_two *hint: do this within the count function*.
3)  Create a two way cross tabulation with year and rating columns. Filter for the years 1966 or 1996.


```r
# your code here
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
##   key key2 num1     num2      num3
## 1   A    Y    3 2.461594 10.396063
## 2   C    X    8 5.002496  7.219554
## 3   B    Y    7 2.300464  6.634806
## 4   A    Y   NA 6.200907  3.215946
## 5   B    X    5 8.129912  3.559388
## 6   B    X    6 6.673570  9.675945
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
## 3 C        15
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
## 1 A        55
## 2 B        28
## 3 C        15
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
## 1 A        55  42.8
## 2 B        28  38.8
## 3 C        15  30.1
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
## 1 A        55  42.8       9     0.45
## 2 B        28  38.8       6     0.3 
## 3 C        15  30.1       5     0.25
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
## [1] 42.84784 38.76425 30.07318
```

```r
# extract sum2 column and give name
agg %>%
  pull(sum2, key)
```

```
##        A        B        C 
## 42.84784 38.76425 30.07318
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
## `summarise()` has grouped output by 'key'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 × 6
## # Groups:   key [3]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        41 22.2        5    0.556
## 2 A     Y        14 20.6        4    0.444
## 3 B     X        12 28.8        4    0.667
## 4 B     Y        16  9.97       2    0.333
## 5 C     X        12 21.5        4    0.8  
## 6 C     Y         3  8.61       1    0.2
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
## 1 X     A        41 22.2        5    0.385
## 2 X     B        12 28.8        4    0.308
## 3 X     C        12 21.5        4    0.308
## 4 Y     A        14 20.6        4    0.571
## 5 Y     B        16  9.97       2    0.286
## 6 Y     C         3  8.61       1    0.143
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
## 1 A     X        41 22.2        5     0.25
## 2 A     Y        14 20.6        4     0.2 
## 3 B     X        12 28.8        4     0.2 
## 4 B     Y        16  9.97       2     0.1 
## 5 C     X        12 21.5        4     0.2 
## 6 C     Y         3  8.61       1     0.05
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
## 1 A     X        41 22.2        5        1
## 2 A     Y        14 20.6        4        1
## 3 B     X        12 28.8        4        1
## 4 B     Y        16  9.97       2        1
## 5 C     X        12 21.5        4        1
## 6 C     Y         3  8.61       1        1
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
```

# Rowwise aggregation

So far we have performed operations (functions) over columns, but sometimes you want to perform operations by rows. For example, you might want to find the average value for each row of several columns in a data frame.

Performing row based aggregation in r can be done with either one of these two functions: dplyr's `rowwise()` or base r's `rowMeans()`.

In the below examples we are using `rowwise()` with `summarise()`, just like we did with `group_by` and `summarise`. You get a total average back for each row in your dataset.


```r
head(df2)
```

```
##   key key2 num1     num2      num3
## 1   A    Y    3 2.461594 10.396063
## 2   C    X    8 5.002496  7.219554
## 3   B    Y    7 2.300464  6.634806
## 4   A    Y   NA 6.200907  3.215946
## 5   B    X    5 8.129912  3.559388
## 6   B    X    6 6.673570  9.675945
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
##  1      5.29
##  2      6.74
##  3      5.31
##  4      4.71
##  5      5.56
##  6      7.45
##  7      6.63
##  8      5.28
##  9      4.43
## 10      3.43
## 11      7.61
## 12      4.17
## 13      5.98
## 14      4.33
## 15      6.70
## 16      4.58
## 17      3.80
## 18      2.42
## 19      4.98
## 20     10.3
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
##  1      5.29
##  2      6.74
##  3      5.31
##  4      4.71
##  5      5.56
##  6      7.45
##  7      6.63
##  8      5.28
##  9      4.43
## 10      3.43
## 11      7.61
## 12      4.17
## 13      5.98
## 14      4.33
## 15      6.70
## 16      4.58
## 17      3.80
## 18      2.42
## 19      4.98
## 20     10.3
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
##    key   key2   num1  num2  num3 total_avg
##    <fct> <fct> <int> <dbl> <dbl>     <dbl>
##  1 A     Y         3  2.46 10.4       5.29
##  2 C     X         8  5.00  7.22      6.74
##  3 B     Y         7  2.30  6.63      5.31
##  4 A     Y        NA  6.20  3.22      4.71
##  5 B     X         5  8.13  3.56      5.56
##  6 B     X         6  6.67  9.68      7.45
##  7 A     Y         8  4.99  6.88      6.63
##  8 C     Y         3  8.61  4.24      5.28
##  9 A     X         9  1.90  2.39      4.43
## 10 A     X         6  2.92  1.36      3.43
## 11 B     Y         9  7.67  6.16      7.61
## 12 A     Y         3  6.98  2.52      4.17
## 13 B     X        NA  8.24  3.73      5.98
## 14 B     X         1  5.75  6.25      4.33
## 15 A     X         8  8.32  3.77      6.70
## 16 C     X         1  9.87  2.87      4.58
## 17 C     X         1  5.06  5.35      3.80
## 18 C     X         2  1.53  3.73      2.42
## 19 A     X         9  1.47  4.47      4.98
## 20 A     X         9  7.61 14.3      10.3
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`.


```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    A    Y    3 2.461594 10.396063  5.285886
## 2    C    X    8 5.002496  7.219554  6.740683
## 3    B    Y    7 2.300464  6.634806  5.311756
## 4    A    Y   NA 6.200907  3.215946  4.708426
## 5    B    X    5 8.129912  3.559388  5.563100
## 6    B    X    6 6.673570  9.675945  7.449838
## 7    A    Y    8 4.990570  6.884496  6.625022
## 8    C    Y    3 8.610816  4.237929  5.282915
## 9    A    X    9 1.896127  2.387314  4.427814
## 10   A    X    6 2.921627  1.357638  3.426422
## 11   B    Y    9 7.670868  6.157875  7.609581
## 12   A    Y    3 6.982111  2.516438  4.166183
## 13   B    X   NA 8.242077  3.725887  5.983982
## 14   B    X    1 5.747360  6.254855  4.334072
## 15   A    X    8 8.323586  3.768337  6.697308
## 16   C    X    1 9.870446  2.868435  4.579627
## 17   C    X    1 5.055711  5.351503  3.802405
## 18   C    X    2 1.533706  3.733209  2.422305
## 19   A    X    9 1.465655  4.467239  4.977631
## 20   A    X    9 7.605658 14.262161 10.289273
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric)), na.rm = TRUE))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    A    Y    3 2.461594 10.396063  5.285886
## 2    C    X    8 5.002496  7.219554  6.740683
## 3    B    Y    7 2.300464  6.634806  5.311756
## 4    A    Y   NA 6.200907  3.215946  4.708426
## 5    B    X    5 8.129912  3.559388  5.563100
## 6    B    X    6 6.673570  9.675945  7.449838
## 7    A    Y    8 4.990570  6.884496  6.625022
## 8    C    Y    3 8.610816  4.237929  5.282915
## 9    A    X    9 1.896127  2.387314  4.427814
## 10   A    X    6 2.921627  1.357638  3.426422
## 11   B    Y    9 7.670868  6.157875  7.609581
## 12   A    Y    3 6.982111  2.516438  4.166183
## 13   B    X   NA 8.242077  3.725887  5.983982
## 14   B    X    1 5.747360  6.254855  4.334072
## 15   A    X    8 8.323586  3.768337  6.697308
## 16   C    X    1 9.870446  2.868435  4.579627
## 17   C    X    1 5.055711  5.351503  3.802405
## 18   C    X    2 1.533706  3.733209  2.422305
## 19   A    X    9 1.465655  4.467239  4.977631
## 20   A    X    9 7.605658 14.262161 10.289273
```

If you want to do a sum calculation, you should use the `rowSums()` function.


```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2      num3 total_sum
## 1    A    Y    3 2.461594 10.396063 15.857657
## 2    C    X    8 5.002496  7.219554 20.222050
## 3    B    Y    7 2.300464  6.634806 15.935269
## 4    A    Y   NA 6.200907  3.215946  9.416852
## 5    B    X    5 8.129912  3.559388 16.689299
## 6    B    X    6 6.673570  9.675945 22.349515
## 7    A    Y    8 4.990570  6.884496 19.875066
## 8    C    Y    3 8.610816  4.237929 15.848745
## 9    A    X    9 1.896127  2.387314 13.283442
## 10   A    X    6 2.921627  1.357638 10.279266
## 11   B    Y    9 7.670868  6.157875 22.828743
## 12   A    Y    3 6.982111  2.516438 12.498549
## 13   B    X   NA 8.242077  3.725887 11.967964
## 14   B    X    1 5.747360  6.254855 13.002215
## 15   A    X    8 8.323586  3.768337 20.091923
## 16   C    X    1 9.870446  2.868435 13.738881
## 17   C    X    1 5.055711  5.351503 11.407214
## 18   C    X    2 1.533706  3.733209  7.266915
## 19   A    X    9 1.465655  4.467239 14.932893
## 20   A    X    9 7.605658 14.262161 30.867819
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
## Error in filter(., year < 1930): object 'imdb_bechdel' not found
```

```r
# rowSums method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, reviews_from_users, rating) %>%
  mutate(total_reviews = sum(across(reviews_from_users:reviews_from_critics)))
```

```
## Error in filter(., year < 1930): object 'imdb_bechdel' not found
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
```

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
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 56% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 44% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 33% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 80% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 20% </td>
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
##   Group.1  num1     num2     num3
## 1       A 6.875 4.760871 5.472848
## 2       B 5.600 6.460708 6.001459
## 3       C 3.000 6.014635 4.682126
```

```r
# two group aggregate
aggregate(df2[, c("num1", "num2", "num3")], 
          by = list(df2$key, df2$key2), 
          FUN = mean, na.rm = TRUE)
```

```
##   Group.1 Group.2     num1     num2     num3
## 1       A       X 8.200000 4.442531 5.248538
## 2       B       X 4.000000 7.198230 5.804019
## 3       C       X 3.000000 5.365590 4.793175
## 4       A       Y 4.666667 5.158795 5.753236
## 5       B       Y 8.000000 4.985666 6.396341
## 6       C       Y 3.000000 8.610816 4.237929
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
## 1:   A        8 4.990570 3.768337
## 2:   C        2 5.055711 4.237929
## 3:   B        6 7.172219 6.206365
```

```r
# by key and key 2 (num 1 >= 10)
df2[num1 >= 5, .(avg_num2 = median(num2, na.rm = TRUE),
                 avg_num3 = median(num3, na.rm = TRUE)), by = c("key", "key2")]
```

```
##    key key2 avg_num2 avg_num3
## 1:   C    X 5.002496 7.219554
## 2:   B    Y 4.985666 6.396341
## 3:   B    X 7.401741 6.617666
## 4:   A    Y 4.990570 6.884496
## 5:   A    X 2.921627 3.768337
```

If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>.
