#' Printing method for datatagr objects
#'
#' This function prints datatagr objects.
#'
#' @param x a `datatagr` object
#'
#' @param ... further arguments to be passed to 'print'
#'
#' @return Invisibly returns the object.
#'
#' @export
#'
#' @examples
#' ## create datatagr
#' x <- make_datatagr(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' ## print object - using only the first few entries
#' head(x)
#'
#' # version with a tibble
#' if (require(tibble) && require(magrittr)) {
#'   cars %>%
#'     tibble() %>%
#'     make_datatagr(
#'       mph = "speed",
#'       distance = "dist"
#'     )
#' }
print.datatagr <- function(x, ...) {
  cat("\n// datatagr object\n")
  print(drop_datatagr(x, remove_tags = TRUE))
  tags_txt <- paste(names(labels(x)), unlist(labels(x)), sep = ":", collapse = ", ")
  if (tags_txt == "") {
    tags_txt <- "[no tagged variable]"
  }
  cat("\n// tags:", tags_txt, "\n")
  invisible(x)
}
