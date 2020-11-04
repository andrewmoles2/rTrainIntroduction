---
title: "R Workshop 3 - Strings, factors, and type conversion"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "04 November, 2020"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What will this workshop cover?

In this workshop, the aim is to cover strings and sting manipulation, introduce factors, and type conversion. We will be covering:

*  String variables
*  Introduction to factors (represent categorical data, ordered/un-ordered, levels)
*  Converting types of data (strings, factors, integers, and numeric)
*  String manipulation with Paste
*  Tabulation using factors

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


# Strings
So far in our previous sessions we have only been working with numbers and integers. Strings are text based data which R calls **characters**. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop2/images/22895-NUNWT2.jpg?raw=true){width=50%}
 
To code a string you need to use quotation marks. You can use either single or double, depending on your preference. When printing the result, R will always use double quotation marks.

```r
instrument <- "Violin"
instrument
```

```
## [1] "Violin"
```

```r
instruments <- c('Violin', 'Cello', 'Viola')
instruments
```

```
## [1] "Violin" "Cello"  "Viola"
```

## Is this a string or a number?
You can find out what type data your variable/vector is using the `class()` function.

```r
name <- 'Claudia'
class(name)
```

```
## [1] "character"
```

```r
age <- 42
class(age)
```

```
## [1] "numeric"
```

## String indexing exercise

1)  Make a vector called orangeVeg with the following strings: Pumpkin, Carrot, Butternut Squash, Sweet Potato
2)  From orangeVeg select everything but carrot using indexing
3)  From orangeVeg select just Pumpkin and Butternut Squash


```r
# your code here
```

# Introduction to factors

Factors in R are a way to represent and work with categorical data. Categorical data has fixed values, for example, the months of the year (January, February etc.). Factors allow you to do analysis with strings by categorising them (more on this on later). 

There are a few different ways to make a factor in R, the primary function to do this is `factor()`. 

```r
veg <- c("carrot", "potato", "squash", "squash", "potato", "carrot")
veg <- factor(veg)
veg
```

```
## [1] carrot potato squash squash potato carrot
## Levels: carrot potato squash
```
We created the vector then made it into a factor. We can also just add the values straight into `factor()`. 

```r
veg <- factor(c("carrot", "potato", "squash", "squash", "potato", "carrot"))
veg
```

```
## [1] carrot potato squash squash potato carrot
## Levels: carrot potato squash
```

To interpret the output, the first line shows all the variables in the veg vector, the second line (*levels:*) gives you the categories. In this case we have four: carrot, onion, potato, squash. 

Why make strings into factors? Other than being easier to work with, factors help you to avoid typos (will give error) and can be sorted in helpful and meaningful ways.

## Exercise

In this debugging exercise, get the below code to run to make the fruit vector a factor. There are three errors in the code. Run the code and use the printed error message to help you find the errors. 

```r
fruit <- Factor(c('apple' 'pear', 'grape', 'apple', 'banana', grape))
```

# Ordering factors

Sometimes the ordering of the factor levels matter. For example, if you had a question on how often someone eats ice cream with the possible answers of *Almost always, Often, Sometimes, Seldom, and Never*, the order is important. This order reflects how the output will be printed or arranged in a figure. 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop3/images/dog_order.jpg?raw=true){width=50%}

Run the below example. Can you see that the order is wrong? 

```r
iceCream <- factor(c('Almost always', 'Often', 'Never', 'Sometimes', 
                     'Seldom','Almost always','Often', 'Never'))
iceCream
```

```
## [1] Almost always Often         Never         Sometimes     Seldom       
## [6] Almost always Often         Never        
## Levels: Almost always Never Often Seldom Sometimes
```

Factors by default are ordered alphabetically. There are a few ways of changing this, the simplest of which is to include the `levels` argument in the `factor()` function. 

Using our example above we add the levels argument after the variables (`factor(variables, levels = )`).

```r
iceCream <- factor(c('Almost always', 'Often', 'Never', 'Sometimes', 
                     'Seldom','Almost always','Often', 'Never'), 
                   levels = c('Almost always', 'Often', 'Sometimes', 
                              'Seldom','Never'))
iceCream
```

