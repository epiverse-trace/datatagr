#' Checks the tags of a datatagr object
#'
#' This function evaluates the validity of the tags of a `datatagr` object by
#' checking that: i) tags are present ii) tags is a `list` of `character` iii)
#' that all default tags are present iv) tagged variables exist.
#'
#' @export
#'
#' @param x a `datatagr` object
#'
#' @return If checks pass, a `datatagr` object; otherwise issues an error.
#'
#' @seealso [validate_types()] to check if tagged variables have
#'   the right classes
#'
#' @examples
#' if (require(dplyr) && require(magrittr)) {
#'   ## create a valid datatagr
#'   x <- cars %>%
#'     make_datatagr(
#'       mph = "speed",
#'       distance = "dist"
#'     )
#'   x
#'
#'   ## the below issues an error as datatagr doesn't know any defaults
#'   ## note: tryCatch is only used to avoid a genuine error in the example
#'   tryCatch(validate_datatagr(x), error = paste)
#'
#'   ## validation requires you to specify the types directly
#'   validate_datatagr(x, ref_types = tags_types(
#'     mph = c("integer", "numeric"),
#'     distance = "numeric"
#'   ))
#' }
validate_tags <- function(x) {
  checkmate::assert_class(x, "datatagr")
  x_tags <- tags(x, show_null = TRUE)

  stopifnot(
    "`x` has no tags attribute" = !is.null(x_tags)
  )

  # check that x is a list, and each tag is a `character`
  checkmate::assert_list(x_tags, types = c("character", "null"))

  # check that tagged variables exist
  x_tags_vec <- unlist(tags(x))
  var_exists <- x_tags_vec %in% names(x)
  if (!all(var_exists)) {
    missing_var <- x_tags_vec[!var_exists]
    stop(
      "The following tagged variables are missing:\n",
      paste0(names(missing_var), ":", missing_var, collapse = ", "),
      call. = FALSE
    )
  }

  x
}
