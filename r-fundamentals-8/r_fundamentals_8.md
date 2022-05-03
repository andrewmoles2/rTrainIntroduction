---
title: "R Fundamentals 8 - Iteration with loops, apply and map"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "14 February, 2022"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: true
    toc_float: true
---

# Objective of workshop

To start using loops (iteration), the act of sequentially repeating your code, to streamline your data cleaning and analysis in R. 

# What this workshop will cover

In this workshop, the aim is to cover how to start working with looping in R. We will be covering:

-   Introduce the use of for loops
-   Perform looping using apply functions
-   Perform looping using map functions

------------------------------------------------------------------------

# For loop basics

A for loop is a programming tool used to sequentially select each element from a collection and carry out a set of commands with the currently selected element.

Every for loop is defined by the collection from which to select elements from sequentially and the variable name for the currently selected element. To put it more practically:
- From which vector (or another collection) do we select elements?
- What should the currently selected element be called?

We translate these questions into R code with the `for` and `in ` keyword. Have a look at line 3 in the below code cell. What is the collection from which elements are being sequentially selected and what is the variable name used for the currently selected element? Think a moment before reading on.

`my_vector` is the collection that we select elements from. `number` is being used as the variable name for the currently selected element. In programming, we call this process of selecting elements with a for loop, to loop over `my_vector` or iterating through `my_vector`.

At the end of the `for` statement we use `{}`. All the commands that should be repeated in the for loop have to be indented following the `for` statement. Consequently, `print(number)` is part of the for loop, while `print('end of for loop')` is not as it is outside of the `{}`.

The for loop takes each number from `my_vector`, assigns the value to the variable `number` and then prints it. After having looped over all numbers from `my_vector` the for loop ends and R continues with the print statement in line 6.

```r
my_vector <- 1:3

for (number in my_vector){
  print(number)
}
```

```
## [1] 1
## [1] 2
## [1] 3
```

```r
print("End of for loop")
```

```
## [1] "End of for loop"
```

## For loop basics exercise 1

Make your first for loop! What would be the output of the for loop if we changed the numbers of my vector to 1-10, and printed the numbers twice? Test it out.

1) Create a vector called `my_vector` with the numbers 1-5
2) Make a for loop using my_vector and print each number twice
3) Add a print statement outside the loop to tell us the for loop has ended

```r
# your code here
my_vector <- 1:5

for (number in my_vector){
  print(number)
  print(number)
}
```

```
## [1] 1
## [1] 1
## [1] 2
## [1] 2
## [1] 3
## [1] 3
## [1] 4
## [1] 4
## [1] 5
## [1] 5
```

```r
print("end of for loop")
```

```
## [1] "end of for loop"
```

# For loop basics part 2

**When writing for loops in R there are three golden rules:**

1) Don't use a for loop if a vectorised or functional alternative exists  
2) Don't grow objects in a for loop as this slows things down a lot. R will make a new object, then copy information which isn't very efficient   
3) Always make an empty data structure before the loop, then fill it during the loop  

We will elaborate on these rules as we go through this workshop!

Loops allow us to write more efficient code, which in a lot of cases means less repetition of code using copy and paste. 

Take the below example. We want to do calculations with a vector and a variable, and write the result of each step as a string (e.g. `"5*12 = 60"`). In this case we are working out the 12 times table. 

As you can see, this is a bit repetitive and impractical, forcing us to write indexes manually which is not ideal!

```r
# vectors of numbers
a <- c(5, 7, 1, 3, 11)
b <- 12
# empty vector
c <- rep(NA, length(a))
# calculations
c[1] <- paste0(a[1], "*", b, " = ", a[1]*b)
c[2] <- paste0(a[2], "*", b, " = ", a[2]*b)
c[3] <- paste0(a[3], "*", b, " = ", a[3]*b)
c[4] <- paste0(a[4], "*", b, " = ", a[4]*b)
c[5] <- paste0(a[5], "*", b, " = ", a[5]*b)
# print result
c
```

```
## [1] "5*12 = 60"   "7*12 = 84"   "1*12 = 12"   "3*12 = 36"   "11*12 = 132"
```

This is where the for loop comes in! It streamlines our code and removes any manual elements. 

The loop takes the first element from `a`, assigns the value to the variable `number`. It then, within the `paste0()` function performs a calculation, then assigns it to the first element of `c`. It then repeats this process for the second, third, fourth elements and so on till there are no more elements left.

