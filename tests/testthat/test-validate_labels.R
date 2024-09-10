test_that("tests for validate_labels", {
  # test errors
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(validate_labels(cars), msg)

  x <- make_datatagr(cars)
  msg <- "`x` has no labels"
  expect_error(validate_labels(x), msg)

  # functionalities
  x <- make_datatagr(cars)
  expect_error(validate_labels(x))

  x <- set_labels(x, dist = "Distance in miles", speed = "Miles per hour")
  expect_identical(x, validate_labels(x))
})
