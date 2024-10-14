test_that("tests for validate_labels", {
  # test errors
  msg <- "Must inherit from class 'safeframe', but has class 'data.frame'."
  expect_error(validate_labels(cars), msg)

  x <- make_safeframe(cars)
  msg <- "`x` has no labels"
  expect_error(validate_labels(x), msg)

  # functionalities
  x <- make_safeframe(cars)
  expect_error(validate_labels(x))

  x <- set_labels(x, dist = "Distance in miles", speed = "Miles per hour")
  expect_identical(x, validate_labels(x))
})
