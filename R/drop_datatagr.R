#' Remove the datatagr class from an object
#'
#' Internal function. Used for dispatching to other methods when `NextMethod` is
#' an issue (typically to pass additional arguments to the `datatagr` method).
#'
#' @param x a `datatagr` object
#'
#' @param remove_labels a `logical` indicating if labels should be removed from
#' the attributes; defaults to `TRUE`
#'
#' @noRd
#'
#' @return The function returns the same object without the `datatagr` class.
#'
drop_datatagr <- function(x, remove_labels = TRUE) {
  classes <- class(x)
  class(x) <- setdiff(classes, "datatagr")
  if (remove_labels) {
    # Set the label attribute to NULL for all variables in x
    for (var in names(x)) {
      attr(x[[var]], "label") <- NULL
    }
  }
  x
}
