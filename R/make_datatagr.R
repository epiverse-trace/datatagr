#' Create a datatagr from a data.frame
#'
#' This function converts a `data.frame` or a `tibble` into a `datatagr` object,
#' where data are labelled and validated. The output will seem to be the same
#' `data.frame`, but `datatagr`-aware packages will then be able to
#' automatically use labelled fields for further data cleaning and analysis.
#'
#' @param x a `data.frame` or a `tibble`
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> A named list with variable
#' names in `x` as list names and the labels as list values. Values set to
#' `NULL` remove the label. When specifying labels, please also see
#' `default_values`.
#'
#' @seealso
#'
#' * An overview of the [datatagr] package
#' * [labels()]: for a list of labelled variables in a `datatagr`
#' * [set_labels()]: for modifying labels
#' * [labels_df()]: for selecting variables by labels
#'
#' @export
#'
#' @return The function returns a `datatagr` object.
#'
#' @examples
#'
#' x <- make_datatagr(cars,
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
#' )
#'
#' ## print result - just first few entries
#' head(x)
#'
#' ## check labels
#' labels(x)
#'
#' ## Labels can also be passed as a list with the splice operator (!!!)
#' my_labels <- list(
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
#' )
#' new_x <- make_datatagr(cars, !!!my_labels)
#'
#' ## The output is strictly equivalent to the previous one
#' identical(x, new_x)
#'
make_datatagr <- function(x,
                          ...) {
  # assert inputs
  checkmate::assert_data_frame(x, min.cols = 1)
  assert_not_data_table(x)

  labels <- rlang::list2(...)
  x <- label_variables(x, labels)

  # shape output and return object
  class(x) <- c("datatagr", class(x))
  x
}
