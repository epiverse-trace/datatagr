test_that("tests for drop_datatagr", {
  x <- make_datatagr(cars, speed = "Miles per hour")
  expect_identical(cars, drop_datatagr(x, TRUE))
  y <- drop_datatagr(x, FALSE)
  expect_identical(labels(x, TRUE), attr(y, "tags"))
})
