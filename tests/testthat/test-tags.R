test_that("tests for tags", {
  # Check error messages
  x <- make_datatagr(cars, mph = "speed")

  # Check functionality
  expect_identical(tags(x), list(mph = "speed"))
  expect_identical(tags(x, TRUE), attr(x, "tags"))
  expect_identical(tags(make_datatagr(cars), TRUE), list())
})
