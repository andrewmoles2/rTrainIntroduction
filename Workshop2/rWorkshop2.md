---
title: "R Workshop 2 - Vectors, functions, and indexing"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "04 March, 2021"
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

*  Vectors
*  Introduction to functions
*  Indexing

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
Another way of making a vector is using the colon (:), which can be done without the c function. We can tell R to select a sequence of integers from x to y, or 5 through to 10 in our example.

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
```

# Functions: what are they and how to use them

A function is code organised together to perform a specific task. The function will take in an input, perform a task, then return an output. They are the backbone of R, which comes built in with a wide array of functions.  

The **function(input)** format the fundamental way to call and use a function in R. **function** is the name of the function we are using, **input** is the argument or data we are passing to the function. 

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
Here we are using the functions `c()` to concatenate, `round()` rounds to specific decimal places, and `mean()` calculates the mean.

## Functions exercise

We are on a walking exercise plan, where we increase our step count by a thousand each day, starting at 1000 steps and ending on 12000.

1)  Make a variable called steps using the `seq()` function that increases steps from 1000 to 12000 by increments of 500
2)  Workout how many steps we have done in total from this exercise plan
3)  Workout out the median amount of steps we have done on this exercise plan
4)  Comment your code


```r
# your code here
```

# Indexing vectors

Indexing is a technical term for accessing elements of a vector. Think of it like selecting books from a book shelf. The vector is your book shelf, the index determines the book, or books you pick from the shelf.

![Designed by macrovector / Freepik](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop2/images/6714.jpg?raw=true){width=30%}

To index in R you use the square brackets [] after you type the name of the vector to index from. You then put the elements you want to index in the square brackets.

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
2)  `mean` doesn't work for weekTwo. There are two ways to fix this; one using indexing and the other adding an argument to mean. Work out both and add them to the code. Hint: `?mean()` gives you a help page in R. 
3)  Calling incorrect indexes can happen. To check the length of vector try running the `length()` function on the coffee vector.


```r
# vector with n coffee per day for two weeks
coffee <- c(3, 5, 4, 2, 3, 1, 1, 6, 2, 3, 2, 4, 2, 1)

# weeks
weekOne <- coffee[1:7]
weekTwo <- coffee[8:15]
```

# Using indexing to change values
Using indexing you can change the value of an item, or multiple items, in a vector. This is very useful if you spot a data error and want to fix it in the code. We will using similar principles in later sessions.

Run the code below to see the example:

```r
someNumbers <- c(4, 26, 11, 15, 18, 9, 3, 1)
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

## Indexing exercise 2
You decided to track your total monthly expenditures for the year to find out more about your monthly spending. You're interested in your spending per quarter, biggest spending month, and lowest spending month.

1)  Make a variable called myExpenses with the following data: 976, 631, 1231, 1120, 1374, 873, 1244, 1398, 989, 1034, 579 and 1506. Each item represents each month, first is January spending, second is February spending etc.
2)  You realise the spending for some of the months is wrong. January should be 921, August should be 1419, and November should be 703. Use indexing to change the values in myExpenses so they are correct.  
3)  Using indexing make a vector for the first quarter of the year. Call it Q1 and make sure the first three months are indexed.
4)  Repeat for quarters 2, 3, and 4.
5)  Workout the average spending for each quarter. Which had the biggest spending?
6)  Using the `which.max()` and `which.min()` functions, find out which months had the highest and lowest spending. Assign the result of each to a variable (minSpend, maxSpend).
7)  Now you know the highest and lowest spending months, put them into a vector together called MaxMin by indexing from the myExpenses vector. 


```r
# enter your code here
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_77M35cq1arxNcj3?course=D046-R2VFI&topic=R&cohort=LT21&link=https://lsecloud.sharepoint.com/:u:/s/TEAM_APD-DSL-Digital-Skills-Trainers/EVNFGAtJwIlKje6Q0JS8EGwBB6v-RfIlC5X4ADXzGJEq4w?e=GcjfyO

The solutions will be available from a link at the end of the survey.

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
```

# Individual coding challenge 2

For this individual coding challenge we will be looking at Lional Messi's season appearances and goals from 2004-2020. 

The code below has been jumbled up and will not run. Your challenge is to re-order it so it runs correctly. It should print out summary statistics for season goal ratio and age band goal ratios, as well as which year was his most and least prolific, and how many years that took him. 


```r
# print career ratio
careerGoalRatio

# which season had the worst goal ratio
season[which.max(goalRatio)]

# combine age band ratios to a vector
ageGoalRatio <- c(round(mean(teenageGoalRatio), digits = 2), 
              round(mean(twentiesGoalRatio), digits = 2),
              round(mean(thirtiesGoalRatio), digits = 2))

# add in appearance, goal and season data
appearances <- c(9,25,36,40,51,53,55,60,50,46,57,49,52,54,50,44)
goals <- c(1,8,17,16,38,47,53,73,60,41,58,41,54,45,51,31)
season <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,
            2013,2014,2015,2016,2017,2018,2019)

# which season had the best goal ratio
season[which.min(goalRatio)]

# goal ratio per age band (teenager, 20's, 30's)
teenageGoalRatio <- goalRatio[1:3]
twentiesGoalRatio <- goalRatio[4:13]
thirtiesGoalRatio <- goalRatio[14:16]

# summary results
summary(goalRatio)
summary(ageGoalRatio)

# how many years playing to reach best goal ratio
season[which.min(goalRatio)] - season[1]

# work out appearance to goal ratio per season and total career ratio
goalRatio <- round(appearances/goals, digits = 2)
careerGoalRatio <- round(sum(appearances)/sum(goals), digits = 2)
```

