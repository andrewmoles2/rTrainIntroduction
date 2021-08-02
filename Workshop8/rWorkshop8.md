---
title: "R Workshop 7 - Joining and aggregation"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "16 July, 2021"
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
## 1   Hello      10       1
## 2   Hello       9       2
## 3   Hello       2       3
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
## 1  Hello     10        1
## 2  Hello      9        2
## 3  Hello      2        3
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
## $ reviews_from_users    <dbl> 1, 7, 5, 25, 31, 13, 12, 7, 4, 8, 9, 9, 16, 8, N…
## $ reviews_from_critics  <dbl> 2, 7, 2, 3, 14, 5, 9, 5, 1, 1, 9, 28, 7, 23, 4, …
```

To join the data we have to make sure the IDs we will be using to join the data match. First we change the name, then we remove the text from the imdb data `imdb_title_id` column.

1) Using the `rename` function, change the `imdb_title_id` column in movies_imdb to `imdb_id`. Make sure to save the result back to movies_imdb
2) We now need to fix the ids in the movies_imdb dataset. Type the following code to fix the ids: `movies_imdb$imdb_id <- parse_number(movies_imdb$imdb_id)`. The `parse_number()` function is from the readr library, and removes text from strings, which is exactly what we need in this case
3) Using the `inner_join()` function, join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel`. You can do this using the by argument with imdb_id, title, and year columns, or you can let the function do this for you
4) Using the `full_join()` function,  join together movies_imdb and bechdel data frames. Call the new data frame `imdb_bechdel_full`. You can do this using the by argument with imdb_id, title, and year columns, or you can let the function do this for you
5) Have a look at both your newly joined up data frames using head, glimpse or View. Do you notice how when we used inner_join we filtered out all data that isn't in our bechdel test dataset? 


```r
# your code here
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
## 1  Cambridge              1
## 2 Birmingham              5
## 3 Birmingham              4
## 4 Birmingham              4
## 5 Birmingham              2
## 6    Bristol              1
```

```r
# frequency of one variable
df1 %>%
  count(city)
```

```
##         city n
## 1 Birmingham 8
## 2    Bristol 5
## 3  Cambridge 6
## 4 Manchester 1
```

```r
table(df1$city)
```

```
## 
## Birmingham    Bristol  Cambridge Manchester 
##          8          5          6          1
```

We can expand this by using conditional operators in the count or table functions.

```r
# conditional frequency
df1 %>%
  count(city == "Cambridge")
```

```
##   city == "Cambridge"  n
## 1               FALSE 14
## 2                TRUE  6
```

```r
table(df1$city == "Cambridge")
```

```
## 
## FALSE  TRUE 
##    14     6
```

We can also make two way frequency tables to compare two variables next to each other. Notice the difference between the two functions. Count provides the table in a data frame structure, which is easy to work with should you need to, but table is perhaps easier to read initially. 


```r
# two way frequency tables
df1 %>%
  count(city, tourist_rating)
```

```
##          city tourist_rating n
## 1  Birmingham              1 3
## 2  Birmingham              2 1
## 3  Birmingham              4 3
## 4  Birmingham              5 1
## 5     Bristol              1 1
## 6     Bristol              2 1
## 7     Bristol              3 2
## 8     Bristol              4 1
## 9   Cambridge              1 2
## 10  Cambridge              2 1
## 11  Cambridge              3 2
## 12  Cambridge              4 1
## 13 Manchester              2 1
```

```r
table(df1$city, df1$tourist_rating)
```

```
##             
##              1 2 3 4 5
##   Birmingham 3 1 0 3 1
##   Bristol    1 1 2 1 0
##   Cambridge  2 1 2 1 0
##   Manchester 0 1 0 0 0
```

We can also apply filtering using count or table functions. With count we use dplyr's filter function, with table we use base r indexing.


```r
df1 %>%
  filter(tourist_rating == 1 | tourist_rating == 5) %>%
  count(city, tourist_rating)
```

