---
title: "R Data Wrangling 1 - Tidyverse introduction with Pipes and dplyr"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "05 October, 2021"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: true
    toc_float: true
---

# What this workshop will cover

-   Introduce the use of pipes
-   Indexing with the select function from dplyr
-   Conditional indexing of data with the filter function from dplyr

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

# What is the tidyverse?

![image credit: Analytics Vidhya](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-1/images/tidyverse.jpeg?raw=true)

The tidyverse is a collection of R packages that are designed for data science. These packages share design, syntax, and philosophy. These packages cover the import of data (`readr` and `haven`), manipulation and transformation of data (`dplyr`, `tidyr`, `stringr`, `purrr`, `forcats`, and `lubridate`), visualisation (`ggplot` and it's extensions), and analysis (`tidymodels`).

Essentially, the tidyverse makes data science in R less painless, improving your experience of R and data science, especially in the data cleaning and wrangling stages.

# What is tidy data?

The tidyverse has a focus on working with tidy data, or making data tidy, ready for visualisation and analysis. So what does tidy data mean?

When your data is tidy, *each column is a variable*, *each row is an observation*, and *each cell is a single observation*, as per our example below:


```r
# tidy data example
tidy_df <- data.frame(
  id = 1:6,
  name = c("floof", "max", "cat", "donut", "merlin", "panda"),
  colour = c("grey", "black", "orange", "grey", "black", "calico")
)

tidy_df
```

```
##   id   name colour
## 1  1  floof   grey
## 2  2    max  black
## 3  3    cat orange
## 4  4  donut   grey
## 5  5 merlin  black
## 6  6  panda calico
```

Messy data is inconsistent and unique, making it harder to work with, and harder for others to work with. See this example of a messy dataset that would be hard to work with. We would have to split up the animal column to name and colour. In later workshops, we will cover how to deal with messy data.


```r
# example messy data frame
messy_df <- data.frame(
  id = c(1,1,2,2,3,3,4,4,5,5,6,6),
  animal = c("floof", "grey",
             "max", "black",
             "cat", "orange",
             "donut", "grey",
             "merlin", "black",
             "panda", "calico")
)

messy_df
```

```
##    id animal
## 1   1  floof
## 2   1   grey
## 3   2    max
## 4   2  black
## 5   3    cat
## 6   3 orange
## 7   4  donut
## 8   4   grey
## 9   5 merlin
## 10  5  black
## 11  6  panda
## 12  6 calico
```

![Image credit: Julie Lowndes and Allison Horst](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-1/images/tidydata_2.jpeg?raw=true)

See this excellent article, which has lots of nice images, for a summary :-<https://www.openscapes.org/blog/2020/10/12/tidy-data/>


# Package install task

In this workshop we will be using three packages: magrittr, dplyr, and readr.

Using the code chunk below, install all three of these packages. *note that dplyr is large and might take a minute or so to install*


```r
# your code here
install.packages("")
install.packages("")
install.packages("")
```

*Also note that you can install the whole tidyverse with install.packages("tidyverse")! This takes a while though, so for this workshop we will just install individual packages.*

# Intro to pipes

The pipe operator in R comes from the `magrittr` package, using syntax of `%>%`.

The pipe operator is for chaining a sequence of operations together. This has two main advantages: it makes your code more readable, and it saves some typing.

The syntax is `data %>% function`, as shown in the example below. The data gets *piped* into the function.


```r
library(magrittr)

data <- c(4.1 ,1.7, 1.1, 7.5, 1.7)

data %>% mean()
```

```
## [1] 3.22
```

To see the difference between using pipes and not using pipes, look at the following examples.

We are going to calculate a mean of a vector of numbers, round the result, and print it using paste.


```r
# Make some data: 20 randomly selected data points, from 1 to 10
x <- sample(1:10, 20, replace = TRUE)
y <- sample(1:10, 20, replace = TRUE)

# without pipe
y_mean <- mean(y)
y_mean <- round(y_mean, digits = 2)
y_mean <- paste("Mean value of y is", y_mean)
y_mean
```

```
## [1] "Mean value of y is 5.4"
```

```r
# without pipe in one line
paste("Mean value of y is", round(mean(y), digits = 2))
```

```
## [1] "Mean value of y is 5.4"
```

Now lets have a look at how to do this same set of operations with pipes. The process is as follows: assign x to x_mean, then pipe to x to a mean function, pipe the result of mean to round, finally assign result to paste.

You will notice in the paste function we have used a `.` after the text. This is called a *place-holder*, whereby instead of using the data (like we did above without the pipe) we add a `.` to tell R that is where we want our data to go.


```r
# load in magrittr
library(magrittr)

# magrittr pipe
x_mean <- x %>% # assign result at the start
  mean() %>% 
  round(digits = 2) %>%
  paste("Mean value of x is", .) # we use the . as a place holder for a variable (e.g. instead of x)

x_mean
```

```
## [1] "Mean value of x is 6.55"
```

Notice how we assign the result at the start just like we would usually do, then pipe from then on.

It is also worth mentioning that as of version 4.1 of R, base R comes with a native pipe operator. This has just been introduced, and may get more use in examples you'll see online in the future. The syntax uses `|>` as the pipe, and the structure is the same as a magrittr pipe.

*note that the native pipe currently doesn't have a place-holder, so we won't use paste in this example*


```r
# native R pipe
z <- sample(1:10, 20, replace = TRUE)

z_mean <- z |> 
  mean() |>
  round(digits = 2)

z_mean
```

```
## [1] 5.35
```

If the above example doesn't work, it means you have a version of R that is less than 4.1. Run the below code chunk to test out your R version. If it is less than 4.1 you can update it after the workshop.


```r
# test your r version
R.version.string
```

```
## [1] "R version 4.1.0 (2021-05-18)"
```

We will be using the magrittr pipe (`%>%`) for the rest of this workshop, as it's currently the pipe operator you will come across most in the r world.

## Exercise - using pipes

Using the vector of temperature provided and using magrittr pipes:

1)  Pipe median and paste functions together to get a final result that looks like: *"median temp is 15"*
2)  Pipe max and paste functions together to get a final result that looks like: *"max temp is 20"*

