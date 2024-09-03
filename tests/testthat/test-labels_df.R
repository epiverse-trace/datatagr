test_that("tests for labels_df without unlabeled variables", {
  # These are now order dependent for the tests
  x <- make_datatagr(cars,
    speed = "Miles per hour",
    dist = "Distance in miles"
  )
  y <- cars[c("speed", "dist")]
  names(y) <- c("Miles per hour", "Distance in miles")

  # errors
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(labels_df(cars), msg)

  # functionality
  expect_identical(labels_df(x), y)
})


test_that("labels_df with unlabeled variables works as expected", {
  x <- make_datatagr(cars,
                     dist = "Distance in miles"
  )
  y <- cars[c("speed", "dist")]
  names(y) <- c("speed", "Distance in miles")
  
  expect_identical(labels_df(x), y)
})