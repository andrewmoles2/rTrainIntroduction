---
title: "R Fundamentals 3 - Strings, factors, and type conversion"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "10 November, 2021"
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

# What will this workshop cover?

In this workshop, the aim is to cover strings and sting manipulation, introduce factors, and type conversion. We will be covering:

-   String variables
-   Introduction to factors (represent categorical data, ordered/un-ordered, levels)
-   Converting types of data (strings, factors, integers, and numeric)
-   String manipulation with Paste

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

# Strings

So far in our previous sessions we have only been working with numbers and integers. Strings are text based data which R calls **characters**.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-fundamentals-2/images/22895-NUNWT2.jpg?raw=true){width="50%"}

To code a string you need to use quotation marks. You can use either single or double quotes, depending on your preference. When printing the result, R will always use double quotation marks.


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

You can use both types of quotation marks in conjunction to add grammar to strings.


```r
day <- "It's a 'lovely' day"
day
```

```
## [1] "It's a 'lovely' day"
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
2)  Use the `class()` function to see what data type orangeVeg is
3)  From orangeVeg select everything but carrot using indexing
4)  From orangeVeg select just Pumpkin and Butternut Squash using indexing


```r
# your code here
```

# Introduction to factors

Factors in R are a way to represent and work with categorical data. Categorical data has fixed values, for example, the months of the year (January, February etc.). Factors allow you to do analysis with strings by categorising them, this gives you values you can do an analysis on.

In the examples below we are going to categorise a vector that contains the strings carrot and potato. There are a few different ways to make a factor in R, the primary function to do this is `factor()`.


```r
veg <- c("carrot", "potato", "carrot", "carrot", "potato", "carrot")
veg <- factor(veg)
veg
```

```
## [1] carrot potato carrot carrot potato carrot
## Levels: carrot potato
```

We created the vector then made it into a factor. We can also just add the values straight into `factor()`.


```r
veg <- factor(c("carrot", "potato", "potato", "potato", "potato", "carrot"))
veg
```

```
## [1] carrot potato potato potato potato carrot
## Levels: carrot potato
```

To interpret the output, the first line shows all the variables in the veg vector, the second line (*levels:*) gives you the categories. In this case we have two: carrot and potato. This is helpful as it tells us that in the vector veg, the two categories we have are potatoes or carrots; these categories are represented as levels in the output.

Why make strings into factors? Other than being easier to work with, factors help you to avoid typos (will give error) and can be sorted in helpful and meaningful ways which is particularly helpful when visualising data.

## Factors exercise

In this debugging exercise, get the below code to run to make the fruit vector a factor. There are three errors in the code. Run the code and use the printed error message to help you find the errors.


```r
fruit <- Factor(c('apple' 'pear', 'grape', 'apple', 'banana', grape))
fruit
```

```
## Error: <text>:1:27: unexpected string constant
## 1: fruit <- Factor(c('apple' 'pear'
##                               ^
```


# Ordering factors

Sometimes the ordering of the factor levels matter. For example, if you had a question on how fast someone eats ice cream with the possible answers of *slow, medium, and fast*, the order is important. This order reflects how the output will be printed or arranged in a figure.

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-fundamentals-3/images/dog_order.jpg?raw=true){width="50%"}

Run the below example. Can you see that the order is the wrong way round? We want slow to be first, then medium, then fast.


```r
iceCream <- factor(c('slow', 'fast', 'fast', 'fast', 
                     'medium','slow','medium', 'slow'))
iceCream
```

```
## [1] slow   fast   fast   fast   medium slow   medium slow  
## Levels: fast medium slow
```

Factors by default are ordered alphabetically. There are a few ways of changing this, the simplest of which is to include the `levels` argument in the `factor()` function.

Using our example above we add the *levels* argument after the variables (`factor(variables, levels = )`).


```r
iceCream <- factor(c('slow', 'fast', 'fast', 'fast', 
                     'medium','slow','medium', 'slow'), 
                   levels = c('slow','medium','fast'))
