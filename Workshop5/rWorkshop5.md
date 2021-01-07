---
title: "R Workshop 5 - Conditionals and Logic"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "07 January, 2021"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What this workshop will cover
*  Boolean operators 
*  Conditional operators
*  Conditional logic
*  If else statements

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

# Boolean operators

In these workshops we have covered numeric, string, and factorised data types. The one data type we have not yet covered in this workshop is the logical data type. The logical data type is boolean; boolean is a binary variable that can have one of two possible values, 0 (false) or 1 (true).

To use boolean in R we capitalise true and false. Run the code below to test this out. 

```r
trueFalse <- c(TRUE, FALSE, TRUE, FALSE)
class(trueFalse)
```

```
## [1] "logical"
```

We can also convert binary into boolean. R will make a 1 true and a 0 false. Run the code below to test this out. 

```r
binary <- c(1,0,0,0,1,1,1,0)
as.logical(binary)
```

```
## [1]  TRUE FALSE FALSE FALSE  TRUE  TRUE  TRUE FALSE
```

Why is this useful? Using boolean allows us to set *conditions* that can either be true or false. Meaning we can test variables against each other on the basis of a condition being met with the outcome being determined by the test. 

## Boolean task

1) Make data frame called pizza. For the first column use the topping vector provided. For the second column call it Good_topping, and use 1's and 0's to indicate a good or bad topping (1 = good, 0 = bad)
2) Convert your good topping column to logical using `as.logical`
3) Run `str()` and `head()` to view your data. Good_topping should now be logical (true and false). 


```r
Topping <- c('Mozzarella', 'Pepperoni','Pinapple', 'Pepper', 'Carrot')

# your code here
pizza <- data.frame(
  Topping,
  Good_topping = c(1,1,0,1,0)
)

pizza$Good_topping <- as.logical(pizza$Good_topping)

str(pizza)
```

```
## 'data.frame':	5 obs. of  2 variables:
##  $ Topping     : chr  "Mozzarella" "Pepperoni" "Pinapple" "Pepper" ...
##  $ Good_topping: logi  TRUE TRUE FALSE TRUE FALSE
```

# Conditional Operators

In order to test conditions we need conditional operators. Below is a table of conditional operators. During this session we will have examples and tasks using them in various contexts. 

| Operator | Meaning                  |
|----------|--------------------------|
| >        | Greater than             |
| >=       | Greater than or equal to |
| <        | Less than                |
| <=       | Less than or equal to    |
| ==       | Equal to                 |
| !=       | Not equal to             |
| !X       | NOT X                    |
| X | Y    | X OR Y                   |
| X & Y    | X AND Y                  |
| X %in% Y | is X in Y                |

The greater than (>), or greater than or equal to (>=) operators test if variable x is greater than y; less than (<), or less than or equal to (<=) test if x is less than, or equal to, y. The output is always boolean. 

Run the code below to test this out. 

```r
18 > 18
```

```
## [1] FALSE
```

```r
18 >= 18
```

```
## [1] TRUE
```

```r
18 < 17
```

```
## [1] FALSE
```
Why is 18 > 18 false? Any value below 18 would be true, but 18 is not greater than 18. To include 18 into the test we have to use the greater than or equal to operator. 

You're most likely to use these tests on data frames or vectors. Run the code below to test out using equals to and not equal to on two columns in a data frame. 

```r
# data frame to test on
df <- data.frame(
  x = c(rep(20,5),rep(40,2),rep(60,3)),
  y = c(rep(20,3),rep(40,5),rep(60,2))
)
# view data
df
```

```
##     x  y
## 1  20 20
## 2  20 20
## 3  20 20
## 4  20 40
## 5  20 40
## 6  40 40
## 7  40 40
## 8  60 40
## 9  60 60
## 10 60 60
```

```r
# where is x equal to y
df$x == df$y
```

```
##  [1]  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE  TRUE
```

```r
# where is x not equal to y
df$x != df$y
```

```
##  [1] FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE
```

```r
# we can also count the true cases
sum(df$x == df$y)
```

```
## [1] 7
```

The *equal to* test tells us where x and y have the same data, *not equal to* does the opposite. We can also use conditional operators on strings. Run the code below to test this out. 

```r
"pizza" == "bad"
```

