test_that("tests for restore_labels", {
  # These are now order dependent for the tests
  x <- make_datatagr(cars, speed = "Miles per hour", dist = "Distance in miles")
  y <- drop_datatagr(x)
  z <- y
  names(z) <- c("titi", "toto")

  # Check error messages
  expect_error(restore_labels(z, labels(x)), 
               "No matching labels provided.")

  # Check functionality
  expect_identical(x, restore_labels(x, labels(x)))
  expect_identical(x, restore_labels(y, labels(x)))
  
  # Classes are correct for different operator use
  expect_equal(class(x), c("datatagr", "data.frame"))
  y <- restore_labels(y, labels(x))
  expect_equal(class(y), c("datatagr", "data.frame"))
  x[[1]] <- 'test'
  expect_equal(class(x), c("datatagr", "data.frame"))
  x[1] <- 'test2'
  expect_equal(class(x), c("datatagr", "data.frame"))
  x$speed <- 'test3'
  expect_equal(class(x), c("datatagr", "data.frame"))
})
