#' Change labels of a safeframe object
#'
#' This function changes the `labels` of a `safeframe` object, using the same
#' syntax as the constructor [make_safeframe()].
#'
#' @inheritParams make_safeframe
#'
#' @seealso [make_safeframe()] to create a `safeframe` object
#'
#' @export
#'
#' @return The function returns a `safeframe` object.
#'
#' @examples
#'
#' ## create a safeframe
#' x <- make_safeframe(cars, speed = "Miles per hour")
#' labels(x)
#'
#' ## add new labels and fix an existing one
#' x <- set_labels(x, dist = "Distance")
#' labels(x)
#'
#' ## remove labels by setting them to NULL
#' old_labels <- labels(x)
#' x <- set_labels(x, speed = NULL, dist = NULL)
#' labels(x)
#'
#' ## setting labels providing a list (used to restore old labels here)
#' x <- set_labels(x, !!!old_labels)
#' labels(x)
set_labels <- function(x, ...) {
  # assert inputs
  checkmate::assertClass(x, "safeframe")

  labels <- rlang::list2(...)

  label_variables(x, labels)
}
