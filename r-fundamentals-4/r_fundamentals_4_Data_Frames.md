---
title: "R Fundamentals 4: Data Frames"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "13 August, 2024"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: true
    toc_float: 
      collapsed: true
---

# Objective of workshop

To create data frames, and be able to manage them by indexing and adding data.

# What will this workshop cover?

In this workshop, the aim is to introduce you to data frames. We will be covering:

-   Manually making data frames
-   Adding rows and columns to data frames
-   Getting information on data frames
-   Indexing data frames

------------------------------------------------------------------------

# What is a data frame

A data frame is a programming object similar to a table or an Excel spreadsheet.

Data frames are commonplace in data science and are needed for most types of analysis. Generally each row contains individual entries (or observations) and each column corresponds to a feature or characteristic of that entry.

Fundamentally, a data frame can contain a mix of different data types (e.g. column 1 is string, column 2 is integer, column 3 is a factor), but a single column in a data frame must be of the same type (e.g. integers, strings, etc.).

![Artwork by @allison_horst](https://github.com/allisonhorst/stats-illustrations/blob/master/rstats-artwork/tidydata_6.jpg?raw=true){width="40%"}

# Making a data frame manually

First, lets have a look how to make data frames manually. This will help you understand the make up and structure of data frames.

To make a data frame we use the `data.frame()` function. The one way to do this is to make a vector and add that vector into the data frame. Run the example below and review the output.


``` r
# vectors for various data types
str1 <- paste0("person_", 1:5)
int1 <- 1:5
num1 <- c(4,7,2,9,3)
fac1 <- factor(c("yes","yes","no","yes","no"))
# adding them into a data frame
example_data <- data.frame(str1, int1, num1, fac1)
# print the result
example_data
```

```
##       str1 int1 num1 fac1
## 1 person_1    1    4  yes
## 2 person_2    2    7  yes
## 3 person_3    3    2   no
## 4 person_4    4    9  yes
## 5 person_5    5    3   no
```

Notice how the column names are the same as what you named your vectors. You can rename the columns by adding your column name then equals, then your data like: `data.frame(column name = vector)`. Run the example below.


``` r
# vectors for various data types
str1 <- paste0("person_", 1:5)
int1 <- 1:5
num1 <- c(4,7,2,9,3)
fac1 <- factor(c("yes","yes","no","yes","no"))
# adding them into a data frame
example_data <- data.frame(string = str1, 
              integer = int1, 
              number = num1, 
              factor = fac1)
# print the result
example_data
```

```
##     string integer number factor
## 1 person_1       1      4    yes
## 2 person_2       2      7    yes
## 3 person_3       3      2     no
## 4 person_4       4      9    yes
## 5 person_5       5      3     no
```

*Note: you can also change column names using functions - https://statisticsglobe.com/rename-column-name-in-r-data-frame/*

## Manual data frame exercise

Lets use the data from a previous workshop looking at Lionel Messi's career. We've got vectors with his goals, club, appearances, and year (season).

Using these vectors make a data frame called `messi_career`. The column names for app and year will have to change to Appearances and Season. You should end up with a data frame that has the column names Appearances, Goals, Season, and Club.


``` r
# Vectors with data on Messi's career
app <- c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44)
Goals <- c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31)
year <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019)
Club <- rep("FC Barcelona", length(app))

# your code here
```

# Adding columns to the data frame

When working with data frames you will need to add columns and rows to them in the process of working with the data. There are multiple ways of adding data to a data frame. We will cover the most common for both adding columns and rows.

There are three common ways to add a column to a data frame, these involve using the `cbind()` function, the `$` operator, or the `transform()` function.

Lets look at the first way using `cbind()`. *It is important to note that the dimensions have to match when using `cbind()` and `rbind()`, so if your data frame has 5 rows, the vector you are binding needs to have 5 rows.*


``` r
# make an integer
integer2 <- seq(5,1)
# bind to the data
example_data <- cbind(example_data, integer2)
# print result
example_data
```

```
##     string integer number factor integer2
## 1 person_1       1      4    yes        5
## 2 person_2       2      7    yes        4
## 3 person_3       3      2     no        3
## 4 person_4       4      9    yes        2
## 5 person_5       5      3     no        1
```

The second way, and easiest, is to use the `$`. The dollar sign is a way of indexing columns in a data frame (more on data frame indexing later). We can use this feature to add columns. For example, see the code chunk below for how to index the string column in example_data.


``` r
example_data$string
```

```
## [1] "person_1" "person_2" "person_3" "person_4" "person_5"
```

To add a new column, after the `$` we name the column we want to add, in this example string 2, then assign the data we want to it. Run the example below to test this out.


``` r
example_data$string2 <- c(rep("Control",2), rep("Experiment", 3))
example_data
```

```
##     string integer number factor integer2    string2
## 1 person_1       1      4    yes        5    Control
## 2 person_2       2      7    yes        4    Control
## 3 person_3       3      2     no        3 Experiment
## 4 person_4       4      9    yes        2 Experiment
## 5 person_5       5      3     no        1 Experiment
```

`transform()` is a really great function and the most flexible of the options. It allows you to assign multiple columns to a data frame.


``` r
example_data <- transform(example_data, 
                        x = c(0.4, 0.5, 0.1, 0.9, 0.6),
                        y = rep(18, 5))
example_data
```

```
##     string integer number factor integer2    string2   x  y
## 1 person_1       1      4    yes        5    Control 0.4 18
## 2 person_2       2      7    yes        4    Control 0.5 18
## 3 person_3       3      2     no        3 Experiment 0.1 18
## 4 person_4       4      9    yes        2 Experiment 0.9 18
## 5 person_5       5      3     no        1 Experiment 0.6 18
```


## Adding columns exercise

Using the data frame you created in the previous task (`messi_career`):

*   Make a vector called `age`, with integers from 17 to 32.
*   Make a vector called `champ_league_goal` with the following data: 0,1,1,6,9,8,12,14,8,8,10,6,11,6,12, and 3.
*   Using any of the methods above, add the `age` and `champ_league_goal` vectors to your `messi_career` data frame. 
*   Print out the result. You should see both the new columns of data you just added.


``` r
# your code here
```

*Note if you end up with multiple columns of age or champ_league_goal, re-run the code from the Manual data frame exercise to reset your data frame* 

# Adding rows to a data frame

To add a row to a data frame you use the `rbind()` function. First, you make a data frame with the data you want to add, then you use `rbind()` to add this onto the data frame. Again, the number of columns (and names of the columns) has to match those of the data frame you are joining to.

Run the example below to test this out:


``` r
# new row information
newRow <- data.frame(string = "person_6",
                     integer = 6,
                     number = 5,
                     factor = factor("yes"),
                     integer2 = 0,
                     string2 = "Control",
                     x = 0.3,
                     y = 18)
# binding new row to example data
example_data <- rbind(example_data, newRow)
# print result
example_data
```

```
##     string integer number factor integer2    string2   x  y
## 1 person_1       1      4    yes        5    Control 0.4 18
## 2 person_2       2      7    yes        4    Control 0.5 18
## 3 person_3       3      2     no        3 Experiment 0.1 18
## 4 person_4       4      9    yes        2 Experiment 0.9 18
## 5 person_5       5      3     no        1 Experiment 0.6 18
## 6 person_6       6      5    yes        0    Control 0.3 18
```

## Adding rows exercise

For this exercise we will use the same `messi_career` data frame, adding data from 2020.

1)  Make a data frame called this_year (or similar) and add the following data: Appearances: 47, Goals: 38, Season: 2020, Club: FC Barcelona, Age: 33, Champions league Goals: 5. *hint: Make sure the column names match up (e.g. champ_league_goal)*
2)  Now, using `rbind()` add the new row of data to your messi_career data frame.
3)  Print the result, you should now see your new row of data!


