test_that("tests for [ operator", {
  x <- make_datatagr(cars, id = "speed", age = "dist")
  on.exit(lost_tags_action())

  # errors
  lost_tags_action("warning", quiet = TRUE)
  msg <- "The following tags have lost their variable:\n age:dist"
  expect_warning(x[, 1], msg)

  lost_tags_action("error", quiet = TRUE)
  msg <- "The following tags have lost their variable:\n age:dist"
  expect_error(x[, 1], msg)

  lost_tags_action("warning", quiet = TRUE)
  msg <- "The following tags have lost their variable:\n id:speed, age:dist"
  expect_warning(x[, NULL], msg)

  # functionalities
  expect_identical(x, x[])
  expect_identical(x, x[, ])
  expect_null(ncol(x[, 1, drop = TRUE]))
  expect_identical(x[, 1, drop = TRUE], cars[, 1])

  lost_tags_action("none", quiet = TRUE)
  expect_identical(x[, 1], make_datatagr(cars[, 1, drop = FALSE], id = "speed"))

  # [ behaves exactly as in the simple data.frame case, including when subset
  # only cols. https://github.com/epiverse-trace/linelist/issues/51
  expect_identical(
    cars[1],
    x[1],
    ignore_attr = TRUE
  )
  expect_identical(
    dplyr::as_tibble(cars)[1],
    x[1],
    ignore_attr = TRUE
  )

  # Warning about drop is surfaced to the user in this situation *iff* not our
  # default
  expect_no_warning(
    x[1]
  )
  expect_warning(
    x[1, drop = FALSE],
    "'drop' argument will be ignored"
  )
  expect_warning(
    dplyr::as_tibble(x)[1, drop = FALSE],
    "`drop` argument ignored"
  )
})

test_that("tests for [<- operator", {
  on.exit(lost_tags_action())

  # errors
  lost_tags_action("warning", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_warning(x[, 1] <- NULL, msg)

  lost_tags_action("error", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_error(x[, 1] <- NULL, msg)

  # functionalities
  x[1:3, 1] <- 1L
  expect_identical(x$speed[1:3], rep(1, 3))

  lost_tags_action("none", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  x[, 1:2] <- NULL
  expect_identical(ncol(x), 0L)
})

test_that("tests for [[<- operator", {
  on.exit(lost_tags_action())

  # errors
  lost_tags_action("warning", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_warning(x[[1]] <- NULL, msg)

  lost_tags_action("error", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_error(x[[1]] <- NULL, msg)

  # functionalities
  x[[1]] <- 1L
  expect_identical(x$speed, rep(1L, nrow(x)))

  lost_tags_action("none", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  x[[2]] <- NULL
  x[[1]] <- NULL
  expect_identical(ncol(x), 0L)
})

test_that("$<- operator detects tag loss", {
  on.exit(lost_tags_action())

  # errors
  lost_tags_action("warning", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_warning(x$speed <- NULL, msg)

  lost_tags_action("error", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  msg <- "The following tags have lost their variable:\n id:speed"
  expect_error(x$speed <- NULL, msg)

  lost_tags_action("none", quiet = TRUE)
  x <- make_datatagr(cars, id = "speed", age = "dist")
  x$speed <- NULL
  x$dist <- NULL
  expect_identical(ncol(x), 0L)
})

test_that("$<- allows innocuous tag modification", {
  x <- make_datatagr(cars, id = "speed", age = "dist")
  expect_no_condition(x$speed <- 1L)
  expect_identical(x$speed, rep(1L, nrow(x)))
})