*hint: don't forget to use the place-holder with paste*


```r
library(magrittr)

temperature <- c(10, 16, 12, 15, 14, 15, 20)

# your code here
```

# Introduction to dplyr

Dplyr is a package that is built for data manipulation, using functions that describe what they do. For example, the `select()` function selects columns you want, or don't want, from a data frame.

The dplyr package has a lot of functions built into the package, each has it's own very helpful documentation page with examples - <https://dplyr.tidyverse.org/reference/index.html>

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-1/images/dplyr_wrangling.png?raw=true){width="516"}

Dplyr functions work with and without pipes and you'll see both when searching online. If using a pipe, you call your data then pipe that to a function, such as `data %>% mean()`. If you are not using a pipe, you call your data within the function, such as `mean(data)`.

We will focus on two key dplyr functions for now: `select()` and `filter()`. We will use the messi_career data for the examples. Run the code chunk below to get the data into r and have a look at it.


```r
# create the messi career data
messi_career <- data.frame(Appearances = c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44),
                           Goals = c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31),
                           Season = c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019),
                           Club = rep("FC Barcelona", 16),
                          Age = seq(17, 32),
                          champLeagueGoal = c(0,1,1,6,9,8,12,14,8,8,10,6,11,6,12,3))
# view the data
head(messi_career)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1           9     1   2004 FC Barcelona  17               0
## 2          25     8   2005 FC Barcelona  18               1
## 3          36    17   2006 FC Barcelona  19               1
## 4          40    16   2007 FC Barcelona  20               6
## 5          51    38   2008 FC Barcelona  21               9
## 6          53    47   2009 FC Barcelona  22               8
```

## Select function

The select function subsets columns from a data frame using their name. There are several different ways of using select. Run each of the code chunks below and review the outputs.

First, we can give the names of the columns we want to select.


```r
# load dplyr
library(dplyr)

# select single column
messi_career %>% select(Goals)
```

```
##    Goals
## 1      1
## 2      8
## 3     17
## 4     16
## 5     38
## 6     47
## 7     53
## 8     73
## 9     60
## 10    41
## 11    58
## 12    41
## 13    54
## 14    45
## 15    51
## 16    31
```

```r
# select all but single column
messi_career %>% select(-Goals)
```

