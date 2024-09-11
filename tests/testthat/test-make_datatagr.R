test_that("tests for make_datatagr", {
  # test errors
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(make_datatagr(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(make_datatagr(data.frame()), msg)

  msg <- "* Variable 'namedLabel': Must be element of set {'speed','dist'}, but"
  expect_error(make_datatagr(cars, outcome = "bar"), msg, fixed = TRUE)

  expect_error(
    make_datatagr(cars, outcome = "bar", age = "bla"),
    "2 assertions failed"
  )

  # test functionalities
  expect_identical(
    list(speed = NULL, dist = NULL),
    labels(make_datatagr(cars), TRUE)
  )

  x <- make_datatagr(cars, dist = "Date onset", speed = "Date outcome")
  expect_identical(labels(x)$dist, "Date onset")
  expect_identical(labels(x)$speed, "Date outcome")
  expect_null(labels(x)$"Date onset")
  expect_null(labels(x)$"Date outcome")

  x <- make_datatagr(cars, speed = "foo", dist = "bar")
  expect_identical(
    labels(x, TRUE),
    c(list(), speed = "foo", dist = "bar")
  )
})

test_that("make_datatagr() works with dynamic dots", {
  expect_identical(
    make_datatagr(cars, dist = "date_onset", speed = "date_outcome"),
    make_datatagr(cars, !!!list(dist = "date_onset", speed = "date_outcome"))
  )
})

test_that("make_datatagr() errors on data.table input", {
  dt_cars <- structure(
    cars,
    class = c("data.table", "data.frame")
  )

  expect_error(
    make_datatagr(dt_cars),
    "NOT be a data.table"
  )
})

test_that("make_datatagr() works with single & multi-word labels", {
  expect_no_condition(make_datatagr(cars, speed = "mph"))
  expect_no_condition(make_datatagr(cars, speed = "Miles per hour"))
})
