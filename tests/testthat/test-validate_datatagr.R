test_that("validate_datatagr() detects invalid objects", {
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
})

test_that("validate_datatagr() allows valid objects", {
  x <- make_datatagr(cars, id = "speed")
  
  # Print a message
  expect_message(
    validate_datatagr(x, ref_types = list(id = "numeric")),
    "valid"
  )
  
  # And returns invisibly...
  v <- suppressMessages(
    expect_invisible(validate_datatagr(x, 
                                       ref_types = list(id = "numeric"))))
  
  # ...an identical object
  expect_identical(x, v)
})
