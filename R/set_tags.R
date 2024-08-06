#' Changes tags of a datatagr object
#'
#' This function changes the `tags` of a `datatagr` object, using the same
#' syntax as the constructor [make_datatagr()]. If some of the default tags are
#' missing, they will be added to the final object.
#'
#' @inheritParams make_datatagr
#'
#' @seealso [make_datatagr()] to create a `datatagr` object
#'
#' @export
#'
#' @return The function returns a `datatagr` object.
#'
#' @examples
#'
#' ## create a datatagr
#' x <- make_datatagr(cars, mph = "speed")
#' tags(x)
#'
#' ## add new tags and fix an existing one
#' x <- set_tags(x, distance = "dist")
#' tags(x)
#'
#' ## remove tags by setting them to NULL
#' old_tags <- tags(x)
#' x <- set_tags(x, mph = NULL, distance = NULL)
#' tags(x)
#'
#' ## setting tags providing a list (used to restore old tags here)
#' x <- set_tags(x, !!!old_tags)
#' tags(x)
set_tags <- function(x, ..., tag_defaults = list(), allow_extra = TRUE) {
  # assert inputs
  checkmate::assertClass(x, "datatagr")
  checkmate::assertLogical(allow_extra)

  old_tags <- attr(x, "tags")
  defaults <- tag_defaults
  new_tags <- rlang::list2(...)

  final_tags <- modify_defaults(defaults, old_tags, strict = FALSE)
  final_tags <- modify_defaults(old_tags, new_tags, strict = !allow_extra)

  tag_variables(x, final_tags)
}
