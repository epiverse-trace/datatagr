#' Rename columns of a datatagr
#'
#' This function can be used to rename the columns a `datatagr`, adjusting tags
#' as needed.
#'
#' @param x a `datatagr` object
#'
#' @param value a `character` vector to set the new names of the columns of `x`
#'
#' @return a `datatagr` with new column names
#'
#' @export
#'
#' @examples
#' ## create datatagr
#' x <- make_datatagr(cars,
#'   mph = "speed",
#'   distance = "dist"
#' )
#' head(x)
#'
#' ## change names
#' names(x)[1] <- "speed in miles"
#'
#' ## see results: tags have been updated
#' head(x)
#' tags(x)
#'
#' # This also works with using `dplyr::rename()` because it uses names<-()
#' # under the hood
#' if (require(dplyr) && require(magrittr)) {
#'   x <- x %>%
#'     rename(speed = "speed in miles")
#'   head(x)
#'   tags(x)
#' }
`names<-.datatagr` <- function(x, value) {
  # Strategy for renaming

  # Since renaming cannot drop columns, we can update tags to match new variable
  # names. We do this by:

  # 1. Storing old names and new names to have define replacement rules
  # 2. Replace all tagged variables using the replacement rules

  out <- drop_datatagr(x, remove_tags = TRUE)
  names(out) <- value

  # Step 1
  old_names <- names(x)
  new_names <- names(out)
  if (anyNA(new_names)) {
    stop(
      "Suggested naming would result in `NA` for some column names.\n",
      "Did you provide less names than columns targetted for renaming?",
      call. = FALSE
    )
  }

  # Step 2
  out_tags <- tags(x, TRUE)
  for (i in seq_along(out_tags)) {
    if (!is.null(out_tags[[i]])) {
      idx <- match(out_tags[[i]], old_names)
      out_tags[[i]] <- new_names[idx]
    }
  }

  attr(out, "tags") <- out_tags
  class(out) <- class(x)
  out
}
