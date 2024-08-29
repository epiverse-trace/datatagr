test_that("label_variables() works with specification by position", {
  expect_error(
    label_variables(cars, list(distance = "toto")),
    "Must be element of set \\{'speed','dist'\\}, but is"
  )

  expect_error(
    label_variables(cars, list(distance = NA)),
    "Must be element of set \\{'speed','dist'\\}, but is."
  )

  # Check functionality
  x <- label_variables(cars, list(distance = "dist"))
  expect_identical(attr(x, "tags"), list(distance = "dist"))

  x <- label_variables(x, list(vitesse = "speed"))
  expect_identical(attr(x, "tags"), list(distance = "dist", vitesse = "speed"))

  x <- label_variables(x, list(vitesse = NULL), replace = TRUE) # reset to NULL
  expect_identical(attr(x, "tags"), list(distance = "dist", vitesse = NULL))
})

test_that("label_variables() works with specification by position", {
  expect_error(
    label_variables(cars, list(distance = 3)),
    "lower than the number of columns"
  )

  expect_identical(
    label_variables(cars, list(distance = 2)),
    label_variables(cars, list(distance = "dist"))
  )
})
