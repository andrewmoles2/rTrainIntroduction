---
title: "R Fundamentals 5 - Loading data and packages"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "21 September, 2021"
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

# What will this workshop cover?

In this workshop, the aim is to cover how to load and work with data frames, as well as an introduction to packages. We will be covering:

-   Introduction to packages
-   Introduction to directories and projects
-   Loading in data
-   Exporting data

# Information on how the session is run

One hour exercise based session with tutor support. You will be given example code for a problem, then given a related exercise to complete.

## Why this style?

-   Online training is tiring so keeping the sessions to one hour
-   No or limited demonstrations provided in order to provide more real world experience - you have a problem and you look up how to solve it, adapting example code
-   Trainer support to guide through process of learning

## We will be working in pairs:

-   Option to work together on worksheet or to work individually
-   If possible have your camera on and introduce yourself to each other

## What to do when getting stuck:

1)  Ask your team members
2)  Search online:

-   The answer box on the top of Google's results page
-   stackoverflow.com (for task-specific solutions)
-   <https://www.r-bloggers.com/> (topic based tutorials)

3)  Don't struggle too long looking online, ask the trainer if you can't find a solution!

------------------------------------------------------------------------

# Introduction to packages

Packages are collections of functions, code, and sample data put together by the R community. Packages are one of the main benefits of R. As R is open source there can be lots of contributors who have made functions to do complex tasks, such as data cleaning, specific types of data analysis, or exciting data visualisation.

To install these packages onto your computer you have to download them from CRAN (The Comprehensive R Archive Network).

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop4a/images/CRAN.png?raw=true){width="30%"}

There are two ways of doing this, using code (recommended and easiest) or using the menus (`Tools > Install Packages`).

Using code involves using the install packages function, which looks like: `install.packages("package name")`. To install the package you would type something like:`install.packages("readr")`.

Once installed, you will not need to do this again unless you install a newer version of R.

## Installing packages exercise

Try installing the following packages:`readr`, `readxl`, and `writexl` using the `install.packages()` function. We will be using these in today's session.


```r
# your code here
install.packages('readr')
install.packages('readxl')
install.packages('writexl')
```

# Loading packages

Now you have installed the packages, you need to load them in order to use them. **Each time you load R you will need to re-load the packages you want to use**.

To load a package you need to use the `library()` function. For example, if I wanted to load the `readr` package I would type `library(readr)`.

## Loading packages exercise

Using `library()` load in the packages you just installed: `readr`, `readxl`, and `writexl`.


```r
# your code here
library(readr)
library(readxl)
library(writexl)
```

If you are not sure what packages are loaded, you can use `sessionInfo()`. Run the code below to test it out. Under *other attached packages* you should see readr, readxl, and writexl.


```r
sessionInfo()
```

```
## R version 4.1.0 (2021-05-18)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Catalina 10.15.7
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] writexl_1.4.0 readxl_1.3.1  readr_1.4.0  
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.7        knitr_1.33        magrittr_2.0.1    hms_1.1.0        
##  [5] R6_2.5.1          rlang_0.4.11      fansi_0.5.0       stringr_1.4.0    
##  [9] tools_4.1.0       xfun_0.25         utf8_1.2.2        jquerylib_0.1.4  
## [13] htmltools_0.5.1.1 ellipsis_0.3.2    yaml_2.2.1        digest_0.6.27    
## [17] tibble_3.1.4      lifecycle_1.0.0   crayon_1.4.1      sass_0.4.0       
## [21] vctrs_0.3.8       evaluate_0.14     rmarkdown_2.10    stringi_1.7.3    
## [25] cellranger_1.1.0  compiler_4.1.0    bslib_0.2.5.1     pillar_1.6.2     
## [29] jsonlite_1.7.2    pkgconfig_2.0.3
```

# Introduction to directories

A directory is a file path on your computer. In R we use working directories and file paths to tell R where to find files to load or save out of R. Directories work in a top down hierarchical manner.

To find out where your working directory is in R you can use `getwd()`. This gives prints out a file path.

Run the code below, the output should be the file your r_fundamentals_5.Rmd is saved in.


```r
getwd()
```

```
## [1] "/Users/MOLES/OneDrive - London School of Economics/Code/rTrainIntroduction/r-fundamentals-5"
```

# Introduction to RStudio Projects

A project is a centralised place to keep all your files for a study, piece of work, or 'project'. When you start a new Project it sets up a working directory in a fresh R session. Because the project sets up the working directory and keeps all your project related files in one place, it makes managing your files and analysis much easier, and helps you to share your code with collaborators or supervisors.

*note: you can also change your working directory using the setwd() function, but in the long run it can be difficult to manage. E.g. if a file moves or gets deleted*

