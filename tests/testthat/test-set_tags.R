test_that("tests for set_tags()", {
  x <- make_datatagr(cars, date_onset = "dist")

  # Check error messages
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(set_tags(cars), msg)

  msg <- "Must be element of set {'speed','dist'}, but is"
  expect_error(set_tags(x, outcome = "toto"), msg, fixed = TRUE)

  # Check functionality
  expect_identical(x, set_tags(x))
  x <- set_tags(x, date_reporting = "speed")
  expect_identical(tags(x)$date_reporting, "speed")
  expect_identical(tags(x)$date_onset, "dist")

  x <- set_tags(x, id = "speed", date_outcome = "dist")
  y <- set_tags(x, !!!list(id = "speed", date_outcome = "dist"))
  expect_identical(x, y)
})
