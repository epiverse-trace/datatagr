#' Get the list of labels in a datatagr
#'
#' This function returns the list of labels identifying specific variable types in
#' a `datatagr`.
#'
#' @param x a `datatagr` object
#'
#' @param show_null a `logical` indicating if the complete list of labels,
#'   including `NULL` ones, should be returned; if `FALSE`, only labels with a
#'   non-NULL value are returned; defaults to `FALSE`
#'
#' @export
#'
#' @return The function returns a named `list` where names indicate which column they correspond to, and values indicate 
#'   the relevant labels.
#'
#' @details Labels are stored as the `label` attribute of the column variable.
#'
#' @examples
#'
#' ## make a datatagr
#' x <- make_datatagr(cars, speed = "Miles per hour")
#'
#' ## check non-null labels
#' labels(x)
#'
#' ## get a list of all labels, including NULL ones
#' labels(x, TRUE)
labels <- function(x, show_null = FALSE) {
  checkmate::assertClass(x, "datatagr")
  out <- lapply(names(x), FUN = function (var) {
    attr(x[[var]], "label")
  })
  names(out) <- names(x)
  
  # Filter out NULL values if show_null is FALSE
  if (!show_null) {
    out <- Filter(Negate(is.null), out)
  }

  out
}