# How to set up a project?

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop4b/images/RStudio_projects.png?raw=true)

1)  File `>` New Project...
2)  Select new directory (or existing directory if you have already set up a file)

**Setting up a project in a new directory:**

1)  Select new project
2)  Give your directory a name, e.g. "r-workshop"
3)  Select browse and find the directory you want to start your project
4)  Press Create Project
5)  Your new project should open

**Setting up a project in a existing directory:**

1)  Select browse and find the directory you want to start your project
2)  Press Create Project
3)  Your new project should open

To open and review your projects in future you will see them in a drop down menu in the top right corner of RStudio.

## Project exercise

*note: making a new project opens a new RStudio window, you can go back to your original window by selecting close project from the project drop down list in the top right corner.*

1)  Set up a project for this workshop using the steps above.
2)  Go to your newly created project folder in either File Explorer (Windows) or Finder (Mac).
3)  Put your rWorkshop4b.Rmd file in your project directory (if you have not do so already).
4)  Add a new file called data, and add in the data files for the session ().
5)  Come back to RStudio and make sure you're project is open (*will see in top right corner your project name*), in the RStudio file explorer (bottom right) you should see the changes you've made.
6)  If you have not already, open the rWorkshop4b.Rmd file.
7)  In the code chunk below run `getwd()`. You should get your new project file system as the output.


```r
# your code here
```

# Loading in data from your computer

Data can be loaded into R either from files from your computer, or the internet using URLs. R can handle many different file types thanks to packages built by the R community. These include .csv, .xlsx, .sav, .dta.

To check your folders or data files are where you expect them to be, you can use the `list.files()` function. You should see your r_fundamentals_5.Rmd and your data file.


```r
list.files()
```

```
## [1] "data"                            "images"                         
## [3] "r_fundamentals_5_solutions.html" "r_fundamentals_5_solutions.md"  
## [5] "r_fundamentals_5_solutions.Rmd"  "r_fundamentals_5.html"          
## [7] "r_fundamentals_5.md"             "r_fundamentals_5.Rmd"
```

RStudio helpfully has auto-completion for directories to help you build file paths.

To get this working use speech marks with a function, like `list.files()`. Press tab (key on far left of keyboard above caps lock with arrow) when the cursor is within the speech marks (""). You should get a drop down list of your files, press tab again to select the file you want. Repeat the process till you get to where you want to be.

## List files exercise

1)  Using speech marks and tab, as outlined above, list the files in your data file. You should get something like: `list.files("data/")`
2)  Run the code, the output should be the data files you put in the data file in step 4 of the project task.


```r
# your code here
list.files("data/")
```

```
## [1] "pokemonGen1.csv"            "pokemonGen1.xlsx"          
## [3] "pokemonGen2.csv"            "pokemonGen2.xlsx"          
## [5] "tfl-daily-cycle-hires.xlsx" "tfl-journeys-type.csv"     
## [7] "tflCycleHire_byMonth.xlsx"  "tflSubset.csv"             
## [9] "tflSubset.xlsx"
```

# Loading csv and Excel (.xlsx) files

Now you know how to access files, we can load them into R!

We are going to load in a .csv file and a .xlsx file, two of the most common file types to be loaded into R. To load data into R we use a read function.

First we will load a csv file. To load a csv we can use either `read.csv()` that comes with R by default, or we can use `read_csv()` that comes with the readr package. `read_csv()` is preferable as it loads in large datasets faster than `read.csv()`.

Just like making vectors or data frames in the previous workshops, you need to assign a name to your data that is being loaded. For example, if I was loading a dataset called *dataset.csv* stored in the data folder I would use: `data <- read_csv("data/dataset.csv")`.

## Loading csv files exercise

1)  Load in the *tfl-journeys-type.csv* using the `read_csv()` function from readr. Make sure to give the data a meaningful name, such as tflJourneyType.
2)  Get some information on your loaded data frame using functions such as `str()`, `head()`, or `summary()`.
3)  From the information, when does the dataset start and end recording data? *hint: head and tail functions will help*


```r
# make sure readr is loaded
library(readr)
# your code here
# load data
tflJourneyType <- read_csv("data/tfl-journeys-type.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   `Period and Financial year` = col_character(),
##   `Reporting Period` = col_double(),
##   `Days in period` = col_double(),
##   `Period beginning` = col_character(),
##   `Period ending` = col_character(),
##   `Bus journeys (m)` = col_double(),
##   `Underground journeys (m)` = col_double(),
##   `DLR Journeys (m)` = col_double(),
##   `Tram Journeys (m)` = col_double(),
##   `Overground Journeys (m)` = col_double(),
##   `Emirates Airline Journeys (m)` = col_double(),
##   `TfL Rail Journeys (m)` = col_double()
## )
```