```
##    Appearances Season         Club Age champLeagueGoal
## 1            9   2004 FC Barcelona  17               0
## 2           25   2005 FC Barcelona  18               1
## 3           36   2006 FC Barcelona  19               1
## 4           40   2007 FC Barcelona  20               6
## 5           51   2008 FC Barcelona  21               9
## 6           53   2009 FC Barcelona  22               8
## 7           55   2010 FC Barcelona  23              12
## 8           60   2011 FC Barcelona  24              14
## 9           50   2012 FC Barcelona  25               8
## 10          46   2013 FC Barcelona  26               8
## 11          57   2014 FC Barcelona  27              10
## 12          49   2015 FC Barcelona  28               6
## 13          52   2016 FC Barcelona  29              11
## 14          54   2017 FC Barcelona  30               6
## 15          50   2018 FC Barcelona  31              12
## 16          44   2019 FC Barcelona  32               3
```

```r
# select multiple columns
messi_career %>% select(Appearances, Goals, Age)
```

```
##    Appearances Goals Age
## 1            9     1  17
## 2           25     8  18
## 3           36    17  19
## 4           40    16  20
## 5           51    38  21
## 6           53    47  22
## 7           55    53  23
## 8           60    73  24
## 9           50    60  25
## 10          46    41  26
## 11          57    58  27
## 12          49    41  28
## 13          52    54  29
## 14          54    45  30
## 15          50    51  31
## 16          44    31  32
```

Another method is using a range of columns, known as a slice. Here we are selecting columns from Season to Age, which includes the Club column as well. We can also combine this with the ! (not) operator to exclude those columns.


```r
# select slice (or range) of columns
messi_career %>% select(Season:Age)
```

```
##    Season         Club Age
## 1    2004 FC Barcelona  17
## 2    2005 FC Barcelona  18
## 3    2006 FC Barcelona  19
## 4    2007 FC Barcelona  20
## 5    2008 FC Barcelona  21
## 6    2009 FC Barcelona  22
## 7    2010 FC Barcelona  23
## 8    2011 FC Barcelona  24
## 9    2012 FC Barcelona  25
## 10   2013 FC Barcelona  26
## 11   2014 FC Barcelona  27
## 12   2015 FC Barcelona  28
## 13   2016 FC Barcelona  29
## 14   2017 FC Barcelona  30
## 15   2018 FC Barcelona  31
## 16   2019 FC Barcelona  32
```

```r
# select slice and other columns
messi_career %>% select(Appearances:Season, champLeagueGoal)
```

```
##    Appearances Goals Season champLeagueGoal
## 1            9     1   2004               0
## 2           25     8   2005               1
## 3           36    17   2006               1
## 4           40    16   2007               6
## 5           51    38   2008               9
## 6           53    47   2009               8
## 7           55    53   2010              12
## 8           60    73   2011              14
## 9           50    60   2012               8
## 10          46    41   2013               8
## 11          57    58   2014              10
## 12          49    41   2015               6
## 13          52    54   2016              11
## 14          54    45   2017               6
## 15          50    51   2018              12
## 16          44    31   2019               3
```

```r
# negate selection of columns
messi_career %>% select(!(Season:Age))
```

```
##    Appearances Goals champLeagueGoal
## 1            9     1               0
## 2           25     8               1
## 3           36    17               1
## 4           40    16               6
## 5           51    38               9
## 6           53    47               8
## 7           55    53              12
## 8           60    73              14
## 9           50    60               8
## 10          46    41               8
## 11          57    58              10
## 12          49    41               6
## 13          52    54              11
## 14          54    45               6
## 15          50    51              12
## 16          44    31               3
```

```r
# negate selection with slice and extra column (note c() function used)
messi_career %>% select(!c(Season:Age, champLeagueGoal))
```

```
##    Appearances Goals
## 1            9     1
## 2           25     8
## 3           36    17
## 4           40    16
## 5           51    38
## 6           53    47
## 7           55    53
## 8           60    73
## 9           50    60
## 10          46    41
## 11          57    58
## 12          49    41
## 13          52    54
## 14          54    45
## 15          50    51
## 16          44    31
```

As you can see, `select()` makes it easy to extract columns from your data, and becomes more useful the larger your dataset becomes.

In the examples above we did not assign the result. See the examples below on how to do this.


```r
# assign result to subset
messi_sub <- messi_career %>%
  select(Appearances, Goals, Age)

messi_sub
```

