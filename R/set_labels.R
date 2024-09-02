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
#' ## add new tags and fix an existing one
#' x <- set_labels(x, dist = "Distance")
#' labels(x)
#'
#' ## remove tags by setting them to NULL
#' old_tags <- labels(x)
#' x <- set_labels(x, speed = NULL, dist = NULL)
#' labels(x)
#'
#' ## setting tags providing a list (used to restore old tags here)
#' x <- set_labels(x, !!!old_tags)
#' labels(x)
set_labels <- function(x, ...) {
  # assert inputs
  checkmate::assertClass(x, "datatagr")

  old <- labels(x)
  new <- rlang::list2(...)

  # keep.null ensures NULL labels are kept in the resulting list
  updated <- utils::modifyList(old, new, keep.null = TRUE)

  label_variables(x, updated)
}