```r
# get info
str(tflJourneyType)
```

```
## spec_tbl_df [137 × 12] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ Period and Financial year    : chr [1:137] "01_10/11" "02_10/11" "03_10/11" "04_10/11" ...
##  $ Reporting Period             : num [1:137] 1 2 3 4 5 6 7 8 9 10 ...
##  $ Days in period               : num [1:137] 31 28 28 28 28 28 28 28 28 28 ...
##  $ Period beginning             : chr [1:137] "01-Apr-10" "02-May-10" "30-May-10" "27-Jun-10" ...
##  $ Period ending                : chr [1:137] "01-May-10" "29-May-10" "26-Jun-10" "24-Jul-10" ...
##  $ Bus journeys (m)             : num [1:137] 189 182 176 183 160 ...
##  $ Underground journeys (m)     : num [1:137] 90.5 84.5 84.3 86.5 82.9 80.9 88.7 90.3 90.6 72.5 ...
##  $ DLR Journeys (m)             : num [1:137] 6.3 5.8 5.8 6.1 5.8 5.5 6.3 6.7 6.4 4.8 ...
##  $ Tram Journeys (m)            : num [1:137] 2.3 2.2 2.1 2.1 2 2 2.3 2.2 2.3 1.8 ...
##  $ Overground Journeys (m)      : num [1:137] NA NA NA NA NA NA NA 5.6 5.4 3.5 ...
##  $ Emirates Airline Journeys (m): num [1:137] NA NA NA NA NA NA NA NA NA NA ...
##  $ TfL Rail Journeys (m)        : num [1:137] NA NA NA NA NA NA NA NA NA NA ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   `Period and Financial year` = col_character(),
##   ..   `Reporting Period` = col_double(),
##   ..   `Days in period` = col_double(),
##   ..   `Period beginning` = col_character(),
##   ..   `Period ending` = col_character(),
##   ..   `Bus journeys (m)` = col_double(),
##   ..   `Underground journeys (m)` = col_double(),
##   ..   `DLR Journeys (m)` = col_double(),
##   ..   `Tram Journeys (m)` = col_double(),
##   ..   `Overground Journeys (m)` = col_double(),
##   ..   `Emirates Airline Journeys (m)` = col_double(),
##   ..   `TfL Rail Journeys (m)` = col_double()
##   .. )
```

```r
head(tflJourneyType)
```

```
## # A tibble: 6 × 12
##   `Period and Financial year` `Reporting Peri… `Days in period` `Period beginni…
##   <chr>                                  <dbl>            <dbl> <chr>           
## 1 01_10/11                                   1               31 01-Apr-10       
## 2 02_10/11                                   2               28 02-May-10       
## 3 03_10/11                                   3               28 30-May-10       
## 4 04_10/11                                   4               28 27-Jun-10       
## 5 05_10/11                                   5               28 25-Jul-10       
## 6 06_10/11                                   6               28 22-Aug-10       
## # … with 8 more variables: Period ending <chr>, Bus journeys (m) <dbl>,
## #   Underground journeys (m) <dbl>, DLR Journeys (m) <dbl>,
## #   Tram Journeys (m) <dbl>, Overground Journeys (m) <dbl>,
## #   Emirates Airline Journeys (m) <dbl>, TfL Rail Journeys (m) <dbl>
```

```r
tail(tflJourneyType)
```

```
## # A tibble: 6 × 12
##   `Period and Financial year` `Reporting Peri… `Days in period` `Period beginni…
##   <chr>                                  <dbl>            <dbl> <chr>           
## 1 02_19/20                                   2               28 28-Apr-20       
## 2 03_19/20                                   3               28 26-May-20       
## 3 04_19/20                                   4               28 23-Jun-20       
## 4 05_19/20                                   5               28 21-Jul-20       
## 5 06_19/20                                   6               28 18-Aug-20       
## 6 07_19/20                                   7               28 15-Sep-20       
## # … with 8 more variables: Period ending <chr>, Bus journeys (m) <dbl>,
## #   Underground journeys (m) <dbl>, DLR Journeys (m) <dbl>,
## #   Tram Journeys (m) <dbl>, Overground Journeys (m) <dbl>,
## #   Emirates Airline Journeys (m) <dbl>, TfL Rail Journeys (m) <dbl>
```

```r
summary(tflJourneyType)
```

