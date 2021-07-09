---
title: "R Workshop 6 - Tidyverse introduction with Pipes and dplyr"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "09 July, 2021"
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

-  Introduce the use of pipes 
-  Indexing with the select function from dplyr
-  Conditional indexing of data with the filter function from dplyr
-  Data manipulation with mutate from dplyr

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

![image credit: Analytics Vidhya](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop6/images/tidyverse.jpeg?raw=true)

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

![Image credit: Julie Lowndes and Allison Horst](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop6/images/tidydata_2.jpeg?raw=true)

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

The pipe operator in R comes from the `magrittr` package, using syntax of %\>%.

The pipe operator is for chaining a sequence of operations together. This has two main advantages: it makes your code more readable, and it saves some typing.

Run the example below to see the difference between using pipes and not using pipes. We are going to calculate a mean of a vector of numbers, then round the result. First we look at what we do when we don't use pipes, which you might be familiar with.


```r
# load in magrittr
library(magrittr)

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
## [1] "Mean value of y is 5.7"
```

Now lets have a look at how to do this same set of operations with a pipe. There are two ways, but both work the same. You can either assign the result at the beginning of your pipe operation, or at the end, as shown in the examples.

You will notice in the paste function we have used a `.` after the text. This is called a *placeholder*, whereby instead of using the data (like we did above without the pipe) we add a `.` to tell R that is where we want our data to go.


```r
# magrittr pipe
x_mean <- x %>% # assign result at the start
  mean() %>% 
  round(digits = 2) %>%
  paste("Mean value of x is", .) # we use the . as a place holder for a variable (e.g. instead of x)

x_mean
```

```
## [1] "Mean value of x is 5.25"
```

```r
# a pipe can also be written like this 
x %>%
  mean() %>%
  round(digits = 2) %>%
  paste("Mean value of x is", .) -> x_mean # assign result at the end

x_mean
```

```
## [1] "Mean value of x is 5.25"
```

It is also worth mentioning that as of version 4.1 of R, base R comes with a native pipe operator. This has just been introduced, and may get more use in examples you'll see online in the future. The syntax uses \|\> as the pipe, and the structure is the same as a magrittr pipe.

*note that the native pipe currently doesn't have a placeholder, so we won't use paste in this example*


```r
# native R pipe
z <- sample(1:10, 20, replace = TRUE)

z_mean <- z |> # assign result at the start
  mean() |>
  round(digits = 2)

z_mean
```

```
## [1] 6.5
```

```r
z |>
  mean() |>
  round(digits = 2) -> z_mean # assign result at the end

z_mean
```

```
## [1] 6.5
```

We will be using the magrittr pipe for the rest of this workshop, as it's currently the pipe operator you will come across most in the r world.

## Exercise - using pipes

Using the vector of temperature provided and using magrittr pipes:

1)  Pipe median and paste functions together to print the message: "median temp is 15"\
2)  Pipe max and paste functions together to print the message: "max temp is 20"

*hint: don't forget to use the placeholder with paste*


```r
library(magrittr)

temperature <- c(10, 16, 12, 15, 14, 15, 20)

# your code here
temperature %>%
  median() %>%
  paste("median temp is", .)
```

```
## [1] "median temp is 15"
```

```r
temperature %>%
  max() %>%
  paste("max temp is", .)
```

```
## [1] "max temp is 20"
```

# Introduction to dplyr

Dplyr is a package that is built for data manipulation, using functions that describe what they do. For example, the `select()` function selects columns you want, or don't want, from a data frame.

The dplyr package has a lot of functions built into the package, each has it's own very helpful documentation page with examples - <https://dplyr.tidyverse.org/reference/index.html>

Dplyr functions work with and without pipes and you'll see both when searching online. If using a pipe, you call your data then pipe that to a function, such as `data %>% mean()`. If you are not using a pipe, you call your data within the function, such as `mean(data)`. 

We will focus on the key dplyr functions for now: `select()`, `filter()`, and `mutate()`. We will use the messi_career data for the examples. Run the code chunk below to get the data into r and have a look at it. 


