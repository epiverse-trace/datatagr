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
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
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
#'       speed = "Miles per hour",
#'       dist = "Distance in miles"
#'     )
#' }
print.datatagr <- function(x, ...) {
  cat("\n// datatagr object\n")
  print(drop_datatagr(x))

  # Extract names and values from labels(x)
  label_values <- unlist(labels(x))
  label_names <- names(label_values)

  # Construct the labels_txt string from the filtered pairs
  labels_txt <- vars_labels(label_names, label_values)

  if (labels_txt == "") {
    cat("\n[no labelled variables]\n")
  } else {
    cat("\nlabelled variables:\n", labels_txt, "\n")
  }

  invisible(x)
}
