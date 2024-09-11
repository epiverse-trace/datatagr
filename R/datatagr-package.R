#' Base Tools for Labelling and Validating Data
#'
#' The *datatagr* package provides tools to help label and validate data. The
#' 'datatagr' class adds variable level attributes to 'data.frame' columns.
#' Once tagged, these variables can be seamlessly used in downstream analyses,
#' making data pipelines more robust and reliable.
#'
#' @aliases datatagr
#'
#' @section Main functions:
#'
#'   * [make_datatagr()]: to create `datatagr` objects from a `data.frame` or a
#'   `tibble`
#'
#'   * [set_labels()]: to change or add labelled variables in a `datatagr`
#'
#'   * [labels()]: to get the list of labels of a `datatagr`
#'
#'   * [labels_df()]: to get a `data.frame` of all tagged variables
#'
#'   * [lost_labels_action()]: to change the behaviour of actions where labelled
#'   variables are lost (e.g. removing columns storing labelled variables) to
#'   issue warnings, errors, or do nothing
#'
#'   * [get_lost_labels_action()]: to check the current behaviour of actions
#'   where labelled variables are lost
#'
#' @section Dedicated methods:
#'
#'   Specific methods commonly used to handle `data.frame` are provided for
#'   `datatagr` objects, typically to help flag or prevent actions which could
#'   alter or lose labelled variables (and may thus break downstream data
#'   pipelines).
#'
#'   * `names() <-` (and related functions, such as [dplyr::rename()]) will
#'   rename labels as needed
#'
#'   * `x[...] <-` and `x[[...]] <-` (see [sub_datatagr]): will adopt the
#'    desired behaviour when labelled variables are lost
#'
#'   * `print()`: prints info about the `datatagr` in addition to the
#'   `data.frame` or `tibble`
#'
#' @note The package does not aim to have complete integration with \pkg{dplyr}
#' functions. For example, [dplyr::mutate()] and [dplyr::bind_rows()] will
#' not preserve labels. We only provide compatibility for [dplyr::rename()].
#'
#' @examples
#'
#' # using base R style
#' x <- make_datatagr(cars[1:50, ],
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
#' )
#' x
#'
#' ## check labelled variables
#' labels(x)
#'
#' ## robust renaming
#' names(x)[1] <- "identifier"
#' x
#'
#' ## example of dropping labels by mistake - default: warning
#' x[, 2]
#'
#' ## to silence warnings when labels are dropped
#' lost_labels_action("none")
#' x[, 2]
#'
#' ## to trigger errors when labels are dropped
#' # lost_labels_action("error")
#' # x[, 2:5]
#'
#' ## reset default behaviour
#' lost_labels_action()
#'
#' # using tidyverse style
#'
#' ## example of creating a datatagr, adding a new variable, and adding a label
#' ## for it
#'
#' if (require(dplyr) && require(magrittr)) {
#'   x <- cars %>%
#'     tibble() %>%
#'     make_datatagr(
#'       speed = "Miles per hour",
#'       dist = "Distance in miles"
#'     ) %>%
#'     mutate(result = if_else(speed > 50, "fast", "slow")) %>%
#'     set_labels(result = "Ticket yes/no")
#'
#'   head(x)
#'
#'   ## extract labelled variables
#'   x %>%
#'     select(has_label(c("Ticket yes/no")))
#'
#'   ## Retrieve all labels
#'   x %>%
#'     labels()
#'
#'   ## Select based on variable name
#'   x %>%
#'     select(starts_with("speed"))
#' }
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom lifecycle deprecated
## usethis namespace: end
NULL