```
##         city tourist_rating n
## 1 Birmingham              1 3
## 2 Birmingham              5 1
## 3    Bristol              1 1
## 4  Cambridge              1 2
```

```r
table(df1$city, df1$tourist_rating)[, c(1, 5)]
```

```
##             
##              1 5
##   Birmingham 3 1
##   Bristol    1 0
##   Cambridge  2 0
##   Manchester 0 0
```


## Cross tabluation exercise

Using your `imdb_bechdel` data you just made, do the following cross tabulations using dplyr's `count` function. If you have time, you can also do the same with the base r `table` function.

1) Use count on the rating column in your imdb_bechdel data, which rating has the most results?
2) Using count on the rating column again, conditionally select ratings greater than 2 *hint: try and do this within the count function*. 
3) Create a two way cross tabulation with year and rating columns. Filter for the years 1966 or 1996. 


```r
# your code here
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
## 1   B    X    9 6.782238 9.569728
## 2   C    Y    2 2.652997 5.017626
## 3   B    Y    4 7.498142 6.010212
## 4   B    X    3 2.548153 1.349955
## 5   C    X    9 9.809728 3.354930
## 6   C    Y    4 3.586538 8.408162
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
## 1 A         8
## 2 B        25
## 3 C        59
```

The grouping concept can be a little confusing, and the below illustrations hopefully will help break down the steps, which are as follows:

1) Group your data by a categorical variable
2) Split your data by that group. You'll end up with several subsets of data
3) Perform a function, such as a mean or sum function, based on those split subsets of data
4) Combine the split subsets back together to make a summary table

![Single group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/Aggregation.png?raw=true){width="600"}


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
## 1 A         8  11.2
## 2 B        25  37.1
## 3 C        59  61.2
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
## 1 A         8  11.2       2     0.1 
## 2 B        25  37.1       7     0.35
## 3 C        59  61.2      11     0.55
```

You can group your data by more than one group. This means when the data is *split*, more subsets are formed for all different possible splits. 

![Two group aggregation](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop7/images/Aggregation_twogroup.png?raw=true){width="600"}


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
## 1 A     X         7  1.78       1    0.5  
## 2 A     Y         1  9.37       1    0.5  
## 3 B     X        13 12.7        3    0.429
## 4 B     Y        12 24.4        4    0.571
## 5 C     X        45 42.1        7    0.636
## 6 C     Y        14 19.1        4    0.364
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
## 1 X     A         7  1.78       1   0.0909
## 2 X     B        13 12.7        3   0.273 
## 3 X     C        45 42.1        7   0.636 
## 4 Y     A         1  9.37       1   0.111 
## 5 Y     B        12 24.4        4   0.444 
## 6 Y     C        14 19.1        4   0.444
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
## 1 A     X         7  1.78       1     0.05
## 2 A     Y         1  9.37       1     0.05
## 3 B     X        13 12.7        3     0.15
## 4 B     Y        12 24.4        4     0.2 
## 5 C     X        45 42.1        7     0.35
## 6 C     Y        14 19.1        4     0.2
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
## 1 A     X         7  1.78       1        1
## 2 A     Y         1  9.37       1        1
## 3 B     X        13 12.7        3        1
## 4 B     Y        12 24.4        4        1
## 5 C     X        45 42.1        7        1
## 6 C     Y        14 19.1        4        1
```

## Aggregation exercise

Using the examples above, we are going to create three aggregations from our `imdb_bechdel` dataset we made earlier in the session. 

1) Group your imdb_bechdel data by rating, and use summarise to find the avg_vote per rating, and the frequency of each group. Use `median()` to calculate the average. 
2) Filter for years greater than 2015 and group by year. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Use `median()` to calculate the average. 
3) Filter for years greater than 2015 and group by year and rating. Summarise the avg_vote per year, average duration per year, and the frequency of each group. Finally, pipe to a mutate function, and calculate the relative frequency of each year. Use `median()` to calculate the average. 

