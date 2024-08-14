test_that("tests for prune_tags", {
  x <- make_datatagr(cars, mph = "speed", distance = "dist")

  # Check error messages
  msg <- "Must inherit from class 'datatagr', but has class 'data.frame'."
  expect_error(prune_tags(cars), msg)

  attr(x, "names") <- c("new1", "new2") # hack needed as names<- is now safe
  msg <- paste(
    "The following tags have lost their variable:",
    " mph:speed, distance:dist",
    sep = "\n"
  )
  expect_error(prune_tags(x), msg, class = "datatagr_error")
  expect_warning(prune_tags(x, "warning"), msg, class = "datatagr_warning")

  # Check functionality
  y <- prune_tags(x, "none")
  expect_identical(list(), tags(y, TRUE))
  expect_s3_class(y, "datatagr")
})

test_that("prune_tags() doesn't error on a datatagr with extra tags", {
  # https://github.com/epiverse-trace/linelist/issues/63

  dat <- data.frame(a = 1)
  ll <- make_datatagr(dat, a = "a")

  expect_no_condition(ll["a"])
  expect_identical(ll, ll["a"])
})
