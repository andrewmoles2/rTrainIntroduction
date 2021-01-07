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
## [1] 10
```

```r
sum(z >= 50)
```

```
## [1] 10
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
## 4 15 53
```

```r
# subsetting data into df2 that are >= 35
df2 <- df[df$x >= 35, ]
df2
```

```
##     x  y
## 2  80 59
## 5  90 90
## 7  68 72
## 8  47 89
## 9  53 14
## 10 75 47
```

In base R there is a specialised function for subsetting data frames called `subset()`. It is pretty handy as it will save you time typing because you only need to give the name of the data frame once. 

```r
subset(df, y <= 40)
```

```
##    x  y
## 6 25 20
## 9 53 14
```

## Subsetting task

In this task we are going to load in data from a URL and do some subsetting with it. The dataset is from the Pokémon games, and includes only the original game Pokémon (Pikachu, Mewtwo etc.). We will use this data for the rest of the tasks. Each row in the data is a different Pokémon, with their various statistics and typing. 

1) Using `read_csv()` from the `readr` library load in the data from the following URL, calling the data pokemon: https://raw.githubusercontent.com/andrewmoles2/rTrainIntroduction/master/Workshop4b/data/pokemonGen1.csv
2) Get information on your loaded data using the `str()`, `head()` and `View()` functions. 
3) Using `subset()` make a new data frame called highHP and subset pokemon with a HP greater than or equal to 80. *HP stands for hit points*
4) Run `summary()` on your highHP data frame to see the statistics of pokemon with high hit points (HP)
5) There are some very low stats for Attack, Defense, and Speed. Use `which.min()` to find out which pokemon have these stats. *hint: data[which.min(data$col),]*. 
6) The attack stat seems to have the highest mean (other than HP). Using `sum()` find out how many of your high HP pokemon have an Attack stat greater than or equal to 100.
7) Finally, find out who those pokemon are. *hint: use subsetting*


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
# subset based on hit points
highHP <- subset(pokemon, HP >= 80)
summary(highHP)
```

```
##      Number           Name              Type.1             Type.2         
##  Min.   :  3.00   Length:39          Length:39          Length:39         
##  1st Qu.: 64.50   Class :character   Class :character   Class :character  
##  Median : 89.00   Mode  :character   Mode  :character   Mode  :character  
##  Mean   : 92.26                                                           
##  3rd Qu.:130.50                                                           
##  Max.   :151.00                                                           
##      Total             HP             Attack          Defense     
##  Min.   :270.0   Min.   : 80.00   Min.   :  5.00   Min.   :  5.0  
##  1st Qu.:477.0   1st Qu.: 80.50   1st Qu.: 74.00   1st Qu.: 65.0  
##  Median :500.0   Median : 90.00   Median : 92.00   Median : 79.0  
##  Mean   :491.4   Mean   : 99.13   Mean   : 89.41   Mean   : 77.1  
##  3rd Qu.:530.0   3rd Qu.:102.50   3rd Qu.:105.00   3rd Qu.: 88.5  
##  Max.   :680.0   Max.   :250.00   Max.   :134.00   Max.   :130.0  
##     Sp..Atk          Sp..Def           Speed          Generation
##  Min.   : 30.00   Min.   : 25.00   Min.   : 15.00   Min.   :1   
##  1st Qu.: 60.00   1st Qu.: 70.00   1st Qu.: 45.00   1st Qu.:1   
##  Median : 73.00   Median : 85.00   Median : 68.00   Median :1   
##  Mean   : 77.87   Mean   : 81.28   Mean   : 66.62   Mean   :1   
##  3rd Qu.:100.00   3rd Qu.: 97.50   3rd Qu.: 85.00   3rd Qu.:1   
##  Max.   :154.00   Max.   :125.00   Max.   :130.00   Max.   :1   
##   Legendary        
##  Length:39         
##  Class :character  
##  Mode  :character  
##                    
##                    
## 
```

```r
# find low attack and defence
highHP[which.min(highHP$Attack),]
```

```
## # A tibble: 1 x 13
##   Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##    <dbl> <chr> <chr>  <chr>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
## 1    113 Chan… Normal <NA>     450   250      5       5      35     105    50
## # … with 2 more variables: Generation <dbl>, Legendary <chr>
```

```r
highHP[which.min(highHP$Defense),]
```

```
## # A tibble: 1 x 13
##   Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##    <dbl> <chr> <chr>  <chr>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
## 1    113 Chan… Normal <NA>     450   250      5       5      35     105    50
## # … with 2 more variables: Generation <dbl>, Legendary <chr>
```

```r
highHP[which.min(highHP$Speed),]
```