As a bonus, we could add extra elements to `a` and the code would still work. Have a go at adding some more strings to the `a` vector to try it different values of the 12 times table.  

*Note, making an empty data structure (e.g. a variable, vector, or data frame) before looping, then adding to that data structure is the best practice, like we did here with c*

```r
# vectors of numbers
a <- c(5, 7, 1, 3, 11)
b <- 12
# empty vector
c <- rep(NA, length(a))
# for loop to do calculations and export as strings
for (number in seq_along(a)){
  c[number] <- paste0(a[number], "*", b, " = ", a[number]*b)
}
# print result
c
```

```
## [1] "5*12 = 60"   "7*12 = 84"   "1*12 = 12"   "3*12 = 36"   "11*12 = 132"
```

Notice we added the `seq_along()` function with our looping through vector `a`, why do we need it? It is a safe way of ensuring predictable behaviour when creating a sequence of numbers or vectors. In the code cell below notice the difference in how `seq_along()` and `seq()` behave when given a variable with a length of 1. We don't want this duplication happening when running a for loop, and `seq_along()` helps to control that behaviour.   

```r
a <- c(8, 9, 10)
b <- 10
# seq_along behaviour
seq_along(a)
```

```
## [1] 1 2 3
```

```r
seq_along(b)
```

```
## [1] 1
```

```r
# seq behaviour
seq(a)
```

```
## [1] 1 2 3
```

```r
seq(b)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

## For loop basics exercise 2

Using the `x`, `y`, and `z` variables, write a for loop that makes a calculation of `x * y` for each element of `x`, makes the result into a string such as `"2*32 = 64"`, then saves the result back to z. 

Print the output at the end to review. `z` should end up with something like: `"2*32 = 64"   "8*32 = 256"  "5*32 = 160"  "19*32 = 608" "7*32 = 224"`. 

```r
x <- c(2, 8, 5, 19, 7)
y <- 32
z <- rep(NA, length(x))

# your code here
for (number in seq_along(x)){
  z[number] <- paste0(x[number], "*", y, " = ", x[number]*y)
}

z
```

```
## [1] "2*32 = 64"   "8*32 = 256"  "5*32 = 160"  "19*32 = 608" "7*32 = 224"
```

## For loop with conditions

For loops are particularly useful when combined with conditional statements like the if statement.

In this below example, for each element of `run_time` our for loop will test the conditions of our if statement, and print out the result for each element of `run_time`. Run the code to test it out. 

```r
# running times vector
run_time <- c(15, 30, 22, 25, 45, 12, 53, 34)
# empty vector for category
run_category <- rep(NA, length(run_time))

# looping through run_time, printing when a condition is met and added to vector
for (run in seq_along(run_time)){
  if (run_time[run] >= 25 & run_time[run] <= 35){
    run_category[run] <- "Medium length run"
    print(run_category[run])
    }
  else if (run_time[run] < 25){
    run_category[run] <- "Short length run"
    print(run_category[run])
  }
  else {
    run_category[run] <- "Long length run"
    print(run_category[run])
  }
}
```

```
## [1] "Short length run"
## [1] "Medium length run"
## [1] "Short length run"
## [1] "Medium length run"
## [1] "Long length run"
## [1] "Short length run"
## [1] "Long length run"
## [1] "Medium length run"
```

```r
# print whole vector
run_category
```

```
## [1] "Short length run"  "Medium length run" "Short length run" 
## [4] "Medium length run" "Long length run"   "Short length run" 
## [7] "Long length run"   "Medium length run"
```

### For loop with conditionals exercise

Have a go at adding conditional statements to a for loop, by trying out a classic programming test, the fizzbuzz programme. 

Write a for loop that prints the numbers from 1 to 25. For multiples of "3" print "Fizz" instead of the number and for the multiples of "5" print "Buzz". For multiples of "3" and "5" print "FIZZBUZZ". Assign the results of each loop back to the `fizzbuzz` variable, then print that variable outside of the loop. 

*hint: a multiple of 3 would have a remainder of 0. E.g. the remainder of 3/3 is 0*
*hint: `%%` gives you the remainder, also called the modulo operator* 

```r
count <- 1:25

fizzbuzz <- rep(NA, length(count))

