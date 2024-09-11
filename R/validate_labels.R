#' Checks the labels of a datatagr object
#'
#' This function evaluates the validity of the labels of a `datatagr` object by
#' checking that: i) labels are present ii) labels is a `list` of `character` or
#' `NULL` values.
#'
#' @export
#'
#' @param x a `datatagr` object
#'
#' @return If checks pass, a `datatagr` object; otherwise issues an error.
#'
#' @seealso [validate_types()] to check if tagged variables have
#'   the right classes
#'
#' @examples
#' ## create a valid datatagr
#' x <- cars |>
#'   make_datatagr(
#'     speed = "Miles per hour",
#'     dist = "Distance in miles"
#'   )
#' x
#'
#' ## the below issues an error as datatagr doesn't know any defaults
#' ## note: tryCatch is only used to avoid a genuine error in the example
#' tryCatch(validate_datatagr(x), error = paste)
#'
#' ## validation requires you to specify the types directly
#' validate_datatagr(x,
#'   speed = c("integer", "numeric"),
#'   dist = "numeric"
#' )
validate_labels <- function(x) {
  checkmate::assert_class(x, "datatagr")
  x_labels <- labels(x, show_null = TRUE)

  if (is.null(unlist(x_labels))) stop("`x` has no labels")

  # check that x is a list, and each tag is a `character`
  checkmate::assert_list(x_labels, types = c("character", "null"))

  x
}
