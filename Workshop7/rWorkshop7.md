---
title: "R Workshop 7 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "15 July, 2021"
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

-   Changing column names
-   Relational joining of datasets
-   Cross tabluation
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

# Change column names with rename

Before we move into joining and aggregation, it is helpful to learn about the `rename()` function from dplyr, which allows for simple changing of column names. 

The syntax is the same as the `mutate()` function, where we have the name of the column we want to make, then what column we are changing: `data %>% rename(new_column_name = old_column_name)`. 


```r
# load dplyr
library(dplyr)

# Make a data frame
df <- data.frame(
  column1 = rep("Hello", 4),
  column2 = sample(1:10, 4),
  column3 = seq(1:4)
)

df
```

```
##   column1 column2 column3
## 1   Hello       7       1
## 2   Hello       8       2
## 3   Hello      10       3
## 4   Hello       3       4
```

```r
# rename all the columns
df %>%
  rename(string = column1,
         random = column2,
         sequence = column3) -> df_new_col

df_new_col
```

```
##   string random sequence
## 1  Hello      7        1
## 2  Hello      8        2
## 3  Hello     10        3
## 4  Hello      3        4
```

## Rename columns exercise

We will be using the imdb movies dataset again, and code has been provided for you to load it. 

1) Type in and run `names(movies_imdb)` to get the column names of your dataset. This is a nice way to finding the column names, making it easy to copy and paste the names should you need to
2) Using the `rename()` function from dplyr, change `reviews_from_users` to `User_reviews` and `reviews_from_critics` to `Critic_reviews`
3) Save the result back to `movies_imdb`
4) Type in and run `names(movies_imdb)` again to view the new column names

```r
library(readr)
library(dplyr)

movies_imdb <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop6/data/IMDb%20movies.csv")

# your code here
names(movies_imdb)
```

```
##  [1] "imdb_title_id"         "title"                 "year"                 
##  [4] "date_published"        "genre"                 "duration"             
##  [7] "country"               "language"              "director"             
## [10] "writer"                "production_company"    "actors"               
## [13] "description"           "avg_vote"              "votes"                
## [16] "budget"                "usa_gross_income"      "worlwide_gross_income"
## [19] "metascore"             "reviews_from_users"    "reviews_from_critics"
```

```r
movies_imdb %>%
  rename(User_reviews = reviews_from_users,
         Critic_reviews = reviews_from_critics) -> movies_imdb

names(movies_imdb)
```

```
##  [1] "imdb_title_id"         "title"                 "year"                 
##  [4] "date_published"        "genre"                 "duration"             
##  [7] "country"               "language"              "director"             
## [10] "writer"                "production_company"    "actors"               
## [13] "description"           "avg_vote"              "votes"                
## [16] "budget"                "usa_gross_income"      "worlwide_gross_income"
## [19] "metascore"             "User_reviews"          "Critic_reviews"
```

# Joining data

In previous workshops we have introduced how to combine data frames together that have matching columns using the `rbind` and `cbind` functions. Here we will introduce relational (or mutating) joins. This means the data frames are related by common columns, such as a id column, but the rest of the data held is different. 

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

Dplyr has several functions for joining data, which are based on SQL: 

- `inner_join` finds matches between both data frames
- `left_join` includes all of the data from the left data frame, and matches from the right
- `right_join` includes all of the data from the right data frame, and matches from the left
- `full_join` includes all data from both data frames


First, we can have a look at what a inner join looks like. Try and run the code below.


```r
inner_join(Person_Info, Food_Info)
```
This doesn't work because our column names for our data frames do not match. This is a common error and is easy to fix with the rename function.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/1.jpg?raw=true){width="600"}

*To view images, either switch to visual markdown editor, or knit document to html*

See the example below, we rename the ID column, then we use the `inner_join()` function again. You can also specify what columns you are joining the data, using the by argument. 

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