```r
# create the messi career data
messi_career <- data.frame(Appearances = c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44),
                           Goals = c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31),
                           Season = c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019),
                           Club = rep("FC Barcelona", length(16)),
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

First, we can just give the column names of the columns we want to select. 

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

Another method is using a range of columns, known as a slice. Here we are selecting columns from Season to Age, which includes the Club column as well. We can combine this with the ! (not) operator to not include those columns. 

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
# negate selection of column
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

Finally, we can use the `contains()` function in dplyr to select columns that contain the string "Goal". This is a useful option if you just want to pick out columns that have some similar text in them. 


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

As you can see, `select()` makes it easy to extract columns from your data, and becomes more useful the larger your dataset becomes.

In the examples above we did not assign the result. See the examples below on how to do this.

```r
# assign result to subset
messi_sub <- messi_career %>%
  select(contains("Goal"))

messi_sub
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

```r
# The no pipe method
messi_sub <- select(messi_career, contains("Goal"))
```

## Select exercise

For your exercises, you will be using imdb movie data! I've loaded it here in the code for you.

The data has 22 columns, some of which we won't need. We can use `select` to subset our data to keep only what we want.

1) Run the code currenty in the code chunk to load the libraries and the data, and review the output from `glimpse()`
2) Using select with pipes, subset the `imdb_movie` data so you have the following columns: imdb_id through to writer, actors, avg_vote to votes, reviews_from_users to reviews_from_critics. Assign the result to `imdb_sub`
3) Use glimpse to review the subsetted data: *data %\>% glimpse()*
4) There is a more efficient way of doing this using select. From looking at the examples provided, can you think of a better way of taking out the columns we removed?

*hint: you should be able to fit this into one select call*


```r
# load libraries
library(readr)
library(dplyr)

# load data
movies_imdb <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop6/data/IMDb%20movies.csv")

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
imdb_sub <- movies_imdb %>%
  select(imdb_title_id:writer, actors, avg_vote:votes, reviews_from_users:reviews_from_critics)

imdb_sub %>% glimpse()
```

```
## Rows: 85,855
## Columns: 15
## $ imdb_title_id        <chr> "tt0000009", "tt0000574", "tt0001892", "tt0002101…
## $ title                <chr> "Miss Jerry", "The Story of the Kelly Gang", "Den…
## $ year                 <dbl> 1894, 1906, 1911, 1912, 1911, 1912, 1919, 1913, 1…
## $ date_published       <chr> "1894-10-09", "26/12/1906", "19/08/1911", "13/11/…
## $ genre                <chr> "Romance", "Biography, Crime, Drama", "Drama", "D…
## $ duration             <dbl> 45, 70, 53, 100, 68, 60, 85, 120, 120, 55, 121, 5…
## $ country              <chr> "USA", "Australia", "Germany, Denmark", "USA", "I…
## $ language             <chr> "None", "None", NA, "English", "Italian", "Englis…
## $ director             <chr> "Alexander Black", "Charles Tait", "Urban Gad", "…
## $ writer               <chr> "Alexander Black", "Charles Tait", "Urban Gad, Ge…
## $ actors               <chr> "Blanche Bayliss, William Courtenay, Chauncey Dep…
## $ avg_vote             <dbl> 5.9, 6.1, 5.8, 5.2, 7.0, 5.7, 6.8, 6.2, 6.7, 5.5,…
## $ votes                <dbl> 154, 589, 188, 446, 2237, 484, 753, 273, 198, 225…
## $ reviews_from_users   <dbl> 1, 7, 5, 25, 31, 13, 12, 7, 4, 8, 9, 9, 16, 8, NA…
## $ reviews_from_critics <dbl> 2, 7, 2, 3, 14, 5, 9, 5, 1, 1, 9, 28, 7, 23, 4, 2…
```

# Filter function

The filter function allows you to subset rows based on conditions, using conditional operators (==, \<=, != etc.). It is similar to the base r `subset()` function which we have used in previous R workshops. The table below is a reminder of the conditional operators you can use.

| Operator | Meaning                  |
|----------|--------------------------|
| \>       | Greater than             |
| \>=      | Greater than or equal to |
| \<       | Less than                |
| \<=      | Less than or equal to    |
| ==       | Equal to                 |
| !=       | Not equal to             |
| !X       | NOT X                    |
| X        | Y                        |
| X & Y    | X AND Y                  |
| X %in% Y | is X in Y                |

Just like when using `select`, you provide the column name you want to apply conditional logic to. If you are piping, you don't need to provide your data as an argument in the function.

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

