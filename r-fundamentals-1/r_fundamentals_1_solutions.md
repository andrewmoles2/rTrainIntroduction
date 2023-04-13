---
title: "R Fundamentals 1: Numerical Variables"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "17 March, 2023"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: true
    toc_float: 
      collapsed: false
---

# Objective of workshop

To get acquainted with R and RStudio, and do calculations using R.

# What will this workshop cover?

The goal of this session is to get started using RStudio, learn how to use variables and solve basic calculations in R. We will cover:

-   Introduction to RStudio
-   Using r as a calculator
-   Assigning variables
-   Numerical variables

------------------------------------------------------------------------

# Using R as a calculator

We can use R to do simple or advanced calculations for us. Remember to run the code by pressing the green play button or Ctrl + Enter (or Cmd + Enter on Mac).


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

1)  `44 * 26`
2)  `9.6/1.6`
3)  `(12+4)^2`
4)  `(4*9)/(5+6)`
5)  `(22/36) * 100`
6)  The remainder of `55 / 2` (hint: look up r's modulus operator)


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

A variable is named storage of information. In our case today we are storing numbers.

We can assign variables by using `<-`. You should see the variable appear to your right in the global environment once you've run this command (under Values).


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

We can do calculations on variables. We first assign the variables and, then use them in the calculation.

In the example below, Score1 is 42, Score2 is 92 and so on. If we calculate `Score1 * Score2` what is really happening is `42 * 92`, as this is the data scored in those variables. Run the code, and review the output as well as the variables we have made in the global environment (top right panel in RStudio).


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

You will have noticed the hashtags (`#`) with text in the above example. These are called comments. In later R sessions we will use a lot of comments to tell us (and others) what each line or section of code is doing.


```r
# this is a comment
```

## Assigning variables exercise 1

1)  Make a variable called my_height, and assign your height in cm (this can be an estimate if you are not sure)
2)  Print the output of my_height
3)  Convert your height in cm to feet. Make a new variable called my_height_feet, and assign the calculation of your height in cm to feet. *hint: there are 0.0328084 feet in 1 cm*
4)  Print your my_height_feet variable


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

You can also change the value of a variable you have already assigned. Here we are going to sum our new paycheck with our previous bank balance.

*Run this code to test it out:*


```r
# create variables
BankBalance <- 100
PayCheck <- 250
# sum old bank balance and pay check, assigning result to bank balance
BankBalance <- BankBalance + PayCheck
# print bank balance
BankBalance
```

```
## [1] 350
```

Note that if you run the `BankBalance <- BankBalance + PayCheck` line of code twice you will get a higher bank balance (600 rather than 350). This is because code works sequentially in R and the order you run commands matters. See the example below on what happens if we repeat adding numbers to a total.


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

Try and sum another paycheck of £50 with the bank balance variable.

1)  Make a variable called PayCheck2 with a value of 50
2)  Assign BankBalance, and calculate BankBalance + PayCheck2
3)  Print the outcome
4)  You go out for dinner with friends and spend 36.55. Make a variable called dinner with the value of 36.55
5)  Assign BankBalance, and calculate BankBalance - dinner
6)  Print the outcome *hint: if this doesn't work run the code chunk with the bank balance variable*


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

Use R to work out the body mass index (BMI) of someone who is 79kg, and 1.77m tall.

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

Debug the code below that is finding the weighted average of a student's coursework and exam scores. You should find three errors:

-   logic (maths) error
-   syntax error
-   naming error


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

Robin and Charlie are a married couple, one gets paid an hourly rate, and the other has an annual salary. They want to workout how much annual salary they have combined before tax. Out of interest Charlie also wants to know what her hourly rate is before tax.

They used simple calculations using the following formulas:

(number hours worked per week x hourly rate) x number of weeks worked = annual salary (annual salary ÷ number of weeks in a year) ÷ hours worked per week = hourly rate

Re-arrange the code so the calculations run. You should have both the combined salary and Charlie's hourly rate calculations printed.


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

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

[https://lse.eu.qualtrics.com/jfe/form/SV_ewXuHQ1nRnurTdY?coursename=R%Fundamentals%1:%Numerical%Variables&topic=R&prog=DS&version=22-23&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Emxx38xoB5FPvabJPeYBPrsBG7sNbQ5NANkCTRnPVPKtbg?e=MCYCbp](https://lse.eu.qualtrics.com/jfe/form/SV_ewXuHQ1nRnurTdY?coursename=R%Fundamentals%1:%Numerical%Variables&topic=R&prog=DS&version=22-23&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Emxx38xoB5FPvabJPeYBPrsBG7sNbQ5NANkCTRnPVPKtbg?e=MCYCbp){.uri}

# Individual coding challenge

A take-home coding task for you.

Task: Splitting a Pizza Pilgrims restaurant bill between 3 friends; Roger, Amal and Genevieve.

-   Roger has a Calzone Ripieno (£11), and a San Pellegrino (£2).
-   Amal has a Bufala (£9), and Birra Moretti (£4.50).
-   Genevieve has a Portobello Mushroom & Truffle (£10), and water to drink.
-   Genevieve and Amal also share a Nutella Pizza ring for dessert (£5.5).

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-fundamentals-1/Images/pizzaP.jpg?raw=true)

1)  Make a variable for each friend that is the sum of their order (e.g. Roger would be 11 + 2)
2)  Make a variable for the shared food
3)  Make a variable called TotalBill, and calculate their total bill
4)  For those that shared food, sum the shared food with their bill
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

Recommended for more information on the RStudio environment: <https://rladiessydney.org/courses/ryouwithme/01-basicbasics-1/>\
Recommended for more information on using R Markdown: <https://rmarkdown.rstudio.com/lesson-1.html>
