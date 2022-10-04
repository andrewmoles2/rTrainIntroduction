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
## 1  Birmingham              1
## 2  Manchester              5
## 3   Cambridge              4
## 4     Bristol              1
## 5  Manchester              1
## 6     Bristol              4
## 7  Birmingham              4
## 8  Birmingham              4
## 9  Birmingham              3
## 10  Cambridge              1
## 11  Cambridge              1
## 12 Birmingham              2
## 13    Bristol              4
## 14 Manchester              1
## 15 Manchester              1
## 16 Manchester              5
## 17  Cambridge              5
## 18  Cambridge              5
## 19    Bristol              2
## 20 Manchester              3
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 5
## 2    Bristol 4
## 3  Cambridge 5
## 4 Manchester 6
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          5          4          5          6
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
## 1  Birmingham              1 1
## 2  Birmingham              2 1
## 3  Birmingham              3 1
## 4  Birmingham              4 2
## 5     Bristol              1 1
## 6     Bristol              2 1
## 7     Bristol              4 2
## 8   Cambridge              1 2
## 9   Cambridge              4 1
## 10  Cambridge              5 2
## 11 Manchester              1 3
## 12 Manchester              3 1
## 13 Manchester              5 2
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 1 1 1 2 0
##   Bristol    1 1 0 2 0
##   Cambridge  2 0 0 1 2
##   Manchester 3 0 1 0 2
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
## 2    Bristol              1 1
## 3  Cambridge              1 2
## 4  Cambridge              5 2
## 5 Manchester              1 3
## 6 Manchester              5 2
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 1 0
##   Bristol    1 0
##   Cambridge  2 2
##   Manchester 3 2
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
##   key key2 num1     num2     num3
## 1   B    X   10 6.643846 4.028617
## 2   B    Y    8 8.068308 7.697606
## 3   C    X    6 6.610573 8.309228
## 4   A    Y    4 6.265286 2.895884
## 5   A    X    8 7.112730 7.520820
## 6   A    X    3 5.950735 3.790373
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
## 1 A        38
## 2 B        NA
## 3 C        25
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
## 1 A        38
## 2 B        49
## 3 C        25
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
## 1 A        38  46.5
## 2 B        49  58.7
## 3 C        25  22.4
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
## 1 A        38  46.5       8      0.4
## 2 B        49  58.7       8      0.4
## 3 C        25  22.4       4      0.2
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
## [1] 46.52790 58.74535 22.40408
```

```r
# extract sum2 column and give name
agg %>%
  pull(sum2, key)
