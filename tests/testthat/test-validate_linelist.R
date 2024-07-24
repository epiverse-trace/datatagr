test_that("tests for validate_datatagr", {

  # errors
  msg <- "Must inherit from class 'datatagr', but has class 'NULL'."
  expect_error(validate_datatagr(NULL), msg)

  x <- make_datatagr(cars, id = "speed", toto = "dist", allow_extra = TRUE)
  msg <- paste(
    "The following tags are not part of the defaults:\ntoto",
    "Consider using `allow_extra = TRUE` to allow additional tags.",
    sep = "\n"
  )
  expect_error(validate_datatagr(x), msg)

  x <- make_datatagr(cars, gender = "speed")
  expect_error(
    validate_datatagr(x), 
    "- gender: Must inherit from class 'character'/'factor'"
  )

  # Functionalities
  x <- make_datatagr(cars)
  expect_identical(x, validate_datatagr(x))
})
