
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mySummary

It is frequently required to find out basic summary statistics while
analyzing data. One has to run multiple command to get a detailed
summary of a numeric variable. That’s why **mySummary** package can help
getting a complete summary by a single function.

The goal of mySummary is to provide common summary statistics for a
numerical variable such as minimum, maximum, mean, median,
inter-quartile range (IQR), standard deviation. In addition, it reports
the missing values.

## Installation

You can install the development version of mySummary from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("momenulhaque/mySummary")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# load the package first
library(mySummary)

# Defining a data set
Dat <- data.frame(age = c(40, 35, 27, 52, 29, 29, 46), sex = c("M", "F", "M", "F", "F", "M", "M"))

# Finding a detailed summary of age variable
mySummary(Dat$age)
#>     min Q1     mean median Q3 max IQR range       sd NAs
#> 25%  27 29 36.85714     35 43  52  14    25 9.546877   0

# Finding a detailed summary of age variable for male only

mySummary(Dat[Dat$sex=="M", ]$age)
#>     min   Q1 mean median   Q3 max IQR range       sd NAs
#> 25%  27 28.5 35.5   34.5 41.5  46  13    19 9.036961   0
```