```r
# your code here
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
##  1      8.45
##  2      3.22
##  3      5.84
##  4      2.30
##  5      7.39
##  6      5.33
##  7      3.41
##  8      7.97
##  9      4.09
## 10      5.82
## 11      2.45
## 12      5.80
## 13      5.77
## 14      4.14
## 15      4.08
## 16      7.75
## 17      3.56
## 18      7.35
## 19      3.80
## 20      2.36
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
##  1      8.45
##  2      3.22
##  3      5.84
##  4      2.30
##  5      7.39
##  6      5.33
##  7      3.41
##  8      7.97
##  9      4.09
## 10      5.82
## 11      2.45
## 12      5.80
## 13      5.77
## 14      4.14
## 15      4.08
## 16      7.75
## 17      3.56
## 18      7.35
## 19      3.80
## 20      2.36
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
##  1 B     X         9  6.78  9.57      8.45
##  2 C     Y         2  2.65  5.02      3.22
##  3 B     Y         4  7.50  6.01      5.84
##  4 B     X         3  2.55  1.35      2.30
##  5 C     X         9  9.81  3.35      7.39
##  6 C     Y         4  3.59  8.41      5.33
##  7 B     Y         2  5.72  2.53      3.41
##  8 C     Y         7  9.23  7.69      7.97
##  9 C     X         1  6.64  4.63      4.09
## 10 A     Y         1  9.37  7.07      5.82
## 11 A     X         7  1.78 -1.43      2.45
## 12 C     X        10  3.10  4.31      5.80
## 13 C     X        10  5.75  1.56      5.77
## 14 B     X         1  3.40  8.01      4.14
## 15 C     X         2  6.48  3.75      4.08
## 16 C     X         9  8.50  5.75      7.75
## 17 C     Y         1  3.64  6.04      3.56
## 18 B     Y         5  9.73  7.32      7.35
## 19 C     X         4  1.80  5.61      3.80
## 20 B     Y         1  1.42  4.65      2.36
```

An alternative to using `rowwise()` is to use the base r `rowMeans()` function within `mutate`. For larger datasets this is a faster option to using `rowwise()`. 

```r
# using rowMeans with mutate and across
df2 %>%
  mutate(total_avg = rowMeans(across(c(num1, num2, num3))))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    B    X    9 6.782238  9.569728  8.450655
## 2    C    Y    2 2.652997  5.017626  3.223541
## 3    B    Y    4 7.498142  6.010212  5.836118
## 4    B    X    3 2.548153  1.349955  2.299369
## 5    C    X    9 9.809728  3.354930  7.388219
## 6    C    Y    4 3.586538  8.408162  5.331567
## 7    B    Y    2 5.716680  2.527597  3.414759
## 8    C    Y    7 9.230242  7.688049  7.972763
## 9    C    X    1 6.641735  4.633204  4.091646
## 10   A    Y    1 9.373589  7.073632  5.815741
## 11   A    X    7 1.777652 -1.430055  2.449199
## 12   C    X   10 3.098852  4.313253  5.804035
## 13   C    X   10 5.747769  1.559590  5.769120
## 14   B    X    1 3.395330  8.014856  4.136729
## 15   C    X    2 6.480945  3.750126  4.077023
## 16   C    X    9 8.498917  5.752309  7.750409
## 17   C    Y    1 3.637159  6.038958  3.558706
## 18   B    Y    5 9.726283  7.324579  7.350287
## 19   C    X    4 1.797630  5.605133  3.800921
## 20   B    Y    1 1.420101  4.652377  2.357493
```

```r
# using rowMeans with mutate, across, and where
df2 %>%
  mutate(total_avg = rowMeans(across(where(is.numeric))))
```