1) Pipe from imdb_sub to filter, filtering for country being equal to USA
2) Pipe from your country filter to another filter, filtering for year being equal to 1989
3) Pipe from your year filter to another filter. Filter for avg_vote to be greater than or equal to 7.5 and reviews_from_critics to be greater than 10
4) Make sure to assign your result to USA_1989_high
5) Print the result to see the highest rated films, made in the USA, in 1989.
6) Do you think you can put this into one filter command using the & operator?  


```r
# your code here
# several filters
USA_1989_high <- imdb_sub %>%
  filter(country == "USA") %>%
  filter(year == 1989) %>%
  filter(avg_vote >= 7.5 & reviews_from_critics > 10)

# single filter
USA_1989_high <- imdb_sub %>%
  filter(country == "USA" &
           year == 1989 &
           avg_vote >= 7.5 &
           reviews_from_critics > 10)

# print result
USA_1989_high
```

```
## # A tibble: 12 x 15
##    imdb_title_id title     year date_published genre  duration country language 
##    <chr>         <chr>    <dbl> <chr>          <chr>     <dbl> <chr>   <chr>    
##  1 tt0096754     The Aby…  1989 22/12/1989     Adven…      171 USA     English  
##  2 tt0096874     Back to…  1989 22/12/1989     Adven…      108 USA     English  
##  3 tt0097123     Crimes …  1989 20/02/1990     Comed…      104 USA     English,…
##  4 tt0097165     Dead Po…  1989 29/09/1989     Comed…      128 USA     English,…
##  5 tt0097216     Do the …  1989 17/11/1989     Comed…      120 USA     English,…
##  6 tt0097351     Field o…  1989 05/05/1989     Drama…      107 USA     English  
##  7 tt0097441     Glory     1989 16/02/1990     Biogr…      122 USA     English  
##  8 tt0097576     Indiana…  1989 06/10/1989     Actio…      127 USA     English,…
##  9 tt0097757     The Lit…  1989 06/12/1990     Anima…       83 USA     English,…
## 10 tt0097958     Nationa…  1989 01/12/1989     Comedy       97 USA     English  
## 11 tt0098635     When Ha…  1989 05/01/1990     Comed…       95 USA     English  
## 12 tt0100049     Longtim…  1989 01/05/1990     Drama…       96 USA     English  
## # … with 7 more variables: director <chr>, writer <chr>, actors <chr>,
## #   avg_vote <dbl>, votes <dbl>, reviews_from_users <dbl>,
## #   reviews_from_critics <dbl>
```

You might have noticed that the country column has some strings that are split by a comma, e.g. "Germany, Denmark". The == operator will not be able to pick these up. Instead we would use the base R `grepl()` function or `str_detect()` from the `stringr` package. This won't be covered in this workshop, but will be in future workshops. If you are interested, have a look at the stringr package - <https://stringr.tidyverse.org/index.html>.

# Mutate function

The mutate function is for making, modifying, or deleting columns in your dataset. Similar to what we have done in previous sessions, mutate allows you to make a new column from a calculation you have made.

The main difference between using matate and making new columns in base R, is that mutate is smarter. You can create a new column based on a new column you have just made in mutate, which you can't do in base R. Lets look at some examples with our messi data.

In our previous workshops, we calculated Messi's goals per game (goals/appearances). We can do this with mutate. Notice the syntax, we give the name we want to call our new column first, then =, then what we want to do (e.g. a calculation);  `mutate(new_column = x/y)`.


```r
messi_career %>%
  mutate(goal_ratio = Goals/Appearances)
```

```
##    Appearances Goals Season         Club Age champLeagueGoal goal_ratio
## 1            9     1   2004 FC Barcelona  17               0  0.1111111
## 2           25     8   2005 FC Barcelona  18               1  0.3200000
## 3           36    17   2006 FC Barcelona  19               1  0.4722222
## 4           40    16   2007 FC Barcelona  20               6  0.4000000
## 5           51    38   2008 FC Barcelona  21               9  0.7450980
## 6           53    47   2009 FC Barcelona  22               8  0.8867925
## 7           55    53   2010 FC Barcelona  23              12  0.9636364
## 8           60    73   2011 FC Barcelona  24              14  1.2166667
## 9           50    60   2012 FC Barcelona  25               8  1.2000000
## 10          46    41   2013 FC Barcelona  26               8  0.8913043
## 11          57    58   2014 FC Barcelona  27              10  1.0175439
## 12          49    41   2015 FC Barcelona  28               6  0.8367347
## 13          52    54   2016 FC Barcelona  29              11  1.0384615
## 14          54    45   2017 FC Barcelona  30               6  0.8333333
## 15          50    51   2018 FC Barcelona  31              12  1.0200000
## 16          44    31   2019 FC Barcelona  32               3  0.7045455
```

