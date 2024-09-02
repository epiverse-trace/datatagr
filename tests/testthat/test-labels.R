test_that("labels() works on singular label datatagr objects", {
    x <- make_datatagr(cars, speed = "Miles per hour")
    y <- list(speed = 'Miles per hour')
    expect_identical(labels(x), y)
})

test_that("labels() works on datatagr objects with multiple labels", {
  x <- make_datatagr(cars, speed = "Miles per hour", dist = "Distance")
  y <- list(speed = 'Miles per hour', dist = 'Distance')
  expect_identical(labels(x), y)
})

test_that("labels() shows NULL values as expected", {
    x <- make_datatagr(cars, speed = "Miles per hour")
    y <- list(speed = 'Miles per hour', dist = NULL)
    expect_identical(labels(x, show_null = TRUE), y)
})