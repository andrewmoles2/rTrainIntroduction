---
title: "R Workshop 4 - Data Frames and libraries"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "28 October, 2020"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What will this workshop cover?

In this workshop, the aim is to cover how to load and work with data frames, as well as an introduction to packages. We will be covering:

*  Introduction to packages
*  Manually making data frames
*  Loading in data
*  Getting information on data frames
*  Indexing data frames
*  Adjusting row and column names

# Information on how the session is run

One hour exercise based session with tutor support. You will be given example code for a problem, then given a related exercise to complete.

## Why this style?

*  Online training is tiring so keeping the sessions to one hour
*  No or limited demonstrations provided in order to provide more real world experience - you have a problem and you look up how to solve it, adapting example code
*  Trainer support to guide through process of learning

## We will be working in pairs:

*  One shares the screen and the other requests remote control.
*  Take turns on who types for each exercise.
*  Share markdown file at end of session via chat
*  If possible have your camera on when doing the paired work.

## What to do when getting stuck:

1)  Ask your team members
2)  Search online:
  *  The answer box on the top of Google's results page 
  *  stackoverflow.com (for task-specific solutions)
  *  https://www.r-bloggers.com/ (topic based tutorials)
3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

***

# Introduction to packages

Packages are collections of functions, code, and sample data put together by the R community. Packages are one of the main benefits of R. As R is open source there can be lots of contributors who have made functions to do complex tasks, such as data cleaning, or specific types of data analysis.

To install these packages onto your computer you have to download them from CRAN (The Comprehensive R Archive Network). 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop4/images/CRAN.png?raw=true){width=30%}

There are two ways of doing this, using code (recommended and easiest) or using the menus (Tools > Install Packages). 

Using code involves using the install packages function, which looks like: `install.packages("package name")`. To install the package you would type something like:`install.packages("readr")`.

## Installing packages task

Try installing the following packages: `data.table`, `readr`, `readxl` using the `install.packages()` function. 


```r
# your code here
```

Once installed, you will not need to do this again unless you install a newer version of R. 

## Loading packages

Now you have installed the packages, you need to load them so you can use them. Each time you load R you will need to re-load the packages you want to use. 

To load a package you need to use the `library()` function. For example, if I wanted to load the `readr` package I would type `library(readr)`.

## Loading packages task

Using `library()` load in the packages you just installed: `data.table`, `readr`, `readxl`.


```r
# your code here
```

If you are not sure what packages are loaded, you can use `sessionInfo()`. Run the code below to test it out. Under *other attached packages* you should see readxl, readr, and data.table. 

```r
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Catalina 10.15.7
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRblas.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] compiler_4.0.2  magrittr_1.5    tools_4.0.2     htmltools_0.5.0
##  [5] yaml_2.2.1      stringi_1.4.6   rmarkdown_2.3   knitr_1.29     
##  [9] stringr_1.4.0   xfun_0.16       digest_0.6.25   rlang_0.4.7    
## [13] evaluate_0.14
```

# What is a data frame

A data frame is a programming object similar to a table. Data frames are commonplace in data science and are needed for most types of analysis. Generally each row contains individual entries (or observations) and each column corresponds to a feature or characteristic of that entry.

Fundamentally, a data frame can contain a mix of different data types (e.g. column 1 is string, column 2 is integer, column 3 is a factor), but a single column in a data frame must be of the same type (e.g. integers, strings, etc.).

![Artwork by @allison_horst](https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/tidydata_6.jpg?raw=true){width=40%}

# Making a data frame manually

Before we start loading in data, lets have a look how to make data frames manually. This will help you understand the make up of data frames. 

To make a data frame we use the `data.frame()` function. The easiest way to do this is to make a vector and add that vector into the data frame. Run both examples below and review the output. 


```r
# vectors for various data types
str1 <- paste0("person_", seq(1:5))
int1 <- seq(1, 5)
num1 <- c(4,7,2,9,3)
fac1 <- factor(c("yes","yes","no","yes","no"))
# adding them into a data frame
exampleDat <- data.frame(str1, int1, num1, fac1)
# print the result
exampleDat
```

```
##       str1 int1 num1 fac1
## 1 person_1    1    4  yes
## 2 person_2    2    7  yes
## 3 person_3    3    2   no
## 4 person_4    4    9  yes
## 5 person_5    5    3   no
```

Notice how the column names are the same as what you named your vectors. You can rename the columns by adding your column name then equals then your data like: `data.frame(column name = vector)`. Run the example below. 


```r
# vectors for various data types
str1 <- paste0("person_", seq(1:5))
int1 <- seq(1, 5)
num1 <- c(4,7,2,9,3)
fac1 <- factor(c("yes","yes","no","yes","no"))
# adding them into a data frame
exampleDat <- data.frame(string = str1, 
              integer = int1, 
              number = num1, 
              factor = fac1)
# print the result
exampleDat
```

```
##     string integer number factor
## 1 person_1       1      4    yes
## 2 person_2       2      7    yes
## 3 person_3       3      2     no
## 4 person_4       4      9    yes
## 5 person_5       5      3     no
```