The new column, goal_ratio in this case, will automatically be added to the end of your data.frame. This is the same behaviour you will see when using base R. This behaviour can be altered if you want, but we won't have time to cover it here. 

What makes `mutate()` powerful, is the ability to do multiple calculations in one statement, as well as using newly made columns. See the below example which will help to understand this. We will use goal_ratio to find out the difference between goal_ratio and the average goal ratio for each row (or season).


```r
# calculate goal ratio and diff from mean
messi_career <- messi_career %>%
  mutate(
    goal_ratio = round(Goals/Appearances, digits = 2),
    diff_avg_goal_ratio = goal_ratio - (mean(Goals) / mean(Appearances)))

# print result
messi_career
```

```
##    Appearances Goals Season         Club Age champLeagueGoal goal_ratio
## 1            9     1   2004 FC Barcelona  17               0       0.11
## 2           25     8   2005 FC Barcelona  18               1       0.32
## 3           36    17   2006 FC Barcelona  19               1       0.47
## 4           40    16   2007 FC Barcelona  20               6       0.40
## 5           51    38   2008 FC Barcelona  21               9       0.75
## 6           53    47   2009 FC Barcelona  22               8       0.89
## 7           55    53   2010 FC Barcelona  23              12       0.96
## 8           60    73   2011 FC Barcelona  24              14       1.22
## 9           50    60   2012 FC Barcelona  25               8       1.20
## 10          46    41   2013 FC Barcelona  26               8       0.89
## 11          57    58   2014 FC Barcelona  27              10       1.02
## 12          49    41   2015 FC Barcelona  28               6       0.84
## 13          52    54   2016 FC Barcelona  29              11       1.04
## 14          54    45   2017 FC Barcelona  30               6       0.83
## 15          50    51   2018 FC Barcelona  31              12       1.02
## 16          44    31   2019 FC Barcelona  32               3       0.70
##    diff_avg_goal_ratio
## 1          -0.75730506
## 2          -0.54730506
## 3          -0.39730506
## 4          -0.46730506
## 5          -0.11730506
## 6           0.02269494
## 7           0.09269494
## 8           0.35269494
## 9           0.33269494
## 10          0.02269494
## 11          0.15269494
## 12         -0.02730506
## 13          0.17269494
## 14         -0.03730506
## 15          0.15269494
## 16         -0.16730506
```

We can then pipe this result to `filter()`, which allows us to see which seasons Messi has a goal ratio above his average goal ratio.


```r
messi_career %>%
  mutate(
    goal_ratio = round(Goals/Appearances, digits = 2),
    diff_avg_goal_ratio = goal_ratio - (mean(Goals) / mean(Appearances))) %>%
  filter(diff_avg_goal_ratio > 0)
```

```
##   Appearances Goals Season         Club Age champLeagueGoal goal_ratio
## 1          53    47   2009 FC Barcelona  22               8       0.89
## 2          55    53   2010 FC Barcelona  23              12       0.96
## 3          60    73   2011 FC Barcelona  24              14       1.22
## 4          50    60   2012 FC Barcelona  25               8       1.20
## 5          46    41   2013 FC Barcelona  26               8       0.89
## 6          57    58   2014 FC Barcelona  27              10       1.02
## 7          52    54   2016 FC Barcelona  29              11       1.04
## 8          50    51   2018 FC Barcelona  31              12       1.02
##   diff_avg_goal_ratio
## 1          0.02269494
## 2          0.09269494
## 3          0.35269494
## 4          0.33269494
## 5          0.02269494
## 6          0.15269494
## 7          0.17269494
## 8          0.15269494
```

## Mutate exercise 1

Lets pretend we are interested in the difference between the number of user reviews and critic reviews for each film in our USA_1989_high dataset we just made in the last exercise. We can use mutate to explore this difference a bit further.

1)  Pipe your USA_1989_high data to a `mutate()` function. Make a new column called `user_critic_ratio`, and divide `reviews_from_users` by `reviews_from_critics`. Wrap the result in a `round()` function, rounding by two digits
2)  Now pipe to a `select()` function, selecting the title, avg_vote and user_critic_ratio columns
3)  Now pipe to a `filter()` function, filtering for user_critic_ratio to be greater than 4.

