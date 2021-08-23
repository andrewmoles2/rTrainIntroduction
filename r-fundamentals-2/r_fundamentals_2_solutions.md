---
title: "R Fundamentals 2: Vectors, Functions, and Indexing"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "16 August, 2021"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: TRUE
    toc_float: TRUE
---

# What will this workshop cover?

In this workshop, the aim is to cover some basics of using variables and vectors in R. We will be covering:

-   Vectors
-   Introduction to functions
-   Indexing

# Information on how the session is run

One hour exercise based session with tutor support. You will be given example code for a problem, then given a related exercise to complete.

## Why this style?

-   Online training is tiring so keeping the sessions to one hour
-   No or limited demonstrations provided in order to provide more real world experience - you have a problem and you look up how to solve it, adapting example code
-   Trainer support to guide through process of learning

## We will be working in pairs:

-   One shares the screen and the other requests remote control.
-   Take turns on who types for each exercise.
-   Share markdown file at end of session via chat
-   If possible have your camera on when doing the paired work.

## What to do when getting stuck:

1)  Ask your team members
2)  Search online:

-   The answer box on the top of Google's results page
-   stackoverflow.com (for task-specific solutions)
-   <https://www.r-bloggers.com/> (topic based tutorials)

3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

------------------------------------------------------------------------

# Vectors

A vector is a set of information contained together in a specific order.

To make a vector you combine variables using the `c()` function (more on functions later); also known as concatenation. To call the `c()` function we use brackets () with the numbers we want separated by a comma.

The first way of making a vector is to add the arguments you want, numbers in this case.

Run this code chunk to test it out.


```r
vect1 <- c(1,6,19,4,9)
vect1
```

```
## [1]  1  6 19  4  9
```

We can also combine predefined variables and vectors together to create a new vector.


```r
x <- 30
vect2 <- c(vect1, 22, 7, x)
vect2
```

```
## [1]  1  6 19  4  9 22  7 30
```

Another way of making a vector is using the colon (`:`), which can be done without the c function. We can tell R to select a sequence of integers from x to y, or 5 through to 10 in our example.


```r
vect3 <- 5:10
vect3
```

```
## [1]  5  6  7  8  9 10
```

We can also do some basic calculations on vectors. These occur elementwise (one element at a time).


```r
vect3/5
```

```
## [1] 1.0 1.2 1.4 1.6 1.8 2.0
```

As you can see this divides all elements in the vector by 5.

## Vector exercise 1

1)  Make a vector called x with integers from 8 through to 14
2)  Add 5 to your x vector (be sure to save as result back to x)
3)  Make a vector called y with variables 34, 55, 13, 71, 98, 43 and 25
4)  Take 12 from your y vector (be sure to save as result back to y)
5)  Times x vector by y


```r
# your code here
x <- 8:14
x <- x + 5
x
```

```
## [1] 13 14 15 16 17 18 19
```

```r
y <- c(34, 55, 13, 71, 98, 43, 25)
y <- y - 12
y
```

```
## [1] 22 43  1 59 86 31 13
```

```r
x * y
```

```
## [1]  286  602   15  944 1462  558  247
```

# Functions: what are they and how to use them

A function is code organised together to perform a specific task. The function will take in an input, perform a task, then return an output. They are the backbone of R, which comes built in with a wide array of functions.

The **function(input)** format is the fundamental way to call and use a function in R. **function** is the name of the function we are using, **input** is the argument or data we are passing to the function.

For example:


```r
# running times (mins)
runTimes <- c(31, 50, 15, 19, 23, 34, 9)
# mean running time
aveRun <- mean(runTimes)
aveRun
```

```
## [1] 25.85714
```

```r
# tidy up result
aveRun <- round(aveRun, digits = 2)
aveRun
```

```
## [1] 25.86
```

Here we are using the functions `c()` to concatenate, `mean()` calculates the mean, and `round()` rounds to specific decimal places. Notice with the `round()` function we have `digits = 2`, which tells the function to round to two decimal places; this is called a *argument*.

## Functions exercise

We are on a walking exercise plan, where we increase our step count by a thousand each day, starting at 1000 steps and ending on 12000.

1)  Make a variable called steps using the `seq()` function that increases steps from 1000 to 12000 by increments of 500
2)  Workout the sum of how many steps we have done in total from this exercise plan
3)  Workout out the median amount of steps we have done on this exercise plan
4)  Comment your code


```r
# your code here
# steps
steps <- seq(1000, 12000, by = 500)
# total steps
sum(steps)
```

```
## [1] 149500
```

```r
# median steps
median(steps)
```

```
## [1] 6500
```

# Indexing vectors

