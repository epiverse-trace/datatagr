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
      validate_types(x, ref_types = tags_types(mph = "numeric"))
    )
  )

  # Failed validations
  x <- make_datatagr(cars, speed = "Miles per hour")
  expect_error(
    validate_types(x, ref_types = tags_types(mph = "factor")),
    "mph: Must inherit from class 'factor', but has class 'numeric'"
  )

  x <- make_datatagr(cars, mph = "speed", distance = "dist")
  expect_snapshot_error(
    validate_types(x, ref_types = tags_types(mph = "factor", distance = "character"))
  )
})

test_that("missing ref_type in validate_types()", {
  # Single missing
  x <- make_datatagr(cars, mph = "speed", d = "dist")
  expect_error(
    validate_types(x),
    "Allowed types for tag `mph`, `d` are not documented in `ref_types`."
  )

  # Two missing
  x <- make_datatagr(cars, a = "speed", d = "dist")
  expect_error(
    validate_types(x),
    "Allowed types for tag `a`, `d` are not documented in `ref_types`."
  )
})
