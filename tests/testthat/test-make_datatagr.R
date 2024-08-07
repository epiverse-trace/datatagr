test_that("tests for make_datatagr", {
  # test errors
  msg <- "Must be of type 'data.frame', not 'NULL'."
  expect_error(make_datatagr(NULL), msg)

  msg <- "Must have at least 1 cols, but has 0 cols."
  expect_error(make_datatagr(data.frame()), msg)

  msg <- "Must be element of set {'speed','dist'}, but is"
  expect_error(make_datatagr(cars, outcome = "bar"), msg, fixed = TRUE)

  expect_error(
    make_datatagr(cars, outcome = "bar", age = "bla"),
    "2 assertions failed"
  )

  msg <- "Use only known tags or set `allow_extra = TRUE`"
  expect_error(
    make_datatagr(cars, foo = "speed", allow_extra = FALSE),
    msg,
    fixed = TRUE
  )

  # test functionalities
  expect_identical(list(), tags(make_datatagr(cars), TRUE))

  x <- make_datatagr(cars, date_onset = "dist", date_outcome = "speed")
  expect_identical(tags(x)$date_onset, "dist")
  expect_identical(tags(x)$date_outcome, "speed")
  expect_null(tags(x)$outcome)
  expect_null(tags(x)$date_reporting)

  x <- make_datatagr(cars, foo = "speed", bar = "dist", allow_extra = TRUE)
  expect_identical(
    tags(x, TRUE),
    c(list(), foo = "speed", bar = "dist")
  )
})

test_that("make_datatagr() works with dynamic dots", {
  expect_identical(
    make_datatagr(cars, date_onset = "dist", date_outcome = "speed"),
    make_datatagr(cars, !!!list(date_onset = "dist", date_outcome = "speed"))
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