```
## # A tibble: 1 x 13
##   Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##    <dbl> <chr> <chr>  <chr>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
## 1     79 Slow… Water  Psych…   315    90     65      65      40      40    15
## # … with 2 more variables: Generation <dbl>, Legendary <chr>
```

```r
# high attack
sum(highHP$Attack >= 100)
```

```
## [1] 15
```

```r
subset(highHP, Attack >= 100)
```

```
## # A tibble: 15 x 13
##    Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##     <dbl> <chr> <chr>  <chr>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
##  1     34 Nido… Poison Ground   505    81    102      77      85      75    85
##  2     59 Arca… Fire   <NA>     555    90    110      80     100      80    95
##  3     67 Mach… Fight… <NA>     405    80    100      70      50      60    45
##  4     68 Mach… Fight… <NA>     505    90    130      80      65      85    55
##  5     71 Vict… Grass  Poison   490    80    105      65     100      70    70
##  6     76 Golem Rock   Ground   495    80    120     130      55      65    45
##  7     89 Muk   Poison <NA>     500   105    105      75      65     100    50
##  8    112 Rhyd… Ground Rock     485   105    130     120      45      45    40
##  9    130 Gyar… Water  Flying   540    95    125      79      60     100    81
## 10    142 Aero… Rock   Flying   515    80    105      65      60      75   130
## 11    143 Snor… Normal <NA>     540   160    110      65      65     110    30
## 12    146 Molt… Fire   Flying   580    90    100      90     125      85    90
## 13    149 Drag… Dragon Flying   600    91    134      95     100     100    80
## 14    150 Mewt… Psych… <NA>     680   106    110      90     154      90   130
## 15    151 Mew   Psych… <NA>     600   100    100     100     100     100   100
## # … with 2 more variables: Generation <dbl>, Legendary <chr>
```

# Using AND OR and %in%

So far we have only been using one condition. By using the AND/OR operators we can thread together multiple conditional tests to make our code more efficient. 

Both statements behave slightly differently. When using AND you must satisfy both conditional tests, when using OR you can satisfy either of your conditional tests. Therefore, AND is strict, while OR is more lenient. 

For example, we have the 7 times table from -70 to 140 and we want to find what numbers are below 20 but above 0. AND works really well for this as it is strict, however OR doesn't work so well and includes everything. OR is better used if we wanted to find numbers less than 0 OR over 70. 

```r
# 7 times table number sequence 
s <- seq(-70, 140, by = 7)
s
```

```
##  [1] -70 -63 -56 -49 -42 -35 -28 -21 -14  -7   0   7  14  21  28  35  42  49  56
## [20]  63  70  77  84  91  98 105 112 119 126 133 140
```

```r
# AND 
s[s < 20 & s > 0]
```

```
## [1]  7 14
```

```r
# OR
s[s < 20 | s > 0]
```

```
##  [1] -70 -63 -56 -49 -42 -35 -28 -21 -14  -7   0   7  14  21  28  35  42  49  56
## [20]  63  70  77  84  91  98 105 112 119 126 133 140
```

```r
# OR finding each end of seq
s[s < 0 | s > 70]
```

```
##  [1] -70 -63 -56 -49 -42 -35 -28 -21 -14  -7  77  84  91  98 105 112 119 126 133
## [20] 140
```

## AND OR exercise

Using the df3 data frame provided run the following tests. Be sure to run the rests using square brackets or the `subset()` function so you see the data as the output. 

1) Subset data where x is less than 50 but greater then 20
2) Subset data where y is greater than or equal to 70 and z is also greater than or equal to 70
3) Subset data where x, y, or z are all less than 15
4) Subset data where y is less than 60 and exp is equal to control

```r
# test data frame
df3 <- data.frame(
  id = paste("person_",letters[1:10]),
  x = sample(1:100, 10),
  y = sample(1:100, 10),
  z = sample(1:100, 10),
  exp = sample(c(rep("control",50),rep("test",50)),10)
)
# your code here
df3[df3$x < 50 & df3$x > 20,]
```

```
##          id  x  y  z     exp
## 2 person_ b 28 22 16    test
## 5 person_ e 48  6 57 control
```

```r
df3[df3$y >= 70 & df3$z >= 70,]
```

```
##          id  x  y   z     exp
## 3 person_ c 17 78  87 control
## 9 person_ i 57 97 100    test
```

```r
df3[df3$x < 15 | df3$y < 15 | df3$z < 15,]
```

```
##          id  x  y  z     exp
## 1 person_ a 59 14 48 control
## 4 person_ d 66 11 50 control
## 5 person_ e 48  6 57 control
```