## Manual data frame task

Lets use the data from the coding challenge in R2 looking at Lionel Messi's career. We've got vectors with his goals, club, appearances, and year (season). 

Using these vectors make a data frame called `messi_career`. The column names for app and year will have to change to Appearances and Season. You should end up with a data frame that has the column names Appearances, Goals, Season, and Club.


```r
# Vectors with data on Messi's career
app <- c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44)
Goals <- c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31)
year <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019)
Club <- rep("FC Barcelona", length(app))

# your code here
```

## Adding columns to the data frame

When working with data frames you will need to add columns and rows to them in the process of working with the data. There are multiple ways of adding data to a data frame. We will cover the most common for both adding columns and rows. 

There are two common ways to add a column to a data frame, these involve using the `cbind()` function or using the `$`. 

Lets look at the first way using `cbind()`. *It is important to note that the dimensions have to match when using `cbind()` and `rbind()`, so if your data frame has 5 rows, the vector you are binding needs to have 5 rows.*


```r
# make an integer
integer2 <- seq(5,1)
# bind to the data
exampleDat <- cbind(exampleDat, integer2)
# print result
exampleDat
```

```
##     string integer number factor integer2
## 1 person_1       1      4    yes        5
## 2 person_2       2      7    yes        4
## 3 person_3       3      2     no        3
## 4 person_4       4      9    yes        2
## 5 person_5       5      3     no        1
```

The second way, and easiest, is to use the `$`. The dollar sign is a way of indexing columns in a data frame (more on data frame indexing later). We can use this feature to add columns. For example, see the code chunk below for how to index the string column in exampleDat. 


```r
exampleDat$string
```

```
## [1] "person_1" "person_2" "person_3" "person_4" "person_5"
```

To add a new column, after the $ we name the column we want to add, in this example string 2, then assign the data we want to it. Run the example below to test this out. 


```r
exampleDat$string2 <- c(rep("Control",2), rep("Experiment", 3))
exampleDat
```

```
##     string integer number factor integer2    string2
## 1 person_1       1      4    yes        5    Control
## 2 person_2       2      7    yes        4    Control
## 3 person_3       3      2     no        3 Experiment
## 4 person_4       4      9    yes        2 Experiment
## 5 person_5       5      3     no        1 Experiment
```

## Adding columns exercise

Using the data frame you created in the previous task (messi_career): 

1)  Make a vector called Age, with integers from 17 to 32. *hint: use the `seq()` function*
2)  Using the `cbind()` method shown above, add the Age vector to the messi_career data frame you created in the previous task.
3)  Now we are going to add Messi's Champions League goals using the $ sign method shown above. Call the new column champLeagueGoal, and add the following data: 0,1,1,6,9,8,12,14,8,8,10,6,11,6,12, and 3.
4)  Print out the result. You should see both the new columns of data you just added.


```r
# your code here
```

## Adding rows to a data frame

To add a row to a data frame you use the `rbind()` function. First, you make a data frame with the data you want to add, then you use `rbind()` to add this onto the data frame. Again, the number of columns (and names of the columns) has to match those of the data frame you are joining to. 

Run the example below to test this out:

```r
# new row infomation
newRow <- data.frame(string = "person_6",
                     integer = 6,
                     number = 5,
                     factor = factor("yes"),
                     integer2 = 0,
                     string2 = "Control")
# binding new row to example data
exampleDat <- rbind(exampleDat, newRow)
# print result
exampleDat
```

```
##     string integer number factor integer2    string2
## 1 person_1       1      4    yes        5    Control
## 2 person_2       2      7    yes        4    Control
## 3 person_3       3      2     no        3 Experiment
## 4 person_4       4      9    yes        2 Experiment
## 5 person_5       5      3     no        1 Experiment
## 6 person_6       6      5    yes        0    Control
```
## Adding rows exercise

For this exercise we will use the same messi_career data frame, adding this years data. 

1)  Make a data frame called thisYear (or similar) and add the following data:
Appearances: 6, Goals: 2, Season: 2020, Club: FC Barcelona, Age: 33, Champions league Goals: 1. *hint: Make sure the column names match up*
2)  Now, using `rbind()` add the new row of data to your messi_career data frame. 
3)  Print the result, you should now see your new row of data! 


```r
# your code here
```

# Loading in data

When loading data it is important to make sure your data file is in the same directory as your rWorkshop4.Rmd file. Make sure you save both the .csv and .xlsx file in the same file as your .Rmd. 

If you are not sure if your data file is in the same directory as this notebook run the below command to list the files in your directory:

```r
list.files()
```

```
## [1] "images"          "rWorkshop4.html" "rWorkshop4.md"   "rWorkshop4.Rmd"
```

We are going to load in a .csv file and a .xlsx file, two of the most common file types to be loaded into R. 

**hint: an RStudio shortcut to find files is to press tab when the cursor is in the speech marks ("")**


# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_9zagWkOtzNhmqt7?course=D025-R1NV&topic=R&cohort=MT20

# Individual take home challenge 

