---
title: "R Workshop 3 - Strings, factors, and type conversion"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "15 September, 2020"
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

We will be working in pairs:

*  Take turns sharing the screen.
*  Take turns on who types for each exercise.
*  Whoever was typing, share your code in the chat with your teammate. 
*  If possible have your camara on when doing the paired work.

What to do when getting stuck:

1)  Ask your team members
2)  Search online:
  *  The answer box on the top of Google's results page 
  *  stackoverflow.com (for task-specific solutions)
  *  https://www.r-bloggers.com/ (topic based tutorials)
3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

**To get feedback**: hand in your R markdown exercise file in the assignment on the Teams channel for the R 3 workshop.

# Strings
So far in our previous sessions we have only been working with numbers and integers. Strings are text based data which R calls characters. 

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
You have to be careful not to run functions on strings that need numerical data.

## Exercise
Using the notNumbers variable defined here:

```r
notNumbers <- c('2', '4', '8')
```
1)  Use the mean function on that variable
2)  Why did it not work?
3)  Can you find a function to change the notNumbers vector to be numeric? Try "searching character to numeric r".
4)  Once you've changed notNumbers to numeric, run mean on it again

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
It is often useful to be able to patten match or replace values in strings. In R there are two very useful functions for this: `grep()` and `gsub()`. 

## String matching with grep
We use `grep()` for string matching. We give it the string or part of string we are looking for, and it will return where in the vector these strings are.

```r
places <- c(rep("Hampshire", 2), rep("London", 5), rep("Kent", 1), rep("Surrey", 3))
places
```

```
##  [1] "Hampshire" "Hampshire" "London"    "London"    "London"    "London"   
##  [7] "London"    "Kent"      "Surrey"    "Surrey"    "Surrey"
```

```r
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

1)  Using grep index the ID variable to pull out the requested ID's and assign it to newID.
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

1)  Using gsub replace ID with patientID, assign the results to a varaible called patientID.
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


# Introduction to factors



# Type conversions

In the workshops so far we have covered several types of data including strings, numeric, integer, and factors. Sometimes when working with data it is necessary to convert the type of data so you can work with it in a different way. 

A simple example is a number being coded as a string. In order to do calculations on that data you need to convert it.

```r
someData <- c('2','5','2','6','9')
mean(someData)
```

```
## Warning in mean.default(someData): argument is not numeric or logical: returning
## NA
```

```
## [1] NA
```

```r
someData <- as.numeric(someData)
mean(someData)
```

```
## [1] 4.8
```

