---
title: "R Workshop 1 - Welcome to R!"
author: "Your name here"
date: "24 August, 2020"
output: 
  html_document: 
    keep_md: yes
---

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

## Exercise (R as calculator) 

Use R to work out the following arithmetic:

1)  44 * 26
2)  9.6/1.6
3)  (12+4)^2
4)  (4*9)/(5+6)
5)  (22/36) * 100


```r
# type your code here
```

# Assigning variables

A variable is a named storage of information. In our case today we are storing numbers. 

We can assign variables by using <-. You should see the variable appear to your right in the global enviroment once you've run this command. 

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

## Task

When calling a variable, be careful to type it exactly (you can also copy it or use code completion to help). 

Try calling the height variable, but spell it incorrectly. You should get an error with something like *Error: object 'hieght' not found*


```r
# type incorrect height call here
```

## Example

We can do calculations on these variables, just as we did before. We first assign the variables, then use them in the calculation. 


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

# Reassigning variables

You can also change the value of a variable you have already assigned. Here we are going to add our new pay check to our previous bank balance. Be sure to run the code.


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

## Task

Try and add another pay check of £50 to the bank balance variable.

1)  Make a variable called PayCheck2 with a value of 50
2)  Assign BankBalance, and calculate BankBalance + PayCheck2
3)  Print the outcome


```r
# Reassigning variables task
```


## Exercise 1 (Assigning variables)

Use R to work out a body mass index (BMI) of someone who is 79kg, and 1.77m tall.

1)  Assign the variables of weight and height
2)  Assign the variable of BMI, and calculate the BMI based of the weight and height variables
3)  Print the outcome
4)  Add comments on what each line of code is doing


```r
# Exercise: BMI calculation
```

## Exercise 2 (Assigning variables)

Debug the code below that is finding the weighted average of a students coursework and exam scores. You should find three errors:

*  logic (maths) error
*  syntax error
*  naming error


```r
# Exercise: weighted average debugging
exam1 <- 52
coursework1 <- 82
exam2 <- 78
coursework2 < 48

cw_weight <- 0.4
ex_weight <- 0.6

course1 <- (exam1 * ex_weight) + (coursework * cw_weight)
course2 <- (exam2 * ex_weight) + (coursework2 * cw_weight)

overall_grade <- (course1 + course2)/3

overall_grade
```

# Workshop survey

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_9zagWkOtzNhmqt7

# Individual (take home) coding challenge

A take home coding task for you, which if you submit to Teams we will mark and give you feedback.

Task: Splitting a Pizza Pilgrims restaurant bill between 3 friends; Roger, Amal and Genevieve.

*  Roger has a Calzone Ripieno (£11), and a San Pellegrino (£2).
*  Amal has a Bufala (£9), and Birra Moretti (£4.50).
*  Genevieve has a Portobello Mushroom & Truffle (£10), and water to drink.
*  Genevieve and Amal also share a Nutella Pizza ring for dessert (£5.5). 


1)  Make a variable for each friend that is the sum of their order (e.g. Roger would be 11 + 2)
2)  Make a variable for the shared food
3)  Make a variable called TotalBill, and calculate their total bill
4)  For those that shared food, add the shared food to their bill
5)  Comment your code
6)  Print the total bill and what each friend owes


```r
# individual coding challenge
```

# Submitting work to teams

**Join the LSE-DSL-ClassTeams-Demo**  

1)  Open the Teams app
2)  Click Teams button on the left side of the app
3)  Click Join or create a team at the bottom of your teams list
4)  Go to Join a team with a code (the second tile)
5)  Paste the code 6rax2tk in the Enter code box, and click Join.

**Submit the R notebook on Teams**  

1)  Open the Teams app
2)  Click Teams button on the left side of the app
3)  Open the LSE-DSL-ClassTeams-Demo Team
4)  Select the R 1 - Numerical Variables channel
5)  Click on View assignment in the R 1 - Numerical Variables assignment in the Posts tab
6)  Upload your R notebook
