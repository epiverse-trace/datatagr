test_that("tests for validate_types() basic input checking", {
  expect_error(
    validate_types(cars),
    "Must inherit from class 'datatagr', but has class 'data.frame'."
  )
})

test_that("validate_types() validates types", {
  # Successful validations
  x <- make_datatagr(cars, speed = "Miles per hour")
  expect_silent(
    expect_identical(
      x,
      validate_types(x, speed = "numeric")
    )
  )
  
  # Failed validations
  x <- make_datatagr(cars, speed = "Miles per hour")
  expect_error(
    validate_types(x, speed = "factor"),
    "speed: Must inherit from class 'factor', but has class 'numeric'"
  )
  
  x <- make_datatagr(cars, speed = "Miles per hour", dist = "Distance in miles")
  expect_snapshot_error(
    validate_types(x, speed = "factor", dist = "character")
  )
})

test_that("ensure validate_types throws error if no types provided", {
  x <- make_datatagr(cars, speed = "Miles per hour", dist = "Distance in miles")
  expect_error(
    validate_types(x),
    "Assertion on 'types' failed: Must have length >= 1, but has length 0."
  )
})
