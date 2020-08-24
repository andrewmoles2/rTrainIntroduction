---
title: "R Workshop 2 - Vectors and Strings"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "24 August, 2020"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What will this workshop cover?

In this workshop, the aim is to cover some basics of using variables and vectors in R, as well as a start on using strings. We will be covering:

*  Vectors
*  Introduction to functions
*  Indexing
*  Strings
*  String manipulation with Paste, gsub and grep

**Note to self: move packages to next workshop, just cover how to use functions here. Also move lists back and cover basic vector indexing (which can be more in depth later with data frames)**

# Information on how the session is run

We will be working in pairs:

*  Take turns sharing the screen.
*  Take turns on who types for each exercise.
*  Whoever was typing, share your code in the chat with your teammate. 

What to do when getting stuck:

1)  Ask your team members
2)  Search online:
  *  The answer box on the top of Google's results page 
  *  stackoverflow.com (for task-specific solutions)
  *  https://www.r-bloggers.com/ (topic based tutorials)
3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

**To get feedback**: hand in your R markdown exercise file in the assignment on the Teams channel for the R 1 workshop.

***

# Vectors

A vector is collection of information stored in a variable...This allows us to store multiple arguments in one vector.

To make a vector you combine variables using the **c** function (more on functions later); also known as concatenation. To call the **c** function we use brackets () with the numbers we want separated by a comma.  

The first way of making a vector is to add the arguments (numbers) you want.

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
Another way of making a vector is using the colon (:), which can be done without the c function. We can tell R to select numbers from x to y, or 5 through to 10 in our example.

```r
vect3 <- 5:10
vect3
```

```
## [1]  5  6  7  8  9 10
```
We can also do some basic calculations on vectors.

```r
vect3/5
```

```
## [1] 1.0 1.2 1.4 1.6 1.8 2.0
```
As you can see this divides all elements in the vector by 5.

## Vector exercise 1

1)  Make a vector called x from 8 through to 14
2)  Add 5 to your x vector (be sure to save as result back to x)
3)  Make a vector called y with variables 34, 55, 13, 71, 98, 43 and 25 
4)  Take 12 from your y vector (be sure to save as result back to x)
5)  Times x vector by y


## Vector exercise 2
If you attended the first R workshop you might remember we calculated a students weighted average grade. Convert this to incorporate 10 students instead of just the one. 

1)  Assign exam1 grades as 52, 62, 55, 82, 48, 65, 68, 62, 65 and 65
2)  Assign coursework1 grades as 72, 72, 85, 52, 78, 62, 65, 52, 55 and 68
3)  Assign exam2 grades as 62, 72, 58, 52, 68, 75, 62, 65, 62 and 88
4)  Assign coursework2 grades as 72, 62, 65, 62, 78, 45, 78, 65, 55 and 75
5)  Make cw_weight 0.4 and ex_weight 0.6
6)  Calculate the weighted average of course 1, assigning the result to course1. Do the same for course2
7)  Calculate the average grade of both courses, and assign to overall_grade
8)  Print your result
9)  Add comments

```r
exam1 <- c(52, 62, 55, 82, 48, 65, 68, 62, 65, 65)
coursework1 <- c(72, 72, 85, 52, 78, 62, 65, 52, 55, 68)
exam2 <- c(62, 72, 58, 52, 68, 75, 62, 65, 62, 88)
coursework2 <- c(72, 62, 65, 62, 78, 45, 78, 65, 55, 75)

cw_weight <- 0.4
ex_weight <- 0.6

course1 <- (exam1 * ex_weight) + (coursework1 * cw_weight)
course2 <- (exam2 * ex_weight) + (coursework2 * cw_weight)

overall_grade <- (course1 + course2)/2
overall_grade
```

```
##  [1] 63.0 67.0 63.9 63.0 66.0 63.4 67.6 61.5 60.1 74.5
```

***

# Functions: what are they and how to use them

Functions are....

The *function(value1, value2)* format the fundamental way to call and use a function in R.

Introduce mean and sum

For example, in the last workshop we manually calculated an average grade.

```r
grade1 <- 61
grade2 <- 73
?c
OverallGrade <- (grade1+grade2)/2
OverallGrade
```

```
## [1] 67
```

The *(grade1+grade2)/2* part can be wrapped in a function which we can repeatedly use. Lucky for us, R comes with lots of functions built in.

```r
grade1 <- 61
grade2 <- 73

OverallGrade <- mean(grade1, grade2)
OverallGrade
```

```
## [1] 61
```

## Vector exercise 2

 For example, our average steps for the week.

```r
# Our steps this week
steps <- c(6000, 1200, 1500, 5000, 9000, 15000, 5500)

sum(steps)/7
```

```
## [1] 6171.429
```

```r
# calculate weekly average
WeekAveSteps <- steps/7
mean(steps)
```

```
## [1] 6171.429
```

```r
WeekAveSteps
```

```
## [1]  857.1429  171.4286  214.2857  714.2857 1285.7143 2142.8571  785.7143
```

## Exercise

Using random sampling (sample) and number generation to make vectors, to then make calculations


```r
runif(10, min = 0, max = 30)
```

```
##  [1] 28.112560  3.234434 11.422847  7.176187 26.504383 21.317686 26.578802
##  [8] 11.695271 21.562490 25.074103
```

```r
distrib <- c(1:50)
sample(distrib, 25)
```

```
##  [1] 47 30 42  4 12 16  5  8 44 38 14 22 35 36 40 19  6 37 39  1  3 45 49 29 24
```

Get them to look up rep and seq functions (homework?)

```r
rep(1:2, 5)
```

```
##  [1] 1 2 1 2 1 2 1 2 1 2
```

```r
seq(1, 20, by = 2)
```

```
##  [1]  1  3  5  7  9 11 13 15 17 19
```

