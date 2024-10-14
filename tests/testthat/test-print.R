test_that("tests for print.safeframe", {
  x <- make_safeframe(cars, dist = "Distance in miles", speed = "Miles per hour")
  expect_snapshot_output(print(x))

  y <- make_safeframe(cars)
  expect_snapshot_output(print(y))
})
