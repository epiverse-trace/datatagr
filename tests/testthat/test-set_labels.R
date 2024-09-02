test_that("tests for set_labels()", {
  x <- make_datatagr(cars, dist = "Distance")

  # Check error messages
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(set_labels(cars), msg)

  msg <- "* Variable 'names(labels)[label == labels]': Must be element of set"
  expect_error(set_labels(x, toto = "speed"), msg, fixed = TRUE)

  # Check functionality
  expect_identical(x, set_labels(x))
  x <- set_labels(x, speed = "Miles per hour")
  expect_identical(labels(x)$speed, "Miles per hour")
  expect_identical(labels(x)$dist, "Distance")

  x <- set_labels(x, speed = 'Km per hour', dist = "Kilometre distance")
  y <- set_labels(x, !!!list(speed = 'Km per hour', dist = "Kilometre distance"))
  expect_identical(x, y)
})
