test_that("tests for validate_datatagr", {
  # errors
  msg <- "Must inherit from class 'datatagr', but has class 'NULL'."
  expect_error(validate_datatagr(NULL), msg)

  x <- make_datatagr(cars, speed = "Miles per hour", dist = "Distance in miles")
  msg <- "Assertion on 'types' failed: Must have length >= 1, but has length 0."
  expect_error(validate_datatagr(x), msg)
  expect_identical(x, validate_datatagr(x, speed = "numeric", 
                                        dist = "numeric"))

  x <- make_datatagr(cars, speed = "Miles per hour")
  expect_error(
    validate_datatagr(x, speed = c(
      "character",
      "factor"
    )),
    "- speed: Must inherit from class 'character'/'factor', but has class 'numeric'"
  )

  # Functionalities
  x <- make_datatagr(cars)
  msg <- "`x` has no labels"
  expect_error(validate_datatagr(x), msg)
})