```
##  Period and Financial year Reporting Period Days in period  Period beginning  
##  Length:137                Min.   : 1.000   Min.   :26.00   Length:137        
##  Class :character          1st Qu.: 4.000   1st Qu.:28.00   Class :character  
##  Mode  :character          Median : 7.000   Median :28.00   Mode  :character  
##                            Mean   : 6.847   Mean   :28.08                     
##                            3rd Qu.:10.000   3rd Qu.:28.00                     
##                            Max.   :13.000   Max.   :31.00                     
##                                                                               
##  Period ending      Bus journeys (m) Underground journeys (m) DLR Journeys (m)
##  Length:137         Min.   : 30.2    Min.   :  5.70           Min.   : 1.200  
##  Class :character   1st Qu.:166.3    1st Qu.: 90.50           1st Qu.: 7.000  
##  Mode  :character   Median :177.0    Median : 98.80           Median : 8.300  
##                     Mean   :170.4    Mean   : 95.15           Mean   : 7.982  
##                     3rd Qu.:185.2    3rd Qu.:106.10           3rd Qu.: 9.300  
##                     Max.   :207.5    Max.   :118.20           Max.   :10.600  
##                                                                               
##  Tram Journeys (m) Overground Journeys (m) Emirates Airline Journeys (m)
##  Min.   :0.400     Min.   : 1.000          Min.   :0.0000               
##  1st Qu.:2.100     1st Qu.: 9.225          1st Qu.:0.0800               
##  Median :2.200     Median :11.350          Median :0.1100               
##  Mean   :2.155     Mean   :11.543          Mean   :0.1124               
##  3rd Qu.:2.400     3rd Qu.:14.500          3rd Qu.:0.1300               
##  Max.   :2.800     Max.   :17.800          Max.   :0.5300               
##                    NA's   :7               NA's   :29                   
##  TfL Rail Journeys (m)
##  Min.   :0.600        
##  1st Qu.:3.400        
##  Median :3.700        
##  Mean   :3.692        
##  3rd Qu.:4.300        
##  Max.   :5.700        
##  NA's   :66
```

**Great work, you've loaded your first dataset!**

## Loading Excel (.xlsx) files exercise

Now lets have a go at reading data from an Excel file (.xlsx) using the tfl-daily-cycle-hires.xlsx file.

Excel files can come with multiple worksheets, such as the example we will use. To handle this the read_xlsx function has a sheet option. By default it will load sheet 1. For example, if I wanted to load in the third worksheet of an .xlsx file I would use: `data <- read_xlsx("data/datafile.xlsx", sheet = 3)`

1)  Using the `read_xlsx()` function, load worksheet 2 of the tfl-daily-cycle-hires.xlsx file, call your loaded data tflCycle.
2)  Get information on your data like you did for the csv task.
3)  Find out the mean, max, and min for the "Number of Bicycle Hires...2" column.

*note: we will tidy this dataframe up in the individual coding challenge*


```r
# make sure readxl is loaded
library(readxl)
# your code here
# load in data
tflCycle <- read_xlsx("data/tfl-daily-cycle-hires.xlsx", sheet = 2)
```

```
## New names:
## * `Number of Bicycle Hires` -> `Number of Bicycle Hires...2`
## * `` -> ...3
## * Month -> Month...4
## * `Number of Bicycle Hires` -> `Number of Bicycle Hires...5`
## * `` -> ...6
## * ...
```

```r
# get info
str(tflCycle)
```

```
## tibble [3,747 × 11] (S3: tbl_df/tbl/data.frame)
##  $ Day                        : POSIXct[1:3747], format: "2010-07-30" "2010-07-31" ...
##  $ Number of Bicycle Hires...2: num [1:3747] 6897 5564 4303 6642 7966 ...
##  $ ...3                       : logi [1:3747] NA NA NA NA NA NA ...
##  $ Month...4                  : POSIXct[1:3747], format: "2010-07-01" "2010-08-01" ...
##  $ Number of Bicycle Hires...5: num [1:3747] 12461 341203 540859 544412 456304 ...
##  $ ...6                       : logi [1:3747] NA NA NA NA NA NA ...
##  $ Year                       : chr [1:3747] "2010" "2011" "2012" "2013" ...
##  $ Number of Bicycle Hires...8: chr [1:3747] "2180813" "7142449" "9519283" "8045459" ...
##  $ ...9                       : logi [1:3747] NA NA NA NA NA NA ...
##  $ Month...10                 : POSIXct[1:3747], format: "2010-07-01" "2010-08-01" ...
##  $ Average Hire Time (mins)   : num [1:3747] 17.2 16.6 15.2 15.2 13.8 ...
```

```r
head(tflCycle)
```

