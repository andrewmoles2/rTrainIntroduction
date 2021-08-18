---
title: "R Fundamentals 6 - Conditionals and Logic"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "17 August, 2021"
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

## Boolean exercise

1) Make data frame called pizza. For the first column use the topping vector provided. For the second column call it Good_topping, and use 1's and 0's to indicate a good or bad topping (1 = good, 0 = bad)
2) Convert your good topping column to logical using `as.logical`
3) Run `str()` and `head()` to view your data. Good_topping should now be logical (true and false). 


```r
Topping <- c('Mozzarella', 'Pepperoni','Pinapple', 'Pepper', 'Sweetcorn')

# your code here
```

# Conditional Operators

In order to test conditions we need conditional operators. Below is a table of conditional operators. During this session we will have examples and tasks using them in various contexts. 

| Operator   | Meaning                  |
|------------|--------------------------|
| `>`        | Greater than             |
| `>=`       | Greater than or equal to |
| `<`        | Less than                |
| `<=`       | Less than or equal to    |
| `==`       | Equal to                 |
| `!=`       | Not equal to             |
| `!X`       | NOT X                    |
| `X`        | Y                        |
| `X & Y`    | X AND Y                  |
| `X %in% Y` | is X in Y                |

The greater than (`>`), or greater than or equal to (`>=`) operators test if variable x is greater than y; less than (`<`), or less than or equal to (`<=`) test if x is less than, or equal to, y. The output is always boolean.


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

Why is `18 > 18` false? Any value below 18 would be true, but 18 is not greater than 18. To include 18 into the test we have to use the greater than or equal to operator. 

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

## Conditional operator exercise 

Using conditional operators work out the following:

1) Is 70 less than or equal to 11?
2) Using the following vector, `z <- sample(1:100, 20)`, count how many elements in *z* are less than (`<`) 50, and how many are greater then or equal to (>=) 50. 
3) Using the following vector, `pets <- c(rep('cat',5), rep('fish',11), rep('dog',6))`, count how many fish there are.
4) Using the same pets vector, how many pets are not fish?


```r
# your code here
```

# Indexing using conditional operators (subsetting)

Indexing using conditional operators is the same as we learned in previous sessions. Instead of calling the index of vector or data frame, we call a condition to test and find data. 

We might want to find specific data, in the example below we are subsetting data from the pets vector that is equal to cat. Run the code to test it out. 

```r
# pet data
pets <- c(rep('cat',5), rep('fish',13), rep('dog',6))
pets
```

```
##  [1] "cat"  "cat"  "cat"  "cat"  "cat"  "fish" "fish" "fish" "fish" "fish"
## [11] "fish" "fish" "fish" "fish" "fish" "fish" "fish" "fish" "dog"  "dog" 
## [21] "dog"  "dog"  "dog"  "dog"
```

```r
# pull out cats
cats <- pets[pets == 'cat']
# view subsetted data
cats
```

```
## [1] "cat" "cat" "cat" "cat" "cat"
```

In the above example we passed our logic `pets == 'cat' directly into our square brackets. We can also make a vector first with our boolean logic, then pass that to our square brackets for indexing. 

```r
# boolean vector
logic_var <- pets != 'fish'
logic_var
```

```
##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
```

```r
# index using boolean vector
not_fish <- pets[logic_var]
not_fish
```

```
##  [1] "cat" "cat" "cat" "cat" "cat" "dog" "dog" "dog" "dog" "dog" "dog"
```

When doing the same with data frames you will need to include a comma. The condition goes in the row index (left hand of comma); Remember `data[row index, col index]`. Run the code below to test it out on data frames. 

```r
# data frame with numbers randomly pulled from 1 to 100 for x & y
df <- data.frame(
  x = sample(1:100, 15),
  y = sample(1:100, 15)
)
# showing data where x is less than 20
df[df$x < 20, ]
```

```
##    x  y
## 2 12  6
## 5 11 62
## 9  4 46
```

```r
# subsetting data into df2 that are >= 35
df2 <- df[df$x >= 35, ]
df2
```

```
##     x  y
## 1  41 80
## 3  70 35
## 4  67 72
## 6  37 65
## 7  73 82
## 8  86 33
## 10 59 53
## 11 66 21
## 12 72 31
## 13 40 13
## 14 71 16
## 15 44 26
```

In base R there is a specialised function for subsetting data frames called `subset()`. It is pretty handy as it will save you time typing because you only need to give the name of the data frame once. 

```r
subset(df, y <= 40)
```

```
##     x  y
## 2  12  6
## 3  70 35
## 8  86 33
## 11 66 21
## 12 72 31
## 13 40 13
## 14 71 16
## 15 44 26
```

## Subsetting exercise

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
```