You should get a data frame returned that has the films: The Abyss, Dead Poets Society, Do the Right Thing, and Glory.


```r
# your code here

# user critic review ratio
USA_1989_high %>%
  mutate(user_critic_ratio = round(reviews_from_users / reviews_from_critics, digits = 2)) %>%
  select(title, avg_vote, user_critic_ratio) %>%
  filter(user_critic_ratio > 4)
```

```
## # A tibble: 4 x 3
##   title              avg_vote user_critic_ratio
##   <chr>                 <dbl>             <dbl>
## 1 The Abyss               7.6              4.08
## 2 Dead Poets Society      8.1              5.98
## 3 Do the Right Thing      7.9              4.72
## 4 Glory                   7.8              6.18
```

We can see we get more user reviews than critic reviews, which makes sense; for example, the The Abyss has 4 user reviews for each critic review.

## Mutate exercise 2

In our second mutate exercise, you will need to de-bug the code to get it running! You may need to re-order some elements of the code as well as checking for other errors. 

We are filtering the imdb_sub data for films that are from the USA before the year 1990, have a duration less than 120 minutes, and an average vote greater than 8.5. We will also be using the user_critic_ratio column to make it into a string for easier reading. 

You should end up with a data frame with 6 rows, and 4 columns (title, year, avg_vote, and ratio_string). The final column, ratio_string, should have an output like "Psycho has a user to critic ratio of 5.44". 


```r
imdb_sub |>
  mutate(user_critic_ratio = round(reviews_from_users / reviews_from_critics, digits = 2),
         ratio_string = paste(title, "has a user to critic ratio of", userCriticRatio)) %>%
  filter(country == "USA" & year < 1990) 
  select(title, year, avg_vote, ratio_string) %>%
  filter(duration < 120 & avg_vote >= 8.5)
```


```r
# answer for solutions
# Re using the user_critic_ratio variable

imdb_sub %>%
  mutate(user_critic_ratio = round(reviews_from_users / reviews_from_critics, digits = 2),
         ratio_string = paste(title, "has a user to critic ratio of", user_critic_ratio)) %>%
  filter(country == "USA" & year < 1990) %>%
  filter(duration < 120 & avg_vote >= 8.5) %>%
  select(title, year, avg_vote, ratio_string)
```

```
## # A tibble: 6 x 4
##   title             year avg_vote ratio_string                                  
##   <chr>            <dbl>    <dbl> <chr>                                         
## 1 City Lights       1931      8.5 City Lights has a user to critic ratio of 2.42
## 2 Modern Times      1936      8.5 Modern Times has a user to critic ratio of 2.…
## 3 Casablanca        1942      8.5 Casablanca has a user to critic ratio of 6.65 
## 4 12 Angry Men      1957      8.9 12 Angry Men has a user to critic ratio of 10…
## 5 Psycho            1960      8.5 Psycho has a user to critic ratio of 5.44     
## 6 Back to the Fut…  1985      8.5 Back to the Future has a user to critic ratio…
```

# Mutate with the across function

We can take the mutate function further by using the `across()` function. This allows us to perform operations (do something) across multiple columns. This is very useful for doing type conversions in an efficient way.

The across function works in a similar way to the `select()` function, but if you want to pick out a few columns you have to use the `c()` function. See the examples below, where we have selected two columns, or used a slice to select out a few columns that are next to each other.


```r
# perform round (to 1 decimal place) across selected columns
messi_career %>%
  mutate(across(c(goal_ratio, diff_avg_goal_ratio), round, digits = 1))
```

```
##    Appearances Goals Season         Club Age champLeagueGoal goal_ratio
## 1            9     1   2004 FC Barcelona  17               0        0.1
## 2           25     8   2005 FC Barcelona  18               1        0.3
## 3           36    17   2006 FC Barcelona  19               1        0.5
## 4           40    16   2007 FC Barcelona  20               6        0.4
## 5           51    38   2008 FC Barcelona  21               9        0.8
## 6           53    47   2009 FC Barcelona  22               8        0.9
## 7           55    53   2010 FC Barcelona  23              12        1.0
## 8           60    73   2011 FC Barcelona  24              14        1.2
## 9           50    60   2012 FC Barcelona  25               8        1.2
## 10          46    41   2013 FC Barcelona  26               8        0.9
## 11          57    58   2014 FC Barcelona  27              10        1.0
## 12          49    41   2015 FC Barcelona  28               6        0.8
## 13          52    54   2016 FC Barcelona  29              11        1.0
## 14          54    45   2017 FC Barcelona  30               6        0.8
## 15          50    51   2018 FC Barcelona  31              12        1.0
## 16          44    31   2019 FC Barcelona  32               3        0.7
##    diff_avg_goal_ratio
## 1                 -0.8
## 2                 -0.5
## 3                 -0.4
## 4                 -0.5
## 5                 -0.1
## 6                  0.0
## 7                  0.1
## 8                  0.4
## 9                  0.3
## 10                 0.0
## 11                 0.2
## 12                 0.0
## 13                 0.2
## 14                 0.0
## 15                 0.2
## 16                -0.2
```

