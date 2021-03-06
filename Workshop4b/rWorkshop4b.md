---
title: "R Workshop 4 - Data Frames part 2"
author:
   - name: Andrew Moles
     affiliation: Learning Developer, Digital Skills Lab
date: "19 January, 2021"
output: 
  html_document: 
    theme: readable
    highlight: pygments
    keep_md: yes
---

# What will this workshop cover?

In this workshop, the aim is to cover how to load and work with data frames, as well as an introduction to packages. We will be covering:

*  Introduction to packages
*  Introduction to directories and projects
*  Loading in data
*  Exporting data

# Information on how the session is run

One hour exercise based session with tutor support. You will be given example code for a problem, then given a related exercise to complete.

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

# Introduction to packages

Packages are collections of functions, code, and sample data put together by the R community. Packages are one of the main benefits of R. As R is open source there can be lots of contributors who have made functions to do complex tasks, such as data cleaning, specific types of data analysis, or exciting data visualisation.

To install these packages onto your computer you have to download them from CRAN (The Comprehensive R Archive Network). 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop4a/images/CRAN.png?raw=true){width=30%}

There are two ways of doing this, using code (recommended and easiest) or using the menus (Tools > Install Packages). 

Using code involves using the install packages function, which looks like: `install.packages("package name")`. To install the package you would type something like:`install.packages("readr")`.

Once installed, you will not need to do this again unless you install a newer version of R. 

## Installing packages task

Try installing the following packages:`readr`, `readxl`, and `writexl` using the `install.packages()` function. We will be using these in today's session. 


```r
# your code here
```

## Loading packages

Now you have installed the packages, you need to load them in order to use them. **Each time you load R you will need to re-load the packages you want to use**. 

To load a package you need to use the `library()` function. For example, if I wanted to load the `readr` package I would type `library(readr)`.

## Loading packages task

Using `library()` load in the packages you just installed: `readr`, `readxl`, and `writexl`.


```r
# your code here
```

If you are not sure what packages are loaded, you can use `sessionInfo()`. Run the code below to test it out. Under *other attached packages* you should see readr, readxl, and writexl. 

```r
sessionInfo()
```

# Introduction to directories

A directory is a file path on your computer. In R we use working directories and file paths to tell R where to find files to load or save out of R. Directories work in a top down hierarchical manner. 

To find out where your working directory is in R you can use `getwd()`. This gives prints out a file path. 

Run the code below, the output should be the file your rWorkshop4b.Rmd is saved in. 

```r
getwd()
```

```
## [1] "/Users/MOLES/OneDrive - London School of Economics/Code/rTrainIntroduction/Workshop4b"
```

# Introduction to RStudio Projects

A project is a centralised place to keep all your files for a study, piece of work, or 'project'. When you start a new Project it sets up a working directory in a fresh R session. Because the project sets up the working directory and keeps all your project related files in one place, it makes managing your files and analysis much easier, and helps you to share your code with collaborators or supervisors. 

*note: you can also change your working directory using the setwd() function, but in the long run it can be difficult to manage. E.g. if a file moves or gets deleted* 

## How to set up a project? 

![](https://github.com/andrewmoles2/rTrainIntroduction/blob/master/Workshop4b/images/RStudio_projects.png?raw=true)

1) File > New Project...
2) Select new directory (or existing directory if you have already set up a file)

*New directory*  

1) Select new project
2) Give your directory a name, e.g. "rWorkshop"
3) Select browse and find the directory you want to start your project
4) Press Create Project
5) Your new project should open

*Existing directory*

1) Select browse and find the directory you want to start your project
2) Press Create Project
3) Your new project should open

To open and review your projects in future you will see them in a drop down menu in the top right corner of RStudio. 

## Project task

*note: making a new project opens a new RStudio window, you can go back to your original window by selecting close project from the project drop down list in the top right corner.*

1) Set up a project for this workshop using the steps above. 
2) Go to your newly created project folder in either File Explorer (Windows) or Finder (Mac). 
3) Put your rWorkshop4b.Rmd file in your project directory (if you have not do so already).
4) Add a new file called data, and add in the data files for the session (tfl-daily-cycle-hires.xlsx and tfl-journeys-type.csv). 
5) Come back to RStudio and make sure your project is open (*will see in top right corner your project name*), in the RStudio file explorer (bottom right) you should see the changes you've made. 
6) If you have not already, open the rWorkshop4b.Rmd file.
7) In the code chunk below run `getwd()`. You should get your new project file system as the output. 


```r
# your code here
```

# Loading in data from your computer

Data can be loaded into R either from files from your computer, or the internet using URLs. R can handle many different file types thanks to packages built by the R community. These include .csv, .xlsx, .sav, .dta and .txt.

To check your folders or data files are where you expect them to be, you can use the `list.files()` function. You should see your rWorkshop4b.Rmd and your data file. 


RStudio helpfully has auto-completion for directories to help you build file paths. To get this working use speech marks with a function, like `list.files()`. Press tab (key on far left of keyboard above caps lock with arrow) when the cursor is within the speech marks (""). You should get a drop down list of your files, press tab again to select the file you want. Repeat the process till you get to where you want to be. 

## List files task

1) Using speech marks and tab, as outlined above, list the files in your data file. You should get something like: `list.files("data/")`
2) Run the code, the output should be the data files you put in the data file in step 4 of the project task. 

```r
# your code here
```