iceCream
```

```
## [1] slow   fast   fast   fast   medium slow   medium slow  
## Levels: slow medium fast
```

We can also add the levels after the factor has been created, by reassigning it and adding the levels argument.


```r
iceCream <- factor(iceCream, levels = c('slow','medium','fast'))
iceCream
```

```
## [1] slow   fast   fast   fast   medium slow   medium slow  
## Levels: slow medium fast
```

Finally, you can pre-define the levels in a vector before adding them as levels.


```r
qlevels <- c('slow','medium','fast')

iceCream <- factor(c('slow', 'fast', 'fast', 'fast', 
                     'medium','slow','medium', 'slow'), 
                   levels = qlevels)
iceCream
```

```
## [1] slow   fast   fast   fast   medium slow   medium slow  
## Levels: slow medium fast
```

## Factor levels task

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

For example, here we will convert numbers to characters using the `as.character()` function. Notice after conversion the speech marks around each number indicating it is a character. The most common type conversion functions are: `as.numeric()`, `as.integer()`, `as.factor()`, `as.character()`.

A simple example of why type conversion is useful is when a number is accidentally coded as a string. In order to do calculations on that data you need to convert it.


```r
# numbers as characters
numbers <- c("1", "2", "3", "4", "5", "6", "7")
numbers
```

```
## [1] "1" "2" "3" "4" "5" "6" "7"
```

```r
# calculate sum (doesn't work)
sum(numbers)
```

```
## Error in sum(numbers): invalid 'type' (character) of argument
```

```r
# convert to numeric and try sum again
numbers <- as.numeric(numbers)
sum(numbers)
```

```
## [1] 28
```

## Type conversion exercise

Using the meditation_time variable defined below:

1)  Use the mean function on the `meditation_time` variable
2)  Why did it not work?
3)  Which function do you need to change the meditation_time vector to be numeric?
4)  Once you've changed meditation_time to numeric, run mean on it again


```r
meditation_time <- c(10, 17, 5, 16, '8', 22, 9)

# your code here
```

The syntax for type conversions in R always start with `as.` then whatever you're converting to, such as `numeric`.

# Basic string manipulation

R comes with several useful functions for manipulating strings, today we will just look at `paste()`, `paste0()`.

The paste functions are useful for producing nice outputs for reports or an analysis. They concatenate strings and variables to make outputs more readable. They are also really helpful to creating data, or making reproducible examples of data.

The most basic use of paste is just adding strings to the function to combine them into one string.


```r
# printing strings hello and world
paste("hello",  "world")
```

```
## [1] "hello world"
```

```r
# Making a string variable more readable
Name <- "Rose"
my_name <- paste("My name is", Name)
my_name
```

```
## [1] "My name is Rose"
```

We can combine paste with other functions such as rep or seq to make new vectors. This is really handy if you want or need to make some string based data.


```r
# repeat hello 
hello <- rep(paste("Hello,", "nice to see you"), 3)
hello
```

```
## [1] "Hello, nice to see you" "Hello, nice to see you" "Hello, nice to see you"
```

```r
# person id 1 to 5
person <- paste("person", "id", seq(1:5))
person
```

```
## [1] "person id 1" "person id 2" "person id 3" "person id 4" "person id 5"
```

The `paste()` function has two extra arguments, `sep` and `collapse.` What do sep and collapse do? They tell paste how to separate the elements. Collapse is used when you give paste a vector, sep is for when you have single values (variables). You have to provide the symbols used to separate the elements, such as a comma.

Some examples of paste with and without the sep or collapse arguments:


```r
# Using sep
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
paste("person", "id", seq(1:5), sep = "_")
```

```
## [1] "person_id_1" "person_id_2" "person_id_3" "person_id_4" "person_id_5"
```

```r
# using collapse
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

```r
paste(trees, collapse = ", ")
```

```
## [1] "Oak, Willow, Redwood"
```

The difference between `paste` and `paste0` is that `paste0` by default has no separation between strings. Run the example below to see the difference.


```r
paste("paste", "seperation", seq(1:3))
```

