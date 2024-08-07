#' Get the list of tags in a datatagr
#'
#' This function returns the list of tags identifying specific variable types in
#' a `datatagr`.
#'
#' @param x a `datatagr` object
#'
#' @param show_null a `logical` indicating if the complete list of tags,
#'   including `NULL` ones, should be returned; if `FALSE`, only tags with a
#'   non-NULL value are returned; defaults to `FALSE`
#'
#' @export
#'
#' @return The function returns a named `list` where names indicate generic
#'   types of data, and values indicate which column they correspond to.
#'
#' @details Tags are stored as the `tags` attribute of the object.
#'
#' @examples
#'
#' ## make a datatagr
#' x <- make_datatagr(cars, mph = "speed")
#'
#' ## check non-null tags
#' tags(x)
#'
#' ## get a list of all tags, including NULL ones
#' tags(x, TRUE)
tags <- function(x, show_null = FALSE) {
  checkmate::assertClass(x, "datatagr")
  out <- attr(x, "tags")
  if (!show_null) {
    to_remove <- vapply(out, is.null, logical(1))
    out <- out[!to_remove]
  }
  out
}
