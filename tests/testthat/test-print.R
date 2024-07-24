test_that("tests for print.datatagr", {
  x <- make_datatagr(cars, date_onset = "dist", date_outcome = "speed")
  expect_snapshot_output(print(x))

  y <- make_datatagr(cars)
  expect_snapshot_output(print(y))
})
