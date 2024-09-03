test_that("tests for print.datatagr", {
  x <- make_datatagr(cars, dist = "Distance in miles", speed = "Miles per hour")
  expect_snapshot_output(print(x))

  y <- make_datatagr(cars)
  expect_snapshot_output(print(y))
})