# Loading csv and Excel (.xlsx) files
Now you know how to access files, we can load them into R! We are going to load in a .csv file and a .xlsx file, two of the most common file types to be loaded into R. To load data into R we use a read function.

First we will load a csv file. To load a csv we can use either `read.csv()` that comes with R by default, or we can use `read_csv()` that comes with the readr package. `read_csv()` is preferable as it loads in large datasets faster than `read.csv()`. 

Just like making vectors or data frames in the previous workshops, you need to assign a name to your data that is being loaded. For example, if I was loading a dataset called *dataset.csv* stored in the data folder I would use: `data <- read_csv("data/dataset.csv")`.

## Loading csv files task

1) Load in the *tfl-journeys-type.csv* using the `read_csv()` function from readr. Make sure to give the data a meaningful name, such as tflJourneyType. 
2) Get some information on your loaded data frame using functions such as `str()`, `head()`, or `summary()`.
3) From the information, when does the dataset start and end recording data? *hint: head and tail functions will help*


```r
# make sure readr is loaded
library(readr)
# your code here
```

**Great work, you've loaded your first dataset!** 

## Loading Excel (.xlsx) files task

Now lets have a go at reading data from an Excel file (.xlsx) using the tfl-daily-cycle-hires.xlsx file. 

Excel files can come with multiple worksheets, such as the example we will use. To handle this the read_xlsx function has a sheet option. By default it will load sheet 1. For example, if I wanted to load in the third worksheet of an .xlsx file I would use: `data <- read_xlsx("data/datafile.xlsx", sheet = 3)`

1) Using the `read_xlsx()` function, load worksheet 2 of the tfl-daily-cycle-hires.xlsx file, call your loaded data tflCycle. 
2) Get information on your data like you did for the csv task. 
3) Find out the mean, max, and min for the "Number of Bicycle Hires...2" column. 

*note: we will tidy this dataframe up in the individual coding challenge*

```r
# make sure readxl is loaded
library(readxl)
# your code here
```

# Loading in data from the internet

Loading data from the internet can be useful for datasets that regularly update, such as the tfl dataset we loaded earlier. By using the URL for the dataset, we don't need to regularly download and store the data on our computer. 

We load the data in a very similar way to how we load in files from our computer, but instead of giving the file path, we give the URL to where the raw data is stored online. For example, we would write something like: `data <- read_csv("link to data")`.

## Loading data from the internet task

1) Go to the following website: https://data.london.gov.uk/dataset/public-transport-journeys-type-transport
2) Find the csv file (yellow colour with 8.94kB). Use the download drop down menu and copy the *'copy link to file'* link provided.
3) Using `read_csv()`, load in the data using the link you just copied. Call it `tflJourneyType` again. 
4) Run commands such as `str()` and `summary()` to make sure the data has loaded correctly. 


```r
# your code here
```

# Exporting data

You've learned how to load in data from computer files and the internet, now lets save some data. We will have a go at writing to both csv and xlsx (using `writexl`). The concept is very much the same as reading in data. We provide the write function with our data, then give it a file path and file name. 

For example, if I wanted to save a csv file to my data folder: `write_csv(data, "data/data.csv")`. 

## Exporting data task

Using the tflJourneyType dataset follow the steps:

1) First lets do some calculations. Make a new column called BusTube that is the sum of bus journeys and tube journeys *think back to R4a if you get stuck: data$newCol <- data$col1 + data$col2*.
2) Make another new column called DLR_Tram that is the sum of DLR journeys and Tram journeys. 
3) Make a new dataset called tflSubset that contains the first column, and both your new columns (BusTube & DLR_Tram) *hint: use indexing [,]*
4) Using `write_csv()` write your tflSubset data to your data file. Call it tflSubset.csv. 
5) Using `write_xlsx()` write your tflSubset data to your data file. Call it tflSubset.xlsx. 
6) Have a look at the csv and xlsx files you have created in finder or windows explorer. 


```r
# make sure writexl is loaded
library(writexl)
# your code here
```

# Final task - Please give us your individual feedback!

This is the first time that we are exploring a remote learning format for our workshops and we would be grateful if you could take 2 mins before the end of the workshop to get your feedback!

https://lse.eu.qualtrics.com/jfe/form/SV_77M35cq1arxNcj3?course=D065:R4aDF2&topic=R&cohort=LT21&link=https://lsecloud.sharepoint.com/:u:/s/TEAM_APD-DSL-Digital-Skills-Trainers/EdKicU-A1QZHhmDBRsEe-ykBzny3RNZVvavx_zsZ-Fom9Q?e=aPnCfn

At the end of the survey a link to the solutions for the workshop will be provided. 

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
maxHire <- tflCycleByMonth[which.max(tflCycleByMonth$`Average Hire Time (mins)`),]
maxYear <- tflCycleByYear[which.max(tflCycleByYear$`Number of Bicycle Hires...8`),]

# load in tfl cycle data (might need to change file path)
tflCycle <- read_xlsx("data/tfl-daily-cycle-hires.xlsx", sheet = 2) 

# hire by month and ave hire time
tflCycleByMonth <- tflCycle[,c("Month...4","Number of Bicycle Hires...5","Average Hire Time (mins)")]

# making month a character for paste
maxHire$Month...4 <- as.character(maxHire$Month...4)

# pasting an output
paste("The highest highest average cycle hire time per month was", maxHire[1,3], 
      "minutes, on the", maxHire[1,1],"with total hires of", maxHire[1,2],
      "which is just after lockdown started!")

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

