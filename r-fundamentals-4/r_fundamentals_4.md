---
title: "R Fundamentals 4 - Data Frames"
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

# Information on how the session is run

One hour exercise based session with tutor support. You will be given example code for a problem, then given a related exercise to complete.

## Why this style?

-   Online training is tiring so keeping the sessions to one hour
-   No or limited demonstrations provided in order to provide more real world experience - you have a problem and you look up how to solve it, adapting example code
-   Trainer support to guide through process of learning

## We will be working together in breakout rooms:

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
```

# Adding columns to the data frame

When working with data frames you will need to add columns and rows to them in the process of working with the data. There are multiple ways of adding data to a data frame. We will cover the most common for both adding columns and rows.

There are two common ways to add a column to a data frame, these involve using the `cbind()` function or using the `$` operator.

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

## Adding columns exercise

Using the data frame you created in the previous task (`messi_career`):

1)  Make a vector called Age, with integers from 17 to 32. *hint: use the `seq()` function*
2)  Using the `cbind()` method shown above, add the Age vector to the messi_career data frame you created in the previous task.
3)  Now we are going to add Messi's Champions League goals using the `$` sign method shown above. Call the new column champLeagueGoal, and add the following data: 0,1,1,6,9,8,12,14,8,8,10,6,11,6,12, and 3.
4)  Print out the result. You should see both the new columns of data you just added.


```r
# your code here
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

For this exercise we will use the same `messi_career` data frame, adding data from 2020.

1)  Make a data frame called thisYear (or similar) and add the following data: Appearances: 19, Goals: 10, Season: 2020, Club: FC Barcelona, Age: 33, Champions league Goals: 3. *hint: Make sure the column names match up (e.g. champLeagueGoal)*
2)  Now, using `rbind()` add the new row of data to your messi_career data frame.
3)  Print the result, you should now see your new row of data!


```r
# your code here
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
## [1] 6 6
```

To get a visual snapshot of our data we can use the `head()` or `tail()` functions. The head function gives you the few rows, and the tail function gives you the last few rows. As the example data is so small we won't see a difference between the functions.


```r
head(exampleDat)
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

To find the structure of our data we use the `str()` command. This function gives us information on the column name, what data type that column is, and some of the data in that column.


```r
str(exampleDat)
```

```
## 'data.frame':	6 obs. of  6 variables:
##  $ string  : chr  "person_1" "person_2" "person_3" "person_4" ...
##  $ integer : num  1 2 3 4 5 6
##  $ number  : num  4 7 2 9 3 5
##  $ factor  : Factor w/ 2 levels "no","yes": 2 2 1 2 1 2
##  $ integer2: num  5 4 3 2 1 0
##  $ string2 : chr  "Control" "Control" "Experiment" "Experiment" ...
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
##    string2         
##  Length:6          
##  Class :character  
##  Mode  :character  
##                    
##                    
## 
```

## Getting information exercise

Use the following commands on the `messi_career` data: `dim()`, `nrow()`, `ncol()`, `head()`, `tail()`, `summary()`, `str()`, and `View()`.


```r
# Your code here
```

# Indexing data frames

When indexing data in R we use square brackets (`[]`). The exact same principle applies to data frames, we can index multiple elements and drop elements.

Data frames have two dimensions in rows and columns, so we need to give indexes for both. The syntax is `data[row index, column index]`, so `data[1,5]` would mean we are indexing the first row and the fifth column.

If you wanted to select all columns or all rows you can leave the column or row index blank. Run the examples below:


```r
exampleDat[3, ]
```

```
##     string integer number factor integer2    string2
## 3 person_3       3      2     no        3 Experiment
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

We can also index the the names of the columns, below are are looking for the column names factor and string2. R will search for the exact match of the string you provide, so it is case sensitive.


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
##     string integer number factor integer2    string2
## 3 person_3       3      2     no        3 Experiment
```

This is conditional indexing, which we will cover more in R fundamentals 6 (conditionals and logic).

We can bring together adding a new column with indexing to do calculations. See the examples below.

In the first example, we make a new column called calculation using the `$` operator..Then we do a calculation with indexing, in this case the *integer* column divided by the *number* column.

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
##     string integer number factor integer2    string2 calculation calculation2
## 1 person_1       1      4    yes        5    Control   0.2500000    0.8333333
## 2 person_2       2      7    yes        4    Control   0.2857143    1.3333333
## 3 person_3       3      2     no        3 Experiment   1.5000000    1.5000000
## 4 person_4       4      9    yes        2 Experiment   0.4444444    1.3333333
## 5 person_5       5      3     no        1 Experiment   1.6666667    0.8333333
## 6 person_6       6      5    yes        0    Control   1.2000000    0.0000000
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
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_eflc2yj4pcryc62?coursename=R Fundamentals 4: Data Frames &topic=R&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Eq8J0o5HZ2hEhHyfOK_Y8PoBqeKPeb-zo52bUZkCsSUfwg?e=izxDVe&prog=DS&version=21-22>

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

