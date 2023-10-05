---
title: "R Fundamentals 4: Data Frames"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "05 October, 2023"
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

Notice how the column names are the same as what you named your vectors. You can rename the columns by adding your column name then equals, then your data like: `data.frame(column name = vector)`. Run the example below.


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

## Manual data frame exercise

Lets use the data from a previous workshop looking at Lionel Messi's career. We've got vectors with his goals, club, appearances, and year (season).

Using these vectors make a data frame called `messi_career`. The column names for app and year will have to change to Appearances and Season. You should end up with a data frame that has the column names Appearances, Goals, Season, and Club.


```r
# Vectors with data on Messi's career
app <- c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44)
Goals <- c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31)
year <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019)
Club <- rep("FC Barcelona", length(app))

# your code here
messi_career <- data.frame(Appearances = app,
                           Goals,
                           Season = year,
                           Club)
messi_career
```

```
##    Appearances Goals Season         Club
## 1            9     1   2004 FC Barcelona
## 2           25     8   2005 FC Barcelona
## 3           36    17   2006 FC Barcelona
## 4           40    16   2007 FC Barcelona
## 5           51    38   2008 FC Barcelona
## 6           53    47   2009 FC Barcelona
## 7           55    53   2010 FC Barcelona
## 8           60    73   2011 FC Barcelona
## 9           50    60   2012 FC Barcelona
## 10          46    41   2013 FC Barcelona
## 11          57    58   2014 FC Barcelona
## 12          49    41   2015 FC Barcelona
## 13          52    54   2016 FC Barcelona
## 14          54    45   2017 FC Barcelona
## 15          50    51   2018 FC Barcelona
## 16          44    31   2019 FC Barcelona
```

# Adding columns to the data frame

When working with data frames you will need to add columns and rows to them in the process of working with the data. There are multiple ways of adding data to a data frame. We will cover the most common for both adding columns and rows.

There are three common ways to add a column to a data frame, these involve using the `cbind()` function, the `$` operator, or the `transform()` function.

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

To add a new column, after the `$` we name the column we want to add, in this example string 2, then assign the data we want to it. Run the example below to test this out.


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

`transform()` is a really great function and the most flexible of the options. It is a convenience function that allows you to assign multiple columns to a data frame. *Fun fact: it is one of the inspirations for some tidyverse functions you will see in later workshops.*


```r
exampleDat <- transform(exampleDat, 
                        x = c(0.4, 0.5, 0.1, 0.9, 0.6),
                        y = rep(18, 5))
exampleDat
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

1)  Make a vector called Age, with integers from 17 to 32. *hint: use the `seq()` function*
2)  Using the `cbind()` method shown above, add the Age vector to the messi_career data frame you created in the previous task.
3)  Now we are going to add Messi's Champions League goals using the `$` sign method shown above. Call the new column champLeagueGoal, and add the following data: 0,1,1,6,9,8,12,14,8,8,10,6,11,6,12, and 3.
4)  Print out the result. You should see both the new columns of data you just added.
5)  Test out using `transform()` on the messi data to add a new column called age2 that is Age times 2


```r
# your code here
# either of these work for making Age
Age <- 17:32
Age <- seq(17, 32)
# cbind age
messi_career <- cbind(messi_career, Age)
messi_career
```

```
##    Appearances Goals Season         Club Age
## 1            9     1   2004 FC Barcelona  17
## 2           25     8   2005 FC Barcelona  18
## 3           36    17   2006 FC Barcelona  19
## 4           40    16   2007 FC Barcelona  20
## 5           51    38   2008 FC Barcelona  21
## 6           53    47   2009 FC Barcelona  22
## 7           55    53   2010 FC Barcelona  23
## 8           60    73   2011 FC Barcelona  24
## 9           50    60   2012 FC Barcelona  25
## 10          46    41   2013 FC Barcelona  26
## 11          57    58   2014 FC Barcelona  27
## 12          49    41   2015 FC Barcelona  28
## 13          52    54   2016 FC Barcelona  29
## 14          54    45   2017 FC Barcelona  30
## 15          50    51   2018 FC Barcelona  31
## 16          44    31   2019 FC Barcelona  32
```

```r
# add champ league goals
messi_career$champLeagueGoal <- c(0,1,1,6,9,8,12,14,8,8,10,6,11,6,12,3)
messi_career
```

```
##    Appearances Goals Season         Club Age champLeagueGoal
## 1            9     1   2004 FC Barcelona  17               0
## 2           25     8   2005 FC Barcelona  18               1
## 3           36    17   2006 FC Barcelona  19               1
## 4           40    16   2007 FC Barcelona  20               6
## 5           51    38   2008 FC Barcelona  21               9
## 6           53    47   2009 FC Barcelona  22               8
## 7           55    53   2010 FC Barcelona  23              12
## 8           60    73   2011 FC Barcelona  24              14
## 9           50    60   2012 FC Barcelona  25               8
## 10          46    41   2013 FC Barcelona  26               8
## 11          57    58   2014 FC Barcelona  27              10
## 12          49    41   2015 FC Barcelona  28               6
## 13          52    54   2016 FC Barcelona  29              11
## 14          54    45   2017 FC Barcelona  30               6
## 15          50    51   2018 FC Barcelona  31              12
## 16          44    31   2019 FC Barcelona  32               3
```

```r
# testing out transform
transform(messi_career, 
          Age = seq(17, 32),
          champLeagueGoal = c(0,1,1,6,9,8,12,14,8,8,10,6,11,6,12,3))
