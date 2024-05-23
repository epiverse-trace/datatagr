#' Base Tools for Tagging and Validating Data
#'
#' The *datatagr* package provides tools to help tag and validate data. The
#' 'datatagr' class adds a custom tagging system to classical 'data.frame'
#' objects to identify key data. Once tagged, these variables can be seamlessly
#' used in downstream analyses, making data pipelines more robust and reliable.
#'
#' @aliases datatagr
#'
#' @section Main functions:
#'
#'   * [make_linelist()]: to create `datatagr` objects from a `data.frame` or a
#'   `tibble`
#'
#'   * [set_tags()]: to change or add tagged variables in a `datatagr`
#'
#'   * [tags()]: to get the list of tags of a `datatagr`
#'
#'   * [tags_df()]: to get a `data.frame` of all tagged variables
#'
#'   * [lost_tags_action()]: to change the behaviour of actions where tagged
#'   variables are lost (e.g. removing columns storing tagged variables) to
#'   issue warnings, errors, or do nothing
#'
#'   * [get_lost_tags_action()]: to check the current behaviour of actions where
#'   tagged variables are lost
#'
#' @section Dedicated methods:
#'
#'   Specific methods commonly used to handle `data.frame` are provided for
#'   `datatagr` objects, typically to help flag or prevent actions which could
#'   alter or lose tagged variables (and may thus break downstream data
#'   pipelines).
#'
#'   * `names() <-` (and related functions, such as [dplyr::rename()]) will
#'   rename tags as needed
#'
#'   * `x[...] <-` and `x[[...]] <-` (see [sub_linelist]): will adopt the
#'    desired behaviour when tagged variables are lost
#'
#'   * `print()`: prints info about the `datatagr` in addition to the
#'   `data.frame` or `tibble`
#'
#' @examples
#'
#' if (require(outbreaks)) {
#'   # using base R style
#'
#'   ## dataset we'll create a linelist from, only using the first 50 entries
#'   measles_hagelloch_1861[1:50, ]
#'
#'   ## create linelist
#'   x <- make_linelist(measles_hagelloch_1861[1:50, ],
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'   x
#'
#'   ## check tagged variables
#'   tags(x)
#'
#'   ## robust renaming
#'   names(x)[1] <- "identifier"
#'   x
#'
#'   ## example of dropping tags by mistake - default: warning
#'   x[, 2:5]
#'
#'   ## to silence warnings when taggs are dropped
#'   lost_tags_action("none")
#'   x[, 2:5]
#'
#'   ## to trigger errors when taggs are dropped
#'   # lost_tags_action("error")
#'   # x[, 2:5]
#'
#'   ## reset default behaviour
#'   lost_tags_action()
#'
#'
#'   # using tidyverse style
#'
#'   ## example of creating a linelist, adding a new variable, and adding a tag
#'   ## for it
#'
#'   if (require(dplyr) && require(magrittr)) {
#'     x <- measles_hagelloch_1861 %>%
#'       tibble() %>%
#'       make_linelist(
#'         id = "case_ID",
#'         date_onset = "date_of_prodrome",
#'         age = "age",
#'         gender = "gender"
#'       ) %>%
#'       mutate(result = if_else(is.na(date_of_death), "survived", "died")) %>%
#'       set_tags(outcome = "result") %>%
#'       rename(identifier = case_ID)
#'
#'     head(x)
#'
#'     ## extract tagged variables
#'     x %>%
#'       select(has_tag(c("gender", "age")))
#'
#'     x %>%
#'       tags()
#'
#'     x %>%
#'       select(starts_with("date"))
#'   }
#' }
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom lifecycle deprecated
## usethis namespace: end
NULL