Indexing is a technical term for accessing elements of a vector. Think of it like selecting books from a book shelf. The vector is your book shelf, the index determines the book, or books you pick from the shelf.

![Designed by macrovector / Freepik](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop2/images/6714.jpg?raw=true){width="30%"}

To index in R you use the square brackets `[]` after you type the name of the vector to index from. You then put the numerical position of the elements you want to index in the square brackets. For example, if I wanted to select the first element from my vector I would do something like `data[1]`; data is my data, and 1 is the element I want to index.

Run the example code chunks to see the results:


```r
someNumbers <- c(4, 26, 11, 15, 18, 9, 3, 1)
# indexing the 6th element
someNumbers[6]
```

```
## [1] 9
```

Indexing elements 1 to 4


```r
someNumbers[1:4]
```

```
## [1]  4 26 11 15
```

Dropping elements 5 to 7


```r
someNumbers[-5:-7]
```

```
## [1]  4 26 11 15  1
```

Indexing 1, 5, and 8


```r
someNumbers[c(1,5,8)]
```

```
## [1]  4 18  1
```

## Indexing exercise 1

You've been keeping track of how much coffee you drink each day for a two week period. We want to split this into week 1 and 2. Using the code below follow the following steps:

1)  Find out the mean for weekOne and WeekTwo vectors.
2)  `mean` doesn't work for weekTwo and gives back `NA`. Print your weekTwo vector to look at the data.
3)  Check the length of your weekTwo vector by running the `length()` function on the weekTwo vector.
4)  There are a few ways ways to fix this, try and find at least two different ways.

*hint: the mean() function has an argument called na.rm, type and run ?mean() to look at the help page*


```r
# vector with n coffee per day for two weeks
coffee <- c(3, 5, 4, 2, 3, 1, 1, 6, 2, 3, 2, 4, 2, 1)

# weeks
weekOne <- coffee[1:7]
weekTwo <- coffee[8:15]

# your code here
# mean coffee per week
mean(weekOne)
```

```
## [1] 2.714286
```

```r
mean(weekTwo)
```

```
## [1] NA
```

```r
# fixing week two
length(weekTwo)
```

```
## [1] 8
```

```r
length(coffee)/2
```

```
## [1] 7
```

```r
# option 1
mean(weekTwo, na.rm = TRUE)
```

```
## [1] 2.857143
```

```r
# option 2
mean(weekTwo[-8])
```

```
## [1] 2.857143
```

```r
# option 3
weekTwo <- weekTwo[-8]
mean(weekTwo)
```

```
## [1] 2.857143
```

# Using indexing to change values

Using indexing you can change the value of an item, or multiple items, in a vector. This is very useful if you spot a data error and want to fix it in the code. We will using similar principles in later sessions.

This is a combination of what we have learned so far, with reassigning data to variables/vectors and indexing. For example, `data[1] <- 5` means we take the first element (or data point) from data, and assign the number 5 as a replacement.

Run the code below to see the example:


```r
someNumbers <- c(4, 26, 11, 15, 18, 9, 3, 1)
someNumbers
```

```
## [1]  4 26 11 15 18  9  3  1
```

```r
# Change one item
someNumbers[8] <- 50
someNumbers
```

```
## [1]  4 26 11 15 18  9  3 50
```

```r
# Change multiple
someNumbers[1:3] <- c(19, 20, 21)
someNumbers
```

```
## [1] 19 20 21 15 18  9  3 50
```

In the first change, we changed the 8th element of the someNumbers data to 50 (it was 1 previously). In the second change, we changed the first, second and third elements to 19, 20, and 21 (changing from 4, 26, 11).

## Indexing exercise 2

You decided to track your total monthly expenditures for the year to find out more about your monthly spending. You're interested in your spending per quarter, biggest spending month, and lowest spending month.

1)  Make a variable called myExpenses with the following data: 976, 631, 1231, 1120, 1374, 873, 1244, 1398, 989, 1034, 579 and 1506. Each item represents each month, first is January spending, second is February spending etc.
2)  You realise the spending for some of the months is wrong. January should be 921, August should be 1419, and November should be 703. Use indexing to change the values in myExpenses so they are correct.\
3)  Using indexing make a vector for the first quarter of the year. Call it Q1 and make sure the first three months are indexed.
4)  Repeat for quarters 2, 3, and 4.
5)  Workout the average spending for each quarter. Which had the biggest spending?
6)  Using the `which.max()` and `which.min()` functions on your myExpenses vector, find out which months had the highest and lowest spending. Assign the result of each to a variable (minSpend, maxSpend).
7)  Now you know the highest and lowest spending months, put them into a vector together called MaxMin by indexing from the myExpenses vector.