```
## [1] FALSE
```

```r
"pizza" == "pizza"
```

```
## [1] TRUE
```

## Conditional operator task 

Using conditional operators work out the following:

1) Is 70 less than or equal to 11?
2) Using the following vector, `z <- sample(1:100, 20)`, count how many elements in *z* are less than (<) 50, and how many are greater then or equal to (>=) 50. 
3) Using the following vector, `pets <- c(rep('cat',5), rep('fish',11), rep('dog',6))`, count how many fish there are.
4) Using the same pets vector, how many pets are not fish?


```r
# your code here
# 1 
70 <= 11
```

```
## [1] FALSE
```

```r
# 2
z <- sample(1:100, 20)
sum(z < 50)
```

```
## [1] 6
```

```r
sum(z >= 50)
```

```
## [1] 14
```

```r
# 3
pets <- c(rep('cat',5), rep('fish',13), rep('dog',6))
sum(pets == 'fish')
```

```
## [1] 13
```

```r
# 4
sum(pets != 'fish')
```

```
## [1] 11
```

# Indexing using conditional operators (subsetting)

Indexing using conditional operators is the same as we learned in previous sessions. Instead of calling the index of vector or data frame, we call a condition to test and find data. 

We might want to find specific data, in the example below we are subsetting data from the pets vector that is equal to cat. Run the code to test it out. 

```r
# pet data
pets <- c(rep('cat',5), rep('fish',13), rep('dog',6))
# pull out cats
cats <- pets[pets == 'cat']
# view subsetted data
cats
```

```
## [1] "cat" "cat" "cat" "cat" "cat"
```

When doing the same with data frames you will need to include a comma. The condition goes in the row index (left hand of comma); Remember `df[row index, col index]`. Run the code below to test it out on data frames. 

```r
# data frame with numbers randomly pulled from 1 to 100 for x & y
df <- data.frame(
  x = sample(1:100, 10),
  y = sample(1:100, 10)
)
# showing data where x is less than 20
df[df$x < 20, ]
```

```
##    x  y
## 8 16 65
## 9  8 85
```

```r
# subsetting data into df2 that are >= 35
df2 <- df[df$x >= 35, ]
df2
```

```
##     x  y
## 2  89 25
## 3  80 40
## 4  50 98
## 5  64 71
## 6  81 20
## 10 42  7
```

In base R there is a specialised function for subsetting data frames called `subset()`. It is pretty handy as it will save you time typing because you only need to give the name of the data frame once. 

```r
subset(df, y <= 40)
```

```
##     x  y
## 1  32 12
## 2  89 25
## 3  80 40
## 6  81 20
## 7  22 14
## 10 42  7
```

## Subsetting task

In this task we are going to load in data from a URL and do some subsetting with it. The dataset is from the Pokémon games, and includes only the original game Pokémon (Pikachu etc.). We will use this data for the rest of the tasks. Each row in the data is a different Pokémon, with their various statistics and typing. 

1) Using `read_csv()` from the `readr` library load in the data from the following URL, calling the data pokemon: https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop4b/data/pokemonGen1.csv
2) Get information on your loaded data using the `str()`, `head()` and `View()` functions. 
3) 


```r
# load in readr (install using install.packages('readr') if you don't have it
library(readr)

# your code here
# load in data
pokemon <- read_csv("https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop4b/data/pokemonGen1.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Number = col_double(),
##   Name = col_character(),
##   Type.1 = col_character(),
##   Type.2 = col_character(),
##   Total = col_double(),
##   HP = col_double(),
##   Attack = col_double(),
##   Defense = col_double(),
##   Sp..Atk = col_double(),
##   Sp..Def = col_double(),
##   Speed = col_double(),
##   Generation = col_double(),
##   Legendary = col_character()
## )
```

```r
# get information about dataset
head(pokemon)
```

```
## # A tibble: 6 x 13
##   Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##    <dbl> <chr> <chr>  <chr>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
## 1      1 Bulb… Grass  Poison   318    45     49      49      65      65    45
## 2      2 Ivys… Grass  Poison   405    60     62      63      80      80    60
## 3      3 Venu… Grass  Poison   525    80     82      83     100     100    80
## 4      4 Char… Fire   <NA>     309    39     52      43      60      50    65
## 5      5 Char… Fire   <NA>     405    58     64      58      80      65    80
## 6      6 Char… Fire   Flying   534    78     84      78     109      85   100
## # … with 2 more variables: Generation <dbl>, Legendary <chr>
```

