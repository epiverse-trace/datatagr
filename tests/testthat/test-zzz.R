skip_if_not_installed("callr")

test_that("tests for zzz", {
  # We need to use callr to avoid conflicts with other tests
  res <- callr::r(
    function() {
      library(datatagr)
      get_lost_labels_action()
    }
  )
  expect_identical(res, "warning")
})

test_that("Environment variable is used for initial `lost_labels_action`", {
  # We need to use callr to avoid conflicts with other tests
  res <- callr::r(
    function() {
      library(datatagr)
      get_lost_labels_action()
    },
    env = c(DATATAGR_LOST_ACTION = "error")
  )
  expect_identical(res, "error")
})
