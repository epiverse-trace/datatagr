test_that("tests for validate_tags", {
  # test errors
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(validate_tags(cars), msg)

  x <- make_datatagr(cars)
  attr(x, "tags") <- NULL
  msg <- "`x` has no tags attribute"
  expect_error(validate_tags(x), msg)

  attr(x, "tags") <- c(list(), toto = "ilestbo")
  msg <- "The following tagged variables are missing:\ntoto:ilestbo"
  expect_error(validate_tags(x), msg)

  tags <- list()
  tags[[2]] <- 1L
  attr(x, "tags") <- tags
  msg <- paste0(
    "May only contain the following types: \\{character,null\\}, ",
    "but element 2 has type 'integer'."
  )
  expect_error(validate_tags(x), msg)

  msg <- ""
  expect_error(validate_tags(x), msg)

  # functionalities
  x <- make_datatagr(cars)
  expect_identical(x, validate_tags(x))

  x <- set_labels(x, date_onset = "dist", toto = "speed")
  expect_identical(x, validate_tags(x))
})
