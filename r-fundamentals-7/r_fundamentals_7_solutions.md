---
title: "R Fundamentals 7 - Lists, Matrices, and objects"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "19 August, 2021"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
    code_download: true
    toc: true
    toc_float: 
      collapsed: true
---

# What this workshop will cover

*  Using lists in R
*  Working with matrices
*  How to work with other objects in R

## Why this style?

*  Online training is tiring so keeping the sessions to one hour
*  No or limited demonstrations provided in order to provide more real world experience - you have a problem and you look up how to solve it, adapting example code
*  Trainer support to guide through process of learning

## We will be working in pairs:

*  Option to work together on worksheet or to work individually
*  If possible have your camera on and introduce yourself to each other

## What to do when getting stuck:

1)  Ask your team members
2)  Search online:
  *  The answer box on the top of Google's results page 
  *  stackoverflow.com (for task-specific solutions)
  *  https://www.r-bloggers.com/ (topic based tutorials)
3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

***

# Introduction to matrices

A matrix is a two dimensional data structure that is organised in a tabular layout, very similar to a data frame. 

What is the difference between a matrix and a data frame? Matrices can have only **one data type**, whereas a data frame can have several so long as they are in separate columns. If you have come from Python, this is similar to a NumPy array. 

To make a matrix in R we use the `matrix()` function, see the two examples below on how to make a simple one dimensional matrix. 

```r
# a matrix with 1:10
matrix(1:10)
```

```
##       [,1]
##  [1,]    1
##  [2,]    2
##  [3,]    3
##  [4,]    4
##  [5,]    5
##  [6,]    6
##  [7,]    7
##  [8,]    8
##  [9,]    9
## [10,]   10
```

```r
# matrix with strings
matrix(c("dog", "cat", "fish", "bird"))
```

```
##      [,1]  
## [1,] "dog" 
## [2,] "cat" 
## [3,] "fish"
## [4,] "bird"
```

How do we make the matrices two dimensional? We have to add arguments to the matrix function. These are `nrow` and `ncol`. We use these to tell R how many rows or columns we want our matrix to have. 

```r
# matrix with 5 rows
matrix(1:10, nrow = 5)
```

```
##      [,1] [,2]
## [1,]    1    6
## [2,]    2    7
## [3,]    3    8
## [4,]    4    9
## [5,]    5   10
```

```r
matrix(1:10, ncol = 2)
```

```
##      [,1] [,2]
## [1,]    1    6
## [2,]    2    7
## [3,]    3    8
## [4,]    4    9
## [5,]    5   10
```

```r
# matrix with 5 cols
matrix(1:10, ncol = 5)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8   10
```

```r
matrix(1:10, nrow = 2)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8   10
```

You may have noticed that by default the matrix is filled by columns. In our example with 5 rows, the first column would be 1 to 5, and the second 6 to 10. We can change this behaviour to make the matrix be filled by rows. We use the `byrow` argument for this. 

```r
# fill by row with 5 cols
matrix(1:10, ncol = 5, byrow = TRUE)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    2    3    4    5
## [2,]    6    7    8    9   10
```

```r
# fill by row with 5 rows
matrix(1:10, nrow = 5, byrow = TRUE)
```

```
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
## [3,]    5    6
## [4,]    7    8
## [5,]    9   10
```

We can also add row and column names to make our data easier to read and use. There are two options for this, which are shown in the example below. The first uses the `dimnames` argument, the second uses the `colnames` and `rownames` functions. 

```r
# name rows and columns with dimnames
matrix(1:10, nrow = 5, byrow = TRUE,
       dimnames = list(c("row_a", "row_b", "row_c", "row_d", "row_e"),
                       c("col_a", "col_b")))
```

```
##       col_a col_b
## row_a     1     2
## row_b     3     4
## row_c     5     6
## row_d     7     8
## row_e     9    10
```

```r
# using colnames and rownames functions
mat <- matrix(1:10, nrow = 5, byrow = TRUE)

colnames(mat) <- c("col_a", "col_b")
rownames(mat) <- c("row_a", "row_b", "row_c", "row_d", "row_e")

mat
```

```
##       col_a col_b
## row_a     1     2
## row_b     3     4
## row_c     5     6
## row_d     7     8
## row_e     9    10
```

To index your matrix, we use square brackets (`[]`), just like a data frame. Remember that we separate the square brackets with a comma, with the first section being row index and second section the column index: `matrix[row_index, col_index]`

```r
# first row, all columns
mat[1, ]
```

```
## col_a col_b 
##     1     2
```

```r
# first col, all rows
mat[, 1]
```

```
## row_a row_b row_c row_d row_e 
##     1     3     5     7     9
```

```r
# first and last row, all cols
mat[c(1, 5), ]
```

```
##       col_a col_b
## row_a     1     2
## row_e     9    10
```

```r
# first three rows
mat[1:3, ]
```

```
##       col_a col_b
## row_a     1     2
## row_b     3     4
## row_c     5     6
```

As we have a matrix with named rows and columns, we can use them to index with instead of numbers. 

```r
# first column, all rows
mat[, "col_a"]
```

```
## row_a row_b row_c row_d row_e 
##     1     3     5     7     9
```

```r
# first row, all cols
mat["row_a", ]
```

```
## col_a col_b 
##     1     2
```

```r
# all cols, row a and e
mat[c("row_a", "row_e"), ]
```

```
##       col_a col_b
## row_a     1     2
## row_e     9    10
```

Finally, we can use the indexing to perform calculations on elements of the matrix. 

```r
# sum the first col
sum(mat[, 2])
```

```
## [1] 30
```

```r
# sum second col
sum(mat[, 1])
```

```
## [1] 25
```

```r
# sum both cols
sum(mat)
```

```
## [1] 55
```
When summing the whole matrix, this is done *columnwise*, this means that the sum of column 1 is added to the sum of column 2. 

## Intro to matricies exercise

Using the `dat` vector provided, try the following exercises:

1)  make a matrix called my_mat with three columns, print the outcome to view your matrix
2)  change the column and row names of your matrix. Your column names should be col_1, col_2 etc. and your row names should be row_1, row_2 etc.  *hint: this can be automated by using paste and seq functions: paste0("text", seq(1:5)*
3)  Print your matrix again to see your new col and row names
4)  Calculate the mean of all the values in your matrix, watch out for the NA value! 
5)  Find the mean of the third column of your matrix
6)  Find the mean of the first 5 rows, and first two columns of your matrix. 

```r
# data to use in the matrix
dat <- sample(c(1:29, NA), 30)

# your code here
# make matrix with 3 cols
my_mat <- matrix(dat, ncol = 3)
my_mat
```

```
##       [,1] [,2] [,3]
##  [1,]   NA   29    7
##  [2,]    3    4   24
##  [3,]   10   21    5
##  [4,]   15   27   12
##  [5,]   20    1   11
##  [6,]   13    9   22
##  [7,]   26   18   17
##  [8,]    2   14   19
##  [9,]    6    8   23
## [10,]   28   25   16
```

```r
# change col and row names
colnames(my_mat) <- paste0("col_", seq(1:3))
rownames(my_mat) <- paste0("row_", seq(1:10))

my_mat
```

```
##        col_1 col_2 col_3
## row_1     NA    29     7
## row_2      3     4    24
## row_3     10    21     5
## row_4     15    27    12
## row_5     20     1    11
## row_6     13     9    22
## row_7     26    18    17
## row_8      2    14    19
## row_9      6     8    23
## row_10    28    25    16
```

```r
# calculate mean of whole matrix
mean(my_mat, na.rm = TRUE)
```

```
## [1] 15
```

```r
# mean of col_3
mean(my_mat[, "col_3"], na.rm = TRUE)
```

```
## [1] 15.6
```

```r
# mean of specific cols and rows with paste
paste("The mean of the first 5 rows, and col 1 and 2 is:", mean(my_mat[5, 1:2], na.rm = TRUE))
```

```
## [1] "The mean of the first 5 rows, and col 1 and 2 is: 10.5"
```

# Converting data into and from matricies

When doing analysis with R, you sometimes come across analysis packages that require your data to be in the form of a matrix. How do you convert your data from an object like a data frame to a matrix? 

The first thing is to make sure you don't have any string (or character) data. If you do, you will have to remove it, or use it as a row index. 

If the string data isn't removed, all elements of your matrix will become string which isn't ideal! 

```r
# make a data frame with some random data
df <- data.frame(
  string = paste0("string", seq(1:10)),
  int = 1:10,
  samp = sample(1:20, 10),
  rand = runif(10, min = 1, max = 10),
  rand2 = rnorm(10, mean = 5, sd = 2)
)

# our col string is a character type
str(df)
```

```
## 'data.frame':	10 obs. of  5 variables:
##  $ string: chr  "string1" "string2" "string3" "string4" ...
##  $ int   : int  1 2 3 4 5 6 7 8 9 10
##  $ samp  : int  15 8 19 4 20 3 7 2 10 14
##  $ rand  : num  3.5 6.11 4.55 1.98 2.9 ...
##  $ rand2 : num  2.53 6.51 3.15 3.8 8.35 ...
```

As you can see we have a character variable, but we can move it to become a row name which can make indexing specific rows easier. 

```r
# make string a row name (or index)
rownames(df) <- df$string

# remove column using conditional logic
rem_col <- "string"
df <- df[, !colnames(df) %in% rem_col]

# review the output
head(df)
```

```
##         int samp     rand    rand2
## string1   1   15 3.501940 2.526364
## string2   2    8 6.106573 6.508874
## string3   3   19 4.549985 3.149848
## string4   4    4 1.979699 3.800586
## string5   5   20 2.899265 8.351228
## string6   6    3 7.949374 5.801176
```

Note that this is made a bit easier with the tidyverse. We can use the tibble package with the function `column_to_rownames()`, which in this example would like like `tibble::column_to_rownames(df, var = "string")`. 

To convert our data frame to a matrix, we use the `as.matrix()` function. By naming the columns and rows, it is easier to read once converted. 

```r
# convert to matrix
df_mat <- as.matrix(df)
head(df_mat)
```

```
##         int samp     rand    rand2
## string1   1   15 3.501940 2.526364
## string2   2    8 6.106573 6.508874
## string3   3   19 4.549985 3.149848
## string4   4    4 1.979699 3.800586
## string5   5   20 2.899265 8.351228
## string6   6    3 7.949374 5.801176
```

```r
# check the class
class(df_mat)
```

```
## [1] "matrix" "array"
```

We can do calculations on matrix elements and add them to the matrix using `cbind` or `rbind`. In the example, we will do a calculation on two columns, then use cbind to add that column to the matrix. Notice how this is slightly more difficult that doing similar with a data frame.  

```r
# make vector with calculation
calc <- (df_mat[, "samp"] * df_mat[, "rand"])/100
calc
```

```
##    string1    string2    string3    string4    string5    string6    string7 
## 0.52529106 0.48852583 0.86449709 0.07918797 0.57985309 0.23848122 0.49614931 
##    string8    string9   string10 
## 0.19340967 0.29987449 0.53917433
```

```r
# add to matrix as column
df_mat <- cbind(df_mat, calc)
df_mat
```

```
##          int samp     rand    rand2       calc
## string1    1   15 3.501940 2.526364 0.52529106
## string2    2    8 6.106573 6.508874 0.48852583
## string3    3   19 4.549985 3.149848 0.86449709
## string4    4    4 1.979699 3.800586 0.07918797
## string5    5   20 2.899265 8.351228 0.57985309
## string6    6    3 7.949374 5.801176 0.23848122
## string7    7    7 7.087847 6.282107 0.49614931
## string8    8    2 9.670483 4.036684 0.19340967
## string9    9   10 2.998745 7.001576 0.29987449
## string10  10   14 3.851245 8.764627 0.53917433
```

The output of some analysis functions, such as the base R `cor()` (correlation) function, returns a matrix. What if you want this to be a data frame or something similar? First, lets run the cor function on our matrix.

```r
# correlation matrix
df_cor <- cor(df_mat)
df_cor
```

```
##              int       samp       rand       rand2        calc
## int    1.0000000 -0.2473355  0.1988946  0.58537793 -0.29156507
## samp  -0.2473355  1.0000000 -0.5772129  0.16336137  0.84243175
## rand   0.1988946 -0.5772129  1.0000000 -0.10938054 -0.17777862
## rand2  0.5853779  0.1633614 -0.1093805  1.00000000  0.06254969
## calc  -0.2915651  0.8424318 -0.1777786  0.06254969  1.00000000
```

```r
# tidy up with round 
df_cor <- round(df_cor, 3)
df_cor
```

```
##          int   samp   rand  rand2   calc
## int    1.000 -0.247  0.199  0.585 -0.292
## samp  -0.247  1.000 -0.577  0.163  0.842
## rand   0.199 -0.577  1.000 -0.109 -0.178
## rand2  0.585  0.163 -0.109  1.000  0.063
## calc  -0.292  0.842 -0.178  0.063  1.000
```

```r
# check class of output
class(df_cor)
```

```
## [1] "matrix" "array"
```

When reviewing the output of a correlation, the closer the output is to one, the more related (linearly) the two variables are. More information on correlations can be found here: <http://www.r-tutor.com/elementary-statistics/numerical-measures/correlation-coefficient>

We can convert the correlation matrix into a data frame with the `as.data.frame()` function. This allows us to use data frame specific indexing again, such as using the dollar sign (`$`). 

```r
# convert matrix to data frame
df_cor <- as.data.frame(df_cor)
df_cor
```

```
##          int   samp   rand  rand2   calc
## int    1.000 -0.247  0.199  0.585 -0.292
## samp  -0.247  1.000 -0.577  0.163  0.842
## rand   0.199 -0.577  1.000 -0.109 -0.178
## rand2  0.585  0.163 -0.109  1.000  0.063
## calc  -0.292  0.842 -0.178  0.063  1.000
```

```r
df_cor$int
```

```
## [1]  1.000 -0.247  0.199  0.585 -0.292
```

## Converting matricies exercise

In this exercise you will be debugging my code! 

We will be using data from Cristiano Ronaldo the famous footballer. If the code runs correctly, you should have a matrix at the end with his most prolific goal scoring seasons. 

There are 5 errors in total to find and fix! 

```r
# load in ronaldo career data
ronaldo <- readcsv("https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/ronaldo_club.csv")
```

```
## Error in readcsv("https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/ronaldo_club.csv"): could not find function "readcsv"
```

```r
# view data
head(ronaldo)
```

```
## Error in head(ronaldo): object 'ronaldo' not found
```

```r
# remove the first row
ronaldo <- ronaldo[-1, ]
```

```
## Error in eval(expr, envir, enclos): object 'ronaldo' not found
```

```r
# make season the row name
rowname(ronaldo) <- ronaldo$season
```

```
## Error in eval(expr, envir, enclos): object 'ronaldo' not found
```

```r
rem_col <- c("club", "season", "league")
ronaldo <- ronaldo[, colnames(ronaldo) %in% rem_col]
```

```
## Error in eval(expr, envir, enclos): object 'ronaldo' not found
```

```r
# make matrix
ronaldo_mat <- as.matrix(ronaldo)
```

```
## Error in as.matrix(ronaldo): object 'ronaldo' not found
```

```r
# add total goal ratio to matrix
goal_ratio <- ronaldo_mat[ "total_goals"]/ronaldo_mat[, "total_apps"]
```

```
## Error in eval(expr, envir, enclos): object 'ronaldo_mat' not found
```

```r
ronaldo_mat <- cbind(ronaldo_mat, goal_ratio)
```

```
## Error in cbind(ronaldo_mat, goal_ratio): object 'ronaldo_mat' not found
```

```r
# which year had the best goal ratios
ronaldo_best <- ronaldomat[ronaldo_mat[, "goal_ratio"] > 1, c("total_apps", "total_goals", "goal_ratio")]
```

```
## Error in eval(expr, envir, enclos): object 'ronaldomat' not found
```

```r
ronaldo_best
```

```
## Error in eval(expr, envir, enclos): object 'ronaldo_best' not found
```


```r
# solution!
# load in ronaldo career data
ronaldo <- read.csv("https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/ronaldo_club.csv")

# view data
head(ronaldo)
```

```
##                club  season            league league_apps league_goals
## 1     Sporting CP B 2002–03 Segunda Divisão B           2            0
## 2       Sporting CP 2002–03     Primeira Liga          25            3
## 3 Manchester United 2003–04    Premier League          29            4
## 4 Manchester United 2004–05    Premier League          33            5
## 5 Manchester United 2005–06    Premier League          33            9
## 6 Manchester United 2006–07    Premier League          34           17
##   national_cup_apps national_cup_goals league_cup_apps league_cup_goals
## 1                NA                 NA              NA               NA
## 2                 3                  2              NA               NA
## 3                 5                  2               1                0
## 4                 7                  4               2                0
## 5                 2                  0               4                2
## 6                 7                  3               1                0
##   europe_cup_apps europe_cup_goals other_apps other_goals total_apps
## 1              NA               NA         NA          NA          2
## 2               3                0          0           0         31
## 3               5                0          0           0         40
## 4               8                0          0           0         50
## 5               8                1         NA          NA         47
## 6              11                3         NA          NA         53
##   total_goals
## 1           0
## 2           5
## 3           6
## 4           9
## 5          12
## 6          23
```

```r
# remove the first row
ronaldo <- ronaldo[-1, ]

# make season the row name
rownames(ronaldo) <- ronaldo$season
rem_col <- c("club", "season", "league")
ronaldo <- ronaldo[, !colnames(ronaldo) %in% rem_col]

# make matrix
ronaldo_mat <- as.matrix(ronaldo)

# add total goal ratio to matrix
goal_ratio <- ronaldo_mat[, "total_goals"]/ronaldo_mat[, "total_apps"]
ronaldo_mat <- cbind(ronaldo_mat, goal_ratio)

# which year had the best goal ratios
ronaldo_best <- ronaldo_mat[ronaldo_mat[, "goal_ratio"] > 1, c("total_apps", "total_goals", "goal_ratio")]
ronaldo_best
```

```
##         total_apps total_goals goal_ratio
## 2011–12         55          60   1.090909
## 2013–14         47          51   1.085106
## 2014–15         54          61   1.129630
## 2015–16         48          51   1.062500
```

# Introduction to lists

A list is a vector that can contain different data types. This makes lists very useful for storing information in a compact format, as they can hold any information. 