```

```
##        A        B        C 
## 46.52790 58.74535 22.40408
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
## # A tibble: 5 × 6
## # Groups:   key [3]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        29 32.4        5    0.625
## 2 A     Y         9 14.1        3    0.375
## 3 B     X        10  6.64       1    0.125
## 4 B     Y        39 52.1        7    0.875
## 5 C     X        25 22.4        4    1
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
## # A tibble: 5 × 6
## # Groups:   key2 [2]
##   key2  key    sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 X     A        29 32.4        5      0.5
## 2 X     B        10  6.64       1      0.1
## 3 X     C        25 22.4        4      0.4
## 4 Y     A         9 14.1        3      0.3
## 5 Y     B        39 52.1        7      0.7
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
## # A tibble: 5 × 6
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        29 32.4        5     0.25
## 2 A     Y         9 14.1        3     0.15
## 3 B     X        10  6.64       1     0.05
## 4 B     Y        39 52.1        7     0.35
## 5 C     X        25 22.4        4     0.2
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
## # A tibble: 5 × 6
## # Groups:   key, key2 [5]
##   key   key2   sum1  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X        29 32.4        5        1
## 2 A     Y         9 14.1        3        1
## 3 B     X        10  6.64       1        1
## 4 B     Y        39 52.1        7        1
## 5 C     X        25 22.4        4        1
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
##   key key2 num1     num2     num3
## 1   B    X   10 6.643846 4.028617
## 2   B    Y    8 8.068308 7.697606
## 3   C    X    6 6.610573 8.309228
## 4   A    Y    4 6.265286 2.895884
## 5   A    X    8 7.112730 7.520820
## 6   A    X    3 5.950735 3.790373
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
##  1      6.89
##  2      7.92
##  3      6.97
##  4      4.39
##  5      7.54
##  6      4.25
##  7      5.28
##  8      6.70
##  9      3.88
## 10      6.79
## 11      3.59
## 12      4.21
## 13      7.97
## 14      6.95
## 15      4.18
## 16      3.97
## 17      7.64
## 18      4.52
## 19      5.13
## 20      8.18
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
##  1      6.89
##  2      7.92
##  3      6.97
##  4      4.39
##  5      7.54
##  6      4.25
##  7      5.28
##  8      6.70
##  9      3.88
## 10      6.79
## 11      3.59
## 12      4.21
## 13      7.97
## 14      6.95
## 15      4.18
## 16      3.97
## 17      7.64
## 18      4.52
## 19      5.13
## 20      8.18
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
##  1 B     X        10  6.64  4.03      6.89
##  2 B     Y         8  8.07  7.70      7.92
##  3 C     X         6  6.61  8.31      6.97
##  4 A     Y         4  6.27  2.90      4.39
##  5 A     X         8  7.11  7.52      7.54
##  6 A     X         3  5.95  3.79      4.25
##  7 C     X         8  2.87  4.98      5.28
##  8 B     Y         6  9.92  4.18      6.70
##  9 C     X         1  6.93  3.71      3.88
## 10 C     X        10  5.99  4.38      6.79
## 11 B     Y         1  7.49  2.29      3.59
## 12 A     Y         1  4.08  7.54      4.21
## 13 B     Y         9  7.46  7.46      7.97
## 14 B     Y        10  8.85  1.99      6.95
## 15 B     Y        NA  1.96  6.40      4.18
## 16 A     X         4  2.13  5.78      3.97
## 17 A     X         9  8.84  5.08      7.64
## 18 A     Y         4  3.79  5.77      4.52
## 19 B     Y         5  8.35  2.02      5.13
## 20 A     X         5  8.36 11.2       8.18
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`.


```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    B    X   10 6.643846  4.028617  6.890821
## 2    B    Y    8 8.068308  7.697606  7.921971
## 3    C    X    6 6.610573  8.309228  6.973267
## 4    A    Y    4 6.265286  2.895884  4.387057
## 5    A    X    8 7.112730  7.520820  7.544517
## 6    A    X    3 5.950735  3.790373  4.247036
## 7    C    X    8 2.870657  4.982453  5.284370
## 8    B    Y    6 9.919086  4.175621  6.698235
## 9    C    X    1 6.932543  3.711811  3.881451
## 10   C    X   10 5.990310  4.384963  6.791758
## 11   B    Y    1 7.487459  2.286103  3.591187
## 12   A    Y    1 4.083308  7.540619  4.207976
## 13   B    Y    9 7.461878  7.459001  7.973626
## 14   B    Y   10 8.854113  1.993221  6.949111
## 15   B    Y   NA 1.957087  6.400648  4.178867
## 16   A    X    4 2.130337  5.779034  3.969790
## 17   A    X    9 8.836361  5.080260  7.638874
## 18   A    Y    4 3.785928  5.774710  4.520212
## 19   B    Y    5 8.353572  2.024727  5.126100
## 20   A    X    5 8.363219 11.189488  8.184236
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric)), na.rm = TRUE))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    B    X   10 6.643846  4.028617  6.890821
## 2    B    Y    8 8.068308  7.697606  7.921971
## 3    C    X    6 6.610573  8.309228  6.973267
## 4    A    Y    4 6.265286  2.895884  4.387057
## 5    A    X    8 7.112730  7.520820  7.544517
## 6    A    X    3 5.950735  3.790373  4.247036
## 7    C    X    8 2.870657  4.982453  5.284370
## 8    B    Y    6 9.919086  4.175621  6.698235
## 9    C    X    1 6.932543  3.711811  3.881451
## 10   C    X   10 5.990310  4.384963  6.791758
## 11   B    Y    1 7.487459  2.286103  3.591187
## 12   A    Y    1 4.083308  7.540619  4.207976
## 13   B    Y    9 7.461878  7.459001  7.973626
## 14   B    Y   10 8.854113  1.993221  6.949111
## 15   B    Y   NA 1.957087  6.400648  4.178867
## 16   A    X    4 2.130337  5.779034  3.969790
## 17   A    X    9 8.836361  5.080260  7.638874
## 18   A    Y    4 3.785928  5.774710  4.520212
## 19   B    Y    5 8.353572  2.024727  5.126100
## 20   A    X    5 8.363219 11.189488  8.184236
```

If you want to do a sum calculation, you should use the `rowSums()` function.


```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3)), na.rm = TRUE))
```

```
##    key key2 num1     num2      num3 total_sum
## 1    B    X   10 6.643846  4.028617 20.672463
## 2    B    Y    8 8.068308  7.697606 23.765914
## 3    C    X    6 6.610573  8.309228 20.919801
## 4    A    Y    4 6.265286  2.895884 13.161170
## 5    A    X    8 7.112730  7.520820 22.633551
## 6    A    X    3 5.950735  3.790373 12.741108
## 7    C    X    8 2.870657  4.982453 15.853109
## 8    B    Y    6 9.919086  4.175621 20.094706
## 9    C    X    1 6.932543  3.711811 11.644354
## 10   C    X   10 5.990310  4.384963 20.375273
## 11   B    Y    1 7.487459  2.286103 10.773562
## 12   A    Y    1 4.083308  7.540619 12.623927
## 13   B    Y    9 7.461878  7.459001 23.920879
## 14   B    Y   10 8.854113  1.993221 20.847334
## 15   B    Y   NA 1.957087  6.400648  8.357735
## 16   A    X    4 2.130337  5.779034 11.909371
## 17   A    X    9 8.836361  5.080260 22.916621
## 18   A    Y    4 3.785928  5.774710 13.560637
## 19   B    Y    5 8.353572  2.024727 15.378299
## 20   A    X    5 8.363219 11.189488 24.552707
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
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 62% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 38% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> 88% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 100% </td>
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