```
##    key key2 num1     num2      num3 total_avg
## 1    B    X    9 6.782238  9.569728  8.450655
## 2    C    Y    2 2.652997  5.017626  3.223541
## 3    B    Y    4 7.498142  6.010212  5.836118
## 4    B    X    3 2.548153  1.349955  2.299369
## 5    C    X    9 9.809728  3.354930  7.388219
## 6    C    Y    4 3.586538  8.408162  5.331567
## 7    B    Y    2 5.716680  2.527597  3.414759
## 8    C    Y    7 9.230242  7.688049  7.972763
## 9    C    X    1 6.641735  4.633204  4.091646
## 10   A    Y    1 9.373589  7.073632  5.815741
## 11   A    X    7 1.777652 -1.430055  2.449199
## 12   C    X   10 3.098852  4.313253  5.804035
## 13   C    X   10 5.747769  1.559590  5.769120
## 14   B    X    1 3.395330  8.014856  4.136729
## 15   C    X    2 6.480945  3.750126  4.077023
## 16   C    X    9 8.498917  5.752309  7.750409
## 17   C    Y    1 3.637159  6.038958  3.558706
## 18   B    Y    5 9.726283  7.324579  7.350287
## 19   C    X    4 1.797630  5.605133  3.800921
## 20   B    Y    1 1.420101  4.652377  2.357493
```

If you want to do a sum calculation, you should use the `rowSums()` function. 

```r
# row sum
df2 %>%
  mutate(total_sum = rowSums(across(c(num1, num2, num3))))
```

```
##    key key2 num1     num2      num3 total_sum
## 1    B    X    9 6.782238  9.569728 25.351966
## 2    C    Y    2 2.652997  5.017626  9.670622
## 3    B    Y    4 7.498142  6.010212 17.508353
## 4    B    X    3 2.548153  1.349955  6.898107
## 5    C    X    9 9.809728  3.354930 22.164658
## 6    C    Y    4 3.586538  8.408162 15.994700
## 7    B    Y    2 5.716680  2.527597 10.244277
## 8    C    Y    7 9.230242  7.688049 23.918290
## 9    C    X    1 6.641735  4.633204 12.274939
## 10   A    Y    1 9.373589  7.073632 17.447222
## 11   A    X    7 1.777652 -1.430055  7.347597
## 12   C    X   10 3.098852  4.313253 17.412105
## 13   C    X   10 5.747769  1.559590 17.307359
## 14   B    X    1 3.395330  8.014856 12.410187
## 15   C    X    2 6.480945  3.750126 12.231070
## 16   C    X    9 8.498917  5.752309 23.251226
## 17   C    Y    1 3.637159  6.038958 10.676117
## 18   B    Y    5 9.726283  7.324579 22.050862
## 19   C    X    4 1.797630  5.605133 11.402763
## 20   B    Y    1 1.420101  4.652377  7.072478
```

## Rowwise aggregation exercise

In this exercise you will be debugging my code to get it running! We are going to sum the User_reviews and Critic_reviews column, to make a new column called total_reviews. We want the total reviews for each row of films from before 1930.

You have to debug the code for both the rowwise method and the rowSums/rowMeans method. 


```r
# rowwise method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, User_reviews, rating) %>%
  mutate(total_reviews = sum(c_across(User_reviews:Critic_reviews), na.rm = TRUE))

# rowSums method
imdb_bechdel %>%
  filter(year < 1930) %>%
  select(title:year, duration, avg_vote, User_reviews, rating) %>%
  mutate(total_reviews = sum(across(User_reviews:Critic_reviews)))
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

1) Using your imdb_bechdel dataset, group by year
2) Pipe to a summarise, and work out the average rating (bechdel), average vote, and the frequency (using n())
3) Pipe to a filter, filtering for your average vote to be greater than 7 and your frequency (count) to be greater than 20 
4) Now pipe the output to `kbl()`
5) Finally, pipe that to `kable_minimal(full_width = F)`. You should now have a nice table! 
6) Play around with different kable styles. Try out the following: `kable_classic(full_width = F)`, `kable_classic2(full_width = F)` and `kable_paper(full_width = F)`

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
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 57% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> X </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> 64% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:left;"> Y </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 36% </td>
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

# by year and rating (> 2015)
imdb_bechdel[year > 2015, .(avg_vote_rating = median(avg_vote),
                 avg_duration = median(duration)), by = c("year","rating")]
```
If you are interested in learning more have a look the introduction to data table vignette: <https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html>. 

