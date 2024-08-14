test_that("tests for validate_datatagr", {
  # errors
  msg <- "Must inherit from class 'datatagr', but has class 'NULL'."
  expect_error(validate_datatagr(NULL), msg)

  x <- make_datatagr(cars, id = "speed", toto = "dist")
  msg <- "Allowed types for tag `id`, `toto` are not documented in `ref_types`."
  expect_error(validate_datatagr(x), msg)
  expect_identical(x, validate_datatagr(x, ref_types = list(id = "numeric", toto = "numeric")))

  x <- make_datatagr(cars, gender = "speed")
  expect_error(
    validate_datatagr(x, ref_types = tags_types(gender = c(
      "character",
      "factor"
    ))),
    "- gender: Must inherit from class 'character'/'factor'"
  )

  # Functionalities
  x <- make_datatagr(cars)
  expect_identical(x, validate_datatagr(x))
})
