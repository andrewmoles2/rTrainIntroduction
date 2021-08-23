---
title: "R Fundamentals 1: Numerical Variables"
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

The goal of this session is to get to started using RStudio, learn how to use variables and solve basic calculations in R. We will cover:

*  Introduction to RStudio
*  Using r as a calculator
*  Assigning variables
*  Numerical variables

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


# Why R 

R is a popular language, especially in data science, this can be seen in the TIOBE Index for August 2020. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop1/Images/tiobe-index.png?raw=true)

It has lots of strengths:

*  Excellent at handling data
*  Very good for statistics
*  Open source
*  You can do almost anything in R due to community written 'packages'
*  Makes pretty and complex data visualisations (see below)

![](https://github.com/andrewmoles2/TidyTuesday/blob/master/Australia-fires-2020-01-07/Auz_Rain&Temp.gif?raw=true)

***

# Introduction to RStudio

RStudio by default has four main quadrants as shown below. The layout is customisable, as is the background. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop1/Images/rstudioEnv.png?raw=true)

When you load RStudio the syntax editor will not be open. Try and open one just like as shown below.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop1/Images/scripts.png?raw=true)

# Using R markdown

For these workshops we will be using R Markdown. It allows you to have text (with simple formatting) and chunks of R code.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop1/Images/RMarkdown.png?raw=true)

To run code in a code chunk either press the green play button or press Ctrl + Enter (or Cmd + Enter on Mac). 

***

# Using R as a calculator

We can use R to do simple or advanced calculations for us. Remember to run the code press the green play button or press Ctrl + Enter (or Cmd + Enter on Mac).


```r
7 * 6
```

```
## [1] 42
```

```r
5 / (2^2)
```

```
## [1] 1.25
```

```r
(16 - 4) + (1 * 9)
```

```
## [1] 21
```

## R as calculator exercise

Use R to work out the following arithmetic:

1)  44 * 26
2)  9.6/1.6
3)  (12+4)^2
4)  (4*9)/(5+6)
5)  (22/36) * 100
6)  The remainder of 55 / 2 (hint: look up r's modulus operator)


```r
# type your code here
44 * 26
```

```
## [1] 1144
```

```r
9.6 / 1.6
```

```
## [1] 6
```

```r
(12 + 4)^2
```

```
## [1] 256
```

```r
(4 * 9)/(5 + 6)
```

```
## [1] 3.272727
```

```r
(22 / 36) * 100
```

```
## [1] 61.11111
```

```r
55%%2
```

```
## [1] 1
```

# Assigning variables

A variable is a named storage of information. In our case today we are storing numbers. 

We can assign variables by using <-. You should see the variable appear to your right in the global environment once you've run this command (under Values). 

```r
height <- 155
```
We can then print the output of the variable by typing in its name. 

```r
height
```

```
## [1] 155
```

When calling a variable, be careful to type it exactly (you can also copy it or use code completion to help). The code below will give you an error because we have spelt height incorrectly. 


```r
hieght
```

```
## Error in eval(expr, envir, enclos): object 'hieght' not found
```

We can do calculations on variables. We first assign the variables, then use them in the calculation. 

In the example below, Score1 is 42, Score2 is 92 and so on. If we calculate Score1 * Score2 what is really happening is 42 * 92, as this is the data scored in those variables. Run the code, and review the output as well as the variables we have made in the global environment (top right panel in RStudio). 

```r
# test scores
Score1 <- 42
Score2 <- 92
Score3 <- 68
# average score calculation
AveScore <- (Score1+Score2+Score3)/3
# print average score
AveScore
```

```
## [1] 67.33333
```

You will have noticed the hashtags (#) with text in the above example. These are called comments. In later R sessions we will use a lot of comments to tell us (and others) what each line or section of code is doing.


```r
# this is a comment
```

## Assigning variables exercise 1

1) Make a variable called my_height, and assign your height in cm (this can be an estimate if you are not sure) 
2) Print the output of my_height 
3) Convert your height in cm to feet. Make a new variable called my_height_feet, and assign the calculation of your height in cm to feet. *hint: there are 0.0328084 feet in 1 cm*
4) Print your my_height_feet variable 


```r
# your code here
my_height <- 195
my_height
```

```
## [1] 195
```

```r
my_height_feet <-  my_height * 0.0328084
my_height_feet
```

```
## [1] 6.397638
```

# Reassigning variables

You can also change the value of a variable you have already assigned. Here we are going to add our new pay check to our previous bank balance. 

*Run this code to test it out:*

```r
# create variables
BankBalance <- 100
PayCheck <- 250
# add old bank balance and pay check, assigning result to bank balance
BankBalance <- BankBalance + PayCheck
# print bank balance
BankBalance
```

```
## [1] 350
```

Note that if you run `BankBalance <- BankBalance + PayCheck` line of code twice you will get a higher bank balance (600 rather than 350). This is because code works sequentially in R and the order you run commands matters. See the example below on what happens if we repeat adding numbers to a total. 


```r
# variables
number <- 5
total <- 0
# adding number to total
total <- total + number
total
```

```
## [1] 5
```

```r
total <- total + number
total
```

```
## [1] 10
```

```r
total <- total + number
total
```

```
## [1] 15
```