```r
# Specifying what we are joining by
inner_join(Person_Info, Food_Info, by = "ID")
```

```
##   ID      Name Age                          Fav_Food Allergic
## 1  1    Andrew  28                             Pizza     <NA>
## 2  4 Cleopatra  35 Pasta con il pesto alla Trapanese      Soy
```

The left join includes all data from our Person_Info data frame and matches from the Food_Info data frame, anything that doesn't match is scored as a NA. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/3.jpg?raw=true){width="600"}


```r
# left join 
left_join(Person_Info, Food_Info)
```

```
## Joining, by = "ID"
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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/4.jpg?raw=true){width="600"}


```r
# right join
right_join(Person_Info, Food_Info)
```

```
## Joining, by = "ID"
```

```
##   ID      Name Age                          Fav_Food  Allergic
## 1  1    Andrew  28                             Pizza      <NA>
## 2  4 Cleopatra  35 Pasta con il pesto alla Trapanese       Soy
## 3  7      <NA>  NA                    Egg fried rice Shellfish
```

Finally, the full join brings all the data of both data frames together. Anything that doesn't match is given NA. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/2.jpg?raw=true){width="600"}


```r
# full join
full_join(Person_Info, Food_Info)
```

```
## Joining, by = "ID"
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

## Joining data exercise

For this workshop you'll be using the imdb data we used in the previous workshop and we will also be using the Bechdel Test flim data. We will be joining the Bechel data to the imdb dataset. 

The Bechdel test is a measure of the representation of women in fiction. Scoring has three criteria which films are scored on: 1) Film has at least two women in it 2) The two, or more, women talk to each other 3) The two, or more, women talk about something besides a man. Films are scored 0 to 3. They score 0 if they don't meet any of the criteria, and 3 if they meet all of them.

Lets jump in, and load our data. We previously loaded the imdb data, so we will just load the bechdel data using the code I've provided.


```r
library(readr)
library(dplyr)

bechdel <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop6/data/raw_bechdel.csv")

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

```r
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
## $ User_reviews          <dbl> 1, 7, 5, 25, 31, 13, 12, 7, 4, 8, 9, 9, 16, 8, N…
## $ Critic_reviews        <dbl> 2, 7, 2, 3, 14, 5, 9, 5, 1, 1, 9, 28, 7, 23, 4, …
```

To join the data we have to make sure the IDs we will be using to join the data match. First we change the name, then we remove the text from the imdb data `imdb_title_id` column.

1) Using the `rename` function, change the `imdb_title_id` column in movies_imdb to `imdb_id`. Make sure to save the result back to movies_imdb
2) We now need to fix the ids in the movies_imdb dataset. Type the following code to fix the ids: `movies_imdb$imdb_id <- parse_number(movies_imdb$imdb_id)`. The `parse_number()` function is from the readr library, and removes text from strings, which is exactly what we need in this case
3) Using the `inner_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel`. You can do this using the by argument with imdb_id, title, and year columns, or you can let the function do this for you
4) Using the `full_join()` function,  join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel_full`. You can do this using the by argument with imdb_id, title, and year columns, or you can let the function do this for you
5) Have a look at both your newly joined up data frames using head, glimpse or View. Do you notice how when we used inner_join we filtered out all data that isn't in our bechdel test dataset? 


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
## $ User_reviews          <dbl> 7, 25, 6, 368, 7, 13, 16, 3, 9, 12, 6, 19, 14, 8…
## $ Critic_reviews        <dbl> 7, 3, 3, 97, 1, 5, 13, 3, 5, 4, 1, 11, 21, 78, 6…
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
## $ User_reviews          <dbl> 1, 7, 5, 25, 31, 13, 12, 7, 4, 8, 9, 9, 16, 8, N…
## $ Critic_reviews        <dbl> 2, 7, 2, 3, 14, 5, 9, 5, 1, 1, 9, 28, 7, 23, 4, …
## $ id                    <dbl> NA, 1349, NA, 2003, NA, NA, NA, NA, NA, NA, NA, …
## $ rating                <dbl> NA, 1, NA, 2, NA, NA, NA, NA, NA, NA, NA, NA, NA…
```

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
## 1 Manchester              5
## 2  Cambridge              2
## 3  Cambridge              3
## 4  Cambridge              4
## 5    Bristol              2
## 6 Birmingham              5
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

We can also make two way frequency tables to compare two variables next to each other. Notice the difference between the two functions. Count provides the table in a data frame structure, which is easy to work with should you need to, but table is perhaps easier to read initially. 


```r
# two way frequency tables
df1 %>%
  count(city, tourist_rating)