``` r
# your code here
```

# Getting information on a data frame

There are several ways to get information on your data frame. The simplest way is to simply click on the data frame in your global environment, this will bring up a viewer plane in a tab. When you have larger datasets however this is not always the best way to view your data.

There are several attributes you will want to find out from your data frame. These include the dimensions (amount of rows and columns), the structure (what data does each column hold), summary information (means, interquartile range etc.), and a visual snapshot of your data.

## Getting information exercise

Use the following commands on the `messi_career` data: `dim()`, `nrow()`, `ncol()`, `head()`, `tail()`, `summary()`, `str()`, and `View()`.

What do each of the functions do? If you want to find out more about the function try looking it up in the built in help menu. For example, if I wanted to look up the summary function I could do `?summary()`. 


``` r
# Your code here
```

# Indexing data frames

When indexing data in R we use square brackets (`[]`). The exact same principle applies to data frames, we can index multiple elements and drop elements.

Data frames have two dimensions in rows and columns, so we need to give indexes for both. The syntax is `data[row index, column index]`, so `data[1,5]` would mean we are indexing the first row and the fifth column.

If you wanted to select all columns or all rows you can leave the column or row index blank. Run the examples below:


``` r
example_data[3, ]
```

```
##     string integer number factor integer2    string2   x  y
## 3 person_3       3      2     no        3 Experiment 0.1 18
```