```
## [1] Almost always Often         Never         Sometimes     Seldom       
## [6] Almost always Often         Never        
## Levels: Almost always Often Sometimes Seldom Never
```

We can also add the levels after the factor has been created, by reassigning it and adding the levels argument.

```r
iceCream <- factor(iceCream, levels = c('Almost always', 'Often', 
                                        'Sometimes', 'Seldom','Never'))
```

Finally, you can pre-define the levels in a vector before adding them as levels. 

```r
qlevels <- c('Almost always','Often','Sometimes','Seldom','Never')

iceCream <- factor(c('Almost always', 'Often', 'Never', 'Sometimes', 
                     'Seldom','Almost always','Often', 'Never'), 
                   levels = qlevels)
iceCream
```

```
## [1] Almost always Often         Never         Sometimes     Seldom       
## [6] Almost always Often         Never        
## Levels: Almost always Often Sometimes Seldom Never
```

## Factor task

1)  Make the sizes vector below into a factor, making sure to put the sizes in the following order: low, medium, high. 
2)  Print the newly factorised sizes vector to see the outcome
3)  Now try and reverse the factor order to: high, medium, low and save the variable
4)  Print the reversed variable

```r
sizes <- c('high', 'low', 'medium', 'low', 'high')

# your code here
```

# Type conversions

In the workshops so far we have covered several types of data including strings, numeric, integer, and factors. Sometimes when working with data it is necessary to convert the type of data so you can work with it in a different way. 

For example, here we will convert numbers to characters using the `as.character()` function. The most common type conversion functions are: `as.numeric()`, `as.integer()`, `as.factor()`, `as.character()`. 

```r
days <- c(1,2,3,4,5,6,7)
days
```

```
## [1] 1 2 3 4 5 6 7
```

```r
days <- as.character(days)
days
```

```
## [1] "1" "2" "3" "4" "5" "6" "7"
```

A simple example of why type conversion is useful is when a number is accidentally coded as a string. In order to do calculations on that data you need to convert it.

## Type conversion exercise 1
Using the notNumbers variable defined below:

1)  Use the mean function on the `notNumbers` variable
2)  Why did it not work?
3)  Which function do you need to change the notNumbers vector to be numeric?
4)  Once you've changed notNumbers to numeric, run mean on it again

```r
notNumbers <- c('2', '4', '8')

# your code here
```

The syntax for type conversions in R always start with `as.` then have whatever you're converting to such as `factor`. 

## Type conversion exercise 2

Type conversion can be helpful with questionnaire data. In this example you've taken a questionnaire how much you agree to certain topics with the following scale: Strongly Disagree, Disagree, Undecided, Agree, Strongly Agree.

1)  Make a vector called *survey* with the following amount of responses: Strongly Agree * 3, Undecided * 1, Disagree * 2, Strongly Disagree * 1, Agree * 5. hint: use the `rep()` function.
2)  Make the survey vector into a factor, with the order levels strongly disagree to strongly disagree. You should get *Levels: strongly disagree disagree undecided agree strongly agree*.
3)  Convert the survey factor to an integer. Now your factor levels will have values; 1 for strongly disagree to 5 for strongly agree. 
4)  Make a variable called aveSurvey and calculate the mean response.
5)  Using `paste0()` print the following statement using your aveSurvey variable: "My average agreement was 3.58 out of 5". hint: use `round()` to tidy up the aveSurvey result.


```r
# your code here
```


# Basic string manipulation
R comes with several useful functions for manipulating strings, these include `paste()`, `paste0()`, `grep()`, `gsub()`. `paste()` and `paste0()` are for creating strings, and `grep()` and `gsub()` for are string matching and replacement. Today we will just look at `paste()`, `paste0()`. 

The paste functions are useful for producing nice outputs for reports or an analysis. They concatenate strings and variables to make outputs more readable. 

Some examples of paste with and without sep or collapse:

```r
paste("Hi", "there")
```

```
## [1] "Hi there"
```

```r
paste("Hi", "there", sep = ", ")
```

```
## [1] "Hi, there"
```

```r
trees <- c('Oak', 'Willow', 'Redwood')
paste(trees)
```

```
## [1] "Oak"     "Willow"  "Redwood"
```

```r
paste(trees, collapse = " and ")
```

```
## [1] "Oak and Willow and Redwood"
```

What do sep and collapse do? They tell paste how to separate the elements. Collapse is used when you give paste a vector, sep is for when you have single values (variables). You have to provide the symbols used to separate the elements, such as a comma. 

You can't change the sep value for `paste0`, but collapse can be changed.  

```r
pizzaEaten <- 4
paste0("This week I ate ", pizzaEaten, " pizzas...")
```

```
## [1] "This week I ate 4 pizzas..."
```

```r
paste0(trees, collapse = " & ")
```

```
## [1] "Oak & Willow & Redwood"
```
As you can see paste can make new strings from existing strings, and format them into a readable format. 

## Paste exercise

1)  Make a vector with the following flowers: sunflower, poppy, dahlia
2)  Use `paste` to make this string: "sunflower, poppy, dahlia"
3)  Make a variable called daysRaining with the value 360
4)  Using `paste0` make the following sentence that uses the daysRaining variable: "It has been raining for 360 days this year"

# Tabulation using factors

It can be helpful to know how many occurrences (counts) of each category you have in a factor. You can do this using the `table()` function, which allows us to do simple tabulations. 

```r
# colours vector
cols <- c('red','blue','red','green','red','green',
          'blue','pink','green','red','red','blue')
# tabulation of colours vector
table(cols)
```

```
## cols
##  blue green  pink   red 
##     3     3     1     5
```

The `table()` function allows us to do calculations such as percentages. We have used the `length()` function to tell R how much to divide by as opposed to adding the number of variables in cols (12). This is good practice as the data used can change. We can also use the `prop.table()` function as shown below. 

```r
# colours vector
cols <- c('red','blue','red','green','red','green',
          'blue','pink','green','red','red','blue')
# found out the percentages rather than counts
table(cols)/length(cols)*100
```

```
## cols
##      blue     green      pink       red 
## 25.000000 25.000000  8.333333 41.666667
```

```r
# found out the percentages using prop.table
prop.table(table(cols))*100
```

```
## cols
##      blue     green      pink       red 
## 25.000000 25.000000  8.333333 41.666667
```

## Tabulation exercise

1)  Make the StringsOrchestra variable, defined below, into a factor. 
2)  Using `table()` work out the percentage each instrument makes up of this orchestra. Test this out with both the examples used above. 

```r
StringsOrchestra <- c(rep('first Violin',12),
                      rep('second Violin',10),
                      rep('Viola',8),
                      rep('Cello',6),
                      rep('Double bass',4))

# your code here
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_9zagWkOtzNhmqt7?course=D048-R3SFTC&topic=R&cohort=MT20

# Individual take home challenge 
In this challenge get the code below to run, it has been jumbled up so needs to be re-ordered. The code calculates your week wine consumption. When it runs it will print out the following statement "This week I drank on average 1.71 glasses of wine, 5 red and 2 white". 


```r
# sum how much red and white wine where drunk
red <- sum(table(typeWine[grep('red',typeWine)]))
white <- sum(table(typeWine[grep('white',typeWine)]))

# calculate the average wine, rounding the result to two decimal places
meanWine <- round(mean(amountWine), digits = 2) 

# type of wine drunk
typeWine <- factor(c('red', 'red', 'red', 'white', 'white', 'red', 'red'))

# print a nice result of your weekly wine consumption
paste0("This week I drank on average ", meanWine, " glasses of wine, ", red, " red and ", white, " white")
# total of small glasses you drank

amountWine <- c(1, 1, 2, 1, 3, 1, 3)
```
*Note: here we have used the grep function so you can see how it can be used. It is searching the type wine variable for either the string 'red' or 'white'*