```r
subset(df3, y < 60 & exp == 'control')
```

```
##          id  x  y  z     exp
## 1 person_ a 59 14 48 control
## 4 person_ d 66 11 50 control
## 5 person_ e 48  6 57 control
## 6 person_ f 90 19 25 control
## 8 person_ h 94 36 76 control
```

# %in% operator

The %in% operator is for value matching. It is a really handy way of comparing vectors of different lengths to see if elements of one vector match at least one element in another. The length of output will be equal to the length of the vector being compared (the first one). This is different to equal to (==) which tests compares if two vectors or variables are exactly equal. 

Two examples of %in% below using the df3 data we just used for the task. First, we compare if numbers 1 to 10 are present in column z. Second, we make a vector with some id's, then we compare those id's to the id column in df3. 

```r
# comparing if 1-10 are in col z
df3[df3$z %in% 1:10,]
```

```
## [1] id  x   y   z   exp
## <0 rows> (or 0-length row.names)
```

```r
# make a table to compare against
match <- paste("person_",letters[6:10])
match
```

```
## [1] "person_ f" "person_ g" "person_ h" "person_ i" "person_ j"
```

```r
# compare your id column to your match vector
subset(df3, id %in% match)
```

```
##           id  x  y   z     exp
## 6  person_ f 90 19  25 control
## 7  person_ g 98 63  41    test
## 8  person_ h 94 36  76 control
## 9  person_ i 57 97 100    test
## 10 person_ j 82 25  82    test
```

## AND OR %in% exercise

Will be using the Pokemon dataset again for this exercise. 

1) Make a vector called Types with the following data: Water, Fire, Grass
2) Using the %in% operator, match your Types vector to the Type.1 or Type.2 column to subset out that data. Call your data poke_wfg (or similar)
3) You should now have a dataset with pokemon that are either fire, water, or grass in the Type.1 or Type.2 columns. Run `summary()` to review your data.
4) It would be interesting to see how many of each pokemon type there are in your subsetted data. First we have to make Type.1 and Type.2 into factors. Using `as.factor()` make the Type.1 and Type.2 columns into factors.
5) Run `summary()` again on your dataset, you will see counts for your Type 1 & 2 columns. 
6) Now run `table()` function on the Type.1 and Type.2 columns, should should see the same result. *hint: table(data$col)*
7) Now, using subsetting, find out which of your fire, grass or water pokemon have a Speed and Attack stat greater than or equal to 90
8) Test out the same conditions but use OR instead. 

```r
# your code here
# types vector
Types <- c('Water', 'Fire', 'Grass')
# using %in% to match
poke_wfg <- subset(pokemon, Type.1 %in% Types | Type.2 %in% Types)
# making types a factor
poke_wfg$Type.1 <- as.factor(poke_wfg$Type.1)
poke_wfg$Type.2 <- as.factor(poke_wfg$Type.2)
# factor counts
summary(poke_wfg)
```

```
##      Number           Name             Type.1       Type.2       Total      
##  Min.   :  1.00   Length:58          Bug  : 2   Poison :11   Min.   :200.0  
##  1st Qu.: 46.25   Class :character   Fire :12   Psychic: 5   1st Qu.:325.0  
##  Median : 77.50   Mode  :character   Grass:12   Water  : 4   Median :407.5  
##  Mean   : 77.48                      Rock : 4   Flying : 3   Mean   :418.7  
##  3rd Qu.:117.75                      Water:28   Ice    : 3   3rd Qu.:503.8  
##  Max.   :146.00                                 (Other): 3   Max.   :580.0  
##                                                 NA's   :29                  
##        HP             Attack          Defense          Sp..Atk     
##  Min.   : 20.00   Min.   : 10.00   Min.   : 35.00   Min.   : 15.0  
##  1st Qu.: 45.00   1st Qu.: 56.25   1st Qu.: 55.50   1st Qu.: 60.0  
##  Median : 60.00   Median : 70.00   Median : 70.00   Median : 70.0  
##  Mean   : 62.81   Mean   : 73.83   Mean   : 74.33   Mean   : 74.4  
##  3rd Qu.: 79.75   3rd Qu.: 91.50   3rd Qu.: 85.00   3rd Qu.: 95.0  
##  Max.   :130.00   Max.   :130.00   Max.   :180.00   Max.   :125.0  
##                                                                    
##     Sp..Def           Speed          Generation  Legendary        
##  Min.   : 20.00   Min.   : 15.00   Min.   :1    Length:58         
##  1st Qu.: 50.00   1st Qu.: 51.25   1st Qu.:1    Class :character  
##  Median : 67.50   Median : 65.00   Median :1    Mode  :character  
##  Mean   : 67.66   Mean   : 65.67   Mean   :1                      
##  3rd Qu.: 85.00   3rd Qu.: 80.75   3rd Qu.:1                      
##  Max.   :120.00   Max.   :115.00   Max.   :1                      
## 
```