```r
str(pokemon)
```

```
## tibble [151 × 13] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ Number    : num [1:151] 1 2 3 4 5 6 7 8 9 10 ...
##  $ Name      : chr [1:151] "Bulbasaur" "Ivysaur" "Venusaur" "Charmander" ...
##  $ Type.1    : chr [1:151] "Grass" "Grass" "Grass" "Fire" ...
##  $ Type.2    : chr [1:151] "Poison" "Poison" "Poison" NA ...
##  $ Total     : num [1:151] 318 405 525 309 405 534 314 405 530 195 ...
##  $ HP        : num [1:151] 45 60 80 39 58 78 44 59 79 45 ...
##  $ Attack    : num [1:151] 49 62 82 52 64 84 48 63 83 30 ...
##  $ Defense   : num [1:151] 49 63 83 43 58 78 65 80 100 35 ...
##  $ Sp..Atk   : num [1:151] 65 80 100 60 80 109 50 65 85 20 ...
##  $ Sp..Def   : num [1:151] 65 80 100 50 65 85 64 80 105 20 ...
##  $ Speed     : num [1:151] 45 60 80 65 80 100 43 58 78 45 ...
##  $ Generation: num [1:151] 1 1 1 1 1 1 1 1 1 1 ...
##  $ Legendary : chr [1:151] "No" "No" "No" "No" ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   Number = col_double(),
##   ..   Name = col_character(),
##   ..   Type.1 = col_character(),
##   ..   Type.2 = col_character(),
##   ..   Total = col_double(),
##   ..   HP = col_double(),
##   ..   Attack = col_double(),
##   ..   Defense = col_double(),
##   ..   Sp..Atk = col_double(),
##   ..   Sp..Def = col_double(),
##   ..   Speed = col_double(),
##   ..   Generation = col_double(),
##   ..   Legendary = col_character()
##   .. )
```

```r
summary(pokemon)
```

```
##      Number          Name              Type.1             Type.2         
##  Min.   :  1.0   Length:151         Length:151         Length:151        
##  1st Qu.: 38.5   Class :character   Class :character   Class :character  
##  Median : 76.0   Mode  :character   Mode  :character   Mode  :character  
##  Mean   : 76.0                                                           
##  3rd Qu.:113.5                                                           
##  Max.   :151.0                                                           
##      Total             HP             Attack          Defense      
##  Min.   :195.0   Min.   : 10.00   Min.   :  5.00   Min.   :  5.00  
##  1st Qu.:320.0   1st Qu.: 45.00   1st Qu.: 51.00   1st Qu.: 50.00  
##  Median :405.0   Median : 60.00   Median : 70.00   Median : 65.00  
##  Mean   :407.1   Mean   : 64.21   Mean   : 72.55   Mean   : 68.23  
##  3rd Qu.:490.0   3rd Qu.: 80.00   3rd Qu.: 90.00   3rd Qu.: 84.00  
##  Max.   :680.0   Max.   :250.00   Max.   :134.00   Max.   :180.00  
##     Sp..Atk          Sp..Def           Speed          Generation
##  Min.   : 15.00   Min.   : 20.00   Min.   : 15.00   Min.   :1   
##  1st Qu.: 45.00   1st Qu.: 49.00   1st Qu.: 46.50   1st Qu.:1   
##  Median : 65.00   Median : 65.00   Median : 70.00   Median :1   
##  Mean   : 67.14   Mean   : 66.02   Mean   : 68.93   Mean   :1   
##  3rd Qu.: 87.50   3rd Qu.: 80.00   3rd Qu.: 90.00   3rd Qu.:1   
##  Max.   :154.00   Max.   :125.00   Max.   :140.00   Max.   :1   
##   Legendary        
##  Length:151        
##  Class :character  
##  Mode  :character  
##                    
##                    
## 
```

# Using AND OR 

We can thread together multiple conditional operators using the AND and OR statements. 

# The If statement

The if statement is fundamental to programming. It uses conditional operators and boolean to *control flow*. This means to run a test to determine which operation of output is given, so it controls the flow of your code. 







