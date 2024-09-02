#' Extract a data.frame of all tagged variables
#'
#' This function returns a `data.frame` of all the tagged variables stored in a
#' `datatagr`. Note that the output is no longer a `datatagr`, but a regular
#' `data.frame`.
#'
#' @param x a `datatagr` object
#'
#' @export
#'
#' @return A `data.frame` of tagged variables.
#'
#' @examples
#'
#' x <- make_datatagr(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' ## get a data.frame of all tagged variables
#' tags_df(x)
tags_df <- function(x) {
  checkmate::assertClass(x, "datatagr")
  tags <- unlist(labels(x))
  out <- drop_datatagr(x, remove_tags = TRUE)[tags]
  names(out) <- names(tags)
  out
}