```

```
##          city tourist_rating n
## 1  Birmingham              1 1
## 2  Birmingham              3 1
## 3  Birmingham              4 1
## 4  Birmingham              5 2
## 5     Bristol              2 1
## 6     Bristol              3 2
## 7     Bristol              4 2
## 8   Cambridge              2 1
## 9   Cambridge              3 1
## 10  Cambridge              4 1
## 11  Cambridge              5 1
## 12 Manchester              1 3
## 13 Manchester              3 2
## 14 Manchester              5 1
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 1 0 1 1 2
##   Bristol    0 1 2 2 0
##   Cambridge  0 1 1 1 1
##   Manchester 3 0 2 0 1
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
## 2 Birmingham              5 2
## 3  Cambridge              5 1
## 4 Manchester              1 3
## 5 Manchester              5 1
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 1 2
##   Bristol    0 0
##   Cambridge  0 1
##   Manchester 3 1
```


## Cross tabluation exercise

Using your `imdb_bechdel` data you just made, do the following cross tabulations using dplyr's `count` function. If you have time, you can also do the same with the base r `table` function.

1) Use count on the rating column in your imdb_bechdel data, which rating has the most results?
2) Using count on the rating column again, conditionally select ratings greater than 2 *hint: try and do this within the count function*. 
3) Create a two way cross tabulation with year and rating columns. Filter for the years 1966 or 1996. 


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
## 1   B    Y    4 4.535766 7.495376
## 2   C    X    5 8.913071 2.898740
## 3   A    X    9 5.193968 7.060462
## 4   C    Y    9 7.353648 3.860800
## 5   B    X    8 9.096596 6.908128
## 6   A    Y    4 5.765679 5.253680
```

```r
# perform simple grouped aggregation
df2 %>%
  group_by(key) %>%
  summarise(sum = sum(num1))
```

```
## # A tibble: 3 x 2
##   key     sum
##   <fct> <int>
## 1 A        33
## 2 B        28
## 3 C        57
```

The grouping concept can be a little confusing, and the below illustrations hopefully will help break down the steps, which are as follows:

1) Group your data by a categorical variable
2) Split your data by that group. You'll end up with several subsets of data
3) Perform a function, such as a mean or sum function, based on those split subsets of data
4) Combine the split subsets back together to make a summary table

![Single group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/Aggregation.png?raw=true){width="600"}


You can also aggregate more than one variable. 


```r
df2 %>%
  group_by(key) %>%
  summarise(sum = sum(num1), sum2 = sum(num2))
```

```
## # A tibble: 3 x 3
##   key     sum  sum2
##   <fct> <int> <dbl>
## 1 A        33  36.8
## 2 B        28  24.9
## 3 C        57  69.5
```


We can take this a bit further by adding the `n()` function, which counts how many of each category in our grouped variable there are. If you want to add in a relative frequency, we can then pipe to a `mutate` function. We then divide our count by the sum of our count.

```r
# adding frequency using n()
df2 %>%
  group_by(key) %>%
  summarise(sum = sum(num1), sum2 = sum(num2),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 3 x 5
##   key     sum  sum2 count_n rel_freq
##   <fct> <int> <dbl>   <int>    <dbl>
## 1 A        33  36.8       5     0.25
## 2 B        28  24.9       5     0.25
## 3 C        57  69.5      10     0.5
```

