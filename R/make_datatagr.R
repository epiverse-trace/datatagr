#' Create a datatagr from a data.frame
#'
#' This function converts a `data.frame` or a `tibble` into a `datatagr` object,
#' where data are tagged. The output will seem to be the same `data.frame`, but
#' `datatagr`-aware packages will then be able to automatically use tagged
#' fields for further data cleaning and analysis.
#'
#' @param x a `data.frame` or a `tibble`
#'
#' @param ... <[`dynamic-dots`][rlang::dyn-dots]> A series of tags provided as
#'   `tag_name = "column_name"`. When specifying tags, please also see
#'   `tag_defaults` to specify default values.
#'
#' @param tag_defaults a list of default values for the provided tags. Defaults
#'   to `list()`, effectively defaulting to NULL values.
#'
#' @seealso
#'
#' * An overview of the [datatagr] package
#' * [tags_types()]: for the associated accepted types/classes
#' * [tags()]: for a list of tagged variables in a `datatagr`
#' * [set_tags()]: for modifying tags
#' * [tags_df()]: for selecting variables by tags
#'
#' @export
#'
#' @return The function returns a `datatagr` object.
#'
#' @examples
#'
#' x <- make_datatagr(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#'
#' ## print result - just first few entries
#' head(x)
#'
#' ## check tags
#' tags(x)
#'
#' ## Tags can also be passed as a list with the splice operator (!!!)
#' my_tags <- list(
#'   mph = "speed",
#'   distance = "dist"
#' )
#' new_x <- make_datatagr(cars, !!!my_tags)
#'
#' ## The output is strictly equivalent to the previous one
#' identical(x, new_x)
#'
make_datatagr <- function(x,
                          ...,
                          tag_defaults = list()) {
  # assert inputs
  checkmate::assert_data_frame(x, min.cols = 1)
  assert_not_data_table(x)

  args <- rlang::list2(...)

  # keep.null ensures empty tags are kept in the resulting list
  tags <- utils::modifyList(tag_defaults, args, keep.null = TRUE)

  x <- tag_variables(x, tags)

  # shape output and return object
  class(x) <- c("datatagr", class(x))
  x
}