```

```
##    Appearances Goals Season         Club Age champLeagueGoal
## 1            9     1   2004 FC Barcelona  17               0
## 2           25     8   2005 FC Barcelona  18               1
## 3           36    17   2006 FC Barcelona  19               1
## 4           40    16   2007 FC Barcelona  20               6
## 5           51    38   2008 FC Barcelona  21               9
## 6           53    47   2009 FC Barcelona  22               8
## 7           55    53   2010 FC Barcelona  23              12
## 8           60    73   2011 FC Barcelona  24              14
## 9           50    60   2012 FC Barcelona  25               8
## 10          46    41   2013 FC Barcelona  26               8
## 11          57    58   2014 FC Barcelona  27              10
## 12          49    41   2015 FC Barcelona  28               6
## 13          52    54   2016 FC Barcelona  29              11
## 14          54    45   2017 FC Barcelona  30               6
## 15          50    51   2018 FC Barcelona  31              12
## 16          44    31   2019 FC Barcelona  32               3
```

# Adding rows to a data frame

To add a row to a data frame you use the `rbind()` function. First, you make a data frame with the data you want to add, then you use `rbind()` to add this onto the data frame. Again, the number of columns (and names of the columns) has to match those of the data frame you are joining to.

Run the example below to test this out:


```r
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
exampleDat <- rbind(exampleDat, newRow)
# print result
exampleDat
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

1)  Make a data frame called thisYear (or similar) and add the following data: Appearances: 47, Goals: 38, Season: 2020, Club: FC Barcelona, Age: 33, Champions league Goals: 5. *hint: Make sure the column names match up (e.g. champLeagueGoal)*
2)  Now, using `rbind()` add the new row of data to your messi_career data frame.
3)  Print the result, you should now see your new row of data!


```r
# your code here
# make data frame for new year
thisYear <- data.frame(Appearances = 47,
                       Goals = 38,
                       Season = 2020,
                       Club = 'FC Barcelona',
                       Age = 33,
                       champLeagueGoal = 5)
# rbind to previous data
messi_career <- rbind(messi_career, thisYear)
# print result
messi_career
```

```
##    Appearances Goals Season         Club Age champLeagueGoal
## 1            9     1   2004 FC Barcelona  17               0
## 2           25     8   2005 FC Barcelona  18               1
## 3           36    17   2006 FC Barcelona  19               1
## 4           40    16   2007 FC Barcelona  20               6
## 5           51    38   2008 FC Barcelona  21               9
## 6           53    47   2009 FC Barcelona  22               8
## 7           55    53   2010 FC Barcelona  23              12
## 8           60    73   2011 FC Barcelona  24              14
## 9           50    60   2012 FC Barcelona  25               8
## 10          46    41   2013 FC Barcelona  26               8
## 11          57    58   2014 FC Barcelona  27              10
## 12          49    41   2015 FC Barcelona  28               6
## 13          52    54   2016 FC Barcelona  29              11
## 14          54    45   2017 FC Barcelona  30               6
## 15          50    51   2018 FC Barcelona  31              12
## 16          44    31   2019 FC Barcelona  32               3
## 17          47    38   2020 FC Barcelona  33               5
```

# Getting information on a data frame

There are several ways to get information on your data frame. The simplest way is to simply click on the data frame in your global environment, this will bring up a viewer plane in a tab. When you have larger datasets however this is not the best way to view your data.

There are several attributes you will want to find out from your data frame. These include the dimensions (amount of rows and columns), the structure (what data does each column hold), summary information (means, interquartile range etc.), and a visual snapshot of your data.

