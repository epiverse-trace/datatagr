test_that("tests for tags_df", {
  # These are now order dependent for the tests
  x <- make_datatagr(cars, distance = "dist", mph = "speed")
  y <- cars[c("dist", "speed")]
  names(y) <- c("distance", "mph")

  # errors
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(tags_df(cars), msg)

  # functionality
  expect_identical(tags_df(x), y)
})