Why is it important to learn about how to work with lists in R? There are two key reasons. 

*  First is you'll find when using statistics packages in R the model and model information are stored in lists once the model is run, so learning how to access lists is vital to getting that information
*  Second, if you have a lot of data you want to load into R at once, such as several data frames, R will put all of these into a list when loaded into R.  

Generally is is always easier to work with data, such as a data frame, outside of a list. However, it is useful to be able to store information in lists and learn how to access the information in them. 

To construct lists in R we use the `list()` function. As you can see it can hold any data type. 

```r
list_info1 <- list("Andrew", 31, TRUE, c("Stegosaurs", "Allosaurus", "diplodocus"))
list_info1
```

```
## [[1]]
## [1] "Andrew"
## 
## [[2]]
## [1] 31
## 
## [[3]]
## [1] TRUE
## 
## [[4]]
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

When we print the list each element is printed with its index. Notice that some have double square brackets. But what does that mean? This effects how we index them and what the output is. 

In the example list (list_info1) the 4th element is a vector of strings. If we access that element using single square brackets we get back a list. Run the example below to test this out. 

```r
# access 4th element of list
list_info1[4]
```

```
## [[1]]
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

```r
# move to a variable
dino_list <- list_info1[4]
# test the object type
str(dino_list)
```

```
## List of 1
##  $ : chr [1:3] "Stegosaurs" "Allosaurus" "diplodocus"
```

If we want to get access to the 4th element as a vector, instead of a list, we have to use double square brackets to access it. Test out the code below, where we extract the 4th element to make it a vector. 

```r
# access 4th element of list
list_info1[[4]]
```

```
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

```r
# move to a vector
dinos <- list_info1[[4]]
# test the object type
str(dinos)
```

```
##  chr [1:3] "Stegosaurs" "Allosaurus" "diplodocus"
```

To access the different elements of a vector in a list we need to add more square brackets after the double square brackets (yes, it is a lot of brackets!). 

```r
# index elements 2 and 3
list_info1[[4]][2:3]
```

```
## [1] "Allosaurus" "diplodocus"
```

```r
# index first element
list_info1[[4]][1]
```

```
## [1] "Stegosaurs"
```

We can also add names to the elements in our list. This makes the elements easier to access and identify what each element is. 

There are two ways of doing this. The first option uses the `names()` function. The second option adds names to elements when adding them to the list. See how to do both in the example below.

```r
# using names function
names(list_info1) <- c("name", "age", "like_dinosaurs", "fav_dinosaurs")
list_info1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

```r
# adding names directly into list function
list_info1 <- list(name = "Andrew", age = 31, like_dinosaurs = TRUE, fav_dinosaurs = c("Stegosaurs", "Allosaurus", "diplodocus"))
list_info1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

We can now use the dollar sign `$` to access the names of the elements in our list, which means a lot less brackets. We can also use double square brackets with the name. 

```r
# index vector
list_info1$fav_dinosaurs
```

```
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

```r
# index vector and 2nd element
list_info1$fav_dinosaurs[2]
```

```
## [1] "Allosaurus"
```

```r
# square brackets with name
list_info1[["fav_dinosaurs"]]
```

```
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

We can also add and remove elements from a list. 

```r
# add another element to the list
list_info1[5] <- "New element"

list_info1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
## 
## [[5]]
## [1] "New element"
```

```r
# remove that element
list_info1[5] <- NULL

list_info1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
```

If we want to add a vector, we need to use the double square brackets. Or we can use the dollar sign to name the new element in the list. 

```r
# add vector to a list (need double brackets)
list_info1[[5]] <- seq(0, 60, by = 6)

# use name to make new element
list_info1$four_times_table <- seq(0, 40, by = 4)

list_info1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus"
## 
## [[5]]
##  [1]  0  6 12 18 24 30 36 42 48 54 60
## 
## $four_times_table
##  [1]  0  4  8 12 16 20 24 28 32 36 40
```

We can also add information to elements within the list. This is made easier and clearer by naming. 

```r
# add another dinosaur to our vector within the list
list_info1$fav_dinosaurs[4] <- "Utahraptor"

list_info1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus" "Utahraptor"
## 
## [[5]]
##  [1]  0  6 12 18 24 30 36 42 48 54 60
## 
## $four_times_table
##  [1]  0  4  8 12 16 20 24 28 32 36 40
```

## Introduction to lists exercise

In this exercise we will practice working with and making lists. 

1)  Make a list called `my_list` with the following information: a string with your location (e.g. UK, France etc.), a number sequence of 1 to 5,and a vector of your favourite foods, for example mine are cheesecake, tomatoes, and bread. Be sure to add names to each element in your list! 
2)  Add the number 10 to the second element of your list. Print the list out to review the output
3)  Add another element to your list called nine_times_table, use the seq function to make this like we did in the examples above
4)  Remove the second element of your list (the number sequence). Print your list to review the output
5)  Make a vector called fav_foods, and extract the fav_foods element of your list to that vector. Print that vector to check the output


```r
# your code here
my_list <- list(location = "UK", numbers = 1:5, fav_foods = c("Cheesecake", "Tomatoes", "Bread"))

my_list[[2]][6] <- 10
my_list$numbers[6] <- 10

my_list$numbers
```

```
## [1]  1  2  3  4  5 10
```

```r
my_list$nine_times_table <- seq(0,90, by = 9)

my_list$numbers <- NULL

my_list
```

```
## $location
## [1] "UK"
## 
## $fav_foods
## [1] "Cheesecake" "Tomatoes"   "Bread"     
## 
## $nine_times_table
##  [1]  0  9 18 27 36 45 54 63 72 81 90
```

```r
fav_foods <- my_list$fav_foods
fav_foods
```

```
## [1] "Cheesecake" "Tomatoes"   "Bread"
```


# List of lists

Lists can be combined to become lists of lists. This is helpful if you have lots of lists of information, or want to tidy up your global environment and store everything in one list. 

```r
# make some more lists with information
list_info2 <- list(name = "Margaret", age = 22, like_dinosaurs = FALSE)

list_info3 <- list(name = "Sofia", age = 19, like_dinosaurs = TRUE, fav_dinosaurs = c("Deinonychus‭", "Ornithomimus"))

# data frame to put into a list
dino_df <- data.frame(
  dinosaur = c("Archaeopteryx", "T-Rex", "Triceratops"),
  scary = c(FALSE, TRUE, TRUE),
  coolness = rep(10, 3)
)

# add all lists and data into another list
list_all <- list(list_info1, list_info2, list_info3, dino_df)

# review the list of lists
str(list_all)
```

```
## List of 4
##  $ :List of 6
##   ..$ name            : chr "Andrew"
##   ..$ age             : num 31
##   ..$ like_dinosaurs  : logi TRUE
##   ..$ fav_dinosaurs   : chr [1:4] "Stegosaurs" "Allosaurus" "diplodocus" "Utahraptor"
##   ..$                 : num [1:11] 0 6 12 18 24 30 36 42 48 54 ...
##   ..$ four_times_table: num [1:11] 0 4 8 12 16 20 24 28 32 36 ...
##  $ :List of 3
##   ..$ name          : chr "Margaret"
##   ..$ age           : num 22
##   ..$ like_dinosaurs: logi FALSE
##  $ :List of 4
##   ..$ name          : chr "Sofia"
##   ..$ age           : num 19
##   ..$ like_dinosaurs: logi TRUE
##   ..$ fav_dinosaurs : chr [1:2] "Deinonychus‭" "Ornithomimus"
##  $ :'data.frame':	3 obs. of  3 variables:
##   ..$ dinosaur: chr [1:3] "Archaeopteryx" "T-Rex" "Triceratops"
##   ..$ scary   : logi [1:3] FALSE TRUE TRUE
##   ..$ coolness: num [1:3] 10 10 10
```

Just like when we made a list previously we can name each list in the list. Again, there are two methods. 

```r
# naming in the list
list_all <- list(person1 = list_info1, person2 = list_info2, person3 = list_info3, dino_data = dino_df)
# using the names function
names(list_all) <- c("person1", "person2", "person3", "dino_data")
# view the names
str(list_all)
```

```
## List of 4
##  $ person1  :List of 6
##   ..$ name            : chr "Andrew"
##   ..$ age             : num 31
##   ..$ like_dinosaurs  : logi TRUE
##   ..$ fav_dinosaurs   : chr [1:4] "Stegosaurs" "Allosaurus" "diplodocus" "Utahraptor"
##   ..$                 : num [1:11] 0 6 12 18 24 30 36 42 48 54 ...
##   ..$ four_times_table: num [1:11] 0 4 8 12 16 20 24 28 32 36 ...
##  $ person2  :List of 3
##   ..$ name          : chr "Margaret"
##   ..$ age           : num 22
##   ..$ like_dinosaurs: logi FALSE
##  $ person3  :List of 4
##   ..$ name          : chr "Sofia"
##   ..$ age           : num 19
##   ..$ like_dinosaurs: logi TRUE
##   ..$ fav_dinosaurs : chr [1:2] "Deinonychus‭" "Ornithomimus"
##  $ dino_data:'data.frame':	3 obs. of  3 variables:
##   ..$ dinosaur: chr [1:3] "Archaeopteryx" "T-Rex" "Triceratops"
##   ..$ scary   : logi [1:3] FALSE TRUE TRUE
##   ..$ coolness: num [1:3] 10 10 10
```

How do we index lists and elements in lists of lists? If we have named the lists we have the option to use the dollar sign again, use square brackets, or both together. 

Below are examples of three different ways to access a list within a list.

```r
# different ways to access lists
list_all[["person1"]]
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus" "Utahraptor"
## 
## [[5]]
##  [1]  0  6 12 18 24 30 36 42 48 54 60
## 
## $four_times_table
##  [1]  0  4  8 12 16 20 24 28 32 36 40
```

```r
list_all[[1]]
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus" "Utahraptor"
## 
## [[5]]
##  [1]  0  6 12 18 24 30 36 42 48 54 60
## 
## $four_times_table
##  [1]  0  4  8 12 16 20 24 28 32 36 40
```

```r
list_all$person1
```

```
## $name
## [1] "Andrew"
## 
## $age
## [1] 31
## 
## $like_dinosaurs
## [1] TRUE
## 
## $fav_dinosaurs
## [1] "Stegosaurs" "Allosaurus" "diplodocus" "Utahraptor"
## 
## [[5]]
##  [1]  0  6 12 18 24 30 36 42 48 54 60
## 
## $four_times_table
##  [1]  0  4  8 12 16 20 24 28 32 36 40
```

We can add another dollar sign or double square brackets to access elements within the list of lists. In this case we are looking in the person3 list, and accessing the fav_dinosaurs element. 

```r
# access elements of list of lists
list_all[["person3"]][["fav_dinosaurs"]]
```

```
## [1] "Deinonychus‭"  "Ornithomimus"
```

```r
list_all$person3$fav_dinosaurs
```

```
## [1] "Deinonychus‭"  "Ornithomimus"
```

To access specific data within those elements we need to use single square brackets

```r
# access elements of data within the lists
list_all[["person3"]][["fav_dinosaurs"]][1]
```

```
## [1] "Deinonychus‭"
```

```r
list_all$person3$fav_dinosaurs[1]
```

```
## [1] "Deinonychus‭"
```

Dealing with data frames in a list is the same concept. We have a sequence of double square bracket calls or dollar signs to get information. 

```r
# index data frame from list
list_all[["dino_data"]]
```

```
##        dinosaur scary coolness
## 1 Archaeopteryx FALSE       10
## 2         T-Rex  TRUE       10
## 3   Triceratops  TRUE       10
```

```r
list_all$dino_data
```

```
##        dinosaur scary coolness
## 1 Archaeopteryx FALSE       10
## 2         T-Rex  TRUE       10
## 3   Triceratops  TRUE       10
```

To index a column we can name it using the dollar sign or double square brackets.  

```r
# index column in data frame
list_all$dino_data$dinosaur
```

```
## [1] "Archaeopteryx" "T-Rex"         "Triceratops"
```

```r
list_all[["dino_data"]][["dinosaur"]]
```

```
## [1] "Archaeopteryx" "T-Rex"         "Triceratops"
```

Index a row using the square brackets with row and column index, like we did earlier with matrices. In the example we are indexing the second row and all columns.

```r
# index row in data frame
list_all$dino_data[2, ]
```

```
##   dinosaur scary coolness
## 2    T-Rex  TRUE       10
```

```r
list_all[["dino_data"]][2, ]
```

```
##   dinosaur scary coolness
## 2    T-Rex  TRUE       10
```

Indexing rows and columns by using square brackets again, but entering names for the column index. 

```r
# index column and row from data frame
list_all$dino_data[2, c("dinosaur", "scary")]
```

```
##   dinosaur scary
## 2    T-Rex  TRUE
```

```r
list_all[["dino_data"]][2, c("dinosaur", "scary")]
```

```
##   dinosaur scary
## 2    T-Rex  TRUE
```

## list of lists exercise



# Loading in lots of data into R


```r
urls <- c(pokemon = "https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/pokemon.csv", 
ronaldo = "https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/ronaldo_club.csv",
messi = "https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/messi_club.csv")

data_files <- lapply(urls, read.csv)