To demonstrate of these functions we will use exampleDat. Run all the code chunks below to test out the functions.

To understand the dimensions of our data frame we use `dim()`, it returns the rows then columns. We can also use `nrow()` and `ncol()`. For exampleDat we get an output of 6 6 which means 6 rows and 6 columns.


```r
dim(exampleDat)
```

```
## [1] 6 8
```

To get a visual snapshot of our data we can use the `head()` or `tail()` functions. The head function gives you the first few rows, and the tail function gives you the last few rows. As the example data is so small we won't see a difference between the functions.


```r
head(exampleDat)
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

To find the structure of our data we use the `str()` command. This function gives us information on the column name, what data type that column is, and some of the data in that column.


```r
str(exampleDat)
```

```
## 'data.frame':	6 obs. of  8 variables:
##  $ string  : chr  "person_1" "person_2" "person_3" "person_4" ...
##  $ integer : num  1 2 3 4 5 6
##  $ number  : num  4 7 2 9 3 5
##  $ factor  : Factor w/ 2 levels "no","yes": 2 2 1 2 1 2
##  $ integer2: num  5 4 3 2 1 0
##  $ string2 : chr  "Control" "Control" "Experiment" "Experiment" ...
##  $ x       : num  0.4 0.5 0.1 0.9 0.6 0.3
##  $ y       : num  18 18 18 18 18 18
```

Finally, to get some basic descriptive statistics we can use `summary()`.


```r
summary(exampleDat)
```

```
##     string             integer         number     factor     integer2   
##  Length:6           Min.   :1.00   Min.   :2.00   no :2   Min.   :0.00  
##  Class :character   1st Qu.:2.25   1st Qu.:3.25   yes:4   1st Qu.:1.25  
##  Mode  :character   Median :3.50   Median :4.50           Median :2.50  
##                     Mean   :3.50   Mean   :5.00           Mean   :2.50  
##                     3rd Qu.:4.75   3rd Qu.:6.50           3rd Qu.:3.75  
##                     Max.   :6.00   Max.   :9.00           Max.   :5.00  
##    string2                x                y     
##  Length:6           Min.   :0.1000   Min.   :18  
##  Class :character   1st Qu.:0.3250   1st Qu.:18  
##  Mode  :character   Median :0.4500   Median :18  
##                     Mean   :0.4667   Mean   :18  
##                     3rd Qu.:0.5750   3rd Qu.:18  
##                     Max.   :0.9000   Max.   :18
```

## Getting information exercise

Use the following commands on the `messi_career` data: `dim()`, `nrow()`, `ncol()`, `head()`, `tail()`, `summary()`, `str()`, and `View()`.


```r
# Your code here
dim(messi_career)
```

```
## [1] 17  6
```

```r
nrow(messi_career)
```

```
## [1] 17
```

```r
ncol(messi_career)
```

```
## [1] 6
```

```r
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

```r
tail(messi_career)
```

```
##    Appearances Goals Season         Club Age champLeagueGoal
## 12          49    41   2015 FC Barcelona  28               6
## 13          52    54   2016 FC Barcelona  29              11
## 14          54    45   2017 FC Barcelona  30               6
## 15          50    51   2018 FC Barcelona  31              12
## 16          44    31   2019 FC Barcelona  32               3
## 17          47    38   2020 FC Barcelona  33               5
```

```r
summary(messi_career)
```

```
##   Appearances        Goals           Season         Club                Age    
##  Min.   : 9.00   Min.   : 1.00   Min.   :2004   Length:17          Min.   :17  
##  1st Qu.:44.00   1st Qu.:31.00   1st Qu.:2008   Class :character   1st Qu.:21  
##  Median :50.00   Median :41.00   Median :2012   Mode  :character   Median :25  
##  Mean   :45.76   Mean   :39.53   Mean   :2012                      Mean   :25  
##  3rd Qu.:53.00   3rd Qu.:53.00   3rd Qu.:2016                      3rd Qu.:29  
##  Max.   :60.00   Max.   :73.00   Max.   :2020                      Max.   :33  
##  champLeagueGoal 
##  Min.   : 0.000  
##  1st Qu.: 5.000  
##  Median : 8.000  
##  Mean   : 7.059  
##  3rd Qu.:10.000  
##  Max.   :14.000
```

```r
str(messi_career)
```

