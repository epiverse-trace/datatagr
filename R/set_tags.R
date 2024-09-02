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
#' x <- make_datatagr(cars, speed = "Miles per hour")
#' labels(x)
#'
#' ## add new tags and fix an existing one
#' x <- set_tags(x, distance = "dist")
#' labels(x)
#'
#' ## remove tags by setting them to NULL
#' old_tags <- tags(x)
#' x <- set_tags(x, mph = NULL, distance = NULL)
#' labels(x)
#'
#' ## setting tags providing a list (used to restore old tags here)
#' x <- set_tags(x, !!!old_tags)
#' labels(x)
set_tags <- function(x, ..., tag_defaults = list()) {
  # assert inputs
  checkmate::assertClass(x, "datatagr")

  old_tags <- attr(x, "tags")
  defaults <- tag_defaults
  new_tags <- rlang::list2(...)

  # keep.null ensures empty tags are kept in the resulting list
  final_tags <- utils::modifyList(defaults, old_tags, keep.null = TRUE)
  final_tags <- utils::modifyList(old_tags, new_tags, keep.null = TRUE)

  label_variables(x, final_tags)
}
