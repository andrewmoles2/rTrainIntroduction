---
title: "R Fundamentals 5 - Loading data and packages"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "03 December, 2021"
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

# Objective of workshop

To load and export data into and out of R, and start using RStudio projects to manage file paths. 

# What will this workshop cover?

In this workshop, the aim is to cover how to load and work with data frames, as well as an introduction to packages. We will be covering:

-   Introduction to packages
-   Introduction to directories and projects
-   Loading in data
-   Exporting data

------------------------------------------------------------------------

# Introduction to packages

Packages are collections of functions, code, and sample data put together by the R community. Packages are one of the main benefits of R. As R is open source there can be lots of contributors who have made functions to do complex tasks, such as data cleaning, specific types of data analysis, or exciting data visualisation.

To install these packages onto your computer you have to download them from CRAN (The Comprehensive R Archive Network).

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-fundamentals-4/images/CRAN.png?raw=true){width="30%"}

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
```

If you are not sure what packages are loaded, you can use `sessionInfo()`. Run the code below to test it out. Under *other attached packages* you should see readr, readxl, and writexl.


```r
sessionInfo()
```

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Catalina 10.15.7
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.0.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.29   R6_2.5.1        jsonlite_1.7.2  magrittr_2.0.1 
##  [5] evaluate_0.14   rlang_0.4.12    stringi_1.7.6   jquerylib_0.1.4
##  [9] bslib_0.3.1     rmarkdown_2.11  tools_4.1.1     stringr_1.4.0  
## [13] xfun_0.28       yaml_2.2.1      fastmap_1.1.0   compiler_4.1.1 
## [17] htmltools_0.5.2 knitr_1.36      sass_0.4.0
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

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/main/r-fundamentals-5/images/RStudio_projects.png?raw=true)

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
3)  Put your r_fundamentals_5.Rmd file in your project directory (if you have not do so already).
4)  Add a new folder called data, and add in the data files for the session.
5)  Come back to RStudio and make sure you're project is open (*will see in top right corner your project name*), in the RStudio file explorer (bottom right) you should see the changes you've made.
6)  If you have not already, open the r_fundamentals_5.Rmd file.
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
```

# Final task - Please give us your individual feedback!

We would be grateful if you could take a minute before the end of the workshop so we can get your feedback!

<https://lse.eu.qualtrics.com/jfe/form/SV_eflc2yj4pcryc62?coursename=R%20Fundamentals%205:%20Loading%20data%20and%20packages%C2%A0&topic=R&link=https://lsecloud.sharepoint.com/:f:/s/TEAM_APD-DSL-Digital-Skills-Trainers/Enb32qhTgaZNrj--DH48fLcBMXQZrXgpjtfW2dawAVYhBQ?e=hPFNlS&prog=DS&version=21-22>

# Individual take home challenge

In this coding challenge you will need to re-organise the code to get it to run. The tfl cycles dataset is a bit messy, the first two columns are the raw data, the rest is aggregated data. We are going to separate it out into separate data frames to make it easier to read. Then write out the most interesting data.

You should end up with an output of *"The highest highest average cycle hire time per month was 36 minutes, on the 2020-04-01 with total hires of 591058 which is just after lockdown started!"*, and the by month xlsx file in your data file.

*note: you might need to change the file paths to match your system*


```r
# Take out raw data (hire by day)
tflCycleByDay <- tflCycle[,1:2]
```

```
## Error in eval(expr, envir, enclos): object 'tflCycle' not found
```

```r
# most popular day, months and year
maxDay <- tflCycleByDay[which.max(tflCycleByDay$`Number of Bicycle Hires...2`),]
```

```
## Error in eval(expr, envir, enclos): object 'tflCycleByDay' not found
```

```r
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


# Other options for loading data

It is useful to mention the `data.table` package, which is the fastest option when loading large csv files by using the `fread()` function.
