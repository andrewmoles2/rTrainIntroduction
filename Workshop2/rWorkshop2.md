---
title: "R Workshop 2 - Vectors and Strings"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "26 August, 2020"
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

A vector is a set of information contained together in a specific order. 

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
4)  Take 12 from your y vector (be sure to save as result back to x)
5)  Times x vector by y

***

# Functions: what are they and how to use them

A function is code organised together to perform a specific task. The function will take in an input, perform a task, then return an output. They are the backbone of R, which comes built in with a wide array of functions.  

The **function(input)** format the fundamental way to call and use a function in R. **function** is the name of the function we are using, **input** is the argument or data we are passing to the function. 

For example:

```r
# running times (mins)
runTimes <- c(31, 50, 15, 19, 23, 34, 9)
# mean running time
meanRun <- mean(runTimes)
meanRun
```

```
## [1] 25.85714
```

```r
# tidy up result
meanRun <- round(meanRun, digits = 2)
# print nice result
paste0("Your mean running time is: ", meanRun, " minutes")
```

```
## [1] "Your mean running time is: 25.86 minutes"
```
Here we are using the functions `c`, `round`, `mean`, and `paste0`. We will be using these in our exercises today. 

## Functions exercise

We are on a walking exercise plan, where we increase our step count by a thousand each day, starting at 1000 steps and ending on 12000.

1)  Make a variable called steps using the seq function that increases steps from 1000 to 12000 by increments of 1000
2)  Workout how many steps we have done in total from this exercise plan
3)  Workout out the median amount of steps we have done on this exercise plan
4)  Comment your code


```r
# enter your code here
```



# Indexing vectors

Indexing is a technical term for accessing elements of a vector. 

To index in R you use the square brackets [] after you type the name of the vector to index from. You then put the elements you want to index in the square brackets.

Some examples:

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
If you try and index outside of the vectors range you get an NA. A way of checking is using the `length` function. Our vector has 8 elements, but we tried to call a 9th. 

```r
someNumbers[9]
```

```
## [1] NA
```

```r
length(someNumbers)
```

```
## [1] 8
```

## Indexing exercise
You decided to track your total monthly expenditures for the year to find out more about your monthly spending. Such as spending per quarter, biggest spending month, and lowest spending month.

1)  Make a variable called myExpenses with the following data: 976, 631, 1231, 1120, 1374, 873, 1244, 1398, 989, 1034, 579 and 1506
2)  Using indexing make a vector for the first quarter of the year. Call it Q1 and make sure the first three months are indexed.
3)  Repeat for quarters 2, 3, and 4.
4)  Workout the average spending for each quarter. Which had the biggest spending?
5)  Using the `which.max()` and `which.min()` functions, find out which months had the highest and lowest spending.
6)  Now you know the highest and lowest spending months, put them into a vector together called MaxMin by indexing from the myExpenses vector. 


```r
# enter your code here
```





# Strings

# String manipulation

## Exercise

Using random sampling (sample) and number generation to make vectors, to then make calculations


```r
runif(10, min = 0, max = 30)
```

```
##  [1]  9.818510 18.709852 19.962914  6.182038 19.009324  4.086289  9.452294
##  [8] 26.936797 22.515414 22.354843
```

```r
distrib <- c(1:50)
sample(distrib, 25)
```

```
##  [1] 20 25  2 47 12  1 19 46  7  8 41  9 44 49 11  4 40 33 22 34  5 42 48 13 32
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

## Vector exercise 3
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