```
## # A tibble: 6 × 11
##   Day                 `Number of Bicycle Hires...2` ...3  Month...4          
##   <dttm>                                      <dbl> <lgl> <dttm>             
## 1 2010-07-30 00:00:00                          6897 NA    2010-07-01 00:00:00
## 2 2010-07-31 00:00:00                          5564 NA    2010-08-01 00:00:00
## 3 2010-08-01 00:00:00                          4303 NA    2010-09-01 00:00:00
## 4 2010-08-02 00:00:00                          6642 NA    2010-10-01 00:00:00
## 5 2010-08-03 00:00:00                          7966 NA    2010-11-01 00:00:00
## 6 2010-08-04 00:00:00                          7893 NA    2010-12-01 00:00:00
## # … with 7 more variables: Number of Bicycle Hires...5 <dbl>, ...6 <lgl>,
## #   Year <chr>, Number of Bicycle Hires...8 <chr>, ...9 <lgl>,
## #   Month...10 <dttm>, Average Hire Time (mins) <dbl>
```

```r
summary(tflCycle)
```

```
##       Day                      Number of Bicycle Hires...2   ...3        
##  Min.   :2010-07-30 00:00:00   Min.   : 2764               Mode:logical  
##  1st Qu.:2013-02-20 12:00:00   1st Qu.:19217               NA's:3747     
##  Median :2015-09-15 00:00:00   Median :25909                             
##  Mean   :2015-09-15 00:00:00   Mean   :26049                             
##  3rd Qu.:2018-04-08 12:00:00   3rd Qu.:32944                             
##  Max.   :2020-10-31 00:00:00   Max.   :73094                             
##                                                                          
##    Month...4                   Number of Bicycle Hires...5   ...6        
##  Min.   :2010-07-01 00:00:00   Min.   :  12461             Mode:logical  
##  1st Qu.:2013-01-24 06:00:00   1st Qu.: 597528             NA's:3747     
##  Median :2015-08-16 12:00:00   Median : 753899                           
##  Mean   :2015-08-16 16:27:05   Mean   : 787153                           
##  3rd Qu.:2018-03-08 18:00:00   3rd Qu.: 995338                           
##  Max.   :2020-10-01 00:00:00   Max.   :1253102                           
##  NA's   :3623                  NA's   :3623                              
##      Year           Number of Bicycle Hires...8   ...9        
##  Length:3747        Length:3747                 Mode:logical  
##  Class :character   Class :character            NA's:3747     
##  Mode  :character   Mode  :character                          
##                                                               
##                                                               
##                                                               
##                                                               
##    Month...10                  Average Hire Time (mins)
##  Min.   :2010-07-01 00:00:00   Min.   :13.78           
##  1st Qu.:2013-01-24 06:00:00   1st Qu.:16.82           
##  Median :2015-08-16 12:00:00   Median :18.70           
##  Mean   :2015-08-16 16:27:05   Mean   :19.27           
##  3rd Qu.:2018-03-08 18:00:00   3rd Qu.:21.02           
##  Max.   :2020-10-01 00:00:00   Max.   :36.00           
##  NA's   :3623                  NA's   :3623
```

```r
# mean, max, min
mean(tflCycle$`Number of Bicycle Hires...2`)
```

```
## [1] 26049.36
```

```r
min(tflCycle$`Number of Bicycle Hires...2`)
```

```
## [1] 2764
```

```r
max(tflCycle$`Number of Bicycle Hires...2`)
```

```
## [1] 73094
```

# Loading in data from the internet

Loading data from the internet can be useful for datasets that regularly update, such as the tfl dataset we loaded earlier. By using the URL for the dataset, we don't need to regularly download and store the data on our computer.

We load the data in a very similar way to how we load in files from our computer, but instead of giving the file path, we give the URL to where the raw data is stored online. For example, we would write something like: `data <- read_csv("link to data")`.

## Loading data from the internet exercise

1)  Go to the following website: <https://data.london.gov.uk/dataset/public-transport-journeys-type-transport>
2)  Find the csv file (yellow colour with around 8 or 9 kB). Use the download drop down menu and copy the *'copy link to file'* link provided.
3)  Using `read_csv()`, load in the data using the link you just copied. Call it `tflJourneyType` again.
4)  Run commands such as `str()` and `summary()` to make sure the data has loaded correctly.


```r
# your code here
# loading data
tflJourneyType <- read_csv("https://data.london.gov.uk/download/public-transport-journeys-type-transport/06a805f6-77c6-481a-8b08-ddef56afffdd/tfl-journeys-type.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   `Period and Financial year` = col_character(),
##   `Reporting Period` = col_double(),
##   `Days in period` = col_double(),
##   `Period beginning` = col_character(),
##   `Period ending` = col_character(),
##   `Bus journeys (m)` = col_double(),
##   `Underground journeys (m)` = col_double(),
##   `DLR Journeys (m)` = col_double(),
##   `Tram Journeys (m)` = col_double(),
##   `Overground Journeys (m)` = col_double(),
##   `Emirates Airline Journeys (m)` = col_double(),
##   `TfL Rail Journeys (m)` = col_double()
## )
```

