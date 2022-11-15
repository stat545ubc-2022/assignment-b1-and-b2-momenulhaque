

#' Provides a detailed summary of a numeric vector or variable
#'
#' @param var a numeric variable
#' @param na.rm if TRUE (default), it removes the missing values
#' @param ... further arguments passed to or from other methods
#'
#' @return a data frame of summary measures
#' @export
#'
#' @examples
#'
#' Dat <- data.frame(age = c(40, 35, 27, 52, 29, 29, 46),
#' sex = c("M", "F", "M", "F", "F", "M", "M"))
#'
#' mySummary(Dat$age)
#'
#' mySummary(Dat[Dat$sex=="M", ]$age)
#'
#'
#'
#'
mySummary <- function(var, na.rm = TRUE, ...)
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
  all_summary <- data.frame(min=min, Q1=Q1, mean = mean,
                            median=median, Q3=Q3, max=max, IQR=IQR,
                            range=range, sd=sd, 'NAs' = missing)

  return(all_summary)

}