```r
table(poke_wfg$Type.1)
```

```
## 
##   Bug  Fire Grass  Rock Water 
##     2    12    12     4    28
```

```r
table(poke_wfg$Type.2)
```

```
## 
## Fighting   Flying    Grass      Ice   Poison  Psychic    Water 
##        1        3        2        3       11        5        4
```

```r
# finding fast attacking pokemon
subset(poke_wfg, Speed >= 90 & Attack >= 90)
```

```
## # A tibble: 4 x 13
##   Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##    <dbl> <chr> <fct>  <fct>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
## 1     59 Arca… Fire   <NA>     555    90    110      80     100      80    95
## 2     78 Rapi… Fire   <NA>     500    65    100      70      80      80   105
## 3    126 Magm… Fire   <NA>     495    65     95      57     100      85    93
## 4    146 Molt… Fire   Flying   580    90    100      90     125      85    90
## # … with 2 more variables: Generation <dbl>, Legendary <chr>
```

```r
subset(poke_wfg, Speed >= 90 | Attack >= 90)
```

```
## # A tibble: 23 x 13
##    Number Name  Type.1 Type.2 Total    HP Attack Defense Sp..Atk Sp..Def Speed
##     <dbl> <chr> <fct>  <fct>  <dbl> <dbl>  <dbl>   <dbl>   <dbl>   <dbl> <dbl>
##  1      6 Char… Fire   Flying   534    78     84      78     109      85   100
##  2     38 Nine… Fire   <NA>     505    73     76      75      81     100   100
##  3     47 Para… Bug    Grass    405    60     95      80      60      80    30
##  4     59 Arca… Fire   <NA>     555    90    110      80     100      80    95
##  5     60 Poli… Water  <NA>     300    40     50      40      40      40    90
##  6     61 Poli… Water  <NA>     385    65     65      65      50      50    90
##  7     62 Poli… Water  Fight…   510    90     95      95      70      90    70
##  8     70 Weep… Grass  Poison   390    65     90      50      85      45    55
##  9     71 Vict… Grass  Poison   490    80    105      65     100      70    70
## 10     73 Tent… Water  Poison   515    80     70      65      80     120   100
## # … with 13 more rows, and 2 more variables: Generation <dbl>, Legendary <chr>
```
# The If statement

The if statement is fundamental to programming. It uses conditional operators and boolean to *control flow*. This means to run a test to determine which operation of output is given, so it controls the flow of your code.They work as follows: If statement is true, do this, else do something else. 

If you doing a test on a variable, you can use the if statement like shown below. Run the code to test it out, and change the variables to see what happens. 

```r
pizza_price <- 5
bank_balance <- 10
if (bank_balance >= pizza_price){
print("Yes I can afford pizza!") } else {
print("No pizza for you") }
```

```
## [1] "Yes I can afford pizza!"
```

If you have a vector with multiple elements you can use the built in `ifelse()` function. The make up of this function is the test (x < y), what happens when true, and what happens when false (the else). This function will compare each element for you. 

```r
pizza_price <- c(5, 11, 9, 7)
bank_balance <- rep(10, 4)
ifelse(bank_balance >= pizza_price, "Yes I can afford pizza!", "No pizza for you")
```

```
## [1] "Yes I can afford pizza!" "No pizza for you"       
## [3] "Yes I can afford pizza!" "Yes I can afford pizza!"
```

We can nest if statements together. In this example we are setting a category of low, medium and high from our x column. 

```r
df3$cat <- ifelse(df3$x < 33, "low",
                  ifelse(df3$x > 33 & df3$x < 66, 'medium', 'high'))
df3
```

```
##           id  x  y   z     exp    cat
## 1  person_ a 59 14  48 control medium
## 2  person_ b 28 22  16    test    low
## 3  person_ c 17 78  87 control    low
## 4  person_ d 66 11  50 control   high
## 5  person_ e 48  6  57 control medium
## 6  person_ f 90 19  25 control   high
## 7  person_ g 98 63  41    test   high
## 8  person_ h 94 36  76 control   high
## 9  person_ i 57 97 100    test medium
## 10 person_ j 82 25  82    test   high
```
When nesting if statements like this, the *else* part becomes the next ifelse statement. 

## ifelse exercise

one if else statement for total stats (high stats, not as high)
nested if else statement to make speed categories