```
## 'data.frame':	17 obs. of  6 variables:
##  $ Appearances    : num  9 25 36 40 51 53 55 60 50 46 ...
##  $ Goals          : num  1 8 17 16 38 47 53 73 60 41 ...
##  $ Season         : num  2004 2005 2006 2007 2008 ...
##  $ Club           : chr  "FC Barcelona" "FC Barcelona" "FC Barcelona" "FC Barcelona" ...
##  $ Age            : num  17 18 19 20 21 22 23 24 25 26 ...
##  $ champLeagueGoal: num  0 1 1 6 9 8 12 14 8 8 ...
```

```r
View(messi_career)
```

# Indexing data frames

When indexing data in R we use square brackets (`[]`). The exact same principle applies to data frames, we can index multiple elements and drop elements.

Data frames have two dimensions in rows and columns, so we need to give indexes for both. The syntax is `data[row index, column index]`, so `data[1,5]` would mean we are indexing the first row and the fifth column.

If you wanted to select all columns or all rows you can leave the column or row index blank. Run the examples below:


```r
exampleDat[3, ]
```

```
##     string integer number factor integer2    string2   x  y
## 3 person_3       3      2     no        3 Experiment 0.1 18
```

```r
exampleDat[ ,4:5]
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


```r
exampleDat[, c("factor", "string2")]
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


```r
my_index <- c("string", "number")

exampleDat[ , my_index]
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

Using the messi_career data, index the columns Goals and Age to print out just those two columns and all the rows. Use the names of the columns as shown in the previous examples.


```r
# your code here
# make an index
messi_index <- c("Goals", "Age")
# pull out those columns
messi_career[, messi_index]
```

```
##    Goals Age
## 1      1  17
## 2      8  18
## 3     17  19
## 4     16  20
## 5     38  21
## 6     47  22
## 7     53  23
## 8     73  24
## 9     60  25
## 10    41  26
## 11    58  27
## 12    41  28
## 13    54  29
## 14    45  30
## 15    51  31
## 16    31  32
## 17    38  33
```

```r
# alt index option
messi_career[, c("Goals", "Age")]
```

```
##    Goals Age
## 1      1  17
## 2      8  18
## 3     17  19
## 4     16  20
## 5     38  21
## 6     47  22
## 7     53  23
## 8     73  24
## 9     60  25
## 10    41  26
## 11    58  27
## 12    41  28
## 13    54  29
## 14    45  30
## 15    51  31
## 16    31  32
## 17    38  33
```

# Subsetting and calculations with indexing

We can use these ideas to *subset* our data frame. Subsetting is simply selecting a portion of your data to work with. Lets say from our exampleDat data frame we wanted to just use the first three rows and columns integer, number, and integer2. See the example below for how to do this.


```r
exampleDat2 <- exampleDat[1:3, c("integer","number","integer2")]
exampleDat2
```

```
##   integer number integer2
## 1       1      4        5
## 2       2      7        4
## 3       3      2        3
```

Another method of indexing is using a function, such as `which.min()` or `which.max()` to index rows. In the below example, we use `which.min()` to find the row with the minimum in the number column, we also selected all columns.


```r
exampleDat3 <- exampleDat[which.min(exampleDat$number), ]
exampleDat3
```

```
##     string integer number factor integer2    string2   x  y
## 3 person_3       3      2     no        3 Experiment 0.1 18
```

This is conditional indexing, which we will cover more in R fundamentals 6 (conditionals and logic).

We can bring together adding a new column with indexing to do calculations. See the examples below.

In the first example, we make a new column called calculation using the `$` operator. Then we do a calculation with indexing, in this case the *integer* column divided by the *number* column.

In the second example, we do the calculations by using only the `$` operator.


```r
# add new column and add calculation to it
exampleDat$calculation <- exampleDat[,"integer"]/exampleDat[,"number"] 

# add second column using different indexing technique
exampleDat$calculation2 <- (exampleDat$integer*exampleDat$integer2)/nrow(exampleDat)

# print result
exampleDat
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


