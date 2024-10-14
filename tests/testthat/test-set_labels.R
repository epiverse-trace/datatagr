test_that("tests for set_labels()", {
  x <- make_safeframe(cars, dist = "Distance")

  # Check whether error messages are the same as before
  # Uses snapshot to prevent formatting issues in validating the error message
  expect_snapshot(set_labels(cars), error = TRUE)
  expect_snapshot(set_labels(x, toto = "speed"), error = TRUE)

  # Check functionality
  expect_identical(x, set_labels(x))
  x <- set_labels(x, speed = "Miles per hour")
  expect_identical(labels(x)$speed, "Miles per hour")
  expect_identical(labels(x)$dist, "Distance")

  x <- set_labels(x, speed = "Km per hour", dist = "Kilometre distance")
  y <- set_labels(x, !!!list(speed = "Km per hour", dist = "Kilometre distance"))
  expect_identical(x, y)
})
