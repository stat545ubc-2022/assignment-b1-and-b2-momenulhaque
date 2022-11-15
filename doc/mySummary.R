## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
devtools::install_github("momenulhaque/mySummary")
library(mySummary)


## -----------------------------------------------------------------------------
# Defining a data set
Dat <- data.frame(age = c(40, 35, 27, 52, 29, 29, 46), sex = c("M", "F", "M", "F", "F", "M", "M"))

# Finding a detailed summary of age variable
mySummary(Dat$age)

# Finding a detailed summary of age variable for male only

mySummary(Dat[Dat$sex=="M", ]$age)

