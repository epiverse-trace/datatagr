test_that("tests for labels", {
  # Check error messages
  x <- make_datatagr(cars, speed = "Miles per hour")

  # Check functionality
  expect_identical(labels(x), list(speed = "Miles per hour"))
  expect_identical(labels(x, show_null = TRUE), list(
    speed = "Miles per hour",
    dist = NULL
  ))

  # labels() returns an empty named list, which we cannot compare to list()
  # directly.
  expect_identical(length(labels(make_datatagr(cars))), length(list()))
  expect_identical(labels(make_datatagr(cars), TRUE), list(
    speed = NULL,
    dist = NULL
  ))
})