```r
# get info
str(tflJourneyType)
```

```
## spec_tbl_df [147 × 12] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ Period and Financial year    : chr [1:147] "01_10/11" "02_10/11" "03_10/11" "04_10/11" ...
##  $ Reporting Period             : num [1:147] 1 2 3 4 5 6 7 8 9 10 ...
##  $ Days in period               : num [1:147] 31 28 28 28 28 28 28 28 28 28 ...
##  $ Period beginning             : chr [1:147] "01-Apr-10" "02-May-10" "30-May-10" "27-Jun-10" ...
##  $ Period ending                : chr [1:147] "01-May-10" "29-May-10" "26-Jun-10" "24-Jul-10" ...
##  $ Bus journeys (m)             : num [1:147] 189 182 176 183 160 ...
##  $ Underground journeys (m)     : num [1:147] 90.5 84.5 84.3 86.5 82.9 80.9 88.7 90.3 90.6 72.5 ...
##  $ DLR Journeys (m)             : num [1:147] 6.3 5.8 5.8 6.1 5.8 5.5 6.3 6.7 6.4 4.8 ...
##  $ Tram Journeys (m)            : num [1:147] 2.3 2.2 2.1 2.1 2 2 2.3 2.2 2.3 1.8 ...
##  $ Overground Journeys (m)      : num [1:147] NA NA NA NA NA NA NA 5.6 5.4 3.5 ...
##  $ Emirates Airline Journeys (m): num [1:147] NA NA NA NA NA NA NA NA NA NA ...
##  $ TfL Rail Journeys (m)        : num [1:147] NA NA NA NA NA NA NA NA NA NA ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   `Period and Financial year` = col_character(),
##   ..   `Reporting Period` = col_double(),
##   ..   `Days in period` = col_double(),
##   ..   `Period beginning` = col_character(),
##   ..   `Period ending` = col_character(),
##   ..   `Bus journeys (m)` = col_double(),
##   ..   `Underground journeys (m)` = col_double(),
##   ..   `DLR Journeys (m)` = col_double(),
##   ..   `Tram Journeys (m)` = col_double(),
##   ..   `Overground Journeys (m)` = col_double(),
##   ..   `Emirates Airline Journeys (m)` = col_double(),
##   ..   `TfL Rail Journeys (m)` = col_double()
##   .. )
```

```r
summary(tflJourneyType)
```

```
##  Period and Financial year Reporting Period Days in period Period beginning  
##  Length:147                Min.   : 1.000   Min.   :26.0   Length:147        
##  Class :character          1st Qu.: 4.000   1st Qu.:28.0   Class :character  
##  Mode  :character          Median : 7.000   Median :28.0   Mode  :character  
##                            Mean   : 6.878   Mean   :28.1                     
##                            3rd Qu.:10.000   3rd Qu.:28.0                     
##                            Max.   :13.000   Max.   :31.0                     
##                                                                              
##  Period ending      Bus journeys (m) Underground journeys (m) DLR Journeys (m)
##  Length:147         Min.   : 30.2    Min.   :  5.70           Min.   : 1.200  
##  Class :character   1st Qu.:161.6    1st Qu.: 88.70           1st Qu.: 6.450  
##  Mode  :character   Median :176.5    Median : 97.30           Median : 8.200  
##                     Mean   :164.5    Mean   : 90.86           Mean   : 7.717  
##                     3rd Qu.:183.8    3rd Qu.:105.95           3rd Qu.: 9.300  
##                     Max.   :207.5    Max.   :118.20           Max.   :10.600  
##                                                                               
##  Tram Journeys (m) Overground Journeys (m) Emirates Airline Journeys (m)
##  Min.   :0.400     Min.   : 1.00           Min.   :0.0000               
##  1st Qu.:2.000     1st Qu.: 8.70           1st Qu.:0.1000               
##  Median :2.200     Median :11.15           Median :0.1000               
##  Mean   :2.084     Mean   :11.18           Mean   :0.1093               
##  3rd Qu.:2.350     3rd Qu.:14.43           3rd Qu.:0.1000               
##  Max.   :2.800     Max.   :17.80           Max.   :0.5000               
##                    NA's   :7               NA's   :29                   
##  TfL Rail Journeys (m)
##  Min.   :0.600        
##  1st Qu.:3.000        
##  Median :3.700        
##  Mean   :3.475        
##  3rd Qu.:4.200        
##  Max.   :5.700        
##  NA's   :66
```

# Exporting data

