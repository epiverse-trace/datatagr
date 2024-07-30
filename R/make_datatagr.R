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
#'   `tag_name = "column_name"`, where `tag_name` indicates any of the known
#'   variables listed in 'Details' and values indicate their name in `x`; see
#'   details for a list of known variable types and their expected content
#'
#' @param tag_defaults a list of default values for the provided tags. Defaults
#'   to `list()`
#'
#' @param allow_extra a `logical` indicating if additional data tags not
#'   currently recognized by `datatagr` should be allowed; if `FALSE`, unknown
#'   tags will trigger an error
#'
#' @seealso
#'
#' * An overview of the [datatagr] package
#' * [tags_names()]: for a list of known tag names
#' * [tags_types()]: for the associated accepted types/classes
#' * [tags()]: for a list of tagged variables in a `datatagr`
#' * [set_tags()]: for modifying tags
#' * [tags_df()]: for selecting variables by tags
#'
#' @details Known variable types include:
#'
#' * `id`: a unique case identifier as `numeric` or `character`
#'
#' * `date_onset`: date of symptom onset (see below for date formats)
#'
#' * `date_reporting`: date of case notification (see below for date formats)
#'
#' * `date_admission`: date of hospital admission (see below for date formats)
#'
#' * `date_discharge`: date of hospital discharge (see below for date formats)
#'
#' * `date_outcome`: date of disease outcome (see below for date formats)
#'
#' * `date_death`: date of death (see below for date formats)
#'
#' * `gender`: a `factor` or `character` indicating the gender of the patient
#'
#' * `age`: a `numeric` indicating the age of the patient, in years
#'
#' * `location`: a `factor` or `character` indicating the location of the
#'   patient
#'
#' * `occupation`: a `factor` or `character` indicating the professional
#'   activity of the patient
#'
#' * `hcw`: a `logical` indicating if the patient is a health care worker
#'
#' * `outcome`: a `factor` or `character` indicating the outcome of the disease
#'   (death or survival)
#'
#'   Dates can be provided in the following formats/types:
#'
#' * `Date` objects (e.g. using `as.Date` on a `character` with a correct date
#'   format); this is the recommended format
#'
#' * `POSIXct/POSIXlt` objects (when a finer scale than days is needed)
#'
#' * `numeric` values, typically indicating the number of days since the first
#'   case
#'
#' @export
#'
#' @return The function returns a `datatagr` object.
#'
#' @examples
#'
#' x <- make_datatagr(cars,
#'                    age = 'speed',
#'                    distance = 'dist'
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
#'   age = "speed",
#'   distance = "dist"
#' )
#' new_x <- make_datatagr(cars, !!!my_tags)
#'
#' ## The output is strictly equivalent to the previous one
#' identical(x, new_x)
#' 
make_datatagr <- function(x,
                          ...,
                          tag_defaults = list(),
                          allow_extra = TRUE) {
  # assert inputs
  checkmate::assert_data_frame(x, min.cols = 1)
  assert_not_data_table(x)
  checkmate::assert_logical(allow_extra)

  args <- rlang::list2(...)

  tags <- modify_defaults(tag_defaults, args, strict = !allow_extra)

  x <- tag_variables(x, tags)

  # shape output and return object
  class(x) <- c("datatagr", class(x))
  x
}