# your code here
for (each in seq_along(count)) {
  if (count[each] %% 3 == 0 & count[each] %% 5 == 0){
    fizzbuzz[each] <- "FIZZBUZZ"
    print(fizzbuzz[each])
  }
  else if (count[each] %% 3 == 0){
    fizzbuzz[each] <- "Fizz"
    print(fizzbuzz[each])
  }
  else if (count[each] %% 5 == 0){
    fizzbuzz[each] <- "Buzz"
    print(fizzbuzz[each])
  }
  else {
    fizzbuzz[each] <- count[each]
    print(fizzbuzz[each])
  } 
}
```

```
## [1] 1
## [1] 2
## [1] "Fizz"
## [1] "4"
## [1] "Buzz"
## [1] "Fizz"
## [1] "7"
## [1] "8"
## [1] "Fizz"
## [1] "Buzz"
## [1] "11"
## [1] "Fizz"
## [1] "13"
## [1] "14"
## [1] "FIZZBUZZ"
## [1] "16"
## [1] "17"
## [1] "Fizz"
## [1] "19"
## [1] "Buzz"
## [1] "Fizz"
## [1] "22"
## [1] "23"
## [1] "Fizz"
## [1] "Buzz"
```

```r
fizzbuzz
```

```
##  [1] "1"        "2"        "Fizz"     "4"        "Buzz"     "Fizz"    
##  [7] "7"        "8"        "Fizz"     "Buzz"     "11"       "Fizz"    
## [13] "13"       "14"       "FIZZBUZZ" "16"       "17"       "Fizz"    
## [19] "19"       "Buzz"     "Fizz"     "22"       "23"       "Fizz"    
## [25] "Buzz"
```

You write do this programme in any programming language, and is a good way to test out your knowledge of loops and conditionals in that language. For example, if we wanted to do this in Python we would do:

```python
count = range(26)

fizzbuzz = []

for each in count:
  if count[each] % 3 == 0 and count[each] % 5 == 0:
    fizzbuzz.append('FIZZBUZZ')
    print('FIZZBUZZ')
  elif count[each] % 3 == 0:
    fizzbuzz.append('Fizz')
    print('Fizz')
  elif count[each] % 5 == 0:
    fizzbuzz.append('Buzz')
    print('Buzz')
  else: 
    fizzbuzz.append(each)
    print(count[each])
    
```

```
## FIZZBUZZ
## 1
## 2
## Fizz
## 4
## Buzz
## Fizz
## 7
## 8
## Fizz
## Buzz
## 11
## Fizz
## 13
## 14
## FIZZBUZZ
## 16
## 17
## Fizz
## 19
## Buzz
## Fizz
## 22
## 23
## Fizz
## Buzz
```

```python
print(fizzbuzz)
```

```
## ['FIZZBUZZ', 1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz', 11, 'Fizz', 13, 14, 'FIZZBUZZ', 16, 17, 'Fizz', 19, 'Buzz', 'Fizz', 22, 23, 'Fizz', 'Buzz']
```

# Looping through a data frame

In R, the most common data type is a data frame, so learning how to use a for loop with a data frame is a very useful skill. For the rest of the examples in this tutorial we will be using the Palmers penguins dataset - https://allisonhorst.github.io/palmerpenguins/.

First we will need to install the package that holds the dataset. 

```r
install.packages("palmerpenguins")
```

Now we load the package and have a quick look at the data. Note when loading a dataset from a package is can be helpful to use the `data()` function, which loads it into your global environment. Run the code and you should see penguins and penguins_raw appear in the global environment (usually right hand side of RStudio). 

```r
# load library
library(palmerpenguins)
# load data to environment
data(penguins)
# review data
head(penguins)
```

```
## # A tibble: 6 × 8
##   species island bill_length_mm bill_depth_mm flipper_length_… body_mass_g sex  
##   <fct>   <fct>           <dbl>         <dbl>            <int>       <int> <fct>
## 1 Adelie  Torge…           39.1          18.7              181        3750 male 
## 2 Adelie  Torge…           39.5          17.4              186        3800 fema…
## 3 Adelie  Torge…           40.3          18                195        3250 fema…
## 4 Adelie  Torge…           NA            NA                 NA          NA <NA> 
## 5 Adelie  Torge…           36.7          19.3              193        3450 fema…
## 6 Adelie  Torge…           39.3          20.6              190        3650 male 
## # … with 1 more variable: year <int>
```

We might be interested to find out the mean, median, and range of certain columns in our penguins data. We can make an aggregate table of these columns using a for loop. 
We first select the columns we are interested in, here we have selected the bill_length_mm and bill_depth_mm columns (column 3 and 4). 

Next we make a empty data frame for our summary statistics to do into, setting the column names as the descriptive statistics used (mean, median etc.). Then we add the column names we have selected as row names. 

Finally, we loop through the selected columns in our penguins data. On each loop we calculate the mean, median etc. for each column and save the result into our `penguin_stats` data frame. The indexing is important here, we are using the selected element (`stats`) to tell R where to extract and add data. 

```r
# select the names columns we are interested in and review
cols <- names(penguins[, 3:4])
cols
```

```
## [1] "bill_length_mm" "bill_depth_mm"
```

```r
# Make a empty data frame based on number of columns
penguins_stats <- data.frame(
  means = rep(NA, length(cols)),
  medians = rep(NA, length(cols)),
  min = rep(NA, length(cols)),
  max = rep(NA, length(cols))
)