```
## [1] "paste seperation 1" "paste seperation 2" "paste seperation 3"
```

```r
paste0("paste", "seperation", seq(1:3))
```

```
## [1] "pasteseperation1" "pasteseperation2" "pasteseperation3"
```

With `paste0` you can add the separation you want after the string instead of as a sep arguement.


```r
paste0("paste_", "seperation_", seq(1:3))
```

```
## [1] "paste_seperation_1" "paste_seperation_2" "paste_seperation_3"
```

You can't change the `sep` value for `paste0`, but collapse can be changed.


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

As you can see paste can make new strings from existing strings and format them into a readable format, as well as make new vectors from strings.

## Paste exercise

1)  Make a vector with the following flowers: sunflowers, echinaceas, dahlias
2)  Use `paste0` or `paste` to make this string: "sunflowers, echinaceas, dahlias"
3)  Use rep in conjunction with paste to print out each of your flowers with "I like" before each flower, repeat it four times
4)  Make a variable called daysRaining with the value 360
5)  Using `paste0` or `paste` make the following sentence that uses the daysRaining variable: "It has been raining for 360 days this year"
6)  Use `paste0` or `paste` with the seq function to make these strings: "order_1", "order_2", "order_3", "order_4", "order_5". Print out the result


```r
# your code here
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_eflc2yj4pcryc62?coursename=R%20Fundamentals%203:%20Strings,%20Factors,%20and%20Type%20Conversion%C2%A0&topic=R&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/ElrN79ulZINElxjPz6Tx4VMBo1NWK7TEaket80nhJMPUwg?e=EjSyVn&prog=DS&version=21-22>

# Individual take home challenge 1

Type conversion can be helpful with questionnaire data. In this example you've taken a questionnaire how much you agree to certain topics with the following scale: Disagree, Undecided, Agree.

1)  Make a vector called `survey` with the following amount of responses: agree times 5, undecided times 3, disagree times 2. hint: use the `rep()` function.
2)  Make the survey vector into a factor, with the order levels disagree to agree. You should get *Levels: disagree undecided agree*.
3)  Convert the survey factor to an integer. Now your factor levels will have values; 1 for disagree to 3 for agree.
4)  Make a variable called aveSurvey and calculate the mean response.
5)  Using `paste()` or `paste0()` print the following statement using your aveSurvey variable: "My average agreement was 2.3 out of 3".


```r
# your code here
```

# Individual take home challenge 2

In this challenge get the code below to run, it has been jumbled up so needs to be re-ordered. The code calculates your week wine consumption. When it runs it will print out the following statement *"This week I drank on average 1.71 glasses of wine, 5 red and 2 white"*.


```r
# sum how much red and white wine where drunk
red <- sum(table(typeWine[grep('red',typeWine)]))
```

```
## Error in table(typeWine[grep("red", typeWine)]): object 'typeWine' not found
```

```r
white <- sum(table(typeWine[grep('white',typeWine)]))
```

```
## Error in table(typeWine[grep("white", typeWine)]): object 'typeWine' not found
```

```r
# calculate the average wine, rounding the result to two decimal places
meanWine <- round(mean(amountWine), digits = 2) 
```

```
## Error in mean(amountWine): object 'amountWine' not found
```

```r
# type of wine drunk
typeWine <- factor(c('red', 'red', 'red', 'white', 'white', 'red', 'red'))

# print a nice result of your weekly wine consumption
paste0("This week I drank on average ", meanWine, " glasses of wine, ", red, " red and ", white, " white")
```

```
## Error in paste0("This week I drank on average ", meanWine, " glasses of wine, ", : object 'meanWine' not found
```

```r
# total of small glasses you drank

amountWine <- c(1, 1, 2, 1, 3, 1, 3)
```

*Note:* here we have used the `grep()` and `table()` functions so you can see how they can be used. They will be covered in later sessions. `grep()` is searching the type wine variable for either the string 'red' or 'white'. `table()` does a count on the number of each level of a factor; test out table() on the typeWine variable to see what it does.
