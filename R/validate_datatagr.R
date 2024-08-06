#' Checks the content of a datatagr object
#'
#' This function evaluates the validity of a `datatagr` object by checking the
#' object class, its tags, and the types of the tagged variables. It combines
#' validations checks made by [validate_types()] and [validate_tags()]. See
#' 'Details' section for more information on the checks performed.
#'
#' @details The following checks are performed:
#'
#' * `x` is a `datatagr` object
#' * `x` has a well-formed `tags` attribute
#' * all default tags are present (even if `NULL`)
#' * all tagged variables correspond to existing columns
#' * all tagged variables have an acceptable class
#' * (optional) `x` has no extra tag beyond the default tags
#'
#' @export
#'
#' @param x a `datatagr` object
#'
#' @inheritParams validate_types
#'
#' @inheritParams set_tags
#'
#' @return If checks pass, a `datatagr` object; otherwise issues an error.
#'
#' @seealso
#' * [tags_types()] to change allowed types
#' * [validate_types()] to check if tagged variables have the right classes
#' * [validate_tags()] to perform a series of checks on the tags
#'
#' @examples
#'
#' if (require(magrittr)) {
#'   ## create a valid datatagr
#'   x <- cars %>%
#'     make_datatagr(
#'       mph = "speed",
#'       distance = "dist"
#'     )
#'   x
#'
#'   ## validation
#'   validate_datatagr(x, ref_types = tags_types(
#'     mph = c("numeric", "factor"),
#'     distance = "numeric"
#'   ))
#'
#'   ## the below issues an error
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_datatagr(x, ref_types = tags_types(
#'     mph = c("numeric", "factor"),
#'     distance = "factor"
#'   )), error = paste)
#' }
validate_datatagr <- function(x,
                              ref_types = tags_types()) {
  checkmate::assert_class(x, "datatagr")
  validate_tags(x)
  validate_types(x, ref_types)

  x
}