You can group your data by more than one group. This means when the data is *split*, more subsets are formed for all different possible splits. 

![Two group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/Aggregation_twogroup.png?raw=true){width="600"}


To do so, we add an extra categorical column to our `group_by()` function. The ordering of the groups matters. Have a look at both examples with the groups in a different order. 

```r
# two group aggregation
df2 %>%
  group_by(key, key2) %>%
  summarise(sum = sum(num1), sum2 = sum(num2),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## `summarise()` has grouped output by 'key'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 x 6
## # Groups:   key [3]
##   key   key2    sum  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X         9  5.19       1      0.2
## 2 A     Y        24 31.6        4      0.8
## 3 B     X        24 20.4        4      0.8
## 4 B     Y         4  4.54       1      0.2
## 5 C     X        17 28.0        4      0.4
## 6 C     Y        40 41.5        6      0.6
```

```r
# flip the groups to see the difference
df2 %>%
  group_by(key2, key) %>%
  summarise(sum = sum(num1), sum2 = sum(num2),
            count_n = n()) %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## `summarise()` has grouped output by 'key2'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 x 6
## # Groups:   key2 [2]
##   key2  key     sum  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 X     A         9  5.19       1   0.111 
## 2 X     B        24 20.4        4   0.444 
## 3 X     C        17 28.0        4   0.444 
## 4 Y     A        24 31.6        4   0.364 
## 5 Y     B         4  4.54       1   0.0909
## 6 Y     C        40 41.5        6   0.545
```

You can manually adjust the grouping structure of the output from your aggregation. By default, dplyr will use just your first grouping variable in the result. You can see this from the output from `rel_freq`. To change this, we use the `.groups` argument. Below are two examples, where we either drop all grouping with "drop" or keep the structure of the grouping with "keep". The default argument is "drop_last", which we what we have seen where only the first grouping is kept in the result. 

```r
# adjusting the grouping structure of the result: drop
df2 %>%
  group_by(key, key2) %>%
  summarise(sum = sum(num1), sum2 = sum(num2),
            count_n = n(), .groups = "drop") %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 6 x 6
##   key   key2    sum  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X         9  5.19       1     0.05
## 2 A     Y        24 31.6        4     0.2 
## 3 B     X        24 20.4        4     0.2 
## 4 B     Y         4  4.54       1     0.05
## 5 C     X        17 28.0        4     0.2 
## 6 C     Y        40 41.5        6     0.3
```

```r
# keep
df2 %>%
  group_by(key, key2) %>%
  summarise(sum = sum(num1), sum2 = sum(num2),
            count_n = n(), .groups = "keep") %>%
  mutate(rel_freq = count_n / sum(count_n))
```

```
## # A tibble: 6 x 6
## # Groups:   key, key2 [6]
##   key   key2    sum  sum2 count_n rel_freq
##   <fct> <fct> <int> <dbl>   <int>    <dbl>
## 1 A     X         9  5.19       1        1
## 2 A     Y        24 31.6        4        1
## 3 B     X        24 20.4        4        1
## 4 B     Y         4  4.54       1        1
## 5 C     X        17 28.0        4        1
## 6 C     Y        40 41.5        6        1
```

## Aggregation exercise


```r
head(imdb_bechdel)
```