```r
# square root across columns selected with slice
messi_career %>%
  mutate(across(1:3, sqrt))
```

```
##    Appearances    Goals   Season         Club Age champLeagueGoal goal_ratio
## 1     3.000000 1.000000 44.76606 FC Barcelona  17               0       0.11
## 2     5.000000 2.828427 44.77723 FC Barcelona  18               1       0.32
## 3     6.000000 4.123106 44.78839 FC Barcelona  19               1       0.47
## 4     6.324555 4.000000 44.79955 FC Barcelona  20               6       0.40
## 5     7.141428 6.164414 44.81071 FC Barcelona  21               9       0.75
## 6     7.280110 6.855655 44.82187 FC Barcelona  22               8       0.89
## 7     7.416198 7.280110 44.83302 FC Barcelona  23              12       0.96
## 8     7.745967 8.544004 44.84417 FC Barcelona  24              14       1.22
## 9     7.071068 7.745967 44.85532 FC Barcelona  25               8       1.20
## 10    6.782330 6.403124 44.86647 FC Barcelona  26               8       0.89
## 11    7.549834 7.615773 44.87761 FC Barcelona  27              10       1.02
## 12    7.000000 6.403124 44.88875 FC Barcelona  28               6       0.84
## 13    7.211103 7.348469 44.89989 FC Barcelona  29              11       1.04
## 14    7.348469 6.708204 44.91102 FC Barcelona  30               6       0.83
## 15    7.071068 7.141428 44.92215 FC Barcelona  31              12       1.02
## 16    6.633250 5.567764 44.93328 FC Barcelona  32               3       0.70
##    diff_avg_goal_ratio
## 1          -0.75730506
## 2          -0.54730506
## 3          -0.39730506
## 4          -0.46730506
## 5          -0.11730506
## 6           0.02269494
## 7           0.09269494
## 8           0.35269494
## 9           0.33269494
## 10          0.02269494
## 11          0.15269494
## 12         -0.02730506
## 13          0.17269494
## 14         -0.03730506
## 15          0.15269494
## 16         -0.16730506
```

```r
# square root across columns selected with slice (using col names)
messi_career %>%
  mutate(across(Appearances:Season, sqrt))
```

```
##    Appearances    Goals   Season         Club Age champLeagueGoal goal_ratio
## 1     3.000000 1.000000 44.76606 FC Barcelona  17               0       0.11
## 2     5.000000 2.828427 44.77723 FC Barcelona  18               1       0.32
## 3     6.000000 4.123106 44.78839 FC Barcelona  19               1       0.47
## 4     6.324555 4.000000 44.79955 FC Barcelona  20               6       0.40
## 5     7.141428 6.164414 44.81071 FC Barcelona  21               9       0.75
## 6     7.280110 6.855655 44.82187 FC Barcelona  22               8       0.89
## 7     7.416198 7.280110 44.83302 FC Barcelona  23              12       0.96
## 8     7.745967 8.544004 44.84417 FC Barcelona  24              14       1.22
## 9     7.071068 7.745967 44.85532 FC Barcelona  25               8       1.20
## 10    6.782330 6.403124 44.86647 FC Barcelona  26               8       0.89
## 11    7.549834 7.615773 44.87761 FC Barcelona  27              10       1.02
## 12    7.000000 6.403124 44.88875 FC Barcelona  28               6       0.84
## 13    7.211103 7.348469 44.89989 FC Barcelona  29              11       1.04
## 14    7.348469 6.708204 44.91102 FC Barcelona  30               6       0.83
## 15    7.071068 7.141428 44.92215 FC Barcelona  31              12       1.02
## 16    6.633250 5.567764 44.93328 FC Barcelona  32               3       0.70
##    diff_avg_goal_ratio
## 1          -0.75730506
## 2          -0.54730506
## 3          -0.39730506
## 4          -0.46730506
## 5          -0.11730506
## 6           0.02269494
## 7           0.09269494
## 8           0.35269494
## 9           0.33269494
## 10          0.02269494
## 11          0.15269494
## 12         -0.02730506
## 13          0.17269494
## 14         -0.03730506
## 15          0.15269494
## 16         -0.16730506
```