``` r
example_data[ ,4:5]
```

```
##   factor integer2
## 1    yes        5
## 2    yes        4
## 3     no        3
## 4    yes        2
## 5     no        1
## 6    yes        0
```

You can see we get the 3rd row of data for the first example. For the second example we get all rows and columns 4 to 5.

We can also index the the names of the columns, below we are looking for the column names factor and string2. R will search for the exact match of the string you provide, so it is case sensitive.


``` r
example_data[, c("factor", "string2")]
```

```
##   factor    string2
## 1    yes    Control
## 2    yes    Control
## 3     no Experiment
## 4    yes Experiment
## 5     no Experiment
## 6    yes    Control
```

Instead of putting the names we want to index straight into the square brackets, we can make a vector with the names, and use them to index.


``` r
my_index <- c("string", "number")

example_data[ , my_index]
```

```
##     string number
## 1 person_1      4
## 2 person_2      7
## 3 person_3      2
## 4 person_4      9
## 5 person_5      3
## 6 person_6      5
```

## Indexing data frames exercise 1

Using the messi_career data, index the columns `Goals` and `Appearances` to print out just those two columns and all the rows. Try to index using the names of the columns. 


``` r
# your code here
```

# Subsetting and calculations with indexing

We can use these ideas to *subset* our data frame. Subsetting is simply selecting a portion of your data to work with. Lets say from our example_data data frame we wanted to just use the first three rows and columns integer, number, and integer2. See the example below for how to do this.


``` r
example_data2 <- example_data[1:3, c("integer","number","integer2")]
example_data2
```

```
##   integer number integer2
## 1       1      4        5
## 2       2      7        4
## 3       3      2        3
```

Another method of indexing is using a function, such as `which.min()` or `which.max()` to index rows. In the below example, we use `which.min()` to find the row with the minimum in the number column, we also selected all columns.


``` r
example_data3 <- example_data[which.min(example_data$number), ]
example_data3
```

```
##     string integer number factor integer2    string2   x  y
## 3 person_3       3      2     no        3 Experiment 0.1 18
```

This is conditional indexing, which we will cover more in R fundamentals 6 (conditionals and logic).

We can bring together adding a new column with indexing to do calculations. See the examples below.

In the first example, we make a new column called calculation using the `$` operator. Then we do a calculation with indexing, in this case the *integer* column divided by the *number* column.

In the second example, we do the calculations by using only the `$` operator.


``` r
# add new column and add calculation to it
example_data$calculation <- example_data[,"integer"]/example_data[,"number"] 

# add second column using different indexing technique
example_data$calculation2 <- (example_data$integer*example_data$integer2)/nrow(example_data)

# print result
example_data
```

```
##     string integer number factor integer2    string2   x  y calculation
## 1 person_1       1      4    yes        5    Control 0.4 18   0.2500000
## 2 person_2       2      7    yes        4    Control 0.5 18   0.2857143
## 3 person_3       3      2     no        3 Experiment 0.1 18   1.5000000
## 4 person_4       4      9    yes        2 Experiment 0.9 18   0.4444444
## 5 person_5       5      3     no        1 Experiment 0.6 18   1.6666667
## 6 person_6       6      5    yes        0    Control 0.3 18   1.2000000
##   calculation2
## 1    0.8333333
## 2    1.3333333
## 3    1.5000000
## 4    1.3333333
## 5    0.8333333
## 6    0.0000000
```

We can also use `transform()` for this sort of operation. The advantage of `transform()` is you can do multiple column assignments and you do not have to call the data frame each time. 


``` r
transform(example_data, 
          new_calculation = (calculation*calculation2)/2,
          new_string = paste0(string, "_", string2))
```

```
##     string integer number factor integer2    string2   x  y calculation
## 1 person_1       1      4    yes        5    Control 0.4 18   0.2500000
## 2 person_2       2      7    yes        4    Control 0.5 18   0.2857143
## 3 person_3       3      2     no        3 Experiment 0.1 18   1.5000000
## 4 person_4       4      9    yes        2 Experiment 0.9 18   0.4444444
## 5 person_5       5      3     no        1 Experiment 0.6 18   1.6666667
## 6 person_6       6      5    yes        0    Control 0.3 18   1.2000000
##   calculation2 new_calculation          new_string
## 1    0.8333333       0.1041667    person_1_Control
## 2    1.3333333       0.1904762    person_2_Control
## 3    1.5000000       1.1250000 person_3_Experiment
## 4    1.3333333       0.2962963 person_4_Experiment
## 5    0.8333333       0.6944444 person_5_Experiment
## 6    0.0000000       0.0000000    person_6_Control
```