# Using AND OR and %in%

So far we have only been using one condition. By using the AND/OR operators we can thread together multiple conditional tests to make our code more efficient. 

Both statements behave slightly differently. When using AND you must satisfy both conditional tests, when using OR you can satisfy either of your conditional tests. Therefore, *AND is strict*, while *OR is lenient*. 

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

Using the df3 data frame provided run the following tests. Be sure to run the tests using square brackets or the `subset()` function so you see the data as the output. 

1) Subset data where y is greater than or equal to 70 and z is also greater than or equal to 70
2) Subset data where x, y, or z are all less than 15
3) Subset data where y is less than 60 and exp is equal to control

```r
# test data frame
df3 <- data.frame(
  id = paste0("person_",letters[1:10]),
  x = sample(1:100, 10),
  y = sample(1:100, 10),
  z = sample(1:100, 10),
  exp = sample(c(rep("control",50),rep("test",50)),10)
)

# your code here
```

# %in% operator

The %in% operator is for value matching. It is a really handy way of comparing vectors of different lengths to see if elements of one vector match at least one element in another. 

The length of output will be equal to the length of the vector being compared (the first one). This is different to equal to (==) which compares if two vectors or variables are *exactly equal*. 

Run the examples of %in% below using the df3 data we just used for the task. First, we compare if numbers 1 to 20 are present in column z. Second, we make a vector with some id's, then we compare those id's to the id column in df3. 

```r
# comparing if 1-20 are in col z
df3[df3$z %in% 1:20, ]
```

```
##         id  x  y  z     exp
## 2 person_b  9 53 11 control
## 3 person_c 12 54 13    test
## 4 person_d 70 14  2    test
## 9 person_i 76 25  5    test
```

```r
# make a table to compare against
val_match <- paste0("person_",letters[8:10])
val_match
```

```
## [1] "person_h" "person_i" "person_j"
```

```r
# compare your id column to your val_match vector
subset(df3, id %in% val_match)
```

```
##          id  x  y  z  exp
## 8  person_h 90 97 59 test
## 9  person_i 76 25  5 test
## 10 person_j 67 40 29 test
```

```r
# trying to do the same with ==
subset(df3, id == val_match)
```

```
## Warning in id == val_match: longer object length is not a multiple of shorter
## object length
```

```
## [1] id  x   y   z   exp
## <0 rows> (or 0-length row.names)
```

## AND OR %in% exercise

Will be using the Pokemon dataset again for this exercise. 

1) Make a vector called Types with the following data: Water, Fire, Grass
2) Using the %in% operator, match your Types vector to the Type.1 or Type.2 column to subset out that data. Call your data poke_wfg (or similar)
3) You should now have a dataset with pokemon that are either fire, water, or grass in the Type.1 or Type.2 columns. Run `summary()` to review your data.
4) It would be interesting to see how many of each pokemon type there are in your subsetted data. First we have to make Type.1 and Type.2 into factors. Using `factor()` make the Type.1 and Type.2 columns into factors.
5) Run `summary()` again on your dataset, you will see counts for your Type 1 & 2 columns. 
6) Now run `table()` function on the Type.1 and Type.2 columns, should should see the same result. *hint: table(data$col)*
7) Now, using subsetting, find out which of your fire, grass or water pokemon have a Speed and Attack stat greater than or equal to 90
8) Test out the same conditions but use OR instead. 

```r
# your code here
```
*note: the table() function makes counts of categorical data (factors)* 

# The If statement