We can also combine the across function with the `where()` or `all_of()` function to perform conditional mutations.

The `where()` function does conditional matching between the statement you've used and what is in your dataset. In the example we are asking `where()` to look for columns that are the character (string) data type. Then we can perform an operation, such as convert those columns to factors. In this case it is just the Club column that changes. 


```r
# perform conditional operation with where
messi_career %>%
  mutate(across(where(is.character), as.factor)) %>%
  glimpse()
```

```
## Rows: 16
## Columns: 8
## $ Appearances         <dbl> 9, 25, 36, 40, 51, 53, 55, 60, 50, 46, 57, 49, 52,…
## $ Goals               <dbl> 1, 8, 17, 16, 38, 47, 53, 73, 60, 41, 58, 41, 54, …
## $ Season              <dbl> 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 20…
## $ Club                <fct> FC Barcelona, FC Barcelona, FC Barcelona, FC Barce…
## $ Age                 <int> 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29…
## $ champLeagueGoal     <dbl> 0, 1, 1, 6, 9, 8, 12, 14, 8, 8, 10, 6, 11, 6, 12, 3
## $ goal_ratio          <dbl> 0.11, 0.32, 0.47, 0.40, 0.75, 0.89, 0.96, 1.22, 1.…
## $ diff_avg_goal_ratio <dbl> -0.75730506, -0.54730506, -0.39730506, -0.46730506…
```

The `all_of()` function looks for matches between the strings you have provided and the column names in your dataset. In our example, we put the Season and Club columns into a vector, then call that vector and convert those columns to a factor.


```r
# change selected variables with all_of
to_factor <- c("Season", "Club")

messi_career %>%
  mutate(across(all_of(to_factor), as.factor)) %>%
  glimpse()
```

```
## Rows: 16
## Columns: 8
## $ Appearances         <dbl> 9, 25, 36, 40, 51, 53, 55, 60, 50, 46, 57, 49, 52,…
## $ Goals               <dbl> 1, 8, 17, 16, 38, 47, 53, 73, 60, 41, 58, 41, 54, …
## $ Season              <fct> 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 20…
## $ Club                <fct> FC Barcelona, FC Barcelona, FC Barcelona, FC Barce…
## $ Age                 <int> 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29…
## $ champLeagueGoal     <dbl> 0, 1, 1, 6, 9, 8, 12, 14, 8, 8, 10, 6, 11, 6, 12, 3
## $ goal_ratio          <dbl> 0.11, 0.32, 0.47, 0.40, 0.75, 0.89, 0.96, 1.22, 1.…
## $ diff_avg_goal_ratio <dbl> -0.75730506, -0.54730506, -0.39730506, -0.46730506…
```

## Across function exercise

Lets go back to our imdb_sub data. We want to extract films from 1990 through to 1995, that are from the USA, and have an avg_vote greater than or equal to 7.5. We also want all our variables that are currently characters to be factors, and want the year column to also be a factor.

1)  Using the imdb_sub data, filter for years between and including 1990 and 1995
2)  Now also filter for the country to be the USA, with an avg_vote greater then or equal to 7.5
3)  Using mutate, across and where, convert any column that has a character data type to a factor
4)  Using mutate, convert year to a factor
5)  Save the result in a data frame called `USA_early90_high`
6)  Using your new USA_early90_high subset, filter for avg_vote greater than or equal to 8.5, then select the title, avg_vote, and year columns. View the result to see the top rated films and what year they were in.


```r
# your code here

# first way of doing this
imdb_sub %>% 
  filter(year >= 1990 & year <= 1995 &
           country == "USA" & avg_vote >= 7.5) %>%
  mutate(across(where(is.character), as.factor),
         year = as.factor(year)) -> USA_early90_high

# second way of doing this
to_factor <- c("year")

imdb_sub %>% 
  filter(year >= 1990 & year <= 1995 &
           country == "USA" & avg_vote >= 7.5) %>%
  mutate(across(where(is.character), as.factor),
         across(any_of(to_factor), as.factor)) -> USA_early90_high

# highest rated with title, avg_vote, and year
USA_early90_high %>%
  filter(avg_vote >= 8.5) %>%
  select(title, avg_vote, year)
```