## Reassigning variables exercise

Try and add another pay check of £50 to the bank balance variable.

1)  Make a variable called PayCheck2 with a value of 50
2)  Assign BankBalance, and calculate BankBalance + PayCheck2
3)  Print the outcome
4)  You go out for dinner with friends and spend 36.55. Make a variable called dinner with the value of 36.55
5)  Assign BankBalance, and calculate BankBalance - dinner
6)  Print the outcome
*hint: if this doesn't work run the code chunk with the bank balance variable*

```r
# your code here
PayCheck2 <- 50
BankBalance <- BankBalance + PayCheck2
BankBalance
```

```
## [1] 400
```

```r
dinner <- 36.55
BankBalance <- BankBalance - dinner
BankBalance
```

```
## [1] 363.45
```

## Assigning variables exercise 2

Use R to work out a body mass index (BMI) of someone who is 79kg, and 1.77m tall.

1)  Assign the variables of weight and height
2)  Assign the variable of BMI, and calculate the BMI based of the weight and height variables
3)  Print the outcome
4)  Add comments on what each line of code is doing


```r
# Exercise: BMI calculation
# assign variables of weight and height
weight <- 79
height <- 1.77

# BMI calculation
BMI <- weight/(height^2)

# print outcome
BMI
```

```
## [1] 25.21625
```

## Overall grade calculation debugging exercise

Debug the code below that is finding the weighted average of a students coursework and exam scores. You should find three errors:

*  logic (maths) error
*  syntax error
*  naming error


```r
# Exercise: weighted average debugging
exam1 <- 52
coursework1 <- 82
exam2 <- 78
coursework2 <- 48 # assignment operator missing - (should be <-)

cw_weight <- 0.4
ex_weight <- 0.6

course1 <- (exam1 * ex_weight) + (coursework1 * cw_weight) # variable is coursework1
course2 <- (exam2 * ex_weight) + (coursework2 * cw_weight)

overall_grade <- (course1 + course2)/2 # should be divided by 2, as there are two courses not three

overall_grade
```

```
## [1] 65
```

## Salary calculation exercise

Robin and Charlie are a married couple, one gets paid an hourly rate, the other has an annual salary. They want to workout how much annual salary they have combined before tax. Out of interest Charlie also wants to know what her hourly rate is before tax. 

They used simple calculations using the following formulas:  

(number hours worked per week x hourly rate) x number of weeks worked = annual salary
(annual salary ÷ number of weeks in a year) ÷ hours worked per week = hourly rate

Re-arrange the code so the calculations run. You should have both the combined salary and Charlies hourly rate calculations printed. 


```r
# Note: Hours worked, salaries and weeks in year can be in any order but need
# to be above the rest of the code

# hours worked
Robin_hoursPerWeek <- 25
Robin_weeksWorking <- 48
Charlie_hoursPerWeek <- 35

# salaries
Robin_HourlyRate <- 16.5
Charlie_annualSary <- 31800

# weeks in year
weeksYear <- 52

# Charlies hourly rate
Charlie_HourlyRate <- (Charlie_annualSary / weeksYear)/Charlie_hoursPerWeek
Charlie_HourlyRate

# Robins annual salary
Robin_annualSalary <- (Robin_hoursPerWeek * Robin_HourlyRate) * Robin_weeksWorking
Robin_annualSalary

# Combined salaries
CombinedSalaries <- Robin_annualSalary + Charlie_annualSary
CombinedSalaries
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_77M35cq1arxNcj3?course=D025-R1NV&topic=R&cohort=LT21

# Individual coding challenge

A take home coding task for you.

Task: Splitting a Pizza Pilgrims restaurant bill between 3 friends; Roger, Amal and Genevieve.

*  Roger has a Calzone Ripieno (£11), and a San Pellegrino (£2).
*  Amal has a Bufala (£9), and Birra Moretti (£4.50).
*  Genevieve has a Portobello Mushroom & Truffle (£10), and water to drink.
*  Genevieve and Amal also share a Nutella Pizza ring for dessert (£5.5). 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop1/Images/pizzaP.jpg?raw=true)


1)  Make a variable for each friend that is the sum of their order (e.g. Roger would be 11 + 2)
2)  Make a variable for the shared food
3)  Make a variable called TotalBill, and calculate their total bill
4)  For those that shared food, add the shared food to their bill
5)  Comment your code
6)  Print the total bill and what each friend owes


```r
# individual coding challenge

# sum of order and shared food
Roger <- 11 + 2
Amal <- 9 + 4.5
Genevieve <- 10
SharedFood <- 5.5

# bill total
TotalBill <- Roger + Amal + Genevieve + SharedFood

# shared food sum
Amal <- Amal + (SharedFood/2)
Genevieve <- Genevieve + (SharedFood/2)

# total bill
TotalBill
```

```
## [1] 42
```

```r
# individual bill
Roger
```

```
## [1] 13
```

```r
Amal
```

```
## [1] 16.25
```

```r
Genevieve
```

```
## [1] 12.75
```


# Recommended links
Recommended for more information on the RStudio environment: https://rladiessydney.org/courses/ryouwithme/01-basicbasics-1/  
Recommended for more information on using R Markdown: https://rmarkdown.rstudio.com/lesson-1.html 