The if statement is fundamental to programming. It uses conditional operators and boolean to *control flow*. This means running a test to determine which operation or output is given, controlling the flow of your code. They work as follows: If statement is true, do this, else do something else. 

If you doing a test on a variable, you can use the if statement like shown below. Run the code to test it out, and change the variables to see what happens. 

```r
# pizza variables
pizza_price <- 10
bank_balance <- 10

# if statement
if (bank_balance > pizza_price) {
  paste("Yes I can afford pizza")
} else if (bank_balance == pizza_price) {
  paste("Spend all my money on pizza!")
} else {
  paste("No pizza for you")
}
```

```
## [1] "Spend all my money on pizza!"
```

If you have a vector with multiple elements you can use the built in `ifelse()` function. 

The make up of this function is: `ifelse(condition, outcome if true, outcome if false)`. This function will compare each element for you. `ifelse()` and is generally easier to use than the if statement, and has the same functionally. 

```r
# pizza variables
pizza_price <- c(7, 11, 9, 10.5)
bank_balance <- 10

# ifelse function
ifelse(bank_balance >= pizza_price, "Yes I can afford pizza!", "No pizza for you")
```

```
## [1] "Yes I can afford pizza!" "No pizza for you"       
## [3] "Yes I can afford pizza!" "No pizza for you"
```

We can nest if statements together if we have several different conditions (or else ifs). 

In this example we are setting a category of low, medium and high from our x column in the df3 data frame. All values less then or equal to 33 are low, any value between 33 and 66 is medium and the rest are high. Run the code to test it out. 

```r
# nested if else
df3$cat <- ifelse(df3$x <= 33, "low",
                  ifelse(df3$x > 33 & df3$x <= 66, 'medium', 
                         'high'))
# view x and cat cols
df3[, c('x','cat')]
```

```
##     x    cat
## 1  71   high
## 2   9    low
## 3  12    low
## 4  70   high
## 5  51 medium
## 6  94   high
## 7  82   high
## 8  90   high
## 9  76   high
## 10 67   high
```
When nesting if statements like this, *else* becomes the next ifelse statement. 

## ifelse exercise

1) Using `ifelse()` on the Speed column in the pokemon data use the following condition: if speed is greater than or equal to 100 they are fast, otherwise they are slow. 
2) We need a bit more classification. This time make a new column called *SpeedTier*, using `ifelse()` on the following conditions: if Speed >= 110, very fast, if Speed < 110 & >= 90, fast, if Speed < 90 & >= 70, not so fast, else slow. *hint: use a nested ifelse()*
3) Make Type.1 a factor, and make SpeedTier a factor with a level order of: very fast, fast,not so fast, and slow.
4) Using `table()` compare SpeedTier with Type.1. You will be able to see counts of which speed tier different types of pokemon are in. *hint: table(data$col1, data$col2)*


```r
# your code here
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_77M35cq1arxNcj3?course=D065:R4aDF2&topic=R&cohort=LT21

# Individual take home challenge 

In this coding challenge we are going to keep looking at the pokemon data. In the Pokemon tv show, the main character (Ash) had a team of Pokemon, we want to see how good they would be in the games, and how they compare to other pokemon. 

1) First, make a vector with Ash's pokemon: Pikachu, Butterfree, Pidgeot, Bulbasaur, Charizard, Squirtle
2) Next we need to make a dataset called ash, and subset out all his pokemon using %in% as shown above
3) Now using `mean()` compare the mean Total for Ash's pokemon and the rest in the pokemon data *hint: putting both mean functions in a c function will allow you to see them side by side*
4) Looks like Ash's pokemon on average are worse, but by how much? Work out the difference between the total of Ash's pokemon and the other pokemon.
5) Which of Ash's pokemon have higher total stats than the average pokemon? Use `table()` to do this comparison. *hint: table(data$name, data$total >= mean(data2$total))*
6) Having stats over or equal to 100 seems important. Using subsetting and OR statements, find out how many of Ash's pokemon have stats in HP,Attack,Defense,Sp..Atk,Sp..Def, and Speed over or equal to 100.   


```r
# your code here
```