```
## # A tibble: 8 x 3
##   title                    avg_vote year 
##   <fct>                       <dbl> <fct>
## 1 Goodfellas                    8.7 1990 
## 2 The Silence of the Lambs      8.6 1991 
## 3 Schindler's List              8.9 1993 
## 4 Forrest Gump                  8.8 1994 
## 5 The Lion King                 8.5 1994 
## 6 Pulp Fiction                  8.9 1994 
## 7 The Shawshank Redemption      9.3 1994 
## 8 Se7en                         8.6 1995
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

Add survey link here

The solutions we be available from a link at the end of the survey.

# Individual coding challenge

For this coding challenge we are going to extract all Tolkien (lord of the rings and hobbit) and Harry Potter films from our imdb dataset. We have provided vectors with the titles of these films. 

1) Using the Tolkien and Potter vectors, use the `%in%` operator to filter titles in the imdb dataset that match the Tolkien or Potter vectors.
2) Use mutate to make a new column called duration_hours, and convert the duration column to hours *hint: times duration by 0.0166667*
3) Select out the title, year, avg_vote, duration and duration_hours columns
4) Save your subsetted data to a data frame called Tolkien_Potter
5) What films in the Tolkien_Potter dataset have a higher than average vote? 
6) What films in the Tolkien_Potter dataset have a less than average duration in hours?

*hint: for 5 and 6 you can use filter to compare the column to the mean of that column, e.g. filter(data, column > mean(column))*

```r
Tolkien <- c("The Lord of the Rings: The Fellowship of the Ring", "The Lord of the Rings: The Return of the King",
           "The Lord of the Rings: The Two Towers", "The Hobbit: An Unexpected Journey",
           "The Hobbit: The Desolation of Smaug", "The Hobbit: The Battle of the Five Armies")

Potter <- c("Harry Potter and the Sorcerer's Stone", "Harry Potter and the Chamber of Secrets",
            "Harry Potter and the Prisoner of Azkaban", "Harry Potter and the Goblet of Fire",
            "Harry Potter and the Order of the Phoenix", "Harry Potter and the Half-Blood Prince",
            "Harry Potter and the Deathly Hallows: Part 1", "Harry Potter and the Deathly Hallows: Part 2")

# your code here

Tolkien_Potter <- imdb_sub %>%
  filter(title %in% Tolkien | title %in% Potter) %>%
  mutate(duration_hours = duration * 0.0166667) %>%
  select(title, year, avg_vote, duration, duration_hours) 

filter(Tolkien_Potter, avg_vote > mean(avg_vote))
```

```
## # A tibble: 4 x 5
##   title                                    year avg_vote duration duration_hours
##   <chr>                                   <dbl>    <dbl>    <dbl>          <dbl>
## 1 The Lord of the Rings: The Fellowship …  2001      8.8      178           2.97
## 2 The Lord of the Rings: The Return of t…  2003      8.9      201           3.35
## 3 The Lord of the Rings: The Two Towers    2002      8.7      179           2.98
## 4 Harry Potter and the Deathly Hallows: …  2011      8.1      130           2.17
```

```r
filter(Tolkien_Potter, duration_hours < mean(duration_hours))
```

```
## # A tibble: 8 x 5
##   title                                    year avg_vote duration duration_hours
##   <chr>                                   <dbl>    <dbl>    <dbl>          <dbl>
## 1 Harry Potter and the Sorcerer's Stone    2001      7.6      152           2.53
## 2 Harry Potter and the Prisoner of Azkab…  2004      7.9      142           2.37
## 3 Harry Potter and the Goblet of Fire      2005      7.7      157           2.62
## 4 Harry Potter and the Order of the Phoe…  2007      7.5      138           2.30
## 5 Harry Potter and the Half-Blood Prince   2009      7.6      153           2.55
## 6 Harry Potter and the Deathly Hallows: …  2010      7.7      146           2.43
## 7 Harry Potter and the Deathly Hallows: …  2011      8.1      130           2.17
## 8 The Hobbit: The Battle of the Five Arm…  2014      7.4      144           2.40
```