You've learned how to load in data from computer files and the internet, now lets save some data. We will have a go at writing to both csv and xlsx (using `writexl`). The concept is very much the same as reading in data. We provide the write function with our data, then give it a file path and file name.

For example, if I wanted to save a csv file to my data folder: `write_csv(data, "data/data.csv")`.

## Exporting data exercise

Using the tflJourneyType dataset follow the steps:

1)  First lets do some calculations. Make a new column called BusTube that is the sum of bus journeys and tube journeys, for example `data$newcol <- data$col1 + data$col2`.
2)  Make another new column called DLR_Tram that is the sum of DLR journeys and Tram journeys.
3)  Make a new dataset called tflSubset that contains the first column, and both your new columns (BusTube & DLR_Tram) *hint: use indexing [ , ]*
4)  Using `write_csv()` write your tflSubset data to your data file. Call it tflSubset.csv.
5)  Using `write_xlsx()` write your tflSubset data to your data file. Call it tflSubset.xlsx.
6)  Have a look at the csv and xlsx files you have created in finder or windows explorer.


```r
# make sure writexl is loaded
library(writexl)
# your code here
# adding calculation cols
tflJourneyType$BusTube <- tflJourneyType$`Bus journeys (m)` + tflJourneyType$`Underground journeys (m)`
tflJourneyType$DLR_Tram <- tflJourneyType$`DLR Journeys (m)`+ tflJourneyType$`Tram Journeys (m)`
# subset to new dataset
str(tflJourneyType)
```

```
## spec_tbl_df [147 × 14] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ Period and Financial year    : chr [1:147] "01_10/11" "02_10/11" "03_10/11" "04_10/11" ...
##  $ Reporting Period             : num [1:147] 1 2 3 4 5 6 7 8 9 10 ...
##  $ Days in period               : num [1:147] 31 28 28 28 28 28 28 28 28 28 ...
##  $ Period beginning             : chr [1:147] "01-Apr-10" "02-May-10" "30-May-10" "27-Jun-10" ...
##  $ Period ending                : chr [1:147] "01-May-10" "29-May-10" "26-Jun-10" "24-Jul-10" ...
##  $ Bus journeys (m)             : num [1:147] 189 182 176 183 160 ...
##  $ Underground journeys (m)     : num [1:147] 90.5 84.5 84.3 86.5 82.9 80.9 88.7 90.3 90.6 72.5 ...
##  $ DLR Journeys (m)             : num [1:147] 6.3 5.8 5.8 6.1 5.8 5.5 6.3 6.7 6.4 4.8 ...
##  $ Tram Journeys (m)            : num [1:147] 2.3 2.2 2.1 2.1 2 2 2.3 2.2 2.3 1.8 ...
##  $ Overground Journeys (m)      : num [1:147] NA NA NA NA NA NA NA 5.6 5.4 3.5 ...
##  $ Emirates Airline Journeys (m): num [1:147] NA NA NA NA NA NA NA NA NA NA ...
##  $ TfL Rail Journeys (m)        : num [1:147] NA NA NA NA NA NA NA NA NA NA ...
##  $ BusTube                      : num [1:147] 280 266 260 270 243 ...
##  $ DLR_Tram                     : num [1:147] 8.6 8 7.9 8.2 7.8 7.5 8.6 8.9 8.7 6.6 ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   `Period and Financial year` = col_character(),
##   ..   `Reporting Period` = col_double(),
##   ..   `Days in period` = col_double(),
##   ..   `Period beginning` = col_character(),
##   ..   `Period ending` = col_character(),
##   ..   `Bus journeys (m)` = col_double(),
##   ..   `Underground journeys (m)` = col_double(),
##   ..   `DLR Journeys (m)` = col_double(),
##   ..   `Tram Journeys (m)` = col_double(),
##   ..   `Overground Journeys (m)` = col_double(),
##   ..   `Emirates Airline Journeys (m)` = col_double(),
##   ..   `TfL Rail Journeys (m)` = col_double()
##   .. )
```

```r
tflSubset <- tflJourneyType[,c('Period and Financial year','BusTube','DLR_Tram')]
# write to csv
write_csv(tflSubset, "data/tflSubset.csv")
# write to xlsx
write_xlsx(tflSubset, "data/tflSubset.xlsx")
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_77M35cq1arxNcj3?course=D065:R4aDF2&topic=R&cohort=LT21>

# Individual take home challenge

In this coding challenge you will need to re-organise the code to get it to run. The tfl cycles dataset is a bit messy, the first two columns are the raw data, the rest is aggregated data. We are going to separate it out into separate data frames to make it easier to read. Then write out the most interesting data.

You should end up with an output of *"The highest highest average cycle hire time per month was 36 minutes, on the 2020-04-01 with total hires of 591058 which is just after lockdown started!"*, and the by month xlsx file in your data file.

*note: you might need to change the file paths to match your system*


```r
# Take out raw data (hire by day)
tflCycleByDay <- tflCycle[,1:2]