## Indexing data frames exercise 2

We will index the `messi_career` data to do some calculations, subset, and print a nice result. 

1)  Make a new column called goal_ratio and, using indexing, divide Goals by Appearances.
2)  Make another new column called prop_champ_goal and, using indexing, divide champ_league_goal by Goals and times by 100.
3)  Subset the messi_career data. Call the subsetted data messi_career_sub, and keep all rows and the following columns: Season, age, goal_ratio and prop_champ_goal.
4)  Using your new messi_career_sub data frame, use `which.max()` to find the row with the best goal ratio. Store this in a data frame called best_GR *hint: using ?which.max() to look up function*.
5)  Use `paste()` or `paste0()` to print the final result: *Messi's best goal ratio is 1.22 goals per game in the 2011 season when he was 24. Of his goals, 19.18 percent were in the Champions League.*.

*hint: use indexing on the best_GR data frame, e.g. paste("text", round(best_GR[,3],2), "more text")*.


``` r
# your code here
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_6eSrOVWuit28qcS?coursename=R%Fundamentals%4:%Data%Frames&topic=R&prog=DS&version=23-24&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Eq8J0o5HZ2hEhHyfOK_Y8PoBqeKPeb-zo52bUZkCsSUfwg?e=33hbek>

# Individual take home challenge

For the individual coding challenge you will need to de-bug the code to get it working. The end result will be: *"Dobby the house elf is very Devoted and has a power to evil ratio of 1.6"*. The numbers you get will not be the same but the text should be the same. There are 6 errors to find.


``` r
# Some Harry Potter characters
HP_Characters <- dataframe(
  Name = c("Harry Potter", "Luna Lovegood", "Nymphadora Tonks", 
           "Hermione Granger", "Severus Snape", "Cedric Diggory",
           "Dobby the house elf"),
  Trait = ("Brave", "Wise", "Loyal", "Brave", "Cunning", "Loyal", 
            "Devoted"))
# Give them a score out of 10 for power
HP_Characters$Power <- c(7,9,5,2,3,10,8)
# Give them a score out of 10 for Evilness
HP_Characters$Evilness <- c(7,6,3,2,8,4,5)
# Give them a power to evil ratio
HP_Characters$PowEvilRatio <- HP_Characters$Pow/HP_Characters$Evil

# print the result for Dobby
paste(HP_Characters[1,1], "is very", HP_Characters[7,2], 
      "and has a power to evil ratio of", round(HP_Characters[7,5],2), sep = "# ")
```

```
## Error: <text>:6:19: unexpected ','
## 5:            "Dobby the house elf"),
## 6:   Trait = ("Brave",
##                      ^
```


# Other options

We have covered some of the classic R options for adding columns and indexing data frames. There are two other very useful functions which can make your life easier when using R: `within()` and `with()`. 

`with()` is designed to save you writing out your data frame name every time you want to use a column in that data frame. `within()` is similar but allows you to assign a variable in the same way you would with $. 

``` r
with(example_data, integer/number)
```

```
## [1] 0.2500000 0.2857143 1.5000000 0.4444444 1.6666667 1.2000000
```

``` r
within(example_data, calc <- integer/number)
```

```
##     string integer number factor integer2    string2   x  y calculation
## 1 person_1       1      4    yes        5    Control 0.4 18   0.2500000
## 2 person_2       2      7    yes        4    Control 0.5 18   0.2857143
## 3 person_3       3      2     no        3 Experiment 0.1 18   1.5000000
## 4 person_4       4      9    yes        2 Experiment 0.9 18   0.4444444
## 5 person_5       5      3     no        1 Experiment 0.6 18   1.6666667
## 6 person_6       6      5    yes        0    Control 0.3 18   1.2000000
##   calculation2      calc
## 1    0.8333333 0.2500000
## 2    1.3333333 0.2857143
## 3    1.5000000 1.5000000
## 4    1.3333333 0.4444444
## 5    0.8333333 1.6666667
## 6    0.0000000 1.2000000
```

`with()` is particularly useful when used with functions which do not have a *data* argument such as mean or paste like the examples show below. 

``` r
with(example_data, mean(calculation))
```

```
## [1] 0.8911376
```

``` r
with(example_data, paste(
  "Average number is", mean(number), 
  "and max number is", max(number)))
```

```
## [1] "Average number is 5 and max number is 9"
```