str(data_files)
```

```
## List of 3
##  $ pokemon:'data.frame':	953 obs. of  13 variables:
##   ..$ Number   : int [1:953] 1 2 3 4 5 6 7 8 9 10 ...
##   ..$ Name     : chr [1:953] "Bulbasaur" "Ivysaur" "Venusaur" "Charmander" ...
##   ..$ Type1    : chr [1:953] "Grass" "Grass" "Grass" "Fire" ...
##   ..$ Type2    : chr [1:953] "Poison" "Poison" "Poison" NA ...
##   ..$ Total    : int [1:953] 318 405 525 309 405 534 314 405 530 195 ...
##   ..$ HP       : int [1:953] 45 60 80 39 58 78 44 59 79 45 ...
##   ..$ Attack   : int [1:953] 49 62 82 52 64 84 48 63 83 30 ...
##   ..$ Defense  : int [1:953] 49 63 83 43 58 78 65 80 100 35 ...
##   ..$ Sp..Atk  : int [1:953] 65 80 100 60 80 109 50 65 85 20 ...
##   ..$ Sp..Def  : int [1:953] 65 80 100 50 65 85 64 80 105 20 ...
##   ..$ Speed    : int [1:953] 45 60 80 65 80 100 43 58 78 45 ...
##   ..$ legendary: logi [1:953] FALSE FALSE FALSE FALSE FALSE FALSE ...
##   ..$ gen      : int [1:953] 1 1 1 1 1 1 1 1 1 1 ...
##  $ ronaldo:'data.frame':	20 obs. of  15 variables:
##   ..$ club              : chr [1:20] "Sporting CP B" "Sporting CP" "Manchester United" "Manchester United" ...
##   ..$ season            : chr [1:20] "2002–03" "2002–03" "2003–04" "2004–05" ...
##   ..$ league            : chr [1:20] "Segunda Divisão B" "Primeira Liga" "Premier League" "Premier League" ...
##   ..$ league_apps       : int [1:20] 2 25 29 33 33 34 34 33 29 34 ...
##   ..$ league_goals      : int [1:20] 0 3 4 5 9 17 31 18 26 40 ...
##   ..$ national_cup_apps : int [1:20] NA 3 5 7 2 7 3 2 0 8 ...
##   ..$ national_cup_goals: int [1:20] NA 2 2 4 0 3 3 1 0 7 ...
##   ..$ league_cup_apps   : int [1:20] NA NA 1 2 4 1 0 4 NA NA ...
##   ..$ league_cup_goals  : int [1:20] NA NA 0 0 2 0 0 2 NA NA ...
##   ..$ europe_cup_apps   : int [1:20] NA 3 5 8 8 11 11 12 6 12 ...
##   ..$ europe_cup_goals  : int [1:20] NA 0 0 0 1 3 8 4 7 6 ...
##   ..$ other_apps        : int [1:20] NA 0 0 0 NA NA 1 2 NA NA ...
##   ..$ other_goals       : int [1:20] NA 0 0 0 NA NA 0 1 NA NA ...
##   ..$ total_apps        : int [1:20] 2 31 40 50 47 53 49 53 35 54 ...
##   ..$ total_goals       : int [1:20] 0 5 6 9 12 23 42 26 33 53 ...
##  $ messi  :'data.frame':	20 obs. of  14 variables:
##   ..$ club                  : chr [1:20] "Barcelona C" "Barcelona B" "Barcelona B" "Barcelona" ...
##   ..$ season                : chr [1:20] "2003–04" "2003–04" "2004–05" "2004–05" ...
##   ..$ league                : chr [1:20] "Tercera División" "Segunda División B" "Segunda División B" "La Liga" ...
##   ..$ league_apps           : int [1:20] 10 5 17 7 17 26 28 31 35 33 ...
##   ..$ league_goals          : int [1:20] 5 0 6 1 6 14 10 23 34 31 ...
##   ..$ copa_del_rey_apps     : int [1:20] NA NA NA 1 2 2 3 8 3 7 ...
##   ..$ copa_del_rey_goals    : int [1:20] NA NA NA 0 1 2 0 6 1 7 ...
##   ..$ champions_league_apps : int [1:20] NA NA NA 1 6 5 9 12 11 13 ...
##   ..$ champions_league_goals: int [1:20] NA NA NA 0 1 1 6 9 8 12 ...
##   ..$ other_apps            : int [1:20] NA NA NA NA 0 3 NA NA 4 2 ...
##   ..$ other_goals           : int [1:20] NA NA NA NA 0 0 NA NA 4 3 ...
##   ..$ total_apps            : int [1:20] 10 5 17 9 25 36 40 51 53 55 ...
##   ..$ total_goals           : int [1:20] 5 0 6 1 8 17 16 38 47 53 ...
##   ..$ year                  : int [1:20] 2003 2003 2004 2004 2005 2006 2007 2008 2009 2010 ...
```

```r
data_files$pokemon
```

```
##     Number                          Name    Type1    Type2 Total  HP Attack
## 1        1                     Bulbasaur    Grass   Poison   318  45     49
## 2        2                       Ivysaur    Grass   Poison   405  60     62
## 3        3                      Venusaur    Grass   Poison   525  80     82
## 4        4                    Charmander     Fire     <NA>   309  39     52
## 5        5                    Charmeleon     Fire     <NA>   405  58     64
## 6        6                     Charizard     Fire   Flying   534  78     84
## 7        7                      Squirtle    Water     <NA>   314  44     48
## 8        8                     Wartortle    Water     <NA>   405  59     63
## 9        9                     Blastoise    Water     <NA>   530  79     83
## 10      10                      Caterpie      Bug     <NA>   195  45     30
## 11      11                       Metapod      Bug     <NA>   205  50     20
## 12      12                    Butterfree      Bug   Flying   395  60     45
## 13      13                        Weedle      Bug   Poison   195  40     35
## 14      14                        Kakuna      Bug   Poison   205  45     25
## 15      15                      Beedrill      Bug   Poison   395  65     90
## 16      16                        Pidgey   Normal   Flying   251  40     45
## 17      17                     Pidgeotto   Normal   Flying   349  63     60
## 18      18                       Pidgeot   Normal   Flying   479  83     80
## 19      19                       Rattata   Normal     <NA>   253  30     56
## 20      20                      Raticate   Normal     <NA>   413  55     81
## 21      21                       Spearow   Normal   Flying   262  40     60
## 22      22                        Fearow   Normal   Flying   442  65     90
## 23      23                         Ekans   Poison     <NA>   288  35     60
## 24      24                         Arbok   Poison     <NA>   448  60     95
## 25      25                       Pikachu Electric     <NA>   320  35     55
## 26      26                        Raichu Electric     <NA>   485  60     90
## 27      27                     Sandshrew   Ground     <NA>   300  50     75
## 28      28                     Sandslash   Ground     <NA>   450  75    100
## 29      29                      Nidoran♀   Poison     <NA>   275  55     47
## 30      30                      Nidorina   Poison     <NA>   365  70     62
## 31      31                     Nidoqueen   Poison   Ground   505  90     92
## 32      32                      Nidoran♂   Poison     <NA>   273  46     57
## 33      33                      Nidorino   Poison     <NA>   365  61     72
## 34      34                      Nidoking   Poison   Ground   505  81    102
## 35      35                      Clefairy    Fairy     <NA>   323  70     45
## 36      36                      Clefable    Fairy     <NA>   483  95     70
## 37      37                        Vulpix     Fire     <NA>   299  38     41
## 38      38                     Ninetales     Fire     <NA>   505  73     76
## 39      39                    Jigglypuff   Normal    Fairy   270 115     45
## 40      40                    Wigglytuff   Normal    Fairy   435 140     70
## 41      41                         Zubat   Poison   Flying   245  40     45
## 42      42                        Golbat   Poison   Flying   455  75     80
## 43      43                        Oddish    Grass   Poison   320  45     50
## 44      44                         Gloom    Grass   Poison   395  60     65
## 45      45                     Vileplume    Grass   Poison   490  75     80
## 46      46                         Paras      Bug    Grass   285  35     70
## 47      47                      Parasect      Bug    Grass   405  60     95
## 48      48                       Venonat      Bug   Poison   305  60     55
## 49      49                      Venomoth      Bug   Poison   450  70     65
## 50      50                       Diglett   Ground     <NA>   265  10     55
## 51      51                       Dugtrio   Ground     <NA>   425  35    100
## 52      52                        Meowth   Normal     <NA>   290  40     45
## 53      53                       Persian   Normal     <NA>   440  65     70
## 54      54                       Psyduck    Water     <NA>   320  50     52
## 55      55                       Golduck    Water     <NA>   500  80     82
## 56      56                        Mankey Fighting     <NA>   305  40     80
## 57      57                      Primeape Fighting     <NA>   455  65    105
## 58      58                     Growlithe     Fire     <NA>   350  55     70
## 59      59                      Arcanine     Fire     <NA>   555  90    110
## 60      60                       Poliwag    Water     <NA>   300  40     50
## 61      61                     Poliwhirl    Water     <NA>   385  65     65
## 62      62                     Poliwrath    Water Fighting   510  90     95
## 63      63                          Abra  Psychic     <NA>   310  25     20
## 64      64                       Kadabra  Psychic     <NA>   400  40     35
## 65      65                      Alakazam  Psychic     <NA>   500  55     50
## 66      66                        Machop Fighting     <NA>   305  70     80
## 67      67                       Machoke Fighting     <NA>   405  80    100
## 68      68                       Machamp Fighting     <NA>   505  90    130
## 69      69                    Bellsprout    Grass   Poison   300  50     75
## 70      70                    Weepinbell    Grass   Poison   390  65     90
## 71      71                    Victreebel    Grass   Poison   490  80    105
## 72      72                     Tentacool    Water   Poison   335  40     40
## 73      73                    Tentacruel    Water   Poison   515  80     70
## 74      74                       Geodude     Rock   Ground   300  40     80
## 75      75                      Graveler     Rock   Ground   390  55     95
## 76      76                         Golem     Rock   Ground   495  80    120
## 77      77                        Ponyta     Fire     <NA>   410  50     85
## 78      78                      Rapidash     Fire     <NA>   500  65    100
## 79      79                      Slowpoke    Water  Psychic   315  90     65
## 80      80                       Slowbro    Water  Psychic   490  95     75
## 81      81                     Magnemite Electric    Steel   325  25     35
## 82      82                      Magneton Electric    Steel   465  50     60
## 83      83                    Farfetch'd   Normal   Flying   377  52     90
## 84      84                         Doduo   Normal   Flying   310  35     85
## 85      85                        Dodrio   Normal   Flying   470  60    110
## 86      86                          Seel    Water     <NA>   325  65     45
## 87      87                       Dewgong    Water      Ice   475  90     70
## 88      88                        Grimer   Poison     <NA>   325  80     80
## 89      89                           Muk   Poison     <NA>   500 105    105
## 90      90                      Shellder    Water     <NA>   305  30     65
## 91      91                      Cloyster    Water      Ice   525  50     95
## 92      92                        Gastly    Ghost   Poison   310  30     35
## 93      93                       Haunter    Ghost   Poison   405  45     50
## 94      94                        Gengar    Ghost   Poison   500  60     65
## 95      95                          Onix     Rock   Ground   385  35     45
## 96      96                       Drowzee  Psychic     <NA>   328  60     48
## 97      97                         Hypno  Psychic     <NA>   483  85     73
## 98      98                        Krabby    Water     <NA>   325  30    105
## 99      99                       Kingler    Water     <NA>   475  55    130
## 100    100                       Voltorb Electric     <NA>   330  40     30
## 101    101                     Electrode Electric     <NA>   490  60     50
## 102    102                     Exeggcute    Grass  Psychic   325  60     40
## 103    103                     Exeggutor    Grass  Psychic   530  95     95
## 104    104                        Cubone   Ground     <NA>   320  50     50
## 105    105                       Marowak   Ground     <NA>   425  60     80
## 106    106                     Hitmonlee Fighting     <NA>   455  50    120
## 107    107                    Hitmonchan Fighting     <NA>   455  50    105
## 108    108                     Lickitung   Normal     <NA>   385  90     55
## 109    109                       Koffing   Poison     <NA>   340  40     65
## 110    110                       Weezing   Poison     <NA>   490  65     90
## 111    111                       Rhyhorn   Ground     Rock   345  80     85
## 112    112                        Rhydon   Ground     Rock   485 105    130
## 113    113                       Chansey   Normal     <NA>   450 250      5
## 114    114                       Tangela    Grass     <NA>   435  65     55
## 115    115                    Kangaskhan   Normal     <NA>   490 105     95
## 116    116                        Horsea    Water     <NA>   295  30     40
## 117    117                        Seadra    Water     <NA>   440  55     65
## 118    118                       Goldeen    Water     <NA>   320  45     67
## 119    119                       Seaking    Water     <NA>   450  80     92
## 120    120                        Staryu    Water     <NA>   340  30     45
## 121    121                       Starmie    Water  Psychic   520  60     75
## 122    122                      Mr. Mime  Psychic    Fairy   460  40     45
## 123    123                       Scyther      Bug   Flying   500  70    110
## 124    124                          Jynx      Ice  Psychic   455  65     50
## 125    125                    Electabuzz Electric     <NA>   490  65     83
## 126    126                        Magmar     Fire     <NA>   495  65     95
## 127    127                        Pinsir      Bug     <NA>   500  65    125
## 128    128                        Tauros   Normal     <NA>   490  75    100
## 129    129                      Magikarp    Water     <NA>   200  20     10
## 130    130                      Gyarados    Water   Flying   540  95    125
## 131    131                        Lapras    Water      Ice   535 130     85
## 132    132                         Ditto   Normal     <NA>   288  48     48
## 133    133                         Eevee   Normal     <NA>   325  55     55
## 134    134                      Vaporeon    Water     <NA>   525 130     65
## 135    135                       Jolteon Electric     <NA>   525  65     65
## 136    136                       Flareon     Fire     <NA>   525  65    130
## 137    137                       Porygon   Normal     <NA>   395  65     60
## 138    138                       Omanyte     Rock    Water   355  35     40
## 139    139                       Omastar     Rock    Water   495  70     60
## 140    140                        Kabuto     Rock    Water   355  30     80
## 141    141                      Kabutops     Rock    Water   495  60    115
## 142    142                    Aerodactyl     Rock   Flying   515  80    105
## 143    143                       Snorlax   Normal     <NA>   540 160    110
## 144    144                      Articuno      Ice   Flying   580  90     85
## 145    145                        Zapdos Electric   Flying   580  90     90
## 146    146                       Moltres     Fire   Flying   580  90    100
## 147    147                       Dratini   Dragon     <NA>   300  41     64
## 148    148                     Dragonair   Dragon     <NA>   420  61     84
## 149    149                     Dragonite   Dragon   Flying   600  91    134
## 150    150                        Mewtwo  Psychic     <NA>   680 106    110
## 151    151                           Mew  Psychic     <NA>   600 100    100
## 152    152                     Chikorita    Grass     <NA>   318  45     49
## 153    153                       Bayleef    Grass     <NA>   405  60     62
## 154    155                     Cyndaquil     Fire     <NA>   309  39     52
## 155    156                       Quilava     Fire     <NA>   405  58     64
## 156    157                    Typhlosion     Fire     <NA>   534  78     84
## 157    158                      Totodile    Water     <NA>   314  50     65
## 158    159                      Croconaw    Water     <NA>   405  65     80
## 159    160                    Feraligatr    Water     <NA>   530  85    105
## 160    161                       Sentret   Normal     <NA>   215  35     46
## 161    162                        Furret   Normal     <NA>   415  85     76
## 162    163                      Hoothoot   Normal   Flying   262  60     30
## 163    164                       Noctowl   Normal   Flying   452 100     50
## 164    165                        Ledyba      Bug   Flying   265  40     20
## 165    166                        Ledian      Bug   Flying   390  55     35
## 166    167                      Spinarak      Bug   Poison   250  40     60
## 167    168                       Ariados      Bug   Poison   400  70     90
## 168    169                        Crobat   Poison   Flying   535  85     90
## 169    170                      Chinchou    Water Electric   330  75     38
## 170    171                       Lanturn    Water Electric   460 125     58
## 171    172                         Pichu Electric     <NA>   205  20     40
## 172    173                        Cleffa    Fairy     <NA>   218  50     25
## 173    174                     Igglybuff   Normal    Fairy   210  90     30
## 174    175                        Togepi    Fairy     <NA>   245  35     20
## 175    176                       Togetic    Fairy   Flying   405  55     40
## 176    177                          Natu  Psychic   Flying   320  40     50
## 177    178                          Xatu  Psychic   Flying   470  65     75
## 178    179                        Mareep Electric     <NA>   280  55     40
## 179    180                       Flaaffy Electric     <NA>   365  70     55
## 180    181                      Ampharos Electric     <NA>   510  90     75
## 181    182                     Bellossom    Grass     <NA>   490  75     80
## 182    183                        Marill    Water    Fairy   250  70     20
## 183    184                     Azumarill    Water    Fairy   420 100     50
## 184    185                     Sudowoodo     Rock     <NA>   410  70    100
## 185    186                      Politoed    Water     <NA>   500  90     75
## 186    187                        Hoppip    Grass   Flying   250  35     35
## 187    188                      Skiploom    Grass   Flying   340  55     45
## 188    189                      Jumpluff    Grass   Flying   460  75     55
## 189    190                         Aipom   Normal     <NA>   360  55     70
## 190    191                       Sunkern    Grass     <NA>   180  30     30
## 191    192                      Sunflora    Grass     <NA>   425  75     75
## 192    193                         Yanma      Bug   Flying   390  65     65
## 193    194                        Wooper    Water   Ground   210  55     45
## 194    195                      Quagsire    Water   Ground   430  95     85
## 195    196                        Espeon  Psychic     <NA>   525  65     65
## 196    197                       Umbreon     Dark     <NA>   525  95     65
## 197    198                       Murkrow     Dark   Flying   405  60     85
## 198    199                      Slowking    Water  Psychic   490  95     75
## 199    200                    Misdreavus    Ghost     <NA>   435  60     60
## 200    201                         Unown  Psychic     <NA>   336  48     72
## 201    202                     Wobbuffet  Psychic     <NA>   405 190     33
## 202    203                     Girafarig   Normal  Psychic   455  70     80
## 203    204                        Pineco      Bug     <NA>   290  50     65
## 204    205                    Forretress      Bug    Steel   465  75     90
## 205    206                     Dunsparce   Normal     <NA>   415 100     70
## 206    207                        Gligar   Ground   Flying   430  65     75
## 207    208                       Steelix    Steel   Ground   510  75     85
## 208    209                      Snubbull    Fairy     <NA>   300  60     80
## 209    210                      Granbull    Fairy     <NA>   450  90    120
## 210    211                      Qwilfish    Water   Poison   440  65     95
## 211    212                        Scizor      Bug    Steel   500  70    130
## 212    213                       Shuckle      Bug     Rock   505  20     10
## 213    214                     Heracross      Bug Fighting   500  80    125
## 214    215                       Sneasel     Dark      Ice   430  55     95
## 215    216                     Teddiursa   Normal     <NA>   330  60     80
## 216    217                      Ursaring   Normal     <NA>   500  90    130
## 217    218                        Slugma     Fire     <NA>   250  40     40
## 218    219                      Magcargo     Fire     Rock   430  60     50
## 219    220                        Swinub      Ice   Ground   250  50     50
## 220    221                     Piloswine      Ice   Ground   450 100    100
## 221    222                       Corsola    Water     Rock   410  65     55
## 222    223                      Remoraid    Water     <NA>   300  35     65
## 223    224                     Octillery    Water     <NA>   480  75    105
## 224    225                      Delibird      Ice   Flying   330  45     55
## 225    226                       Mantine    Water   Flying   485  85     40
## 226    227                      Skarmory    Steel   Flying   465  65     80
## 227    228                      Houndour     Dark     Fire   330  45     60
## 228    229                      Houndoom     Dark     Fire   500  75     90
## 229    230                       Kingdra    Water   Dragon   540  75     95
## 230    231                        Phanpy   Ground     <NA>   330  90     60
## 231    232                       Donphan   Ground     <NA>   500  90    120
## 232    233                      Porygon2   Normal     <NA>   515  85     80
## 233    234                      Stantler   Normal     <NA>   465  73     95
## 234    235                      Smeargle   Normal     <NA>   250  55     20
## 235    236                       Tyrogue Fighting     <NA>   210  35     35
## 236    237                     Hitmontop Fighting     <NA>   455  50     95
## 237    238                      Smoochum      Ice  Psychic   305  45     30
## 238    239                        Elekid Electric     <NA>   360  45     63
## 239    240                         Magby     Fire     <NA>   365  45     75
## 240    241                       Miltank   Normal     <NA>   490  95     80
## 241    242                       Blissey   Normal     <NA>   540 255     10
## 242    243                        Raikou Electric     <NA>   580  90     85
## 243    244                         Entei     Fire     <NA>   580 115    115
## 244    245                       Suicune    Water     <NA>   580 100     75
## 245    246                      Larvitar     Rock   Ground   300  50     64
## 246    247                       Pupitar     Rock   Ground   410  70     84
## 247    248                     Tyranitar     Rock     Dark   600 100    134
## 248    249                         Lugia  Psychic   Flying   680 106     90
## 249    250                         Ho-oh     Fire   Flying   680 106    130
## 250    251                        Celebi  Psychic    Grass   600 100    100
## 251    252                       Treecko    Grass     <NA>   310  40     45
## 252    253                       Grovyle    Grass     <NA>   405  50     65
## 253    254                      Sceptile    Grass     <NA>   530  70     85
## 254    255                       Torchic     Fire     <NA>   310  45     60
## 255    256                     Combusken     Fire Fighting   405  60     85
## 256    257                      Blaziken     Fire Fighting   530  80    120
## 257    258                        Mudkip    Water     <NA>   310  50     70
## 258    259                     Marshtomp    Water   Ground   405  70     85
## 259    260                      Swampert    Water   Ground   535 100    110
## 260    261                     Poochyena     Dark     <NA>   220  35     55
## 261    262                     Mightyena     Dark     <NA>   420  70     90
## 262    263                     Zigzagoon   Normal     <NA>   240  38     30
## 263    264                       Linoone   Normal     <NA>   420  78     70
## 264    265                       Wurmple      Bug     <NA>   195  45     45
## 265    266                       Silcoon      Bug     <NA>   205  50     35
## 266    267                     Beautifly      Bug   Flying   395  60     70
## 267    268                       Cascoon      Bug     <NA>   205  50     35
## 268    269                        Dustox      Bug   Poison   385  60     50
## 269    270                         Lotad    Water    Grass   220  40     30
## 270    271                        Lombre    Water    Grass   340  60     50
## 271    272                      Ludicolo    Water    Grass   480  80     70
## 272    273                        Seedot    Grass     <NA>   220  40     40
## 273    274                       Nuzleaf    Grass     Dark   340  70     70
## 274    275                       Shiftry    Grass     Dark   480  90    100
## 275    276                       Taillow   Normal   Flying   270  40     55
## 276    277                       Swellow   Normal   Flying   455  60     85
## 277    278                       Wingull    Water   Flying   270  40     30
## 278    279                      Pelipper    Water   Flying   440  60     50
## 279    280                         Ralts  Psychic    Fairy   198  28     25
## 280    281                        Kirlia  Psychic    Fairy   278  38     35
## 281    282                     Gardevoir  Psychic    Fairy   518  68     65
## 282    283                       Surskit      Bug    Water   269  40     30
## 283    284                    Masquerain      Bug   Flying   454  70     60
## 284    285                     Shroomish    Grass     <NA>   295  60     40
## 285    286                       Breloom    Grass Fighting   460  60    130
## 286    287                       Slakoth   Normal     <NA>   280  60     60
## 287    288                      Vigoroth   Normal     <NA>   440  80     80
## 288    289                       Slaking   Normal     <NA>   670 150    160
## 289    290                       Nincada      Bug   Ground   266  31     45
## 290    291                       Ninjask      Bug   Flying   456  61     90
## 291    292                      Shedinja      Bug    Ghost   236   1     90
## 292    293                       Whismur   Normal     <NA>   240  64     51
## 293    294                       Loudred   Normal     <NA>   360  84     71
## 294    295                       Exploud   Normal     <NA>   490 104     91
## 295    296                      Makuhita Fighting     <NA>   237  72     60
## 296    297                      Hariyama Fighting     <NA>   474 144    120
## 297    298                       Azurill   Normal    Fairy   190  50     20
## 298    299                      Nosepass     Rock     <NA>   375  30     45
## 299    300                        Skitty   Normal     <NA>   260  50     45
## 300    301                      Delcatty   Normal     <NA>   400  70     65
## 301    302                       Sableye     Dark    Ghost   380  50     75
## 302    303                        Mawile    Steel    Fairy   380  50     85
## 303    304                          Aron    Steel     Rock   330  50     70
## 304    305                        Lairon    Steel     Rock   430  60     90
## 305    306                        Aggron    Steel     Rock   530  70    110
## 306    307                      Meditite Fighting  Psychic   280  30     40
## 307    308                      Medicham Fighting  Psychic   410  60     60
## 308    309                     Electrike Electric     <NA>   295  40     45
## 309    310                     Manectric Electric     <NA>   475  70     75
## 310    311                        Plusle Electric     <NA>   405  60     50
## 311    312                         Minun Electric     <NA>   405  60     40
## 312    313                       Volbeat      Bug     <NA>   430  65     73
## 313    314                      Illumise      Bug     <NA>   430  65     47
## 314    315                       Roselia    Grass   Poison   400  50     60
## 315    316                        Gulpin   Poison     <NA>   302  70     43
## 316    317                        Swalot   Poison     <NA>   467 100     73
## 317    318                      Carvanha    Water     Dark   305  45     90
## 318    319                      Sharpedo    Water     Dark   460  70    120
## 319    320                       Wailmer    Water     <NA>   400 130     70
## 320    321                       Wailord    Water     <NA>   500 170     90
## 321    322                         Numel     Fire   Ground   305  60     60
## 322    323                      Camerupt     Fire   Ground   460  70    100
## 323    324                       Torkoal     Fire     <NA>   470  70     85
## 324    325                        Spoink  Psychic     <NA>   330  60     25
## 325    326                       Grumpig  Psychic     <NA>   470  80     45
## 326    327                        Spinda   Normal     <NA>   360  60     60
## 327    328                      Trapinch   Ground     <NA>   290  45    100
## 328    329                       Vibrava   Ground   Dragon   340  50     70
## 329    330                        Flygon   Ground   Dragon   520  80    100
## 330    331                        Cacnea    Grass     <NA>   335  50     85
## 331    332                      Cacturne    Grass     Dark   475  70    115
## 332    333                        Swablu   Normal   Flying   310  45     40
## 333    334                       Altaria   Dragon   Flying   490  75     70
## 334    335                      Zangoose   Normal     <NA>   458  73    115
## 335    336                       Seviper   Poison     <NA>   458  73    100
## 336    337                      Lunatone     Rock  Psychic   460  90     55
## 337    338                       Solrock     Rock  Psychic   460  90     95
## 338    339                      Barboach    Water   Ground   288  50     48
## 339    340                      Whiscash    Water   Ground   468 110     78
## 340    341                      Corphish    Water     <NA>   308  43     80
## 341    342                     Crawdaunt    Water     Dark   468  63    120
## 342    343                        Baltoy   Ground  Psychic   300  40     40
## 343    344                       Claydol   Ground  Psychic   500  60     70
## 344    345                        Lileep     Rock    Grass   355  66     41
## 345    346                       Cradily     Rock    Grass   495  86     81
## 346    347                       Anorith     Rock      Bug   355  45     95
## 347    348                       Armaldo     Rock      Bug   495  75    125
## 348    349                        Feebas    Water     <NA>   200  20     15
## 349    350                       Milotic    Water     <NA>   540  95     60
## 350    351                      Castform   Normal     <NA>   420  70     70
## 351    351            CastformSunny Form     Fire     <NA>   420  70     70
## 352    351            CastformRainy Form    Water     <NA>   420  70     70
## 353    351            CastformSnowy Form      Ice     <NA>   420  70     70
## 354    352                       Kecleon   Normal     <NA>   440  60     90
## 355    353                       Shuppet    Ghost     <NA>   295  44     75
## 356    354                       Banette    Ghost     <NA>   455  64    115
## 357    355                       Duskull    Ghost     <NA>   295  20     40
## 358    356                      Dusclops    Ghost     <NA>   455  40     70
## 359    357                       Tropius    Grass   Flying   460  99     68
## 360    358                      Chimecho  Psychic     <NA>   455  75     50
## 361    359                         Absol     Dark     <NA>   465  65    130
## 362    360                        Wynaut  Psychic     <NA>   260  95     23
## 363    361                       Snorunt      Ice     <NA>   300  50     50
## 364    362                        Glalie      Ice     <NA>   480  80     80
## 365    363                        Spheal      Ice    Water   290  70     40
## 366    364                        Sealeo      Ice    Water   410  90     60
## 367    365                       Walrein      Ice    Water   530 110     80
## 368    366                      Clamperl    Water     <NA>   345  35     64
## 369    367                       Huntail    Water     <NA>   485  55    104
## 370    368                      Gorebyss    Water     <NA>   485  55     84
## 371    369                     Relicanth    Water     Rock   485 100     90
## 372    370                       Luvdisc    Water     <NA>   330  43     30
## 373    371                         Bagon   Dragon     <NA>   300  45     75
## 374    372                       Shelgon   Dragon     <NA>   420  65     95
## 375    373                     Salamence   Dragon   Flying   600  95    135
## 376    374                        Beldum    Steel  Psychic   300  40     55
## 377    375                        Metang    Steel  Psychic   420  60     75
## 378    376                     Metagross    Steel  Psychic   600  80    135
## 379    377                      Regirock     Rock     <NA>   580  80    100
## 380    378                        Regice      Ice     <NA>   580  80     50
## 381    379                     Registeel    Steel     <NA>   580  80     75
## 382    380                        Latias   Dragon  Psychic   600  80     80
## 383    381                        Latios   Dragon  Psychic   600  80     90
## 384    382                        Kyogre    Water     <NA>   670 100    100
## 385    383                       Groudon   Ground     <NA>   670 100    150
## 386    384                      Rayquaza   Dragon   Flying   680 105    150
## 387    385                       Jirachi    Steel  Psychic   600 100    100
## 388    386            DeoxysNormal Forme  Psychic     <NA>   600  50    150
## 389    386            DeoxysAttack Forme  Psychic     <NA>   600  50    180
## 390    386           DeoxysDefense Forme  Psychic     <NA>   600  50     70
## 391    386             DeoxysSpeed Forme  Psychic     <NA>   600  50     95
## 392    387                       Turtwig    Grass     <NA>   318  55     68
## 393    388                        Grotle    Grass     <NA>   405  75     89
## 394    389                      Torterra    Grass   Ground   525  95    109
## 395    390                      Chimchar     Fire     <NA>   309  44     58
## 396    391                      Monferno     Fire Fighting   405  64     78
## 397    392                     Infernape     Fire Fighting   534  76    104
## 398    393                        Piplup    Water     <NA>   314  53     51
## 399    394                      Prinplup    Water     <NA>   405  64     66
## 400    395                      Empoleon    Water    Steel   530  84     86
## 401    396                        Starly   Normal   Flying   245  40     55
## 402    397                      Staravia   Normal   Flying   340  55     75
## 403    398                     Staraptor   Normal   Flying   485  85    120
## 404    399                        Bidoof   Normal     <NA>   250  59     45
## 405    400                       Bibarel   Normal    Water   410  79     85
## 406    401                     Kricketot      Bug     <NA>   194  37     25
## 407    402                    Kricketune      Bug     <NA>   384  77     85
## 408    403                         Shinx Electric     <NA>   263  45     65
## 409    404                         Luxio Electric     <NA>   363  60     85
## 410    405                        Luxray Electric     <NA>   523  80    120
## 411    406                         Budew    Grass   Poison   280  40     30
## 412    407                      Roserade    Grass   Poison   515  60     70
## 413    408                      Cranidos     Rock     <NA>   350  67    125
## 414    409                     Rampardos     Rock     <NA>   495  97    165
## 415    410                      Shieldon     Rock    Steel   350  30     42
## 416    411                     Bastiodon     Rock    Steel   495  60     52
## 417    412                         Burmy      Bug     <NA>   224  40     29
## 418    413           WormadamPlant Cloak      Bug    Grass   424  60     59
## 419    413           WormadamSandy Cloak      Bug   Ground   424  60     79
## 420    413           WormadamTrash Cloak      Bug    Steel   424  60     69
## 421    414                        Mothim      Bug   Flying   424  70     94
## 422    415                        Combee      Bug   Flying   244  30     30
## 423    416                     Vespiquen      Bug   Flying   474  70     80
## 424    417                     Pachirisu Electric     <NA>   405  60     45
## 425    418                        Buizel    Water     <NA>   330  55     65
## 426    419                      Floatzel    Water     <NA>   495  85    105
## 427    420                       Cherubi    Grass     <NA>   275  45     35
## 428    421                       Cherrim    Grass     <NA>   450  70     60
## 429    422                       Shellos    Water     <NA>   325  76     48
## 430    423                     Gastrodon    Water   Ground   475 111     83
## 431    424                       Ambipom   Normal     <NA>   482  75    100
## 432    425                      Drifloon    Ghost   Flying   348  90     50
## 433    426                      Drifblim    Ghost   Flying   498 150     80
## 434    427                       Buneary   Normal     <NA>   350  55     66
## 435    428                       Lopunny   Normal     <NA>   480  65     76
## 436    429                     Mismagius    Ghost     <NA>   495  60     60
## 437    430                     Honchkrow     Dark   Flying   505 100    125
## 438    431                       Glameow   Normal     <NA>   310  49     55
## 439    432                       Purugly   Normal     <NA>   452  71     82
## 440    433                     Chingling  Psychic     <NA>   285  45     30
## 441    434                        Stunky   Poison     Dark   329  63     63
## 442    435                      Skuntank   Poison     Dark   479 103     93
## 443    436                       Bronzor    Steel  Psychic   300  57     24
## 444    437                      Bronzong    Steel  Psychic   500  67     89
## 445    438                        Bonsly     Rock     <NA>   290  50     80
## 446    439                      Mime Jr.  Psychic    Fairy   310  20     25
## 447    440                       Happiny   Normal     <NA>   220 100      5
## 448    441                        Chatot   Normal   Flying   411  76     65
## 449    442                     Spiritomb    Ghost     Dark   485  50     92
## 450    443                         Gible   Dragon   Ground   300  58     70
## 451    444                        Gabite   Dragon   Ground   410  68     90
## 452    445                      Garchomp   Dragon   Ground   600 108    130
## 453    446                      Munchlax   Normal     <NA>   390 135     85
## 454    447                         Riolu Fighting     <NA>   285  40     70
## 455    448                       Lucario Fighting    Steel   525  70    110
## 456    449                    Hippopotas   Ground     <NA>   330  68     72
## 457    450                     Hippowdon   Ground     <NA>   525 108    112
## 458    451                       Skorupi   Poison      Bug   330  40     50
## 459    452                       Drapion   Poison     Dark   500  70     90
## 460    453                      Croagunk   Poison Fighting   300  48     61
## 461    454                     Toxicroak   Poison Fighting   490  83    106
## 462    455                     Carnivine    Grass     <NA>   454  74    100
## 463    456                       Finneon    Water     <NA>   330  49     49
## 464    457                      Lumineon    Water     <NA>   460  69     69
## 465    458                       Mantyke    Water   Flying   345  45     20
## 466    459                        Snover    Grass      Ice   334  60     62
## 467    460                     Abomasnow    Grass      Ice   494  90     92
## 468    461                       Weavile     Dark      Ice   510  70    120
## 469    462                     Magnezone Electric    Steel   535  70     70
## 470    463                    Lickilicky   Normal     <NA>   515 110     85
## 471    464                     Rhyperior   Ground     Rock   535 115    140
## 472    465                     Tangrowth    Grass     <NA>   535 100    100
## 473    466                    Electivire Electric     <NA>   540  75    123
## 474    467                     Magmortar     Fire     <NA>   540  75     95
## 475    468                      Togekiss    Fairy   Flying   545  85     50
## 476    469                       Yanmega      Bug   Flying   515  86     76
## 477    470                       Leafeon    Grass     <NA>   525  65    110
## 478    471                       Glaceon      Ice     <NA>   525  65     60
## 479    472                       Gliscor   Ground   Flying   510  75     95
## 480    473                     Mamoswine      Ice   Ground   530 110    130
## 481    474                     Porygon-Z   Normal     <NA>   535  85     80
## 482    475                       Gallade  Psychic Fighting   518  68    125
## 483    476                     Probopass     Rock    Steel   525  60     55
## 484    477                      Dusknoir    Ghost     <NA>   525  45    100
## 485    478                      Froslass      Ice    Ghost   480  70     80
## 486    479                         Rotom Electric    Ghost   440  50     50
## 487    479               RotomHeat Rotom Electric     Fire   520  50     65
## 488    479               RotomWash Rotom Electric    Water   520  50     65
## 489    479              RotomFrost Rotom Electric      Ice   520  50     65
## 490    479                RotomFan Rotom Electric   Flying   520  50     65
## 491    479                RotomMow Rotom Electric    Grass   520  50     65
## 492    480                          Uxie  Psychic     <NA>   580  75     75
## 493    481                       Mesprit  Psychic     <NA>   580  80    105
## 494    482                         Azelf  Psychic     <NA>   580  75    125
## 495    483                        Dialga    Steel   Dragon   680 100    120
## 496    484                        Palkia    Water   Dragon   680  90    120
## 497    485                       Heatran     Fire    Steel   600  91     90
## 498    486                     Regigigas   Normal     <NA>   670 110    160
## 499    487          GiratinaOrigin Forme    Ghost   Dragon   680 150    120
## 500    488                     Cresselia  Psychic     <NA>   600 120     70
## 501    489                        Phione    Water     <NA>   480  80     80
## 502    490                       Manaphy    Water     <NA>   600 100    100
## 503    491                       Darkrai     Dark     <NA>   600  70     90
## 504    492             ShayminLand Forme    Grass     <NA>   600 100    100
## 505    492              ShayminSky Forme    Grass   Flying   600 100    103
## 506    493                        Arceus   Normal     <NA>   720 120    120
## 507    494                       Victini  Psychic     Fire   600 100    100
## 508    495                         Snivy    Grass     <NA>   308  45     45
## 509    496                       Servine    Grass     <NA>   413  60     60
## 510    497                     Serperior    Grass     <NA>   528  75     75
## 511    498                         Tepig     Fire     <NA>   308  65     63
## 512    499                       Pignite     Fire Fighting   418  90     93
## 513    500                        Emboar     Fire Fighting   528 110    123
## 514    501                      Oshawott    Water     <NA>   308  55     55
## 515    502                        Dewott    Water     <NA>   413  75     75
## 516    503                      Samurott    Water     <NA>   528  95    100
## 517    504                        Patrat   Normal     <NA>   255  45     55
## 518    505                       Watchog   Normal     <NA>   420  60     85
## 519    506                      Lillipup   Normal     <NA>   275  45     60
## 520    507                       Herdier   Normal     <NA>   370  65     80
## 521    508                     Stoutland   Normal     <NA>   500  85    110
## 522    509                      Purrloin     Dark     <NA>   281  41     50
## 523    510                       Liepard     Dark     <NA>   446  64     88
## 524    511                       Pansage    Grass     <NA>   316  50     53
## 525    512                      Simisage    Grass     <NA>   498  75     98
## 526    513                       Pansear     Fire     <NA>   316  50     53
## 527    514                      Simisear     Fire     <NA>   498  75     98
## 528    515                       Panpour    Water     <NA>   316  50     53
## 529    516                      Simipour    Water     <NA>   498  75     98
## 530    517                         Munna  Psychic     <NA>   292  76     25
## 531    518                      Musharna  Psychic     <NA>   487 116     55
## 532    519                        Pidove   Normal   Flying   264  50     55
## 533    520                     Tranquill   Normal   Flying   358  62     77
## 534    521                      Unfezant   Normal   Flying   488  80    115
## 535    522                       Blitzle Electric     <NA>   295  45     60
## 536    523                     Zebstrika Electric     <NA>   497  75    100
## 537    524                    Roggenrola     Rock     <NA>   280  55     75
## 538    525                       Boldore     Rock     <NA>   390  70    105
## 539    526                      Gigalith     Rock     <NA>   515  85    135
## 540    527                        Woobat  Psychic   Flying   323  65     45
## 541    528                       Swoobat  Psychic   Flying   425  67     57
## 542    529                       Drilbur   Ground     <NA>   328  60     85
## 543    530                     Excadrill   Ground    Steel   508 110    135
## 544    531                        Audino   Normal     <NA>   445 103     60
## 545    532                       Timburr Fighting     <NA>   305  75     80
## 546    533                       Gurdurr Fighting     <NA>   405  85    105
## 547    534                    Conkeldurr Fighting     <NA>   505 105    140
## 548    535                       Tympole    Water     <NA>   294  50     50
## 549    536                     Palpitoad    Water   Ground   384  75     65
## 550    537                    Seismitoad    Water   Ground   509 105     95
## 551    538                         Throh Fighting     <NA>   465 120    100
## 552    539                          Sawk Fighting     <NA>   465  75    125
## 553    540                      Sewaddle      Bug    Grass   310  45     53
## 554    541                      Swadloon      Bug    Grass   380  55     63
## 555    542                      Leavanny      Bug    Grass   500  75    103
## 556    543                      Venipede      Bug   Poison   260  30     45
## 557    544                    Whirlipede      Bug   Poison   360  40     55
## 558    545                     Scolipede      Bug   Poison   485  60    100
## 559    546                      Cottonee    Grass    Fairy   280  40     27
## 560    547                    Whimsicott    Grass    Fairy   480  60     67
## 561    548                       Petilil    Grass     <NA>   280  45     35
## 562    549                     Lilligant    Grass     <NA>   480  70     60
## 563    550      BasculinRed-Striped Form    Water     <NA>   460  70     92
## 564    550     BasculinBlue-Striped Form    Water     <NA>   460  70     92
## 565    551                       Sandile   Ground     Dark   292  50     72
## 566    552                      Krokorok   Ground     Dark   351  60     82
## 567    553                    Krookodile   Ground     Dark   519  95    117
## 568    554                      Darumaka     Fire     <NA>   315  70     90
## 569    555       DarmanitanStandard Mode     Fire     <NA>   480 105    140
## 570    555            DarmanitanZen Mode     Fire  Psychic   540 105     30
## 571    556                      Maractus    Grass     <NA>   461  75     86
## 572    557                       Dwebble      Bug     Rock   325  50     65
## 573    558                       Crustle      Bug     Rock   485  70    105
## 574    559                       Scraggy     Dark Fighting   348  50     75
## 575    560                       Scrafty     Dark Fighting   488  65     90
## 576    561                      Sigilyph  Psychic   Flying   490  72     58
## 577    562                        Yamask    Ghost     <NA>   303  38     30
## 578    563                    Cofagrigus    Ghost     <NA>   483  58     50
## 579    564                      Tirtouga    Water     Rock   355  54     78
## 580    565                    Carracosta    Water     Rock   495  74    108
## 581    566                        Archen     Rock   Flying   401  55    112
## 582    567                      Archeops     Rock   Flying   567  75    140
## 583    568                      Trubbish   Poison     <NA>   329  50     50
## 584    569                      Garbodor   Poison     <NA>   474  80     95
## 585    570                         Zorua     Dark     <NA>   330  40     65
## 586    571                       Zoroark     Dark     <NA>   510  60    105
## 587    572                      Minccino   Normal     <NA>   300  55     50
## 588    573                      Cinccino   Normal     <NA>   470  75     95
## 589    574                       Gothita  Psychic     <NA>   290  45     30
## 590    575                     Gothorita  Psychic     <NA>   390  60     45
## 591    576                    Gothitelle  Psychic     <NA>   490  70     55
## 592    577                       Solosis  Psychic     <NA>   290  45     30
## 593    578                       Duosion  Psychic     <NA>   370  65     40
## 594    579                     Reuniclus  Psychic     <NA>   490 110     65
## 595    580                      Ducklett    Water   Flying   305  62     44
## 596    581                        Swanna    Water   Flying   473  75     87
## 597    582                     Vanillite      Ice     <NA>   305  36     50
## 598    583                     Vanillish      Ice     <NA>   395  51     65
## 599    584                     Vanilluxe      Ice     <NA>   535  71     95
## 600    585                      Deerling   Normal    Grass   335  60     60
## 601    586                      Sawsbuck   Normal    Grass   475  80    100
## 602    587                        Emolga Electric   Flying   428  55     75
## 603    588                    Karrablast      Bug     <NA>   315  50     75
## 604    589                    Escavalier      Bug    Steel   495  70    135
## 605    590                       Foongus    Grass   Poison   294  69     55
## 606    591                     Amoonguss    Grass   Poison   464 114     85
## 607    592                      Frillish    Water    Ghost   335  55     40
## 608    593                     Jellicent    Water    Ghost   480 100     60
## 609    594                     Alomomola    Water     <NA>   470 165     75
## 610    595                        Joltik      Bug Electric   319  50     47
## 611    596                    Galvantula      Bug Electric   472  70     77
## 612    597                     Ferroseed    Grass    Steel   305  44     50
## 613    598                    Ferrothorn    Grass    Steel   489  74     94
## 614    599                         Klink    Steel     <NA>   300  40     55
## 615    600                         Klang    Steel     <NA>   440  60     80
## 616    601                     Klinklang    Steel     <NA>   520  60    100
## 617    602                        Tynamo Electric     <NA>   275  35     55
## 618    603                     Eelektrik Electric     <NA>   405  65     85
## 619    604                    Eelektross Electric     <NA>   515  85    115
## 620    605                        Elgyem  Psychic     <NA>   335  55     55
## 621    606                      Beheeyem  Psychic     <NA>   485  75     75
## 622    607                       Litwick    Ghost     Fire   275  50     30
## 623    608                       Lampent    Ghost     Fire   370  60     40
## 624    609                    Chandelure    Ghost     Fire   520  60     55
## 625    610                          Axew   Dragon     <NA>   320  46     87
## 626    611                       Fraxure   Dragon     <NA>   410  66    117
## 627    612                       Haxorus   Dragon     <NA>   540  76    147
## 628    613                       Cubchoo      Ice     <NA>   305  55     70
## 629    614                       Beartic      Ice     <NA>   505  95    130
## 630    615                     Cryogonal      Ice     <NA>   515  80     50
## 631    616                       Shelmet      Bug     <NA>   305  50     40
## 632    617                      Accelgor      Bug     <NA>   495  80     70
## 633    618                      Stunfisk   Ground Electric   471 109     66
## 634    619                       Mienfoo Fighting     <NA>   350  45     85
## 635    620                      Mienshao Fighting     <NA>   510  65    125
## 636    621                     Druddigon   Dragon     <NA>   485  77    120
## 637    622                        Golett   Ground    Ghost   303  59     74
## 638    623                        Golurk   Ground    Ghost   483  89    124
## 639    624                      Pawniard     Dark    Steel   340  45     85
## 640    625                       Bisharp     Dark    Steel   490  65    125
## 641    626                    Bouffalant   Normal     <NA>   490  95    110
## 642    627                       Rufflet   Normal   Flying   350  70     83
## 643    628                      Braviary   Normal   Flying   510 100    123
## 644    629                       Vullaby     Dark   Flying   370  70     55
## 645    630                     Mandibuzz     Dark   Flying   510 110     65
## 646    631                       Heatmor     Fire     <NA>   484  85     97
## 647    632                        Durant      Bug    Steel   484  58    109
## 648    633                         Deino     Dark   Dragon   300  52     65
## 649    634                      Zweilous     Dark   Dragon   420  72     85
## 650    635                     Hydreigon     Dark   Dragon   600  92    105
## 651    636                      Larvesta      Bug     Fire   360  55     85
## 652    637                     Volcarona      Bug     Fire   550  85     60
## 653    638                      Cobalion    Steel Fighting   580  91     90
## 654    639                     Terrakion     Rock Fighting   580  91    129
## 655    640                      Virizion    Grass Fighting   580  91     90
## 656    641       TornadusIncarnate Forme   Flying     <NA>   580  79    115
## 657    641         TornadusTherian Forme   Flying     <NA>   580  79    100
## 658    642      ThundurusIncarnate Forme Electric   Flying   580  79    115
## 659    642        ThundurusTherian Forme Electric   Flying   580  79    105
## 660    643                      Reshiram   Dragon     Fire   680 100    120
## 661    644                        Zekrom   Dragon Electric   680 100    150
## 662    645       LandorusIncarnate Forme   Ground   Flying   600  89    125
## 663    645         LandorusTherian Forme   Ground   Flying   600  89    145
## 664    646                        Kyurem   Dragon      Ice   660 125    130
## 665    646            KyuremBlack Kyurem   Dragon      Ice   700 125    170
## 666    646            KyuremWhite Kyurem   Dragon      Ice   700 125    120
## 667    647           KeldeoOrdinary Form    Water Fighting   580  91     72
## 668    647           KeldeoResolute Form    Water Fighting   580  91     72
## 669    648            MeloettaAria Forme   Normal  Psychic   600 100     77
## 670    648       MeloettaPirouette Forme   Normal Fighting   600 100    128
## 671    649                      Genesect      Bug    Steel   600  71    120
## 672    650                       Chespin    Grass     <NA>   313  56     61
## 673    651                     Quilladin    Grass     <NA>   405  61     78
## 674    652                    Chesnaught    Grass Fighting   530  88    107
## 675    653                      Fennekin     Fire     <NA>   307  40     45
## 676    654                       Braixen     Fire     <NA>   409  59     59
## 677    655                       Delphox     Fire  Psychic   534  75     69
## 678    656                       Froakie    Water     <NA>   314  41     56
## 679    657                     Frogadier    Water     <NA>   405  54     63
## 680    658                      Greninja    Water     Dark   530  72     95
## 681    658          GreninjaAsh-Greninja    Water     Dark   640  72    145
## 682    659                      Bunnelby   Normal     <NA>   237  38     36
## 683    660                     Diggersby   Normal   Ground   423  85     56
## 684    661                    Fletchling   Normal   Flying   278  45     50
## 685    662                   Fletchinder     Fire   Flying   382  62     73
## 686    663                    Talonflame     Fire   Flying   499  78     81
## 687    664                    Scatterbug      Bug     <NA>   200  38     35
## 688    665                        Spewpa      Bug     <NA>   213  45     22
## 689    666                      Vivillon      Bug   Flying   411  80     52
## 690    667                        Litleo     Fire   Normal   369  62     50
## 691    668                        Pyroar     Fire   Normal   507  86     68
## 692    669                       Flabébé    Fairy     <NA>   303  44     38
## 693    670                       Floette    Fairy     <NA>   371  54     45
## 694    671                       Florges    Fairy     <NA>   552  78     65
## 695    672                        Skiddo    Grass     <NA>   350  66     65
## 696    673                        Gogoat    Grass     <NA>   531 123    100
## 697    674                       Pancham Fighting     <NA>   348  67     82
## 698    675                       Pangoro Fighting     Dark   495  95    124
## 699    676                       Furfrou   Normal     <NA>   472  75     80
## 700    677                        Espurr  Psychic     <NA>   355  62     48
## 701    678                  MeowsticMale  Psychic     <NA>   466  74     48
## 702    678                MeowsticFemale  Psychic     <NA>   466  74     48
## 703    679                       Honedge    Steel    Ghost   325  45     80
## 704    680                      Doublade    Steel    Ghost   448  59    110
## 705    681         AegislashShield Forme    Steel    Ghost   500  60     50
## 706    681          AegislashBlade Forme    Steel    Ghost   500  60    140
## 707    682                      Spritzee    Fairy     <NA>   341  78     52
## 708    683                    Aromatisse    Fairy     <NA>   462 101     72
## 709    684                       Swirlix    Fairy     <NA>   341  62     48
## 710    685                      Slurpuff    Fairy     <NA>   480  82     80
## 711    686                         Inkay     Dark  Psychic   288  53     54
## 712    687                       Malamar     Dark  Psychic   482  86     92
## 713    688                       Binacle     Rock    Water   306  42     52
## 714    689                    Barbaracle     Rock    Water   500  72    105
## 715    690                        Skrelp   Poison    Water   320  50     60
## 716    691                      Dragalge   Poison   Dragon   494  65     75
## 717    692                     Clauncher    Water     <NA>   330  50     53
## 718    693                     Clawitzer    Water     <NA>   500  71     73
## 719    694                    Helioptile Electric   Normal   289  44     38
## 720    695                     Heliolisk Electric   Normal   481  62     55
## 721    696                        Tyrunt     Rock   Dragon   362  58     89
## 722    697                     Tyrantrum     Rock   Dragon   521  82    121
## 723    698                        Amaura     Rock      Ice   362  77     59
## 724    699                       Aurorus     Rock      Ice   521 123     77
## 725    700                       Sylveon    Fairy     <NA>   525  95     65
## 726    701                      Hawlucha Fighting   Flying   500  78     92
## 727    702                       Dedenne Electric    Fairy   431  67     58
## 728    703                       Carbink     Rock    Fairy   500  50     50
## 729    704                         Goomy   Dragon     <NA>   300  45     50
## 730    705                       Sliggoo   Dragon     <NA>   452  68     75
## 731    706                        Goodra   Dragon     <NA>   600  90    100
## 732    707                        Klefki    Steel    Fairy   470  57     80
## 733    708                      Phantump    Ghost    Grass   309  43     70
## 734    709                     Trevenant    Ghost    Grass   474  85    110
## 735    710         PumpkabooAverage Size    Ghost    Grass   335  49     66
## 736    710           PumpkabooSmall Size    Ghost    Grass   335  44     66
## 737    710           PumpkabooLarge Size    Ghost    Grass   335  54     66
## 738    710           PumpkabooSuper Size    Ghost    Grass   335  59     66
## 739    711         GourgeistAverage Size    Ghost    Grass   494  65     90
## 740    711           GourgeistSmall Size    Ghost    Grass   494  55     85
## 741    711           GourgeistLarge Size    Ghost    Grass   494  75     95
## 742    711           GourgeistSuper Size    Ghost    Grass   494  85    100
## 743    712                      Bergmite      Ice     <NA>   304  55     69
## 744    713                       Avalugg      Ice     <NA>   514  95    117
## 745    714                        Noibat   Flying   Dragon   245  40     30
## 746    715                       Noivern   Flying   Dragon   535  85     70
## 747    716                       Xerneas    Fairy     <NA>   680 126    131
## 748    717                       Yveltal     Dark   Flying   680 126    131
## 749    718              Zygarde50% Forme   Dragon   Ground   600 108    100
## 750    718              Zygarde10% Forme   Dragon   Ground   486  54    100
## 751    718         ZygardeComplete Forme   Dragon   Ground   708 216    100
## 752    719                       Diancie     Rock    Fairy   600  50    100
## 753    720           HoopaHoopa Confined  Psychic    Ghost   600  80    110
## 754    720            HoopaHoopa Unbound  Psychic     Dark   680  80    160
## 755    721                     Volcanion     Fire    Water   600  80    110
## 756    722                        Rowlet    Grass   Flying   320  68     55
## 757    723                       Dartrix    Grass   Flying   420  78     75
## 758    724                     Decidueye    Grass    Ghost   530  78    107
## 759    725                        Litten     Fire     <NA>   320  45     65
## 760    726                      Torracat     Fire     <NA>   420  65     85
## 761    727                    Incineroar     Fire     Dark   530  95    115
## 762    728                       Popplio    Water     <NA>   320  50     54
## 763    729                       Brionne    Water     <NA>   420  60     69
## 764    730                     Primarina    Water    Fairy   530  80     74
## 765    731                       Pikipek   Normal   Flying   265  35     75
## 766    732                      Trumbeak   Normal   Flying   355  55     85
## 767    733                     Toucannon   Normal   Flying   485  80    120
## 768    734                       Yungoos   Normal     <NA>   253  48     70
## 769    735                      Gumshoos   Normal     <NA>   418  88    110
## 770    736                       Grubbin      Bug     <NA>   300  47     62
## 771    737                     Charjabug      Bug Electric   400  57     82
## 772    738                      Vikavolt      Bug Electric   500  77     70
## 773    739                    Crabrawler Fighting     <NA>   338  47     82
## 774    740                  Crabominable Fighting      Ice   478  97    132
## 775    741           OricorioBaile Style     Fire   Flying   476  75     70
## 776    741         OricorioPom-Pom Style Electric   Flying   476  75     70
## 777    741            OricorioPa'u Style  Psychic   Flying   476  75     70
## 778    741           OricorioSensu Style    Ghost   Flying   476  75     70
## 779    742                      Cutiefly      Bug    Fairy   304  40     45
## 780    743                      Ribombee      Bug    Fairy   464  60     55
## 781    744                      Rockruff     Rock     <NA>   280  45     65
## 782    744    RockruffOwn Tempo Rockruff     Rock     <NA>   280  45     65
## 783    745           LycanrocMidday Form     Rock     <NA>   487  75    115
## 784    745         LycanrocMidnight Form     Rock     <NA>   487  85    115
## 785    745             LycanrocDusk Form     Rock     <NA>   487  75    117
## 786    746           WishiwashiSolo Form    Water     <NA>   175  45     20
## 787    746         WishiwashiSchool Form    Water     <NA>   620  45    140
## 788    747                      Mareanie   Poison    Water   305  50     53
## 789    748                       Toxapex   Poison    Water   495  50     63
## 790    749                       Mudbray   Ground     <NA>   385  70    100
## 791    750                      Mudsdale   Ground     <NA>   500 100    125
## 792    751                      Dewpider    Water      Bug   269  38     40
## 793    752                     Araquanid    Water      Bug   454  68     70
## 794    753                      Fomantis    Grass     <NA>   250  40     55
## 795    754                      Lurantis    Grass     <NA>   480  70    105
## 796    755                      Morelull    Grass    Fairy   285  40     35
## 797    756                     Shiinotic    Grass    Fairy   405  60     45
## 798    757                      Salandit   Poison     Fire   320  48     44
## 799    758                      Salazzle   Poison     Fire   480  68     64
## 800    759                       Stufful   Normal Fighting   340  70     75
## 801    760                        Bewear   Normal Fighting   500 120    125
## 802    761                     Bounsweet    Grass     <NA>   210  42     30
## 803    762                       Steenee    Grass     <NA>   290  52     40
## 804    763                      Tsareena    Grass     <NA>   510  72    120
## 805    764                        Comfey    Fairy     <NA>   485  51     52
## 806    765                      Oranguru   Normal  Psychic   490  90     60
## 807    766                     Passimian Fighting     <NA>   490 100    120
## 808    767                        Wimpod      Bug    Water   230  25     35
## 809    768                     Golisopod      Bug    Water   530  75    125
## 810    769                     Sandygast    Ghost   Ground   320  55     55
## 811    770                     Palossand    Ghost   Ground   480  85     75
## 812    771                     Pyukumuku    Water     <NA>   410  55     60
## 813    772                    Type: Null   Normal     <NA>   534  95     95
## 814    773                      Silvally   Normal     <NA>   570  95     95
## 815    774             MiniorMeteor Form     Rock   Flying   440  60     60
## 816    774               MiniorCore Form     Rock   Flying   500  60    100
## 817    775                        Komala   Normal     <NA>   480  65    115
## 818    776                    Turtonator     Fire   Dragon   485  60     78
## 819    777                    Togedemaru Electric    Steel   435  65     98
## 820    778                       Mimikyu    Ghost    Fairy   476  55     90
## 821    779                       Bruxish    Water  Psychic   475  68    105
## 822    780                        Drampa   Normal   Dragon   485  78     60
## 823    781                      Dhelmise    Ghost    Grass   517  70    131
## 824    782                      Jangmo-o   Dragon     <NA>   300  45     55
## 825    783                      Hakamo-o   Dragon Fighting   420  55     75
## 826    784                       Kommo-o   Dragon Fighting   600  75    110
## 827    785                     Tapu Koko Electric    Fairy   570  70    115
## 828    786                     Tapu Lele  Psychic    Fairy   570  70     85
## 829    787                     Tapu Bulu    Grass    Fairy   570  70    130
## 830    788                     Tapu Fini    Water    Fairy   570  70     75
## 831    789                        Cosmog  Psychic     <NA>   200  43     29
## 832    790                       Cosmoem  Psychic     <NA>   400  43     29
## 833    791                      Solgaleo  Psychic    Steel   680 137    137
## 834    792                        Lunala  Psychic    Ghost   680 137    113
## 835    793                      Nihilego     Rock   Poison   570 109     53
## 836    794                      Buzzwole      Bug Fighting   570 107    139
## 837    795                     Pheromosa      Bug Fighting   570  71    137
## 838    796                     Xurkitree Electric     <NA>   570  83     89
## 839    797                    Celesteela    Steel   Flying   570  97    101
## 840    798                       Kartana    Grass    Steel   570  59    181
## 841    799                      Guzzlord     Dark   Dragon   570 223    101
## 842    800                      Necrozma  Psychic     <NA>   600  97    107
## 843    800    NecrozmaDusk Mane Necrozma  Psychic    Steel   680  97    157
## 844    800   NecrozmaDawn Wings Necrozma  Psychic    Ghost   680  97    113
## 845    800        NecrozmaUltra Necrozma  Psychic   Dragon   754  97    167
## 846    801                      Magearna    Steel    Fairy   600  80     95
## 847    802                     Marshadow Fighting    Ghost   600  90    125
## 848    803                       Poipole   Poison     <NA>   420  67     73
## 849    804                     Naganadel   Poison   Dragon   540  73     73
## 850    805                     Stakataka     Rock    Steel   570  61    131
## 851    806                   Blacephalon     Fire    Ghost   570  53    127
## 852    807                       Zeraora Electric     <NA>   600  88    112
## 853    808                        Meltan    Steel     <NA>   300  46     65
## 854    809                      Melmetal    Steel     <NA>   600 135    143
## 855    810                       Grookey    Grass     <NA>   310  50     65
## 856    811                      Thwackey    Grass     <NA>   420  70     85
## 857    812                     Rillaboom    Grass     <NA>   530 100    125
## 858    813                     Scorbunny     Fire     <NA>   310  50     71
## 859    814                        Raboot     Fire     <NA>   420  65     86
## 860    815                     Cinderace     Fire     <NA>   530  80    116
## 861    816                        Sobble    Water     <NA>   310  50     40
## 862    817                      Drizzile    Water     <NA>   420  65     60
## 863    818                      Inteleon    Water     <NA>   530  70     85
## 864    819                       Skwovet   Normal     <NA>   275  70     55
## 865    820                      Greedent   Normal     <NA>   460 120     95
## 866    821                      Rookidee   Flying     <NA>   245  38     47
## 867    822                   Corvisquire   Flying     <NA>   365  68     67
## 868    823                   Corviknight   Flying    Steel   495  98     87
## 869    824                       Blipbug      Bug     <NA>   180  25     20
## 870    825                       Dottler      Bug  Psychic   335  50     35
## 871    826                      Orbeetle      Bug  Psychic   505  60     45
## 872    827                        Nickit     Dark     <NA>   245  40     28
## 873    828                       Thievul     Dark     <NA>   455  70     58
## 874    829                    Gossifleur    Grass     <NA>   250  40     40
## 875    830                      Eldegoss    Grass     <NA>   460  60     50
## 876    831                        Wooloo   Normal     <NA>   270  42     40
## 877    832                       Dubwool   Normal     <NA>   490  72     80
## 878    833                       Chewtle    Water     <NA>   284  50     64
## 879    834                       Drednaw    Water     Rock   485  90    115
## 880    835                        Yamper Electric     <NA>   270  59     45
## 881    836                       Boltund Electric     <NA>   490  69     90
## 882    837                      Rolycoly     Rock     <NA>   240  30     40
## 883    838                        Carkol     Rock     Fire   410  80     60
## 884    839                     Coalossal     Rock     Fire   510 110     80
## 885    840                        Applin    Grass   Dragon   260  40     40
## 886    841                       Flapple    Grass   Dragon   485  70    110
## 887    842                      Appletun    Grass   Dragon   485 110     85
## 888    843                     Silicobra   Ground     <NA>   315  52     57
## 889    844                    Sandaconda   Ground     <NA>   510  72    107
## 890    845                     Cramorant   Flying    Water   475  70     85
## 891    846                      Arrokuda    Water     <NA>   280  41     63
## 892    847                   Barraskewda    Water     <NA>   490  61    123
## 893    848                         Toxel Electric   Poison   242  40     38
## 894    849        ToxtricityLow Key Form Electric   Poison   502  75     98
## 895    849          ToxtricityAmped Form Electric   Poison   502  75     98
## 896    850                    Sizzlipede     Fire      Bug   305  50     65
## 897    851                   Centiskorch     Fire      Bug   525 100    115
## 898    852                     Clobbopus Fighting     <NA>   310  50     68
## 899    853                     Grapploct Fighting     <NA>   480  80    118
## 900    854                      Sinistea    Ghost     <NA>   308  40     45
## 901    855                   Polteageist    Ghost     <NA>   508  60     65
## 902    856                       Hatenna  Psychic     <NA>   265  42     30
## 903    857                       Hattrem  Psychic     <NA>   370  57     40
## 904    858                     Hatterene  Psychic    Fairy   510  57     90
## 905    859                      Impidimp     Dark    Fairy   265  45     45
## 906    860                       Morgrem     Dark    Fairy   370  65     60
## 907    861                    Grimmsnarl     Dark    Fairy   510  95    120
## 908    862                     Obstagoon     Dark   Normal   520  93     90
## 909    863                    Perrserker    Steel     <NA>   440  70    110
## 910    864                       Cursola    Ghost     <NA>   510  60     95
## 911    865                    Sirfetch'd Fighting     <NA>   507  62    135
## 912    866                      Mr. Rime      Ice  Psychic   520  80     85
## 913    867                     Runerigus   Ground    Ghost   483  58     95
## 914    868                       Milcery    Fairy     <NA>   270  45     40
## 915    869                      Alcremie    Fairy     <NA>   495  65     60
## 916    870                       Falinks Fighting     <NA>   470  65    100
## 917    871                    Pincurchin Electric     <NA>   435  48    101
## 918    872                          Snom      Ice      Bug   185  30     25
## 919    873                      Frosmoth      Ice      Bug   475  70     65
## 920    874                   Stonjourner     Rock     <NA>   470 100    125
## 921    875                EiscueIce Face      Ice     <NA>   470  75     80
## 922    875              EiscueNoice Face      Ice     <NA>   470  75     80
## 923    876                  IndeedeeMale  Psychic   Normal   475  60     65
## 924    876                IndeedeeFemale  Psychic   Normal   475  70     55
## 925    877        MorpekoFull Belly Mode Electric     Dark   436  58     95
## 926    877            MorpekoHangry Mode Electric     Dark   436  58     95
## 927    878                        Cufant    Steel     <NA>   330  72     80
## 928    879                    Copperajah    Steel     <NA>   500 122    130
## 929    880                     Dracozolt Electric   Dragon   505  90    100
## 930    881                     Arctozolt Electric      Ice   505  90    100
## 931    882                     Dracovish    Water   Dragon   505  90     90
## 932    883                     Arctovish    Water      Ice   505  90     90
## 933    884                     Duraludon    Steel   Dragon   535  70     95
## 934    885                        Dreepy   Dragon    Ghost   270  28     60
## 935    886                      Drakloak   Dragon    Ghost   410  68     80
## 936    887                     Dragapult   Dragon    Ghost   600  88    120
## 937    888           ZacianCrowned Sword    Fairy    Steel   720  92    170
## 938    888    ZacianHero of Many Battles    Fairy     <NA>   670  92    130
## 939    889       ZamazentaCrowned Shield Fighting    Steel   720  92    130
## 940    889 ZamazentaHero of Many Battles Fighting     <NA>   670  92    130
## 941    890                     Eternatus   Poison   Dragon   690 140     85
## 942    890            EternatusEternamax   Poison   Dragon  1125 255    115
## 943    891                         Kubfu Fighting     <NA>   385  60     90
## 944    892    UrshifuSingle Strike Style Fighting     Dark   550 100    130
## 945    892     UrshifuRapid Strike Style Fighting    Water   550 100    130
## 946    893                        Zarude     Dark    Grass   600 105    120
## 947    894                     Regieleki Electric     <NA>   580  80    100
## 948    895                     Regidrago   Dragon     <NA>   580 200    100
## 949    896                     Glastrier      Ice     <NA>   580 100    145
## 950    897                     Spectrier    Ghost     <NA>   580 100     65
## 951    898                       Calyrex  Psychic    Grass   500 100     80
## 952    898              CalyrexIce Rider  Psychic      Ice   680 100    165
## 953    898           CalyrexShadow Rider  Psychic    Ghost   680 100     85
##     Defense Sp..Atk Sp..Def Speed legendary gen
## 1        49      65      65    45     FALSE   1
## 2        63      80      80    60     FALSE   1
## 3        83     100     100    80     FALSE   1
## 4        43      60      50    65     FALSE   1
## 5        58      80      65    80     FALSE   1
## 6        78     109      85   100     FALSE   1
## 7        65      50      64    43     FALSE   1
## 8        80      65      80    58     FALSE   1
## 9       100      85     105    78     FALSE   1
## 10       35      20      20    45     FALSE   1
## 11       55      25      25    30     FALSE   1
## 12       50      90      80    70     FALSE   1
## 13       30      20      20    50     FALSE   1
## 14       50      25      25    35     FALSE   1
## 15       40      45      80    75     FALSE   1
## 16       40      35      35    56     FALSE   1
## 17       55      50      50    71     FALSE   1
## 18       75      70      70   101     FALSE   1
## 19       35      25      35    72     FALSE   1
## 20       60      50      70    97     FALSE   1
## 21       30      31      31    70     FALSE   1
## 22       65      61      61   100     FALSE   1
## 23       44      40      54    55     FALSE   1
## 24       69      65      79    80     FALSE   1
## 25       40      50      50    90     FALSE   1
## 26       55      90      80   110     FALSE   1
## 27       85      20      30    40     FALSE   1
## 28      110      45      55    65     FALSE   1
## 29       52      40      40    41     FALSE   1
## 30       67      55      55    56     FALSE   1
## 31       87      75      85    76     FALSE   1
## 32       40      40      40    50     FALSE   1
## 33       57      55      55    65     FALSE   1
## 34       77      85      75    85     FALSE   1
## 35       48      60      65    35     FALSE   1
## 36       73      95      90    60     FALSE   1
## 37       40      50      65    65     FALSE   1
## 38       75      81     100   100     FALSE   1
## 39       20      45      25    20     FALSE   1
## 40       45      85      50    45     FALSE   1
## 41       35      30      40    55     FALSE   1
## 42       70      65      75    90     FALSE   1
## 43       55      75      65    30     FALSE   1
## 44       70      85      75    40     FALSE   1
## 45       85     110      90    50     FALSE   1
## 46       55      45      55    25     FALSE   1
## 47       80      60      80    30     FALSE   1
## 48       50      40      55    45     FALSE   1
## 49       60      90      75    90     FALSE   1
## 50       25      35      45    95     FALSE   1
## 51       50      50      70   120     FALSE   1
## 52       35      40      40    90     FALSE   1
## 53       60      65      65   115     FALSE   1
## 54       48      65      50    55     FALSE   1
## 55       78      95      80    85     FALSE   1
## 56       35      35      45    70     FALSE   1
## 57       60      60      70    95     FALSE   1
## 58       45      70      50    60     FALSE   1
## 59       80     100      80    95     FALSE   1
## 60       40      40      40    90     FALSE   1
## 61       65      50      50    90     FALSE   1
## 62       95      70      90    70     FALSE   1
## 63       15     105      55    90     FALSE   1
## 64       30     120      70   105     FALSE   1
## 65       45     135      95   120     FALSE   1
## 66       50      35      35    35     FALSE   1
## 67       70      50      60    45     FALSE   1
## 68       80      65      85    55     FALSE   1
## 69       35      70      30    40     FALSE   1
## 70       50      85      45    55     FALSE   1
## 71       65     100      70    70     FALSE   1
## 72       35      50     100    70     FALSE   1
## 73       65      80     120   100     FALSE   1
## 74      100      30      30    20     FALSE   1
## 75      115      45      45    35     FALSE   1
## 76      130      55      65    45     FALSE   1
## 77       55      65      65    90     FALSE   1
## 78       70      80      80   105     FALSE   1
## 79       65      40      40    15     FALSE   1
## 80      110     100      80    30     FALSE   1
## 81       70      95      55    45     FALSE   1
## 82       95     120      70    70     FALSE   1
## 83       55      58      62    60     FALSE   1
## 84       45      35      35    75     FALSE   1
## 85       70      60      60   110     FALSE   1
## 86       55      45      70    45     FALSE   1
## 87       80      70      95    70     FALSE   1
## 88       50      40      50    25     FALSE   1
## 89       75      65     100    50     FALSE   1
## 90      100      45      25    40     FALSE   1
## 91      180      85      45    70     FALSE   1
## 92       30     100      35    80     FALSE   1
## 93       45     115      55    95     FALSE   1
## 94       60     130      75   110     FALSE   1
## 95      160      30      45    70     FALSE   1
## 96       45      43      90    42     FALSE   1
## 97       70      73     115    67     FALSE   1
## 98       90      25      25    50     FALSE   1
## 99      115      50      50    75     FALSE   1
## 100      50      55      55   100     FALSE   1
## 101      70      80      80   150     FALSE   1
## 102      80      60      45    40     FALSE   1
## 103      85     125      75    55     FALSE   1
## 104      95      40      50    35     FALSE   1
## 105     110      50      80    45     FALSE   1
## 106      53      35     110    87     FALSE   1
## 107      79      35     110    76     FALSE   1
## 108      75      60      75    30     FALSE   1
## 109      95      60      45    35     FALSE   1
## 110     120      85      70    60     FALSE   1
## 111      95      30      30    25     FALSE   1
## 112     120      45      45    40     FALSE   1
## 113       5      35     105    50     FALSE   1
## 114     115     100      40    60     FALSE   1
## 115      80      40      80    90     FALSE   1
## 116      70      70      25    60     FALSE   1
## 117      95      95      45    85     FALSE   1
## 118      60      35      50    63     FALSE   1
## 119      65      65      80    68     FALSE   1
## 120      55      70      55    85     FALSE   1
## 121      85     100      85   115     FALSE   1
## 122      65     100     120    90     FALSE   1
## 123      80      55      80   105     FALSE   1
## 124      35     115      95    95     FALSE   1
## 125      57      95      85   105     FALSE   1
## 126      57     100      85    93     FALSE   1
## 127     100      55      70    85     FALSE   1
## 128      95      40      70   110     FALSE   1
## 129      55      15      20    80     FALSE   1
## 130      79      60     100    81     FALSE   1
## 131      80      85      95    60     FALSE   1
## 132      48      48      48    48     FALSE   1
## 133      50      45      65    55     FALSE   1
## 134      60     110      95    65     FALSE   1
## 135      60     110      95   130     FALSE   1
## 136      60      95     110    65     FALSE   1
## 137      70      85      75    40     FALSE   1
## 138     100      90      55    35     FALSE   1
## 139     125     115      70    55     FALSE   1
## 140      90      55      45    55     FALSE   1
## 141     105      65      70    80     FALSE   1
## 142      65      60      75   130     FALSE   1
## 143      65      65     110    30     FALSE   1
## 144     100      95     125    85      TRUE   1
## 145      85     125      90   100      TRUE   1
## 146      90     125      85    90      TRUE   1
## 147      45      50      50    50     FALSE   1
## 148      65      70      70    70     FALSE   1
## 149      95     100     100    80     FALSE   1
## 150      90     154      90   130      TRUE   1
## 151     100     100     100   100      TRUE   1
## 152      65      49      65    45     FALSE   2
## 153      80      63      80    60     FALSE   2
## 154      43      60      50    65     FALSE   2
## 155      58      80      65    80     FALSE   2
## 156      78     109      85   100     FALSE   2
## 157      64      44      48    43     FALSE   2
## 158      80      59      63    58     FALSE   2
## 159     100      79      83    78     FALSE   2
## 160      34      35      45    20     FALSE   2
## 161      64      45      55    90     FALSE   2
## 162      30      36      56    50     FALSE   2
## 163      50      86      96    70     FALSE   2
## 164      30      40      80    55     FALSE   2
## 165      50      55     110    85     FALSE   2
## 166      40      40      40    30     FALSE   2
## 167      70      60      70    40     FALSE   2
## 168      80      70      80   130     FALSE   2
## 169      38      56      56    67     FALSE   2
## 170      58      76      76    67     FALSE   2
## 171      15      35      35    60     FALSE   2
## 172      28      45      55    15     FALSE   2
## 173      15      40      20    15     FALSE   2
## 174      65      40      65    20     FALSE   2
## 175      85      80     105    40     FALSE   2
## 176      45      70      45    70     FALSE   2
## 177      70      95      70    95     FALSE   2
## 178      40      65      45    35     FALSE   2
## 179      55      80      60    45     FALSE   2
## 180      85     115      90    55     FALSE   2
## 181      95      90     100    50     FALSE   2
## 182      50      20      50    40     FALSE   2
## 183      80      60      80    50     FALSE   2
## 184     115      30      65    30     FALSE   2
## 185      75      90     100    70     FALSE   2
## 186      40      35      55    50     FALSE   2
## 187      50      45      65    80     FALSE   2
## 188      70      55      95   110     FALSE   2
## 189      55      40      55    85     FALSE   2
## 190      30      30      30    30     FALSE   2
## 191      55     105      85    30     FALSE   2
## 192      45      75      45    95     FALSE   2
## 193      45      25      25    15     FALSE   2
## 194      85      65      65    35     FALSE   2
## 195      60     130      95   110     FALSE   2
## 196     110      60     130    65     FALSE   2
## 197      42      85      42    91     FALSE   2
## 198      80     100     110    30     FALSE   2
## 199      60      85      85    85     FALSE   2
## 200      48      72      48    48     FALSE   2
## 201      58      33      58    33     FALSE   2
## 202      65      90      65    85     FALSE   2
## 203      90      35      35    15     FALSE   2
## 204     140      60      60    40     FALSE   2
## 205      70      65      65    45     FALSE   2
## 206     105      35      65    85     FALSE   2
## 207     200      55      65    30     FALSE   2
## 208      50      40      40    30     FALSE   2
## 209      75      60      60    45     FALSE   2
## 210      85      55      55    85     FALSE   2
## 211     100      55      80    65     FALSE   2
## 212     230      10     230     5     FALSE   2
## 213      75      40      95    85     FALSE   2
## 214      55      35      75   115     FALSE   2
## 215      50      50      50    40     FALSE   2
## 216      75      75      75    55     FALSE   2
## 217      40      70      40    20     FALSE   2
## 218     120      90      80    30     FALSE   2
## 219      40      30      30    50     FALSE   2
## 220      80      60      60    50     FALSE   2
## 221      95      65      95    35     FALSE   2
## 222      35      65      35    65     FALSE   2
## 223      75     105      75    45     FALSE   2
## 224      45      65      45    75     FALSE   2
## 225      70      80     140    70     FALSE   2
## 226     140      40      70    70     FALSE   2
## 227      30      80      50    65     FALSE   2
## 228      50     110      80    95     FALSE   2
## 229      95      95      95    85     FALSE   2
## 230      60      40      40    40     FALSE   2
## 231     120      60      60    50     FALSE   2
## 232      90     105      95    60     FALSE   2
## 233      62      85      65    85     FALSE   2
## 234      35      20      45    75     FALSE   2
## 235      35      35      35    35     FALSE   2
## 236      95      35     110    70     FALSE   2
## 237      15      85      65    65     FALSE   2
## 238      37      65      55    95     FALSE   2
## 239      37      70      55    83     FALSE   2
## 240     105      40      70   100     FALSE   2
## 241      10      75     135    55     FALSE   2
## 242      75     115     100   115      TRUE   2
## 243      85      90      75   100      TRUE   2
## 244     115      90     115    85      TRUE   2
## 245      50      45      50    41     FALSE   2
## 246      70      65      70    51     FALSE   2
## 247     110      95     100    61     FALSE   2
## 248     130      90     154   110      TRUE   2
## 249      90     110     154    90     FALSE   2
## 250     100     100     100   100      TRUE   2
## 251      35      65      55    70     FALSE   3
## 252      45      85      65    95     FALSE   3
## 253      65     105      85   120     FALSE   3
## 254      40      70      50    45     FALSE   3
## 255      60      85      60    55     FALSE   3
## 256      70     110      70    80     FALSE   3
## 257      50      50      50    40     FALSE   3
## 258      70      60      70    50     FALSE   3
## 259      90      85      90    60     FALSE   3
## 260      35      30      30    35     FALSE   3
## 261      70      60      60    70     FALSE   3
## 262      41      30      41    60     FALSE   3
## 263      61      50      61   100     FALSE   3
## 264      35      20      30    20     FALSE   3
## 265      55      25      25    15     FALSE   3
## 266      50     100      50    65     FALSE   3
## 267      55      25      25    15     FALSE   3
## 268      70      50      90    65     FALSE   3
## 269      30      40      50    30     FALSE   3
## 270      50      60      70    50     FALSE   3
## 271      70      90     100    70     FALSE   3
## 272      50      30      30    30     FALSE   3
## 273      40      60      40    60     FALSE   3
## 274      60      90      60    80     FALSE   3
## 275      30      30      30    85     FALSE   3
## 276      60      75      50   125     FALSE   3
## 277      30      55      30    85     FALSE   3
## 278     100      95      70    65     FALSE   3
## 279      25      45      35    40     FALSE   3
## 280      35      65      55    50     FALSE   3
## 281      65     125     115    80     FALSE   3
## 282      32      50      52    65     FALSE   3
## 283      62     100      82    80     FALSE   3
## 284      60      40      60    35     FALSE   3
## 285      80      60      60    70     FALSE   3
## 286      60      35      35    30     FALSE   3
## 287      80      55      55    90     FALSE   3
## 288     100      95      65   100     FALSE   3
## 289      90      30      30    40     FALSE   3
## 290      45      50      50   160     FALSE   3
## 291      45      30      30    40     FALSE   3
## 292      23      51      23    28     FALSE   3
## 293      43      71      43    48     FALSE   3
## 294      63      91      73    68     FALSE   3
## 295      30      20      30    25     FALSE   3
## 296      60      40      60    50     FALSE   3
## 297      40      20      40    20     FALSE   3
## 298     135      45      90    30     FALSE   3
## 299      45      35      35    50     FALSE   3
## 300      65      55      55    90     FALSE   3
## 301      75      65      65    50     FALSE   3
## 302      85      55      55    50     FALSE   3
## 303     100      40      40    30     FALSE   3
## 304     140      50      50    40     FALSE   3
## 305     180      60      60    50     FALSE   3
## 306      55      40      55    60     FALSE   3
## 307      75      60      75    80     FALSE   3
## 308      40      65      40    65     FALSE   3
## 309      60     105      60   105     FALSE   3
## 310      40      85      75    95     FALSE   3
## 311      50      75      85    95     FALSE   3
## 312      75      47      85    85     FALSE   3
## 313      75      73      85    85     FALSE   3
## 314      45     100      80    65     FALSE   3
## 315      53      43      53    40     FALSE   3
## 316      83      73      83    55     FALSE   3
## 317      20      65      20    65     FALSE   3
## 318      40      95      40    95     FALSE   3
## 319      35      70      35    60     FALSE   3
## 320      45      90      45    60     FALSE   3
## 321      40      65      45    35     FALSE   3
## 322      70     105      75    40     FALSE   3
## 323     140      85      70    20     FALSE   3
## 324      35      70      80    60     FALSE   3
## 325      65      90     110    80     FALSE   3
## 326      60      60      60    60     FALSE   3
## 327      45      45      45    10     FALSE   3
## 328      50      50      50    70     FALSE   3
## 329      80      80      80   100     FALSE   3
## 330      40      85      40    35     FALSE   3
## 331      60     115      60    55     FALSE   3
## 332      60      40      75    50     FALSE   3
## 333      90      70     105    80     FALSE   3
## 334      60      60      60    90     FALSE   3
## 335      60     100      60    65     FALSE   3
## 336      65      95      85    70     FALSE   3
## 337      85      55      65    70     FALSE   3
## 338      43      46      41    60     FALSE   3
## 339      73      76      71    60     FALSE   3
## 340      65      50      35    35     FALSE   3
## 341      85      90      55    55     FALSE   3
## 342      55      40      70    55     FALSE   3
## 343     105      70     120    75     FALSE   3
## 344      77      61      87    23     FALSE   3
## 345      97      81     107    43     FALSE   3
## 346      50      40      50    75     FALSE   3
## 347     100      70      80    45     FALSE   3
## 348      20      10      55    80     FALSE   3
## 349      79     100     125    81     FALSE   3
## 350      70      70      70    70     FALSE   3
## 351      70      70      70    70     FALSE   3
## 352      70      70      70    70     FALSE   3
## 353      70      70      70    70     FALSE   3
## 354      70      60     120    40     FALSE   3
## 355      35      63      33    45     FALSE   3
## 356      65      83      63    65     FALSE   3
## 357      90      30      90    25     FALSE   3
## 358     130      60     130    25     FALSE   3
## 359      83      72      87    51     FALSE   3
## 360      80      95      90    65     FALSE   3
## 361      60      75      60    75     FALSE   3
## 362      48      23      48    23     FALSE   3
## 363      50      50      50    50     FALSE   3
## 364      80      80      80    80     FALSE   3
## 365      50      55      50    25     FALSE   3
## 366      70      75      70    45     FALSE   3
## 367      90      95      90    65     FALSE   3
## 368      85      74      55    32     FALSE   3
## 369     105      94      75    52     FALSE   3
## 370     105     114      75    52     FALSE   3
## 371     130      45      65    55     FALSE   3
## 372      55      40      65    97     FALSE   3
## 373      60      40      30    50     FALSE   3
## 374     100      60      50    50     FALSE   3
## 375      80     110      80   100     FALSE   3
## 376      80      35      60    30     FALSE   3
## 377     100      55      80    50     FALSE   3
## 378     130      95      90    70     FALSE   3
## 379     200      50     100    50      TRUE   3
## 380     100     100     200    50      TRUE   3
## 381     150      75     150    50      TRUE   3
## 382      90     110     130   110      TRUE   3
## 383      80     130     110   110      TRUE   3
## 384      90     150     140    90      TRUE   3
## 385     140     100      90    90      TRUE   3
## 386      90     150      90    95      TRUE   3
## 387     100     100     100   100      TRUE   3
## 388      50     150      50   150      TRUE   3
## 389      20     180      20   150      TRUE   3
## 390     160      70     160    90      TRUE   3
## 391      90      95      90   180      TRUE   3
## 392      64      45      55    31     FALSE   4
## 393      85      55      65    36     FALSE   4
## 394     105      75      85    56     FALSE   4
## 395      44      58      44    61     FALSE   4
## 396      52      78      52    81     FALSE   4
## 397      71     104      71   108     FALSE   4
## 398      53      61      56    40     FALSE   4
## 399      68      81      76    50     FALSE   4
## 400      88     111     101    60     FALSE   4
## 401      30      30      30    60     FALSE   4
## 402      50      40      40    80     FALSE   4
## 403      70      50      60   100     FALSE   4
## 404      40      35      40    31     FALSE   4
## 405      60      55      60    71     FALSE   4
## 406      41      25      41    25     FALSE   4
## 407      51      55      51    65     FALSE   4
## 408      34      40      34    45     FALSE   4
## 409      49      60      49    60     FALSE   4
## 410      79      95      79    70     FALSE   4
## 411      35      50      70    55     FALSE   4
## 412      65     125     105    90     FALSE   4
## 413      40      30      30    58     FALSE   4
## 414      60      65      50    58     FALSE   4
## 415     118      42      88    30     FALSE   4
## 416     168      47     138    30     FALSE   4
## 417      45      29      45    36     FALSE   4
## 418      85      79     105    36     FALSE   4
## 419     105      59      85    36     FALSE   4
## 420      95      69      95    36     FALSE   4
## 421      50      94      50    66     FALSE   4
## 422      42      30      42    70     FALSE   4
## 423     102      80     102    40     FALSE   4
## 424      70      45      90    95     FALSE   4
## 425      35      60      30    85     FALSE   4
## 426      55      85      50   115     FALSE   4
## 427      45      62      53    35     FALSE   4
## 428      70      87      78    85     FALSE   4
## 429      48      57      62    34     FALSE   4
## 430      68      92      82    39     FALSE   4
## 431      66      60      66   115     FALSE   4
## 432      34      60      44    70     FALSE   4
## 433      44      90      54    80     FALSE   4
## 434      44      44      56    85     FALSE   4
## 435      84      54      96   105     FALSE   4
## 436      60     105     105   105     FALSE   4
## 437      52     105      52    71     FALSE   4
## 438      42      42      37    85     FALSE   4
## 439      64      64      59   112     FALSE   4
## 440      50      65      50    45     FALSE   4
## 441      47      41      41    74     FALSE   4
## 442      67      71      61    84     FALSE   4
## 443      86      24      86    23     FALSE   4
## 444     116      79     116    33     FALSE   4
## 445      95      10      45    10     FALSE   4
## 446      45      70      90    60     FALSE   4
## 447       5      15      65    30     FALSE   4
## 448      45      92      42    91     FALSE   4
## 449     108      92     108    35     FALSE   4
## 450      45      40      45    42     FALSE   4
## 451      65      50      55    82     FALSE   4
## 452      95      80      85   102     FALSE   4
## 453      40      40      85     5     FALSE   4
## 454      40      35      40    60     FALSE   4
## 455      70     115      70    90     FALSE   4
## 456      78      38      42    32     FALSE   4
## 457     118      68      72    47     FALSE   4
## 458      90      30      55    65     FALSE   4
## 459     110      60      75    95     FALSE   4
## 460      40      61      40    50     FALSE   4
## 461      65      86      65    85     FALSE   4
## 462      72      90      72    46     FALSE   4
## 463      56      49      61    66     FALSE   4
## 464      76      69      86    91     FALSE   4
## 465      50      60     120    50     FALSE   4
## 466      50      62      60    40     FALSE   4
## 467      75      92      85    60     FALSE   4
## 468      65      45      85   125     FALSE   4
## 469     115     130      90    60     FALSE   4
## 470      95      80      95    50     FALSE   4
## 471     130      55      55    40     FALSE   4
## 472     125     110      50    50     FALSE   4
## 473      67      95      85    95     FALSE   4
## 474      67     125      95    83     FALSE   4
## 475      95     120     115    80     FALSE   4
## 476      86     116      56    95     FALSE   4
## 477     130      60      65    95     FALSE   4
## 478     110     130      95    65     FALSE   4
## 479     125      45      75    95     FALSE   4
## 480      80      70      60    80     FALSE   4
## 481      70     135      75    90     FALSE   4
## 482      65      65     115    80     FALSE   4
## 483     145      75     150    40     FALSE   4
## 484     135      65     135    45     FALSE   4
## 485      70      80      70   110     FALSE   4
## 486      77      95      77    91     FALSE   4
## 487     107     105     107    86     FALSE   4
## 488     107     105     107    86     FALSE   4
## 489     107     105     107    86     FALSE   4
## 490     107     105     107    86     FALSE   4
## 491     107     105     107    86     FALSE   4
## 492     130      75     130    95      TRUE   4
## 493     105     105     105    80      TRUE   4
## 494      70     125      70   115      TRUE   4
## 495     120     150     100    90      TRUE   4
## 496     100     150     120   100      TRUE   4
## 497     106     130     106    77      TRUE   4
## 498     110      80     110   100      TRUE   4
## 499     100     120     100    90      TRUE   4
## 500     120      75     130    85      TRUE   4
## 501      80      80      80    80      TRUE   4
## 502     100     100     100   100      TRUE   4
## 503      90     135      90   125      TRUE   4
## 504     100     100     100   100      TRUE   4
## 505      75     120      75   127      TRUE   4
## 506     120     120     120   120      TRUE   4
## 507     100     100     100   100      TRUE   5
## 508      55      45      55    63     FALSE   5
## 509      75      60      75    83     FALSE   5
## 510      95      75      95   113     FALSE   5
## 511      45      45      45    45     FALSE   5
## 512      55      70      55    55     FALSE   5
## 513      65     100      65    65     FALSE   5
## 514      45      63      45    45     FALSE   5
## 515      60      83      60    60     FALSE   5
## 516      85     108      70    70     FALSE   5
## 517      39      35      39    42     FALSE   5
## 518      69      60      69    77     FALSE   5
## 519      45      25      45    55     FALSE   5
## 520      65      35      65    60     FALSE   5
## 521      90      45      90    80     FALSE   5
## 522      37      50      37    66     FALSE   5
## 523      50      88      50   106     FALSE   5
## 524      48      53      48    64     FALSE   5
## 525      63      98      63   101     FALSE   5
## 526      48      53      48    64     FALSE   5
## 527      63      98      63   101     FALSE   5
## 528      48      53      48    64     FALSE   5
## 529      63      98      63   101     FALSE   5
## 530      45      67      55    24     FALSE   5
## 531      85     107      95    29     FALSE   5
## 532      50      36      30    43     FALSE   5
## 533      62      50      42    65     FALSE   5
## 534      80      65      55    93     FALSE   5
## 535      32      50      32    76     FALSE   5
## 536      63      80      63   116     FALSE   5
## 537      85      25      25    15     FALSE   5
## 538     105      50      40    20     FALSE   5
## 539     130      60      80    25     FALSE   5
## 540      43      55      43    72     FALSE   5
## 541      55      77      55   114     FALSE   5
## 542      40      30      45    68     FALSE   5
## 543      60      50      65    88     FALSE   5
## 544      86      60      86    50     FALSE   5
## 545      55      25      35    35     FALSE   5
## 546      85      40      50    40     FALSE   5
## 547      95      55      65    45     FALSE   5
## 548      40      50      40    64     FALSE   5
## 549      55      65      55    69     FALSE   5
## 550      75      85      75    74     FALSE   5
## 551      85      30      85    45     FALSE   5
## 552      75      30      75    85     FALSE   5
## 553      70      40      60    42     FALSE   5
## 554      90      50      80    42     FALSE   5
## 555      80      70      80    92     FALSE   5
## 556      59      30      39    57     FALSE   5
## 557      99      40      79    47     FALSE   5
## 558      89      55      69   112     FALSE   5
## 559      60      37      50    66     FALSE   5
## 560      85      77      75   116     FALSE   5
## 561      50      70      50    30     FALSE   5
## 562      75     110      75    90     FALSE   5
## 563      65      80      55    98     FALSE   5
## 564      65      80      55    98     FALSE   5
## 565      35      35      35    65     FALSE   5
## 566      45      45      45    74     FALSE   5
## 567      80      65      70    92     FALSE   5
## 568      45      15      45    50     FALSE   5
## 569      55      30      55    95     FALSE   5
## 570     105     140     105    55     FALSE   5
## 571      67     106      67    60     FALSE   5
## 572      85      35      35    55     FALSE   5
## 573     125      65      75    45     FALSE   5
## 574      70      35      70    48     FALSE   5
## 575     115      45     115    58     FALSE   5
## 576      80     103      80    97     FALSE   5
## 577      85      55      65    30     FALSE   5
## 578     145      95     105    30     FALSE   5
## 579     103      53      45    22     FALSE   5
## 580     133      83      65    32     FALSE   5
## 581      45      74      45    70     FALSE   5
## 582      65     112      65   110     FALSE   5
## 583      62      40      62    65     FALSE   5
## 584      82      60      82    75     FALSE   5
## 585      40      80      40    65     FALSE   5
## 586      60     120      60   105     FALSE   5
## 587      40      40      40    75     FALSE   5
## 588      60      65      60   115     FALSE   5
## 589      50      55      65    45     FALSE   5
## 590      70      75      85    55     FALSE   5
## 591      95      95     110    65     FALSE   5
## 592      40     105      50    20     FALSE   5
## 593      50     125      60    30     FALSE   5
## 594      75     125      85    30     FALSE   5
## 595      50      44      50    55     FALSE   5
## 596      63      87      63    98     FALSE   5
## 597      50      65      60    44     FALSE   5
## 598      65      80      75    59     FALSE   5
## 599      85     110      95    79     FALSE   5
## 600      50      40      50    75     FALSE   5
## 601      70      60      70    95     FALSE   5
## 602      60      75      60   103     FALSE   5
## 603      45      40      45    60     FALSE   5
## 604     105      60     105    20     FALSE   5
## 605      45      55      55    15     FALSE   5
## 606      70      85      80    30     FALSE   5
## 607      50      65      85    40     FALSE   5
## 608      70      85     105    60     FALSE   5
## 609      80      40      45    65     FALSE   5
## 610      50      57      50    65     FALSE   5
## 611      60      97      60   108     FALSE   5
## 612      91      24      86    10     FALSE   5
## 613     131      54     116    20     FALSE   5
## 614      70      45      60    30     FALSE   5
## 615      95      70      85    50     FALSE   5
## 616     115      70      85    90     FALSE   5
## 617      40      45      40    60     FALSE   5
## 618      70      75      70    40     FALSE   5
## 619      80     105      80    50     FALSE   5
## 620      55      85      55    30     FALSE   5
## 621      75     125      95    40     FALSE   5
## 622      55      65      55    20     FALSE   5
## 623      60      95      60    55     FALSE   5
## 624      90     145      90    80     FALSE   5
## 625      60      30      40    57     FALSE   5
## 626      70      40      50    67     FALSE   5
## 627      90      60      70    97     FALSE   5
## 628      40      60      40    40     FALSE   5
## 629      80      70      80    50     FALSE   5
## 630      50      95     135   105     FALSE   5
## 631      85      40      65    25     FALSE   5
## 632      40     100      60   145     FALSE   5
## 633      84      81      99    32     FALSE   5
## 634      50      55      50    65     FALSE   5
## 635      60      95      60   105     FALSE   5
## 636      90      60      90    48     FALSE   5
## 637      50      35      50    35     FALSE   5
## 638      80      55      80    55     FALSE   5
## 639      70      40      40    60     FALSE   5
## 640     100      60      70    70     FALSE   5
## 641      95      40      95    55     FALSE   5
## 642      50      37      50    60     FALSE   5
## 643      75      57      75    80     FALSE   5
## 644      75      45      65    60     FALSE   5
## 645     105      55      95    80     FALSE   5
## 646      66     105      66    65     FALSE   5
## 647     112      48      48   109     FALSE   5
## 648      50      45      50    38     FALSE   5
## 649      70      65      70    58     FALSE   5
## 650      90     125      90    98     FALSE   5
## 651      55      50      55    60     FALSE   5
## 652      65     135     105   100     FALSE   5
## 653     129      90      72   108      TRUE   5
## 654      90      72      90   108      TRUE   5
## 655      72      90     129   108      TRUE   5
## 656      70     125      80   111      TRUE   5
## 657      80     110      90   121      TRUE   5
## 658      70     125      80   111      TRUE   5
## 659      70     145      80   101      TRUE   5
## 660     100     150     120    90      TRUE   5
## 661     120     120     100    90      TRUE   5
## 662      90     115      80   101      TRUE   5
## 663      90     105      80    91      TRUE   5
## 664      90     130      90    95      TRUE   5
## 665     100     120      90    95      TRUE   5
## 666      90     170     100    95      TRUE   5
## 667      90     129      90   108      TRUE   5
## 668      90     129      90   108      TRUE   5
## 669      77     128     128    90      TRUE   5
## 670      90      77      77   128      TRUE   5
## 671      95     120      95    99      TRUE   5
## 672      65      48      45    38     FALSE   6
## 673      95      56      58    57     FALSE   6
## 674     122      74      75    64     FALSE   6
## 675      40      62      60    60     FALSE   6
## 676      58      90      70    73     FALSE   6
## 677      72     114     100   104     FALSE   6
## 678      40      62      44    71     FALSE   6
## 679      52      83      56    97     FALSE   6
## 680      67     103      71   122     FALSE   6
## 681      67     153      71   132     FALSE   6
## 682      38      32      36    57     FALSE   6
## 683      77      50      77    78     FALSE   6
## 684      43      40      38    62     FALSE   6
## 685      55      56      52    84     FALSE   6
## 686      71      74      69   126     FALSE   6
## 687      40      27      25    35     FALSE   6
## 688      60      27      30    29     FALSE   6
## 689      50      90      50    89     FALSE   6
## 690      58      73      54    72     FALSE   6
## 691      72     109      66   106     FALSE   6
## 692      39      61      79    42     FALSE   6
## 693      47      75      98    52     FALSE   6
## 694      68     112     154    75     FALSE   6
## 695      48      62      57    52     FALSE   6
## 696      62      97      81    68     FALSE   6
## 697      62      46      48    43     FALSE   6
## 698      78      69      71    58     FALSE   6
## 699      60      65      90   102     FALSE   6
## 700      54      63      60    68     FALSE   6
## 701      76      83      81   104     FALSE   6
## 702      76      83      81   104     FALSE   6
## 703     100      35      37    28     FALSE   6
## 704     150      45      49    35     FALSE   6
## 705     140      50     140    60     FALSE   6
## 706      50     140      50    60     FALSE   6
## 707      60      63      65    23     FALSE   6
## 708      72      99      89    29     FALSE   6
## 709      66      59      57    49     FALSE   6
## 710      86      85      75    72     FALSE   6
## 711      53      37      46    45     FALSE   6
## 712      88      68      75    73     FALSE   6
## 713      67      39      56    50     FALSE   6
## 714     115      54      86    68     FALSE   6
## 715      60      60      60    30     FALSE   6
## 716      90      97     123    44     FALSE   6
## 717      62      58      63    44     FALSE   6
## 718      88     120      89    59     FALSE   6
## 719      33      61      43    70     FALSE   6
## 720      52     109      94   109     FALSE   6
## 721      77      45      45    48     FALSE   6
## 722     119      69      59    71     FALSE   6
## 723      50      67      63    46     FALSE   6
## 724      72      99      92    58     FALSE   6
## 725      65     110     130    60     FALSE   6
## 726      75      74      63   118     FALSE   6
## 727      57      81      67   101     FALSE   6
## 728     150      50     150    50     FALSE   6
## 729      35      55      75    40     FALSE   6
## 730      53      83     113    60     FALSE   6
## 731      70     110     150    80     FALSE   6
## 732      91      80      87    75     FALSE   6
## 733      48      50      60    38     FALSE   6
## 734      76      65      82    56     FALSE   6
## 735      70      44      55    51     FALSE   6
## 736      70      44      55    56     FALSE   6
## 737      70      44      55    46     FALSE   6
## 738      70      44      55    41     FALSE   6
## 739     122      58      75    84     FALSE   6
## 740     122      58      75    99     FALSE   6
## 741     122      58      75    69     FALSE   6
## 742     122      58      75    54     FALSE   6
## 743      85      32      35    28     FALSE   6
## 744     184      44      46    28     FALSE   6
## 745      35      45      40    55     FALSE   6
## 746      80      97      80   123     FALSE   6
## 747      95     131      98    99      TRUE   6
## 748      95     131      98    99      TRUE   6
## 749     121      81      95    95      TRUE   6
## 750      71      61      85   115      TRUE   6
## 751     121      91      95    85      TRUE   6
## 752     150     100     150    50      TRUE   6
## 753      60     150     130    70      TRUE   6
## 754      60     170     130    80      TRUE   6
## 755     120     130      90    70      TRUE   6
## 756      55      50      50    42     FALSE   7
## 757      75      70      70    52     FALSE   7
## 758      75     100     100    70     FALSE   7
## 759      40      60      40    70     FALSE   7
## 760      50      80      50    90     FALSE   7
## 761      90      80      90    60     FALSE   7
## 762      54      66      56    40     FALSE   7
## 763      69      91      81    50     FALSE   7
## 764      74     126     116    60     FALSE   7
## 765      30      30      30    65     FALSE   7
## 766      50      40      50    75     FALSE   7
## 767      75      75      75    60     FALSE   7
## 768      30      30      30    45     FALSE   7
## 769      60      55      60    45     FALSE   7
## 770      45      55      45    46     FALSE   7
## 771      95      55      75    36     FALSE   7
## 772      90     145      75    43     FALSE   7
## 773      57      42      47    63     FALSE   7
## 774      77      62      67    43     FALSE   7
## 775      70      98      70    93     FALSE   7
## 776      70      98      70    93     FALSE   7
## 777      70      98      70    93     FALSE   7
## 778      70      98      70    93     FALSE   7
## 779      40      55      40    84     FALSE   7
## 780      60      95      70   124     FALSE   7
## 781      40      30      40    60     FALSE   7
## 782      40      30      40    60     FALSE   7
## 783      65      55      65   112     FALSE   7
## 784      75      55      75    82     FALSE   7
## 785      65      55      65   110     FALSE   7
## 786      20      25      25    40     FALSE   7
## 787     130     140     135    30     FALSE   7
## 788      62      43      52    45     FALSE   7
## 789     152      53     142    35     FALSE   7
## 790      70      45      55    45     FALSE   7
## 791     100      55      85    35     FALSE   7
## 792      52      40      72    27     FALSE   7
## 793      92      50     132    42     FALSE   7
## 794      35      50      35    35     FALSE   7
## 795      90      80      90    45     FALSE   7
## 796      55      65      75    15     FALSE   7
## 797      80      90     100    30     FALSE   7
## 798      40      71      40    77     FALSE   7
## 799      60     111      60   117     FALSE   7
## 800      50      45      50    50     FALSE   7
## 801      80      55      60    60     FALSE   7
## 802      38      30      38    32     FALSE   7
## 803      48      40      48    62     FALSE   7
## 804      98      50      98    72     FALSE   7
## 805      90      82     110   100     FALSE   7
## 806      80      90     110    60     FALSE   7
## 807      90      40      60    80     FALSE   7
## 808      40      20      30    80     FALSE   7
## 809     140      60      90    40     FALSE   7
## 810      80      70      45    15     FALSE   7
## 811     110     100      75    35     FALSE   7
## 812     130      30     130     5     FALSE   7
## 813      95      95      95    59      TRUE   7
## 814      95      95      95    95      TRUE   7
## 815     100      60     100    60     FALSE   7
## 816      60     100      60   120     FALSE   7
## 817      65      75      95    65     FALSE   7
## 818     135      91      85    36     FALSE   7
## 819      63      40      73    96     FALSE   7
## 820      80      50     105    96     FALSE   7
## 821      70      70      70    92     FALSE   7
## 822      85     135      91    36     FALSE   7
## 823     100      86      90    40     FALSE   7
## 824      65      45      45    45     FALSE   7
## 825      90      65      70    65     FALSE   7
## 826     125     100     105    85     FALSE   7
## 827      85      95      75   130      TRUE   7
## 828      75     130     115    95      TRUE   7
## 829     115      85      95    75      TRUE   7
## 830     115      95     130    85      TRUE   7
## 831      31      29      31    37      TRUE   7
## 832     131      29     131    37      TRUE   7
## 833     107     113      89    97      TRUE   7
## 834      89     137     107    97      TRUE   7
## 835      47     127     131   103      TRUE   7
## 836     139      53      53    79      TRUE   7
## 837      37     137      37   151      TRUE   7
## 838      71     173      71    83      TRUE   7
## 839     103     107     101    61      TRUE   7
## 840     131      59      31   109      TRUE   7
## 841      53      97      53    43      TRUE   7
## 842     101     127      89    79      TRUE   7
## 843     127     113     109    77      TRUE   7
## 844     109     157     127    77      TRUE   7
## 845      97     167      97   129      TRUE   7
## 846     115     130     115    65      TRUE   7
## 847      80      90      90   125      TRUE   7
## 848      67      73      67    73      TRUE   7
## 849      73     127      73   121      TRUE   7
## 850     211      53     101    13      TRUE   7
## 851      53     151      79   107      TRUE   7
## 852      75     102      80   143      TRUE   7
## 853      65      55      35    34      TRUE   7
## 854     143      80      65    34      TRUE   7
## 855      50      40      40    65     FALSE   8
## 856      70      55      60    80     FALSE   8
## 857      90      60      70    85     FALSE   8
## 858      40      40      40    69     FALSE   8
## 859      60      55      60    94     FALSE   8
## 860      75      65      75   119     FALSE   8
## 861      40      70      40    70     FALSE   8
## 862      55      95      55    90     FALSE   8
## 863      65     125      65   120     FALSE   8
## 864      55      35      35    25     FALSE   8
## 865      95      55      75    20     FALSE   8
## 866      35      33      35    57     FALSE   8
## 867      55      43      55    77     FALSE   8
## 868     105      53      85    67     FALSE   8
## 869      20      25      45    45     FALSE   8
## 870      80      50      90    30     FALSE   8
## 871     110      80     120    90     FALSE   8
## 872      28      47      52    50     FALSE   8
## 873      58      87      92    90     FALSE   8
## 874      60      40      60    10     FALSE   8
## 875      90      80     120    60     FALSE   8
## 876      55      40      45    48     FALSE   8
## 877     100      60      90    88     FALSE   8
## 878      50      38      38    44     FALSE   8
## 879      90      48      68    74     FALSE   8
## 880      50      40      50    26     FALSE   8
## 881      60      90      60   121     FALSE   8
## 882      50      40      50    30     FALSE   8
## 883      90      60      70    50     FALSE   8
## 884     120      80      90    30     FALSE   8
## 885      80      40      40    20     FALSE   8
## 886      80      95      60    70     FALSE   8
## 887      80     100      80    30     FALSE   8
## 888      75      35      50    46     FALSE   8
## 889     125      65      70    71     FALSE   8
## 890      55      85      95    85     FALSE   8
## 891      40      40      30    66     FALSE   8
## 892      60      60      50   136     FALSE   8
## 893      35      54      35    40     FALSE   8
## 894      70     114      70    75     FALSE   8
## 895      70     114      70    75     FALSE   8
## 896      45      50      50    45     FALSE   8
## 897      65      90      90    65     FALSE   8
## 898      60      50      50    32     FALSE   8
## 899      90      70      80    42     FALSE   8
## 900      45      74      54    50     FALSE   8
## 901      65     134     114    70     FALSE   8
## 902      45      56      53    39     FALSE   8
## 903      65      86      73    49     FALSE   8
## 904      95     136     103    29     FALSE   8
## 905      30      55      40    50     FALSE   8
## 906      45      75      55    70     FALSE   8
## 907      65      95      75    60     FALSE   8
## 908     101      60      81    95     FALSE   8
## 909     100      50      60    50     FALSE   8
## 910      50     145     130    30     FALSE   8
## 911      95      68      82    65     FALSE   8
## 912      75     110     100    70     FALSE   8
## 913     145      50     105    30     FALSE   8
## 914      40      50      61    34     FALSE   8
## 915      75     110     121    64     FALSE   8
## 916     100      70      60    75     FALSE   8
## 917      95      91      85    15     FALSE   8
## 918      35      45      30    20     FALSE   8
## 919      60     125      90    65     FALSE   8
## 920     135      20      20    70     FALSE   8
## 921     110      65      90    50     FALSE   8
## 922      70      65      50   130     FALSE   8
## 923      55     105      95    95     FALSE   8
## 924      65      95     105    85     FALSE   8
## 925      58      70      58    97     FALSE   8
## 926      58      70      58    97     FALSE   8
## 927      49      40      49    40     FALSE   8
## 928      69      80      69    30     FALSE   8
## 929      90      80      70    75     FALSE   8
## 930      90      90      80    55     FALSE   8
## 931     100      70      80    75     FALSE   8
## 932     100      80      90    55     FALSE   8
## 933     115     120      50    85     FALSE   8
## 934      30      40      30    82     FALSE   8
## 935      50      60      50   102     FALSE   8
## 936      75     100      75   142     FALSE   8
## 937     115      80     115   148      TRUE   8
## 938     115      80     115   138      TRUE   8
## 939     145      80     145   128      TRUE   8
## 940     115      80     115   138      TRUE   8
## 941      95     145      95   130      TRUE   8
## 942     250     125     250   130      TRUE   8
## 943      60      53      50    72      TRUE   8
## 944     100      63      60    97      TRUE   8
## 945     100      63      60    97      TRUE   8
## 946     105      70      95   105      TRUE   8
## 947      50     100      50   200      TRUE   8
## 948      50     100      50    80      TRUE   8
## 949     130      65     110    30      TRUE   8
## 950      60     145      80   130      TRUE   8
## 951      80      80      80    80      TRUE   8
## 952     150      85     130    50      TRUE   8
## 953      80     165     100   150      TRUE   8
```

# Other objects in R

In R, everything is an object. Whether it is a vector, data frame, list or Matrix, they are all objects. 


```r
ronaldo <- read.csv("https://raw.githubusercontent.com/andrewmoles2/webScraping/main/R/data/ronaldo_club.csv")

ronaldo_lm <- lm(total_apps ~ total_goals, data = ronaldo)
summary(ronaldo_lm)
```

```
## 
## Call:
## lm(formula = total_apps ~ total_goals, data = ronaldo)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -30.0127  -3.0235   0.0842   3.0160  14.5723 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  32.0127     4.4414   7.208 1.05e-06 ***
## total_goals   0.3794     0.1150   3.301  0.00398 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9.712 on 18 degrees of freedom
## Multiple R-squared:  0.377,	Adjusted R-squared:  0.3424 
## F-statistic: 10.89 on 1 and 18 DF,  p-value: 0.003977
```

```r
class(ronaldo_lm)
```

```
## [1] "lm"
```

```r
ronaldo_lm$model
```

```
##    total_apps total_goals
## 1           2           0
## 2          31           5
## 3          40           6
## 4          50           9
## 5          47          12
## 6          53          23
## 7          49          42
## 8          53          26
## 9          35          33
## 10         54          53
## 11         55          60
## 12         55          55
## 13         47          51
## 14         54          61
## 15         48          51
## 16         46          42
## 17         44          44
## 18         43          28
## 19         46          37
## 20         44          36
```

