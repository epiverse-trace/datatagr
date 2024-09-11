#' Change labels of a datatagr object
#'
#' This function changes the `labels` of a `datatagr` object, using the same
#' syntax as the constructor [make_datatagr()].
#'
#' @inheritParams make_datatagr
#'
#' @seealso [make_datatagr()] to create a `datatagr` object
#'
#' @export
#'
#' @return The function returns a `datatagr` object.
#'
#' @examples
#'
#' ## create a datatagr
#' x <- make_datatagr(cars, speed = "Miles per hour")
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
  checkmate::assertClass(x, "datatagr")

  labels <- rlang::list2(...)

  label_variables(x, labels)
}
