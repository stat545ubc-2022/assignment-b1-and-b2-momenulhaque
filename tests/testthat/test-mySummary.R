test_that("Testing mySummary function", {
  expect_equal(unlist(mySummary(var = 1:10)[c("min", "max")]), c(min=1, max=10))
  expect_error(mySummary(var = c("2", 3, 4)), "I am so sorry, but this function only works for numeric input!")
  expect_setequal(c(mySummary(var = 2:8)[c("min", "max")]), list(2, 8))

})
