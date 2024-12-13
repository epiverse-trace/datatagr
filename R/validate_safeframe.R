#' Checks the content of a safeframe object
#'
#' This function evaluates the validity of a `safeframe` object by checking the
#' object class, its labels, and the types of variables. It combines
#' validation checks made by [validate_types()] and [validate_labels()]. See
#' 'Details' section for more information on the checks performed.
#'
#' @details The following checks are performed:
#'
#' * `x` is a `safeframe` object
#' * variables in `x` have a well-formed `label` attribute
#' * variables correspond to the specified types
#'
#' @export
#'
#' @inheritParams validate_types
#'
#' @inheritParams set_labels
#'
#' @return If checks pass, a `safeframe` object; otherwise issues an error.
#'
#' @seealso
#' * [validate_types()] to check if variables have the right types
#' * [validate_labels()] to perform a series of checks on the tags
#'
#' @examples
#'
#' ## create a valid safeframe
#' x <- cars |>
#'   make_safeframe(
#'     speed = "Miles per hour",
#'     dist = "Distance in miles"
#'   )
#' x
#'
#' ## validation
#' validate_safeframe(x,
#'   speed = c("numeric", "factor"),
#'   dist = "numeric"
#' )
#'
#' ## the below issues an error
#' ## note: tryCatch is only used to avoid a genuine error in the example
#' tryCatch(validate_safeframe(x,
#'   speed = c("numeric", "factor"),
#'   dist = "factor"
#' ), error = paste)
validate_safeframe <- function(x,
                               ...) {
  checkmate::assert_class(x, "safeframe")
  validate_labels(x)
  validate_types(x, ...)

  x
}
