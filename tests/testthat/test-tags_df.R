test_that("tests for tags_df", {
  # These are now order dependent for the tests
  x <- make_datatagr(cars, date_reporting = "dist", age = "speed")
  y <- cars[c("dist", "speed")]
  names(y) <- c("date_reporting", "age")

  # errors
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(tags_df(cars), msg)

  # functionality
  expect_identical(tags_df(x), y)
})