```
##    Appearances Goals Age
## 1            9     1  17
## 2           25     8  18
## 3           36    17  19
## 4           40    16  20
## 5           51    38  21
## 6           53    47  22
## 7           55    53  23
## 8           60    73  24
## 9           50    60  25
## 10          46    41  26
## 11          57    58  27
## 12          49    41  28
## 13          52    54  29
## 14          54    45  30
## 15          50    51  31
## 16          44    31  32
```

```r
# The no pipe method
messi_sub <- select(messi_career, Appearances, Goals, Age)
```

## Select exercise

For your exercises, you will be using imdb movie data! I've loaded it here in the code for you.

The data has 22 columns, some of which we won't need. We can use `select` to subset our data to keep only what we want.

1)  Run the code currenty in the code chunk to load the libraries and the data, and review the output from `glimpse()`
2)  Using select with pipes, subset the `imdb_movie` data so you have the following columns: imdb_id through to writer, actors, avg_vote to votes, reviews_from_users to reviews_from_critics. Assign the result to `imdb_sub`
3)  Use glimpse to review the subsetted data: *data %\>% glimpse()*
4)  There is a more efficient way of doing this using select. From looking at the examples provided, can you think of a better way of taking out the columns we removed?

*hint: you should be able to fit this into one select call*


```r
# load libraries
library(readr)
library(dplyr)

# load data
movies_imdb <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/r-data-wrangling-1/data/IMDb%20movies.csv")

# use glimpse to review data (tidyverse version of str())
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
# your code here
```

# Select helper functions

So far we have selected just columns we named, but there are other methods we can use. Dplyr has a number of *helper* functions that come with `select()`.

One such example is the `contains()` function, that finds columns that contain the string a string. This is a useful option if you just want to pick out columns that have some similar text in them.


```r
# select by literal string
messi_career %>% select(contains("Goal"))
```

```
##    Goals champLeagueGoal
## 1      1               0
## 2      8               1
## 3     17               1
## 4     16               6
## 5     38               9
## 6     47               8
## 7     53              12
## 8     73              14
## 9     60               8
## 10    41               8
## 11    58              10
## 12    41               6
## 13    54              11
## 14    45               6
## 15    51              12
## 16    31               3
```

Other options are the `starts_with()` or `ends_with()` helpers. You provide a string of what your column either starts with or ends with, and they will be selected.


```r
# columns starting with A
messi_career %>%
  select(starts_with("A"))
```

```
##    Appearances Age
## 1            9  17
## 2           25  18
## 3           36  19
## 4           40  20
## 5           51  21
## 6           53  22
## 7           55  23
## 8           60  24
## 9           50  25
## 10          46  26
## 11          57  27
## 12          49  28
## 13          52  29
## 14          54  30
## 15          50  31
## 16          44  32
```

```r
# columns ending with s
messi_career %>%
  select(ends_with("s"))
```

```
##    Appearances Goals
## 1            9     1
## 2           25     8
## 3           36    17
## 4           40    16
## 5           51    38
## 6           53    47
## 7           55    53
## 8           60    73
## 9           50    60
## 10          46    41
## 11          57    58
## 12          49    41
## 13          52    54
## 14          54    45
## 15          50    51
## 16          44    31
```

```r
# columns not starting with A
messi_career %>%
  select(!starts_with("A"))
```

```
##    Goals Season         Club champLeagueGoal
## 1      1   2004 FC Barcelona               0
## 2      8   2005 FC Barcelona               1
## 3     17   2006 FC Barcelona               1
## 4     16   2007 FC Barcelona               6
## 5     38   2008 FC Barcelona               9
## 6     47   2009 FC Barcelona               8
## 7     53   2010 FC Barcelona              12
## 8     73   2011 FC Barcelona              14
## 9     60   2012 FC Barcelona               8
## 10    41   2013 FC Barcelona               8
## 11    58   2014 FC Barcelona              10
## 12    41   2015 FC Barcelona               6
## 13    54   2016 FC Barcelona              11
## 14    45   2017 FC Barcelona               6
## 15    51   2018 FC Barcelona              12
## 16    31   2019 FC Barcelona               3
```

## Select helper exercise

Using the imdb_sub dataset you made in the previous exercise:

1)  Find columns in imdb_sub that contain "vote"
2)  Find columns in imdb_sub that start with "d"
3)  Find columns in imdb_sub that end with "e"
4)  Find columns in imdb_sub that either start with "d" or end with "e" *hint: you can use an or (`|`) statement with select*


