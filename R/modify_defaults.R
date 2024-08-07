#' Modify defaults in a list
#'
#' Internal function. This is used to modify default values provided in a named
#' list.
#'
#' @author Code by Rich FitzJohn borrowed from outbreaker2
#'
#' @param defaults a named list of default values
#'
#' @param x a named list of modified values, to replace the defaults
#'
#' @param strict a `logical` indicating if allowed modification should be
#'   restricted to variables existing in the defaults (`TRUE`); if `FALSE`, new
#'   variables will allowed and added to the output
#'
#' @noRd
#'
#' @return A named `list`.

modify_defaults <- function(defaults, x, strict = TRUE) {
  extra <- setdiff(names(x), names(defaults))
  if (strict && (length(extra) > 0L)) {
    stop(
      "Unknown variable types: ",
      toString(extra),
      "\n  ",
      "Use only known tags or set `allow_extra = TRUE`",
      call. = FALSE
    )
  }
  utils::modifyList(defaults, x, keep.null = TRUE) # keep.null is needed here
}