```
## # A tibble: 6 x 23
##   imdb_id title   year date_published genre  duration country language director 
##     <dbl> <chr>  <dbl> <chr>          <chr>     <dbl> <chr>   <chr>    <chr>    
## 1     574 The S…  1906 26/12/1906     Biogr…       70 Austra… None     Charles …
## 2    2101 Cleop…  1912 13/11/1912     Drama…      100 USA     English  Charles …
## 3    3973 A Flo…  1914 04/09/1916     Comedy       63 USA     English  Sidney D…
## 4    4972 The B…  1915 21/03/1915     Drama…      195 USA     None     D.W. Gri…
## 5    6745 Gretc…  1916 03/09/1916     Crime…       58 USA     English  Chester …
## 6    7361 Snow …  1916 25/12/1916     Fanta…       63 USA     English  J. Searl…
## # … with 14 more variables: writer <chr>, production_company <chr>,
## #   actors <chr>, description <chr>, avg_vote <dbl>, votes <dbl>, budget <chr>,
## #   usa_gross_income <chr>, worlwide_gross_income <chr>, metascore <dbl>,
## #   User_reviews <dbl>, Critic_reviews <dbl>, id <dbl>, rating <dbl>
```

```r
names(imdb_bechdel)
```

```
##  [1] "imdb_id"               "title"                 "year"                 
##  [4] "date_published"        "genre"                 "duration"             
##  [7] "country"               "language"              "director"             
## [10] "writer"                "production_company"    "actors"               
## [13] "description"           "avg_vote"              "votes"                
## [16] "budget"                "usa_gross_income"      "worlwide_gross_income"
## [19] "metascore"             "User_reviews"          "Critic_reviews"       
## [22] "id"                    "rating"
```

```r
imdb_bechdel %>%
  filter(year > 2015) %>%
  group_by(year) %>%
  summarise(avg_vote_year = mean(avg_vote),
            avg_bechdel = mean(rating),
            count_n = n())  
```

```
## # A tibble: 5 x 4
##    year avg_vote_year avg_bechdel count_n
##   <dbl>         <dbl>       <dbl>   <int>
## 1  2016          6.50        2.27     241
## 2  2017          6.40        2.34     196
## 3  2018          6.45        2.44     164
## 4  2019          6.41        2.30     164
## 5  2020          6.26        2.61      44
```



# Rowwise aggregation

Performing aggregation of rows using either RowMeans or rowwise

------------------------------------------------------------------------

## Other options for aggregation

We have used dplyr for aggregation here, but there are two other options: the base r `aggregate()` function, or using the data.table package. We have shown some examples here so you are able to compare. 



```r
# fun extra, change your frequency to a percentage
df2 %>%
  group_by(key2, key) %>%
  summarise(sum = sum(num1), count_n = n()) %>%
  mutate(rel_freq = paste0(round(100 * count_n/sum(count_n), 0), "%"))
```

```
## `summarise()` has grouped output by 'key2'. You can override using the `.groups` argument.
```

```
## # A tibble: 6 x 5
## # Groups:   key2 [2]
##   key2  key     sum count_n rel_freq
##   <fct> <fct> <int>   <int> <chr>   
## 1 X     A         9       1 11%     
## 2 X     B        24       4 44%     
## 3 X     C        17       4 44%     
## 4 Y     A        24       4 36%     
## 5 Y     B         4       1 9%      
## 6 Y     C        40       6 55%
```

## Extra: Sampling explaination

If you are curious about how the `sample()` function works, which we used earlier, run the below code several times, reviewing the histogram it produces. This process is known as sampling with replacement, which means from our sample (numbers 1 to 10) we randomly extract a set number of values (20 in our example) which can be duplicates (extract the same number more than once).


```r
# sample with replacement
rand_num <- sample(1:10, 20, replace = TRUE)
# plot using hist function
hist(rand_num, breaks = 0:10)
# add line for mean
abline(v=mean(rand_num),col="darkblue")
```

![](rWorkshop7_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

Sampling without replacement means we don't extract the same number more than once, this means the number we extract must be less than the amount of data in our sample; in our second example we have 1 to 10 and are extract 5 values.


```r
# sample without replacement
rand_num2 <- sample(1:10, 5, replace = FALSE)
# plot using hist function
hist(rand_num2, breaks = 0:10)
# add line for mean
abline(v=mean(rand_num2),col="darkgreen")
```

![](rWorkshop7_files/figure-html/unnamed-chunk-24-1.png)<!-- -->
