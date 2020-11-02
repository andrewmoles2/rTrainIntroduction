---
title: "R Workshop 4 - Data Frames part 2"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "02 November, 2020"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What will this workshop cover?

In this workshop, the aim is to cover how to load and work with data frames, as well as an introduction to packages. We will be covering:

*  Introduction to packages
*  Loading in data
*  Row binding two data frames
*  Using knowledge from first session 4a

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

***

# Introduction to packages

Packages are collections of functions, code, and sample data put together by the R community. Packages are one of the main benefits of R. As R is open source there can be lots of contributors who have made functions to do complex tasks, such as data cleaning, or specific types of data analysis.

To install these packages onto your computer you have to download them from CRAN (The Comprehensive R Archive Network). 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop4a/images/CRAN.png?raw=true){width=30%}

There are two ways of doing this, using code (recommended and easiest) or using the menus (Tools > Install Packages). 

Using code involves using the install packages function, which looks like: `install.packages("package name")`. To install the package you would type something like:`install.packages("readr")`.

## Installing packages task

Try installing the following packages: `data.table`, `readr`, `readxl` using the `install.packages()` function. 


```r
# your code here
```

Once installed, you will not need to do this again unless you install a newer version of R. 

## Loading packages

Now you have installed the packages, you need to load them so you can use them. Each time you load R you will need to re-load the packages you want to use. 

To load a package you need to use the `library()` function. For example, if I wanted to load the `readr` package I would type `library(readr)`.

## Loading packages task

Using `library()` load in the packages you just installed: `data.table`, `readr`, `readxl`.


```r
# your code here
```

If you are not sure what packages are loaded, you can use `sessionInfo()`. Run the code below to test it out. Under *other attached packages* you should see readxl, readr, and data.table. 

```r
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Catalina 10.15.7
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRblas.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] compiler_4.0.2  magrittr_1.5    tools_4.0.2     htmltools_0.5.0
##  [5] yaml_2.2.1      stringi_1.4.6   rmarkdown_2.3   knitr_1.29     
##  [9] stringr_1.4.0   xfun_0.16       digest_0.6.25   rlang_0.4.7    
## [13] evaluate_0.14
```

# Loading in data

Loading data is how you will be getting data into R most of the time! R can handle many different file types thanks to packages built by the R community. These include .csv, .xlsx, .sav, .dta. 

When loading data it is important to make sure your data file is in the same directory as your rWorkshop4.Rmd file. Make sure you save both the .csv and .xlsx file in the same file as your .Rmd. 

If you are not sure if your data file is in the same directory as this notebook run the below command to list the files in your directory. This command should print out *pokemonGen1.csv*, *pokemonGen1.xlsx*, *pokemonGen2.csv*, *pokemongen2.xlsx*, *rWorkshop4.Rmd*, plus any other files you have saved in that file. 

```r
list.files()
```

```
## [1] "pokemonGen1.csv"  "pokemonGen1.xlsx" "pokemonGen2.csv"  "pokemonGen2.xlsx"
## [5] "rWorkshop4b.html" "rWorkshop4b.md"   "rWorkshop4b.Rmd"
```

We are going to load in a .csv file and a .xlsx file, two of the most common file types to be loaded into R. 

**hint: an RStudio shortcut to find files is to press tab when the cursor is in the speech marks ("")**


# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_9zagWkOtzNhmqt7?course=D025-R1NV&topic=R&cohort=MT20

# Individual take home challenge 