```r
# your code here
```

# Using select to change column order

It is also helpful to change the order of your columns, and you can use `select` to do this.

If we wanted to move the club column as the first column in our messi_career data, we could do it manually but naming all the columns like the example below.


```r
# manually
messi_career %>%
  select(Club, Appearances, Goals, Season, Age, champLeagueGoal)
```

```
##            Club Appearances Goals Season Age champLeagueGoal
## 1  FC Barcelona           9     1   2004  17               0
## 2  FC Barcelona          25     8   2005  18               1
## 3  FC Barcelona          36    17   2006  19               1
## 4  FC Barcelona          40    16   2007  20               6
## 5  FC Barcelona          51    38   2008  21               9
## 6  FC Barcelona          53    47   2009  22               8
## 7  FC Barcelona          55    53   2010  23              12
## 8  FC Barcelona          60    73   2011  24              14
## 9  FC Barcelona          50    60   2012  25               8
## 10 FC Barcelona          46    41   2013  26               8
## 11 FC Barcelona          57    58   2014  27              10
## 12 FC Barcelona          49    41   2015  28               6
## 13 FC Barcelona          52    54   2016  29              11
## 14 FC Barcelona          54    45   2017  30               6
## 15 FC Barcelona          50    51   2018  31              12
## 16 FC Barcelona          44    31   2019  32               3
```

This could get really messy if you have lots of data. Two helper functions make this much easier: `everything()` and `last_col()`. Everything selects every column not already specified, so is useful if we want to move a column to the first column in the dataset.


```r
# move club to first column
messi_career %>%
  select(Club, everything())
```

```
##            Club Appearances Goals Season Age champLeagueGoal
## 1  FC Barcelona           9     1   2004  17               0
## 2  FC Barcelona          25     8   2005  18               1
## 3  FC Barcelona          36    17   2006  19               1
## 4  FC Barcelona          40    16   2007  20               6
## 5  FC Barcelona          51    38   2008  21               9
## 6  FC Barcelona          53    47   2009  22               8
## 7  FC Barcelona          55    53   2010  23              12
## 8  FC Barcelona          60    73   2011  24              14
## 9  FC Barcelona          50    60   2012  25               8
## 10 FC Barcelona          46    41   2013  26               8
## 11 FC Barcelona          57    58   2014  27              10
## 12 FC Barcelona          49    41   2015  28               6
## 13 FC Barcelona          52    54   2016  29              11
## 14 FC Barcelona          54    45   2017  30               6
## 15 FC Barcelona          50    51   2018  31              12
## 16 FC Barcelona          44    31   2019  32               3
```

Last col calls the last column in your data frame, so we can call `last_col()` to move 'champLeagueGoal' to the first column, then use everything to keep the rest of the columns as they are.


```r
# move last column to first column
messi_career %>%
  select(last_col(), everything())
```

```
##    champLeagueGoal Appearances Goals Season         Club Age
## 1                0           9     1   2004 FC Barcelona  17
## 2                1          25     8   2005 FC Barcelona  18
## 3                1          36    17   2006 FC Barcelona  19
## 4                6          40    16   2007 FC Barcelona  20
## 5                9          51    38   2008 FC Barcelona  21
## 6                8          53    47   2009 FC Barcelona  22
## 7               12          55    53   2010 FC Barcelona  23
## 8               14          60    73   2011 FC Barcelona  24
## 9                8          50    60   2012 FC Barcelona  25
## 10               8          46    41   2013 FC Barcelona  26
## 11              10          57    58   2014 FC Barcelona  27
## 12               6          49    41   2015 FC Barcelona  28
## 13              11          52    54   2016 FC Barcelona  29
## 14               6          54    45   2017 FC Barcelona  30
## 15              12          50    51   2018 FC Barcelona  31
## 16               3          44    31   2019 FC Barcelona  32
```

Another option is to use the `relocate()` function. This has the same syntax as select, but has extra functionally for moving columns with the `.after` and `.before` arguments.

By default, relocate will move the column you specify to the first column.


```r
# default moves to first column
messi_career %>%
  relocate(Club)
```