```
## Error in dplyr::group_vars(data): object 'billboard_agg' not found
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
## 1       A 4.75 5.815988 6.196398
## 2       B 7.00 7.343169 4.508193
## 3       C 6.25 5.601021 5.347114
```

```r
# two group aggregate
aggregate(df2[, c("num1", "num2", "num3")], 
          by = list(df2$key, df2$key2), 
          FUN = mean, na.rm = TRUE)
```

```
##   Group.1 Group.2  num1     num2     num3
## 1       A       X  5.80 6.478676 6.671995
## 2       B       X 10.00 6.643846 4.028617
## 3       C       X  6.25 5.601021 5.347114
## 4       A       Y  3.00 4.711507 5.403738
## 5       B       Y  6.50 7.443072 4.576704
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
## 1:   B        8 7.777884 4.102119
## 2:   C        7 6.300442 4.683708
## 3:   A        4 6.108011 5.776872
```

```r
# by key and key 2 (num 1 >= 10)
df2[num1 >= 5, .(avg_num2 = median(num2, na.rm = TRUE),
                 avg_num3 = median(num3, na.rm = TRUE)), by = c("key", "key2")]
```

```
##    key key2 avg_num2 avg_num3
## 1:   B    X 6.643846 4.028617
## 2:   B    Y 8.353572 4.175621
## 3:   C    X 5.990310 4.982453
## 4:   A    X 8.363219 7.520820
```

If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>.
