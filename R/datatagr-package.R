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
#'   * [make_datatagr()]: to create `datatagr` objects from a `data.frame` or a
#'   `tibble`
#'
#'   * [set_labels()]: to change or add tagged variables in a `datatagr`
#'
#'   * [labels()]: to get the list of labels of a `datatagr`
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
#'   * `x[...] <-` and `x[[...]] <-` (see [sub_datatagr]): will adopt the
#'    desired behaviour when tagged variables are lost
#'
#'   * `print()`: prints info about the `datatagr` in addition to the
#'   `data.frame` or `tibble`
#'
#' @examples
#'
#' # using base R style
#' x <- make_datatagr(cars[1:50, ],
#'   mph = "speed",
#'   distance = "dist"
#' )
#' x
#'
#' ## check tagged variables
#' labels(x)
#'
#' ## robust renaming
#' names(x)[1] <- "identifier"
#' x
#'
#' ## example of dropping tags by mistake - default: warning
#' x[, 2]
#'
#' ## to silence warnings when taggs are dropped
#' lost_tags_action("none")
#' x[, 2]
#'
#' ## to trigger errors when taggs are dropped
#' # lost_tags_action("error")
#' # x[, 2:5]
#'
#' ## reset default behaviour
#' lost_tags_action()
#'
#' # using tidyverse style
#'
#' ## example of creating a datatagr, adding a new variable, and adding a tag
#' ## for it
#'
#' if (require(dplyr) && require(magrittr)) {
#'   x <- cars %>%
#'     tibble() %>%
#'     make_datatagr(
#'       mph = "speed",
#'       distance = "dist"
#'     ) %>%
#'     mutate(result = if_else(speed > 50, "fast", "slow")) %>%
#'     set_labels(ticket = "result")
#'
#'   head(x)
#'
#'   ## extract tagged variables
#'   x %>%
#'     select(has_tag(c("mph", "distance")))
#'
#'   x %>%
#'     labels()
#'
#'   x %>%
#'     select(starts_with("dist"))
#' }
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom lifecycle deprecated
## usethis namespace: end
NULL
