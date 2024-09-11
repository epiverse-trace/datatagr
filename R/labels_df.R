#' Extract a data.frame of all labelled variables
#'
#' This function returns a `data.frame`, where labelled variables (as stored in
#' the `datatagr` object) are renamed. Note that the output is no longer a
#' `datatagr`, but a regular `data.frame`. Unlabeled variables are unaffected.
#'
#' @param x a `datatagr` object
#'
#' @export
#'
#' @return A `data.frame` of with variables renamed according to their labels.
#'
#' @examples
#'
#' x <- make_datatagr(cars,
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
#' )
#'
#' ## get a data.frame with variables renamed based on labels
#' labels_df(x)
labels_df <- function(x) {
  checkmate::assertClass(x, "datatagr")

  labels <- unlist(labels(x))
  out <- drop_datatagr(x)

  # Find the intersection of names(out) and names(labels)
  common_names <- intersect(names(out), names(labels))
  # Replace the names of out that are in intersection with corresponding labels
  names(out)[match(common_names, names(out))] <- labels[common_names]

  out
}
