#' Extract tagged variables of a datatagr object
#'
#' @keywords deprecated
#' @description
#' `r lifecycle::badge("deprecated")`

#' This function was  equivalent to running successively [tags_df()] and
#' [dplyr::select()] on a `datatagr` object.
#' To encourage users to understand what is going on and in order to follow the
#' software engineering good practice of providing just one way to do a given
#' task, this function is now deprecated.
#'
#' @param x a `datatagr` object
#'
#' @param ... the tagged variables to select, using [dplyr::select()] compatible
#'   terminology; see [tags_names()] for default values
#'
#' @return A `data.frame` of tagged variables.
#'
#' @export
#'
#' @seealso
#' * [tags()] for existing tags in a `datatagr`
#' * [tags_df()] to get a `data.frame` of all tags
#'
#' @examples
#' if (require(outbreaks)) {
#'   ## dataset we'll create a datatagr from
#'   measles_hagelloch_1861
#'
#'   ## create datatagr
#'   x <- make_datatagr(measles_hagelloch_1861,
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'   head(x)
#'
#'   ## check tagged variables
#'   tags(x)
#'
#'   # DEPRECATED!
#'   select_tags(x, "gender", "age")
#'
#'   # Instead, use:
#'   library(dplyr)
#'   x %>%
#'     tags_df() %>%
#'     select(gender, age)
#' }
#'
select_tags <- function(x, ...) {
  lifecycle::deprecate_warn(
    "1.0.0",
    "select_tags()",
    details =
      paste(
        "This function is deprecated:",
        "use the two step `tags_df()` and `dplyr::select()` process instead"
      )
  )

  df <- tags_df(x)
  dplyr::select(df, ...)
}