```
##            Club Appearances Goals Season Age champLeagueGoal
## 1  FC Barcelona           9     1   2004  17               0
## 2  FC Barcelona          25     8   2005  18               1
## 3  FC Barcelona          36    17   2006  19               1
## 4  FC Barcelona          40    16   2007  20               6
## 5  FC Barcelona          51    38   2008  21               9
## 6  FC Barcelona          53    47   2009  22               8
## 7  FC Barcelona          55    53   2010  23              12
## 8  FC Barcelona          60    73   2011  24              14
## 9  FC Barcelona          50    60   2012  25               8
## 10 FC Barcelona          46    41   2013  26               8
## 11 FC Barcelona          57    58   2014  27              10
## 12 FC Barcelona          49    41   2015  28               6
## 13 FC Barcelona          52    54   2016  29              11
## 14 FC Barcelona          54    45   2017  30               6
## 15 FC Barcelona          50    51   2018  31              12
## 16 FC Barcelona          44    31   2019  32               3
```

We call `.after` and `.before` like the examples below. We can also move more than one column.


```r
# move club to col after champLeagueGoal
messi_career %>%
  relocate(Club, .after = champLeagueGoal)
```

```
##    Appearances Goals Season Age champLeagueGoal         Club
## 1            9     1   2004  17               0 FC Barcelona
## 2           25     8   2005  18               1 FC Barcelona
## 3           36    17   2006  19               1 FC Barcelona
## 4           40    16   2007  20               6 FC Barcelona
## 5           51    38   2008  21               9 FC Barcelona
## 6           53    47   2009  22               8 FC Barcelona
## 7           55    53   2010  23              12 FC Barcelona
## 8           60    73   2011  24              14 FC Barcelona
## 9           50    60   2012  25               8 FC Barcelona
## 10          46    41   2013  26               8 FC Barcelona
## 11          57    58   2014  27              10 FC Barcelona
## 12          49    41   2015  28               6 FC Barcelona
## 13          52    54   2016  29              11 FC Barcelona
## 14          54    45   2017  30               6 FC Barcelona
## 15          50    51   2018  31              12 FC Barcelona
## 16          44    31   2019  32               3 FC Barcelona
```

```r
# move club to col before champLeagueGoal
messi_career %>%
  relocate(Club, Goals, .before = champLeagueGoal)
```

```
##    Appearances Season Age         Club Goals champLeagueGoal
## 1            9   2004  17 FC Barcelona     1               0
## 2           25   2005  18 FC Barcelona     8               1
## 3           36   2006  19 FC Barcelona    17               1
## 4           40   2007  20 FC Barcelona    16               6
## 5           51   2008  21 FC Barcelona    38               9
## 6           53   2009  22 FC Barcelona    47               8
## 7           55   2010  23 FC Barcelona    53              12
## 8           60   2011  24 FC Barcelona    73              14
## 9           50   2012  25 FC Barcelona    60               8
## 10          46   2013  26 FC Barcelona    41               8
## 11          57   2014  27 FC Barcelona    58              10
## 12          49   2015  28 FC Barcelona    41               6
## 13          52   2016  29 FC Barcelona    54              11
## 14          54   2017  30 FC Barcelona    45               6
## 15          50   2018  31 FC Barcelona    51              12
## 16          44   2019  32 FC Barcelona    31               3
```

## Column ordering exercise

Using the examples above:

1)  Move the `year` column to be the first column in the `imdb_sub` data frame
2)  Move the `avg_vote` column to be after the `year` column


```r
# your code here
```

# Filter function

The filter function allows you to subset rows based on conditions, using conditional operators (==, \<=, != etc.). It is similar to the base r `subset()` function which we have used in previous R workshops. The table below is a reminder of the conditional operators you can use.

| Operator   | Meaning                  |
|------------|--------------------------|
| `>`        | Greater than             |
| `>=`       | Greater than or equal to |
| `<`        | Less than                |
| `<=`       | Less than or equal to    |
| `==`       | Equal to                 |
| `!=`       | Not equal to             |
| `!X`       | NOT X                    |
| `X`        | Y                        |
| `X & Y`    | X AND Y                  |
| `X %in% Y` | is X in Y                |

Just like when using `select`, you provide the column name you want to apply conditional logic to. If you are piping, you don't need to provide your data as an argument in the function.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/r-data-wrangling-1/images/dplyr_filter.jpeg?raw=true){width="516"}

