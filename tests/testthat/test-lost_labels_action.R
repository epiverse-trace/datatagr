test_that("tests for lost_labels_action", {
  msg <- "Lost labels will now issue a warning."
  expect_message(lost_labels_action(), msg)

  msg <- "Lost labels will now issue an error."
  expect_message(lost_labels_action("error"), msg)

  msg <- "Lost labels will now be ignored."
  expect_message(lost_labels_action("none"), msg)

  lost_labels_action("error", quiet = TRUE)
  expect_identical(get_lost_labels_action(), "error")

  lost_labels_action("none", quiet = TRUE)
  expect_identical(get_lost_labels_action(), "none")

  lost_labels_action("warning", quiet = TRUE)
  expect_identical(get_lost_labels_action(), "warning")
})