# most popular day, months and year
maxDay <- tflCycleByDay[which.max(tflCycleByDay$`Number of Bicycle Hires...2`),]
maxMonth <- tflCycleByMonth[which.max(tflCycleByMonth$`Number of Bicycle Hires...5`),]
```

```
## Error in eval(expr, envir, enclos): object 'tflCycleByMonth' not found
```

```r
maxHire <- tflCycleByMonth[which.max(tflCycleByMonth$`Average Hire Time (mins)`),]
```

```
## Error in eval(expr, envir, enclos): object 'tflCycleByMonth' not found
```

```r
maxYear <- tflCycleByYear[which.max(tflCycleByYear$`Number of Bicycle Hires...8`),]
```

```
## Error in eval(expr, envir, enclos): object 'tflCycleByYear' not found
```

```r
# load in tfl cycle data (might need to change file path)
tflCycle <- read_xlsx("data/tfl-daily-cycle-hires.xlsx", sheet = 2) 
```

```
## New names:
## * `Number of Bicycle Hires` -> `Number of Bicycle Hires...2`
## * `` -> ...3
## * Month -> Month...4
## * `Number of Bicycle Hires` -> `Number of Bicycle Hires...5`
## * `` -> ...6
## * ...
```

```r
# hire by month and ave hire time
tflCycleByMonth <- tflCycle[,c("Month...4","Number of Bicycle Hires...5","Average Hire Time (mins)")]

# making month a character for paste
maxHire$Month...4 <- as.character(maxHire$Month...4)
```

```
## Error in eval(expr, envir, enclos): object 'maxHire' not found
```

```r
# pasting an output
paste("The highest highest average cycle hire time per month was", maxHire[1,3], 
      "minutes, on the", maxHire[1,1],"with total hires of", maxHire[1,2],
      "which is just after lockdown started!")
```

```
## Error in paste("The highest highest average cycle hire time per month was", : object 'maxHire' not found
```

```r
# hire by year
tflCycleByYear <- tflCycle[1:10,c("Year", "Number of Bicycle Hires...8")]

# write the tfl cycle by month data (most interesting)
write_xlsx(tflCycleByMonth, "data/tflCycleHire_byMonth.xlsx")

# load libraries
library(readxl)
library(writexl)
```


```r
# solution!
# load libraries
library(readxl)
library(writexl)

# load in tfl cycle data (might need to change file path)
tflCycle <- read_xlsx("data/tfl-daily-cycle-hires.xlsx", sheet = 2) 
```

```
## New names:
## * `Number of Bicycle Hires` -> `Number of Bicycle Hires...2`
## * `` -> ...3
## * Month -> Month...4
## * `Number of Bicycle Hires` -> `Number of Bicycle Hires...5`
## * `` -> ...6
## * ...
```

```r
# Take out raw data (hire by day)
tflCycleByDay <- tflCycle[,1:2]

# hire by month and ave hire time
tflCycleByMonth <- tflCycle[,c("Month...4","Number of Bicycle Hires...5","Average Hire Time (mins)")]

# hire by year
tflCycleByYear <- tflCycle[1:10,c("Year", "Number of Bicycle Hires...8")]

# most popular day, months and year
maxDay <- tflCycleByDay[which.max(tflCycleByDay$`Number of Bicycle Hires...2`),]
maxMonth <- tflCycleByMonth[which.max(tflCycleByMonth$`Number of Bicycle Hires...5`),]
maxHire <- tflCycleByMonth[which.max(tflCycleByMonth$`Average Hire Time (mins)`),]
maxYear <- tflCycleByYear[which.max(tflCycleByYear$`Number of Bicycle Hires...8`),]

# making month a character for paste
maxHire$Month...4 <- as.character(maxHire$Month...4)

# pasting an output
paste("The highest highest average cycle hire time per month was", maxHire[1,3], 
      "minutes, on the", maxHire[1,1],"with total hires of", maxHire[1,2],
      "which is just after lockdown started!")
```

```
## [1] "The highest highest average cycle hire time per month was 36 minutes, on the 2020-04-01 with total hires of 591058 which is just after lockdown started!"
```

```r
# write the tfl cycle by month data (most interesting)
write_xlsx(tflCycleByMonth, "data/tflCycleHire_byMonth.xlsx")
```

# Other options for loading data

It is useful to mention the `data.table` package, which is the fastest option when loading large csv files by using the `fread()` function.