# add the columns as row names
rownames(penguins_stats) <- cols

# review data frame pre-loop
penguins_stats
```

```
##                means medians min max
## bill_length_mm    NA      NA  NA  NA
## bill_depth_mm     NA      NA  NA  NA
```

```r
# loop through selected cols from penguins, performing statistics
for (stats in seq_along(penguins[, cols])){
  penguins_stats[stats, "means"] <- mean(penguins[, cols[stats], drop = TRUE], na.rm = TRUE)
  penguins_stats[stats, "medians"] <- median(penguins[, cols[stats], drop = TRUE], na.rm = TRUE)
  penguins_stats[stats, "min"] <- min(penguins[, cols[stats], drop = TRUE], na.rm = TRUE)
  penguins_stats[stats, "max"] <- max(penguins[, cols[stats], drop = TRUE], na.rm = TRUE)
}

# print outcome
penguins_stats
```

```
##                   means medians  min  max
## bill_length_mm 43.92193   44.45 32.1 59.6
## bill_depth_mm  17.15117   17.30 13.1 21.5
```

You might notice how we indexed our statistics functions was slightly different as we included the `drop = TRUE`. Without `drop = TRUE` our output is a data frame, which the `mean()` function struggles to work with. With `drop = TRUE` it makes the selected column into a vector, allowing the `mean()` function to work. 

Example without the `drop = TRUE` argument. 

```r
# without the drop = TRUE
mean(penguins[1:5, "body_mass_g"], 
     na.rm = TRUE)
```

```
## Warning in mean.default(penguins[1:5, "body_mass_g"], na.rm = TRUE): argument is
## not numeric or logical: returning NA
```

```
## [1] NA
```
Example with the `drop = TRUE` argument. 

```r
# with the drop = TRUE
mean(penguins[1:5, "body_mass_g", drop = TRUE], 
     na.rm = TRUE)
```

```
## [1] 3562.5
```

R is a functional language, which means a lot of the time other people have written for loops like the one above for us which are wrapped up in functions. 

For example, the base R `summary()` function provides us with a summary of selected columns. This is one of the nice things about R; you don't always have to write for loops and can use functions most of the time. This can make your coding easier and faster. When you get more comfortable, you can start writing your own for loops and functions, which provide more flexibility. 

```r
summary(penguins[, cols])
```

```
##  bill_length_mm  bill_depth_mm  
##  Min.   :32.10   Min.   :13.10  
##  1st Qu.:39.23   1st Qu.:15.60  
##  Median :44.45   Median :17.30  
##  Mean   :43.92   Mean   :17.15  
##  3rd Qu.:48.50   3rd Qu.:18.70  
##  Max.   :59.60   Max.   :21.50  
##  NA's   :2       NA's   :2
```

## Looping through a data frame exercise

Adapt the code we used above to include the following:

1) The columns "bill_length_mm", "bill_depth_mm", "flipper_length_mm", and "body_mass_g"
2) The following descriptive statistics: `median()`, standard deviation `sd()` and the interquartile range `IQR()` 

Skeleton code has been provided. Feel free to copy and paste sections from the example to adapt the code.


```r
# select the names columns we are interested in
cols <- names(penguins[, 3])

