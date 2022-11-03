Assignment B1
================
Momenul Haque Mondol
(2022-11-02)

``` r
#' @title  Calculating detailed summary of a numeric vector
#'
#' @description Provides five number summary (min, Q1, median, Q3, and max) of a numeric vector.
#' In addition, it calculates mean, IQR, range, and sd also.
#'
#' @param var numeric vector or a variable of data frame. 
#' Since the function applies on variable, I named the parameter as `var'.
#'
#'
#' @param na.rm a logical parameter. If na.rm = TRUE (default), 
#' it deletes the missing observation. It is common in other R functions as well.
#' 
#' @param ... further arguments passed to or from other methods.
#'
#' @return a tibble that contains all the basic summary.
#' 
#'  
#' @author Momenul Haque Mondol \email{mhmondol@student.ubc.ca}
#'
#'
#' @examples
#'
#' # loading package
#' suppressPackageStartupMessages(library(tidyverse))
#' 
#' # making summary of body_mass_g variable in palmerpenguins::penguins data set
#' palmerpenguins::penguins %>% 
#'  summarise(my_summary(body_mass_g, na.rm = TRUE))
#'  
#' # making summary of body_mass_g variable by grouping sex variable
#' 
#' palmerpenguins::penguins %>% 
#'  summarise(my_summary(body_mass_g, na.rm = TRUE))
#'
#'  
#'
#' 

# mail function starts here

 my_summary <- function(var, na.rm = TRUE, ...)
   {
     # Checking the var class.  
     if(!(class(var) %in% c("numeric", "integer")))
       {
          stop('I am so sorry, but this function only works for numeric input!\n',
               'You have provided an object of class: ', class(var)[1])
       }
     # Checking the missing values.   
     if(na.rm == FALSE && !missing(var))
       {
          stop(" There exist ", sum(is.na(var)) ," missing values in your variable!\n")
       }
     # Checking the vars length and giving warning!   
     if(length(var) < 2)
       {
          warning("Your vector has single element!
                   The standard deviation is not possible to calculate") 
       } 
   
      # Calculating summary starts here
      
      # Calculating central tendency measures.   
      min = min(var, na.rm = na.rm, ...)
      Q1 = stats::quantile(var, probs = .25, na.rm = na.rm, ...)
      mean = mean(var, na.rm = na.rm, ...)
      median = stats::median(var, na.rm = na.rm, ...)
      Q3 = stats::quantile(var, probs = .75, na.rm = na.rm, ...)
      max = max(var, na.rm = na.rm, ...)
      # Calculating dispersion measures.
      IQR = Q3 - Q1
      range = max - min
      sd = stats::sd(var, na.rm = na.rm)
      missing = sum(is.na(var))
      all_summary <- tibble_row(min=min, Q1=Q1, mean = mean,
                         median=median, Q3=Q3, max=max, IQR=IQR,
                         range=range, sd=sd, 'NAs' = missing)
      
      return(all_summary) 
      
   }
```

-   An example is demonstrated for *penguins* data set in
    *palmerpenguins* R package. Summary statistics of **body_mass_g**
    can be found by running the following codes.

``` r
suppressPackageStartupMessages(library(tidyverse))


palmerpenguins::penguins %>% 
  summarise(my_summary(body_mass_g, na.rm = TRUE))
```

    ## # A tibble: 1 × 10
    ##     min    Q1  mean median    Q3   max   IQR range    sd   NAs
    ##   <int> <dbl> <dbl>  <dbl> <dbl> <int> <dbl> <int> <dbl> <int>
    ## 1  2700  3550 4202.   4050  4750  6300  1200  3600  802.     2

-   Summary statistics of **body_mass_g** variable for male and female
    separately.

``` r
palmerpenguins::penguins %>% 
  group_by(sex) %>% 
  summarise(my_summary(body_mass_g, na.rm = TRUE))
```

    ## # A tibble: 3 × 11
    ##   sex      min    Q1  mean median    Q3   max   IQR range    sd   NAs
    ##   <fct>  <int> <dbl> <dbl>  <dbl> <dbl> <int> <dbl> <int> <dbl> <int>
    ## 1 female  2700  3350 3862.   3650 4550   5200 1200   2500  666.     0
    ## 2 male    3250  3900 4546.   4300 5312.  6300 1412.  3050  788.     0
    ## 3 <NA>    2975  3475 4006.   4100 4650   4875 1175   1900  679.     2

Here, we found three rows although the sex has two categories. The third
row is a summary of **body_mass_g** variable who didn’t report the sex,
e.g. NA.

-   If someone is interested to report a few summary instead, it allows
    to take a subset just mentioning the name of that specific measures.

``` r
# reporting mean, and standard deviation only instead of detailed summary.

palmerpenguins::penguins %>% 
  group_by(sex) %>% 
  summarise(my_summary(body_mass_g, na.rm = TRUE)[c("mean", "sd")])
```

    ## # A tibble: 3 × 3
    ##   sex     mean    sd
    ##   <fct>  <dbl> <dbl>
    ## 1 female 3862.  666.
    ## 2 male   4546.  788.
    ## 3 <NA>   4006.  679.

-   If someone is interested to report a few summary for 10% trimmed
    data set, it allows to calculate.

``` r
# reporting 10% trimmed mean both from my_summary and mean function
palmerpenguins::penguins %>% 
  group_by(sex) %>% 
  summarise(From_my_summary = my_summary(body_mass_g, trim = .10, na.rm = TRUE)["mean"],
            From_mean=mean(body_mass_g, trim = .10, na.rm = TRUE))
```

    ## # A tibble: 3 × 3
    ##   sex    From_my_summary$mean From_mean
    ##   <fct>                 <dbl>     <dbl>
    ## 1 female                3834.     3834.
    ## 2 male                  4515.     4515.
    ## 3 <NA>                  4006.     4006.

-   The function will give warnings in case it gets a single value. But
    it can calculate all the summary measures but not the standard
    deviation.

``` r
palmerpenguins::penguins %>% 
  summarise(my_summary(body_mass_g[1], na.rm = TRUE))
```

    ## Warning in my_summary(body_mass_g[1], na.rm = TRUE): Your vector has single element!
    ##                    The standard deviation is not possible to calculate

    ## # A tibble: 1 × 10
    ##     min    Q1  mean median    Q3   max   IQR range    sd   NAs
    ##   <int> <dbl> <dbl>  <int> <dbl> <int> <dbl> <int> <dbl> <int>
    ## 1  3750  3750  3750   3750  3750  3750     0     0    NA     0

-   Testing the **my_summary()** function by three conditions.

``` r
suppressPackageStartupMessages(library(testthat))
test_that("Testing my_summary function", {
  expect_equal(my_summary(var = 1:10)[c("min", "max")], tibble(min=1, max=10))
  expect_error(my_summary(var = c("2", 3, 4)), "I am so sorry, but this function only works for numeric input!")
  expect_error(my_summary(var = c(NA, 3, 4), na.rm = FALSE), "missing values in your variable!")

  })
```

    ## Test passed 😸
