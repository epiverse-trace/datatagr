#' Restore tags of a datatagr
#'
#' Internal. This function is used to restore tags of a `datatagr` object which
#' may have lost its tags after handling e.g. through `dplyr` verbs. Specific
#' actions can be triggered when some of the tagged variables have disappeared
#' from the object.
#'
#' @param x a `data.frame`
#'
#' @param tags a list of tags as returned by [labels()]; if default values are
#'   missing, they will be added to the new list of tags
#'
#' @param lost_action a `character` indicating the behaviour to adopt when
#'   tagged variables have been lost: "error" (default) will issue an error;
#'   "warning" will issue a warning; "none" will do nothing
#'
#' @noRd
#'
#' @seealso [prune_tags()] for removing tags which have lost their variables
#'
#' @return The function returns a `datatagr` object with updated tags.
#'

restore_tags <- function(x, tags,
                         lost_action = c("error", "warning", "none")) {
  # assertions
  checkmate::assertClass(x, "data.frame")
  checkmate::assertClass(tags, "list")
  lost_action <- match.arg(lost_action)

  # actual work
  out <- x
  if (!inherits(out, "datatagr")) {
    class(out) <- c("datatagr", class(out))
  }
  attr(out, "tags") <- tags
  out <- prune_tags(out, lost_action)
  out
}
