---
title: "R Workshop 3 - Strings, factors, and type conversion"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "19 October, 2020"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What will this workshop cover?

In this workshop, the aim is to cover strings and sting manipulation, introduce factors, and type conversion. We will be covering:

*  String variables
*  String manipulation with Paste, gsub and grep
*  Introduction to factors (represent categorical data, ordered/un-ordered, levels)
*  Tabulation using factors
*  Converting types of data (strings, factors, integers, and numeric)

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


# Basic string manipulation
R comes with several useful functions for manipulating strings, these include `paste()`, `paste0()`, `grep()`, `gsub()`. `paste()` and `paste0()` are for creating strings, and `grep()` and `gsub()` for are string matching and replacement. 

Some examples of paste:

```r
trees <- c('Oak', 'Willow', 'Redwood')
paste(trees, collapse = ", ")
```

```
## [1] "Oak, Willow, Redwood"
```

```r
paste("Hi", "there", sep = ", ")
```

```
## [1] "Hi, there"
```

```r
pizzaEaten <- 4
paste0("This week I ate ", pizzaEaten, " pizzas...")
```

```
## [1] "This week I ate 4 pizzas..."
```
As you can see paste can make new strings from existing strings, and format them into a readable format. 

## Paste exercise

1)  Make a vector with the following flowers: sunflower, poppy, dahlia
2)  Use `paste` to make this string: "sunflower, poppy, dahlia"
3)  Make a variable called daysRaining with the value 360
4)  Using `paste0` make the following sentence that uses the daysRaining variable: "It has been raining for 360 days this year"

# String manipulation with grep and gsub
It is often useful to be able to pattern match or replace values in strings. In R there are two very useful functions for this: `grep()` and `gsub()`. 

## String matching with grep
We use `grep()` for string matching. We give it the string or part of string we are looking for, and it will return the indexes in the vector for the selected string/s.

```r
places <- c(rep("Hampshire", 2), rep("London", 5), rep("Kent", 1), rep("Surrey", 3))
grep("London", places)
```

```
## [1] 3 4 5 6 7
```
It is very useful for indexing strings.

```r
places[grep("Lon", places)]
```

```
## [1] "London" "London" "London" "London" "London"
```

## grep exercise
We have some patient IDs. We want to just pull out Id's 1, and 10 to 19. So you should get *"ID_1"  "ID_10" "ID_11" "ID_12" "ID_13" "ID_14" "ID_15" "ID_16" "ID_17" "ID_18" "ID_19"*

1)  Using `grep()`, index the ID variable to pull out the requested ID's and assign it to new variable called newID.
2)  Print your newID variable.
3)  Comment your code.

```r
ID <- paste0("ID_", seq(1:50))

# your code here
```

## String replacement with gsub
With `gsub()` we give the function the pattern we are looking to replace, what to replace it with, and the variable or vector to work on.

```r
Names <- c("Andrew", "Andrea", "Angela")
gsub("An" ,"" , Names)
```

```
## [1] "drew" "drea" "gela"
```
Here we are removing the An from the names in the Names vector. 

## gsub exercise
Using the same IDs variable we are going to use gsub to replace the *ID* from each string and replace it with *patientID*. You should end up with IDs that looks like *patientID_3*. 

1)  Using gsub replace ID with patientID, assign the results to a variable called patientID.
2)  Print your new patientID variable.
3)  Comment your code.

```r
ID <- paste0("ID_", seq(1:50))

# your code here
```


## String manipulation exercise
For this exercise I have given you the code but it is in the wrong order. You need to re-arrange the code so it runs correctly. Comment on what each line of code is doing. 

The end result you are aiming for is: **"These 4 pokemon have 'ar' in their names: Charmander, Charmeleon, Charizard, Wartortle"**

```r
pokemon <- gsub("[0-9]", "", pokemon)

paste0("These ",arPokes_num, " pokemon have 'ar' in their names: ", arPokes)

arPokes_num <- sum(length(arPokes))

arPokes <- pokemon[grepl("ar", pokemon)]

pokemon <- c("Bulbasaur001", "Ivysaur002", "Venusaur003",
             "Charmander004", "Charmeleon005", "Charizard006",
             "Squirtle007", "Wartortle008", "Blastoise009")

arPokes <- paste(arPokes, collapse = ", ")
```
***

# Introduction to factors

Factors in R are a way to represent and work with categorical data. Categorical data has fixed values, for example, the months of the year (January, February etc.). Factors allow you to do analysis with strings by categorising them (more on this on later). 

The are a few different ways to make a factor in R, the primary function to do this is `factor()`. 

```r
veg <- c("carrot", "potato", "squash", "squash", "potato", "onion")
veg <- factor(veg)
veg
```

```
## [1] carrot potato squash squash potato onion 
## Levels: carrot onion potato squash
```
We created the vector then made it into a factor. We can also just add the values straight into `factor()`. 

```r
veg <- factor(c("carrot", "potato", "squash", "squash", "potato", "onion"))
veg
```

```
## [1] carrot potato squash squash potato onion 
## Levels: carrot onion potato squash
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

The `table()` function allows us to do calculations such as percentages. We have used the `length()` function to tell R how much to divide by as opposed to adding the number of variables in cols (12). This is good practice as the data used can change. 

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

## Tabulation exercise

1)  Make the StringsOrchestra variable, defined below, into a factor. 
2)  Using `table()` work out the percentage each instrument makes up of this orchestra. See above example for help. 
3)  Combine the `table()` and `grep()` function to select just the Violins, save as a vector called violin. *hint: table(data[grep()])*
4)  calculate the sum of violin and print the result. 


```r
StringsOrchestra <- c(rep('first Violin',12),
                      rep('second Violin',10),
                      rep('Viola',8),
                      rep('Cello',6),
                      rep('Double bass',4))

# your code here
```

# Type conversions

In the workshops so far we have covered several types of data including strings, numeric, integer, and factors. Sometimes when working with data it is necessary to convert the type of data so you can work with it in a different way. 

A simple example of why type conversion is useful is when a number is accidentally coded as a string. In order to do calculations on that data you need to convert it.

## Type conversion exercise 1
Using the notNumbers variable defined below:

1)  Use the mean function on the `notNumbers` variable
2)  Why did it not work?
3)  Can you find a function to change the notNumbers vector to be numeric? Try "searching character to numeric r" in Google.
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

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_9zagWkOtzNhmqt7?course=D025-R1NV&topic=R&cohort=MT20


# Individual take home challenge 
In this debugging challenge get the code below to run. The code calculates your week wine consumption. When it runs it will print out the following statement "This week I drank on average 1.71 glasses of wine, 5 red and 2 white". *Hint: test out each line of code one by one to pick up the errors*

As an addition to the debugging you can add another week of wine consumption to the variables `typeWine` and `amountWine`, then run the code again. 

```r
# type of wine drunk
typeWine <- factor(('red', 'red', 'red', 'white', 'white', 'red', 'red'))
# total of small glasses you drank
amountWine <- c(1, 1, 2, 1, 3, 1, 3)

# calculate the average wine, rounding the result to two decimal places
meanWine <- round(mean(amountwine), digits = 4) 

# sum how much red and white wine where drunk
red <- sum(table(typeWine[grep('Red',typeWine)]))
white <- sum(table(grep('white',typeWine)))

# print a nice result of your weekly wine consumption
paste0("This week I drank on average , meanWine", " glasses of wine, ", red, " red and ", white, " white")
```

