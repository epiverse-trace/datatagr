#' A selector function to use in \pkg{tidyverse} functions
#'
#' @param labels A character vector of labels you want to operate on
#'
#' @returns A numeric vector containing the position of the columns with the
#'   requested labels
#'
#' @note Using this in a pipeline results in a 'safeframe' object, but does not
#'   maintain the variable labels at this time. It is primarily useful to make
#'   your pipelines human readable.
#'
#' @export
#'
#' @examples
#' ## create safeframe
#' x <- make_safeframe(cars,
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
#' )
#' head(x)
#'
#' if (require(dplyr) && require(magrittr)) {
#'   x %>%
#'     select(has_label(c("Miles per hour", "Distance in miles"))) %>%
#'     head()
#' }
has_label <- function(labels) {
  dat <- tidyselect::peek_data(fn = "has_label")
  dat_labels <- labels(dat)

  cols_to_extract <- dat_labels[dat_labels %in% labels]

  which(colnames(dat) %in% names(cols_to_extract))
}