```r
# enter your code here
myExpenses <- c(976, 631, 1231, 1120, 1374, 873, 1244, 1398, 989, 1034, 579 ,1506)
# change jan, aug, and nov
myExpenses[c(1,8,11)] <- c(921, 1419, 703)
# spending per quarter
Q1 <- myExpenses[1:3]
Q2 <- myExpenses[4:6]
Q3 <- myExpenses[7:9]
Q4 <- myExpenses[10:12]
# mean spend per quarter
mean(Q1)
```

```
## [1] 927.6667
```

```r
mean(Q2)
```

```
## [1] 1122.333
```

```r
mean(Q3)
```

```
## [1] 1217.333
```

```r
mean(Q4)
```

```
## [1] 1081
```

```r
# highest and lowest spending
minSpend <- which.min(myExpenses)
maxSpend <- which.max(myExpenses)
# totals
MaxMin <- myExpenses[c(minSpend, maxSpend)]
MaxMin
```

```
## [1]  631 1506
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_77M35cq1arxNcj3?course=D046-R2VFI&topic=R&cohort=LT21>

# Individual coding challenge 1

You decide to calculate your commuting times over a weekly period. You decide to see if you can workout, based off your weekly commute, how much commuting you will do on average this month.

1)  Replicate the commute variable four times using `rep()` and assign to a variable called commute_est.
2)  Calculate the mean of commute_est and assign to a variable called aveCommute.
3)  Round the value of aveCommute to two decimal places using `round()` and assign to aveCommute.
4)  You miss timed your Tuesday commute, it should be 37 instead of 33. To make replacement easier use `sort()` on commute_est, and assign to a variable called commute_sort.
5)  Replace the 33 values with 37 using indexing in the variable commute_sort.
6)  Re-calculate and round aveCommute as per instructions two and three.
7)  Test out the following functions on the commute_sort variable: `unique()` and `sort(commute, decreasing = TRUE)`.


```r
commute <- c(41, 33, 44, 52, 36, 39)
# enter your code here
# replicate
commute_est <- rep(commute, 4)
# average commute
aveCommute <- mean(commute_est)
aveCommute <- round(aveCommute, digits = 2)
aveCommute
```

```
## [1] 40.83
```

```r
# sorting
commute_sort <- sort(commute_est)
commute_sort
```

```
##  [1] 33 33 33 33 36 36 36 36 39 39 39 39 41 41 41 41 44 44 44 44 52 52 52 52
```

```r
commute_sort[1:4] <- 37
# running ave again
aveCommute <- mean(commute_sort)
aveCommute
```

```
## [1] 41.5
```

```r
# testing functions
unique(commute_est)
```

```
## [1] 41 33 44 52 36 39
```

```r
sort(commute_est, decreasing = TRUE)
```

```
##  [1] 52 52 52 52 44 44 44 44 41 41 41 41 39 39 39 39 36 36 36 36 33 33 33 33
```

# Individual coding challenge 2

For this individual coding challenge we will be looking at Lional Messi's season appearances and goals from 2004-2020.

The code below has been jumbled up and will not run. Your challenge is to re-order it so it runs correctly. It should print out summary statistics for season goal ratio and age band goal ratios, as well as which year was his most and least prolific, and how many years that took him.


```r
# add in appearance, goal and season data
appearances <- c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44)
goals <- c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31)
season <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019)

# work out appearance to goal ratio per season and total career ratio
goalRatio <- round(appearances/goals, digits = 2)
careerGoalRatio <- round(sum(appearances)/sum(goals), digits = 2)

# goal ratio per age band (teenager, 20's, 30's)
teenageGoalRatio <- goalRatio[1:3]
twentiesGoalRatio <- goalRatio[4:13]
thirtiesGoalRatio <- goalRatio[14:16]

# combine age band ratios to a vector
ageGoalRatio <- c(round(mean(teenageGoalRatio), digits = 2), 
              round(mean(twentiesGoalRatio), digits = 2),
              round(mean(thirtiesGoalRatio), digits = 2))

# which season had the worst goal ratio
season[which.max(goalRatio)]
```

```
## [1] 2004
```

```r
# which season had the best goal ratio
season[which.min(goalRatio)]
```

```
## [1] 2011
```

```r
# summary results
summary(goalRatio)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.820   0.980   1.165   1.860   1.595   9.000
```

```r
summary(ageGoalRatio)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   1.190   1.195   1.200   2.380   2.975   4.750
```

```r
# how many years playing to reach best goal ratio
season[which.min(goalRatio)] - season[1]
```

```
## [1] 7
```

```r
# print career ratio
careerGoalRatio
```

```
## [1] 1.15
```