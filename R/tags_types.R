#' List acceptable variable types for tags
#'
#' This function returns a named list providing the acceptable data types for
#' the default tags. If no argument is provided, it returns default
#' values. Otherwise, provided values will be used to define the defaults.
#'
#' @export
#'
#' @inheritParams make_datatagr
#'
#' @return A named `list`.
#'
#' @seealso
#' * [validate_types()] uses [tags_types()] for validating tags
#' * [validate_datatagr()] uses [tags_types()] for validating tags
#'
#' @examples
#' # list default values
#' tags_types()
#'
#' # change existing values
#' tags_types(date_onset = "Date") # impose a Date class
#'
#' # add new types e.g. to allow genetic sequences using ape's format
#' tags_types(sequence = "DNAbin", allow_extra = TRUE)
#'
tags_types <- function(..., allow_extra = TRUE) {
  defaults <- list()

  new_values <- rlang::list2(...)
  checkmate::assert_list(new_values, types = "character")

  # keep.null ensures empty tags are kept in the resulting list
  utils::modifyList(defaults, new_values, keep.null = TRUE)
}