```r
transform(exampleDat, 
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

We will index the `messi_career` data we have using to do some calculations, subset, and print a nice result. The final printed result should be: *Messi's best goal ratio is 1.22 goals per game in the 2011 Season, at the age of 24 , of his goals 19 percent where in the Champions League.*.

1)  Make a new column called goalRatio and, using indexing, divide Goals by Appearances.
2)  Make another new column called propChampGoal and, using indexing, divide champLeagueGoal by Goals and times by 100.
3)  Subset the messi_career data. Call the subsetted data messi_careerSub, and keep all rows and the following columns: Season, Age, goalRatio and propChampGoal.
4)  Using your new messi_careerSub data frame, use `which.max()` to find the row with the best goal ratio. Store this in a data frame called bestGR. *hint: see which.min() example*.
5)  Use `paste()` or `paste0` to print the result: Messi's best goal ratio is 1.22 goals per game in the 2011 Season, at the age of 24 , of his goals 19 percent where in the Champions League. *hint: use indexing on the bestGR data frame, e.g. paste("text", round(bestGR[,3],2), "more text")*.


```r
# your code here
# calculations
messi_career$goalRatio <- messi_career$Goals/messi_career$Appearances
messi_career$propChampGoal <- messi_career$champLeagueGoal/messi_career$Goals*100
# subsetting
messi_careerSub <- messi_career[,c('Season', 'Age', 'goalRatio', 'propChampGoal')]
# best season
bestGR <- messi_careerSub[which.max(messi_careerSub$goalRatio),]
bestGR
```

```
##   Season Age goalRatio propChampGoal
## 8   2011  24  1.216667      19.17808
```

```r
# output (using two methods of calling bestGR)
paste("Messi's best goal ratio is", round(bestGR$goalRatio,2), "goals per game in the", bestGR[1] ,"Season, at the age of", bestGR[2], ", of his goals", round(bestGR$propChampGoal,2) ,"percent where in the Champions League")
```

```
## [1] "Messi's best goal ratio is 1.22 goals per game in the 2011 Season, at the age of 24 , of his goals 19.18 percent where in the Champions League"
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_6eSrOVWuit28qcS?coursename=R%Fundamentals%4:%Data%Frames&topic=R&prog=DS&version=23-24&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Eq8J0o5HZ2hEhHyfOK_Y8PoBqeKPeb-zo52bUZkCsSUfwg?e=33hbek>

# Individual take home challenge

For the individual coding challenge you will need to de-bug the code to get it working. The end result will be something like: *Dobby the house elf is very Devoted and has a power to evil ratio of 0.67*. The numbers you get will not be the same but the text should be the same. There are 6 errors to find.


```r
# Some Harry Potter characters
HP_Characters <- dataframe(
  Name = c("Harry Potter", "Luna Lovegood", "Nymphadora Tonks", 
           "Hermione Granger", "Severus Snape", "Cedric Diggory",
           "Dobby the house elf"),
  Trait = ("Brave", "Wise", "Loyal", "Brave", "Cunning", "Loyal", 
            "Devoted"))
# Give them a score out of 10 for power
HP_Char$Power <- sample(1:10, 7)
# Give them a score out of 10 for Evilness
HP_Characters$Evilness <- sample(1:10, 7)
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


```r
# solution! 
# Some Harry Potter characters
HP_Characters <- data.frame( 
  Name = c("Harry Potter", "Luna Lovegood", "Nymphadora Tonks", 
           "Hermione Granger", "Severus Snape", "Cedric Diggory",
           "Dobby the house elf"),
  Trait = c("Brave", "Wise", "Loyal", "Brave", "Cunning", "Loyal", 
            "Devoted"))
# Give them a score out of 10 for power
HP_Characters$Power <- sample(1:10, 7)
# Give them a score out of 10 for Evilness
HP_Characters$Evilness <- sample(1:10, 7)
# Give them a power to evil ratio
HP_Characters$PowEvilRatio <- HP_Characters$Power/HP_Characters$Evil

# print the result for Dobby
paste(HP_Characters[7,1], "is very", HP_Characters[7,2], 
      "and has a power to evil ratio of", round(HP_Characters[7,5],2), sep = " ")
```

```
## [1] "Dobby the house elf is very Devoted and has a power to evil ratio of 0.14"
```


# Other options

We have covered some of the classic R options for adding columns and indexing data frames. There are two other very useful functions which can make your life easier when using R: `within()` and `with()`. 

`with()` is a convenience function designed to save you writing out your data frame name every time you want to use a column in that data frame. `within()` is similar but allows you to assign a variable in the same way you would with $. 

```r
with(exampleDat, integer/number)
```

```
## [1] 0.2500000 0.2857143 1.5000000 0.4444444 1.6666667 1.2000000
```

```r
within(exampleDat, calc <- integer/number)
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

```r
with(exampleDat, mean(calculation))
```

```
## [1] 0.8911376
```

```r
with(exampleDat, paste(
  "Average number is", mean(number), 
  "and max number is", max(number)))
```

```
## [1] "Average number is 5 and max number is 9"
```