# Make a empty data frame based on number of columns
penguins_stats <- data.frame(
  medians = rep(NA, length(cols))
)

# add the columns as row names
rownames(penguins_stats) <- cols

# loop through selected cols from penguins, doing descriptive statistics
for (variable in vector) {
  # median
  # sd
  # IQR
}
```

```
## Error in for (variable in vector) {: invalid for() loop sequence
```

```r
# print outcome
penguins_stats
```

```
##                medians
## bill_length_mm      NA
```

# Simplifying for loops and iteration with apply and map

For loops can be complicated and difficult to write. Luckily, you don't always have to write them in R thanks to the functional nature of R. Someone else has written these loops and put them into a function!

>Of course, someone has to write loops. It doesn’t have to be you. — Jenny Bryan

Jenny Bryan is a software developer as RStudio: https://jennybryan.org/

There are two main options when it comes to using *functional loops* in R, the apply family of functions, and the map family of functions. 

What is apply
What is map

Basic apply and map

Next chapter is different options, like lapply and map_df. 

# Introduction to the apply family of functions

Apply functions

A *rowwise* calculation, calculates a function across all rows. To do a rowwise calculation with apply, we use the `MARGIN = 1` argument. 

```r
penguins$bill_avg <- apply(penguins[, c("bill_length_mm", "bill_depth_mm")],
                           MARGIN = 1, mean, na.rm = TRUE)

penguins[1:5, c(3:4, 9)]
```

```
## # A tibble: 5 × 3
##   bill_length_mm bill_depth_mm bill_avg
##            <dbl>         <dbl>    <dbl>
## 1           39.1          18.7     28.9
## 2           39.5          17.4     28.4
## 3           40.3          18       29.2
## 4           NA            NA      NaN  
## 5           36.7          19.3     28
```

To replicate what we did earlier with a for loop...


```r
cols <- names(penguins[, 3:4])

penguins_stats_apply <- apply(penguins[, cols],
                              MARGIN = 2,
                              function(x) c(mean = mean(x, na.rm = TRUE),
                                            median = median(x, na.rm = TRUE),
                                            min = min(x, na.rm = TRUE),
                                            max = max(x, na.rm = TRUE)))

penguins_stats_apply
```

```
##        bill_length_mm bill_depth_mm
## mean         43.92193      17.15117
## median       44.45000      17.30000
## min          32.10000      13.10000
## max          59.60000      21.50000
```

```r
class(penguins_stats_apply)
```

```
## [1] "matrix" "array"
```

```r
data.frame(penguins_stats_apply)
```

```
##        bill_length_mm bill_depth_mm
## mean         43.92193      17.15117
## median       44.45000      17.30000
## min          32.10000      13.10000
## max          59.60000      21.50000
```

```r
# can wrap the apply function in a data frame function to have it output as a data.frame
```


## Apply exercises

# Lapply and sapply

## lapply and sapply exercises

# Map

The map family of functions work in very much the same way as the apply functions, however they are in some ways simpler. You select the map function based on the output you want, for example, if you want character you use `map_chr()` or if you want a data frame you use `map_df()`. 

To use map, we first have to install the `purrr` library. This is part of the *tidyverse* ecosystem of packages which are covered in the R Data Wrangling and R Data Visualisation series. 


```r
install.packages("purrr")
```



```r
library(purrr)

map(penguins[, cols], mean, na.rm = TRUE)
```

```
## $bill_length_mm
## [1] 43.92193
## 
## $bill_depth_mm
## [1] 17.15117
```

```r
map(penguins[, cols], 
    function(x) c(mean = mean(x, na.rm = TRUE), 
                  median = median(x, na.rm = TRUE)))
```

```
## $bill_length_mm
##     mean   median 
## 43.92193 44.45000 
## 
## $bill_depth_mm
##     mean   median 
## 17.15117 17.30000
```


## Map exercises


```r
# your code here
```


# Individual coding challenge

Use the loading lots of urls here, plus give example of how to load in lots of data using apply


# useful links

https://www.rebeccabarter.com/blog/2019-08-19_purrr/
https://jennybc.github.io/purrr-tutorial/
file:///Users/MOLES/OneDrive%20-%20London%20School%20of%20Economics/Code/rTrainIntroduction/Additional%20content/apply-functions/apply_functions_solutions.html#Apply_exercises

