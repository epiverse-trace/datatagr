test_that("tests for tags", {
  # Check error messages
  x <- make_datatagr(cars, speed = "Miles per hour")

  # Check functionality
  expect_identical(labels(x), list(mph = "speed"))
  expect_identical(labels(x, TRUE), attr(x, "tags"))
  expect_identical(labels(make_datatagr(cars), TRUE), list())
})