Run the examples below and review the outputs.


```r
# filter based on one criteria
messi_career %>% filter(Goals > 50)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1          55    53   2010 FC Barcelona  23              12
## 2          60    73   2011 FC Barcelona  24              14
## 3          50    60   2012 FC Barcelona  25               8
## 4          57    58   2014 FC Barcelona  27              10
## 5          52    54   2016 FC Barcelona  29              11
## 6          50    51   2018 FC Barcelona  31              12
```

```r
# filter then pipe to select
messi_career %>% filter(Appearances >= 55) %>%
  select(Season, Age)
```

```
##   Season Age
## 1   2010  23
## 2   2011  24
## 3   2014  27
```

```r
# filter on more than one condition
messi_career %>% filter(Goals > 50 & champLeagueGoal <= 10)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1          50    60   2012 FC Barcelona  25               8
## 2          57    58   2014 FC Barcelona  27              10
```

```r
# filter on average
messi_career %>% filter(Goals > mean(Goals, na.rm = TRUE))
```

```
##    Appearances Goals Season         Club Age champLeagueGoal
## 1           53    47   2009 FC Barcelona  22               8
## 2           55    53   2010 FC Barcelona  23              12
## 3           60    73   2011 FC Barcelona  24              14
## 4           50    60   2012 FC Barcelona  25               8
## 5           46    41   2013 FC Barcelona  26               8
## 6           57    58   2014 FC Barcelona  27              10
## 7           49    41   2015 FC Barcelona  28               6
## 8           52    54   2016 FC Barcelona  29              11
## 9           54    45   2017 FC Barcelona  30               6
## 10          50    51   2018 FC Barcelona  31              12
```

To assign the result to a new data frame (subset) we use the assignment operator at the beginning or the end of our code; here we have just shown the beginning, in the pipes section we show both versions.


```r
# assign result to messi_sub
messi_sub <- messi_career %>%
  filter(Appearances <= 40) %>%
  select(Goals, Age)

# view result
messi_sub
```

```
##   Goals Age
## 1     1  17
## 2     8  18
## 3    17  19
## 4    16  20
```

## Filter exercise

We are going to filter our subsetted (`imdb_sub`) data to find the best rated films from the USA in the year 1989, and create a subset called USA_1989_high.

1)  Pipe from imdb_sub to filter, filtering for country being equal to USA
2)  Pipe from your country filter to another filter, filtering for year being equal to 1989
3)  Pipe from your year filter to another filter. Filter for avg_vote to be greater than or equal to 7.5 and reviews_from_critics to be greater than 10
4)  Make sure to assign your result to USA_1989_high
5)  Print the result to see the highest rated films, made in the USA, in 1989.
6)  Do you think you can put this into one filter command using the & operator?


```r
# your code here
```

You might have noticed that the country column has some strings that are split by a comma, e.g. "Germany, Denmark". The == operator will not be able to pick these up. Instead we would use the base R `grepl()` function or `str_detect()` from the `stringr` package. This won't be covered in this workshop, but will be in future workshops. If you are interested, have a look at the stringr package - <https://stringr.tidyverse.org/index.html>.

# Other filtering options with dplyr

Other than conditional subsetting of data using `filter()`, dplyr has other functions we can use to subset our data: `slice`, `sample`, and `distinct.`

The sample functions randomly extract a set number of rows from your data. This is helpful if you want to take a random sample of your dataset. The examples below show the `sample_n()` and `sample_frac()` functions. 


```r
# sample 5 rows
messi_career %>%
  sample_n(5)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1          52    54   2016 FC Barcelona  29              11
## 2          50    51   2018 FC Barcelona  31              12
## 3          36    17   2006 FC Barcelona  19               1
## 4          60    73   2011 FC Barcelona  24              14
## 5          57    58   2014 FC Barcelona  27              10
```

```r
# sample 25% of your data
messi_career %>%
  sample_frac(0.25)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1          40    16   2007 FC Barcelona  20               6
## 2          60    73   2011 FC Barcelona  24              14
## 3          36    17   2006 FC Barcelona  19               1
## 4          57    58   2014 FC Barcelona  27              10
```

The slice functions are more useful. The basic `slice` function is the equivalent of using numbered indexing in base r `data[1:5, ]`, but is designed to work better in the tidyverse enviroment. 

