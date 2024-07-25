test_that("tests for drop_datatagr", {
  x <- make_datatagr(cars, age = "speed")
  expect_identical(cars, drop_datatagr(x, TRUE))
  y <- drop_datatagr(x, FALSE)
  expect_identical(tags(x, TRUE), attr(y, "tags"))
})
