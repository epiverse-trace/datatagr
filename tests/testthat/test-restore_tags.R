test_that("tests for restore_tags", {
  # These are now order dependent for the tests
  x <- make_datatagr(cars, distance = "dist", mph = "speed")
  y <- drop_datatagr(x)
  z <- y
  names(z) <- c("titi", "toto")

  # Check error messages
  msg <- paste(
    "The following tags have lost their variable:",
    " distance:dist, mph:speed",
    sep = "\n"
  )
  expect_error(restore_tags(z, tags(x), "error"), msg)
  expect_warning(restore_tags(z, labels(x), "warning"), msg)

  # Check functionality
  expect_identical(x, restore_tags(x, labels(x)))
  expect_identical(x, restore_tags(y, labels(x)))
})