```r
# select rows 4, 5, and 6
messi_career %>%
  slice(4:6)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1          40    16   2007 FC Barcelona  20               6
## 2          51    38   2008 FC Barcelona  21               9
## 3          53    47   2009 FC Barcelona  22               8
```

```r
# equivalent in base r
messi_career[4:6, ]
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 4          40    16   2007 FC Barcelona  20               6
## 5          51    38   2008 FC Barcelona  21               9
## 6          53    47   2009 FC Barcelona  22               8
```

The `slice_max` and `slice_min` functions are much more powerful, and are harder and messier to achieve with normal base r code. They allow you to index the rows that have the max (or min) in a specified column. In the example, we extract the rows that have the top three and bottom three values in the Goals column. 

```r
# extract rows with top three Goals
messi_career %>%
  slice_max(Goals, n = 3)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1          60    73   2011 FC Barcelona  24              14
## 2          50    60   2012 FC Barcelona  25               8
## 3          57    58   2014 FC Barcelona  27              10
```

```r
# this harder and less clear in base r
messi_career[messi_career$Goals %in% tail(sort(messi_career$Goals), 3), ]
```

```
##    Appearances Goals Season         Club Age champLeagueGoal
## 8           60    73   2011 FC Barcelona  24              14
## 9           50    60   2012 FC Barcelona  25               8
## 11          57    58   2014 FC Barcelona  27              10
```

```r
# extract rows with bottom three Goals
messi_career %>%
  slice_min(Goals, n = 3)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal
## 1           9     1   2004 FC Barcelona  17               0
## 2          25     8   2005 FC Barcelona  18               1
## 3          40    16   2007 FC Barcelona  20               6
```

## Filtering continued exercise

In this exercise you will need to debug my code to get it working. We will filter the imdb_sub data for films over 120 minutes, and in the USA, then extract the top 20 rated films.  

If you get it working your `top_votes_USA` data frame should have 20 rows and 4 columns (title, year, genre and avg_vote) with films such as *The Shawshank Redemption* and *the Godfather*. As a bonus, if you get your code working, the plot at the end of the code will run! 


```r
# your code here
top_votes_USA <- imdb_sub %>%
  filter(duration >= 120 & country = "USA") |>
  slicemax(avgvote, n = 20) %>%
  select(title year, genre, avg_vote)

top_votes_USA

# fun extra, plot the output of your debugging! 
plot(top_votes_USA$year, top_votes_USA$avg_vote,
     col = "orange", # point colour
     pch = 16, # point type
     cex = 1.5, # point size
     xlab = "Year",
     ylab = "Average vote") 
```


# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_eflc2yj4pcryc62?coursename=R Data Wrangling 1: Pipes and introduction to dplyr  &topic=R&link=&prog=DS&version=21-22

The solutions we be available from a link at the end of the survey.

# Individual coding challenge

For this coding challenge we are going to extract all Tolkien (lord of the rings and hobbit) and Harry Potter films from our imdb dataset. We have provided vectors with the titles of these films.

1)  Using the Tolkien and Potter vectors, use the `%in%` operator to filter titles in the imdb dataset that match the Tolkien or Potter vectors.
2)  Select out the title, year, avg_vote, and duration columns
3)  Save your subsetted data to a data frame called Tolkien_Potter
4)  What films in the Tolkien_Potter dataset have a higher than average vote?
5)  What films in the Tolkien_Potter dataset have a less than average duration in hours?

*hint: for 4 and 5 you can use filter to compare the column to the mean of that column, e.g. filter(data, column \> mean(column))*


```r
Tolkien <- c("The Lord of the Rings: The Fellowship of the Ring", "The Lord of the Rings: The Return of the King",
           "The Lord of the Rings: The Two Towers", "The Hobbit: An Unexpected Journey",
           "The Hobbit: The Desolation of Smaug", "The Hobbit: The Battle of the Five Armies")

Potter <- c("Harry Potter and the Sorcerer's Stone", "Harry Potter and the Chamber of Secrets",
            "Harry Potter and the Prisoner of Azkaban", "Harry Potter and the Goblet of Fire",
            "Harry Potter and the Order of the Phoenix", "Harry Potter and the Half-Blood Prince",
            "Harry Potter and the Deathly Hallows: Part 1", "Harry Potter and the Deathly Hallows: Part 2")

# your code here
```
