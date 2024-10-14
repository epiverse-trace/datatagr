test_that("tests for drop_safeframe", {
  x <- make_safeframe(cars, speed = "Miles per hour")
  expect_identical(cars, drop_safeframe(x, remove_labels = TRUE))

  y <- drop_safeframe(x, remove_labels = FALSE)
  expect_identical(labels(x, TRUE)$speed, attr(y$speed, "label"))
  expect_identical(labels(x, TRUE)$dist, attr(y$dist, "label"))
})
