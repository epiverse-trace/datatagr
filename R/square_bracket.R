#' Subsetting of datatagr objects
#'
#' The `[]` and `[[]]` operators for `datatagr` objects behaves like for regular
#' `data.frame` or `tibble`, but check that tagged variables are not lost, and
#' takes the appropriate action if this is the case (warning, error, or ignore,
#' depending on the general option set via [lost_tags_action()]) .
#'
#' @inheritParams base::Extract
#' @param x a `datatagr` object
#' @param i a vector of `integer` or `logical` to subset the rows of the
#'   `datatagr`
#' @param j a vector of `character`, `integer`, or `logical` to subset the
#'   columns of the `datatagr`
#' @param drop a `logical` indicating if, when a single column is selected, the
#'   `data.frame` class should be dropped to return a simple vector, in which
#'   case the `datatagr` class is lost as well; defaults to `FALSE`
#' @param value the replacement to be used for the entries identified in `x`
#'
#' @return If no drop is happening, a `datatagr`. Otherwise an atomic vector.
#'
#' @seealso
#' * [lost_tags_action()] to set the behaviour to adopt when tags are
#'   lost through subsetting; default is to issue a warning
#' * [get_lost_tags_action()] to check the current the behaviour
#'
#' @export
#'
#' @rdname sub_datatagr
#'
#' @aliases sub_datatagr
#'
#' @examples
#' if (require(dplyr) && require(magrittr)) {
#'   ## create a datatagr
#'   x <- cars %>%
#'     make_datatagr(
#'       mph = "speed",
#'       distance = "dist"
#'     ) %>%
#'     mutate(result = if_else(speed > 50, "fast", "slow")) %>%
#'     set_tags(ticket = "result")
#'   x
#'
#'   ## dangerous removal of a tagged column setting it to NULL issues a warning
#'   x[, 1] <- NULL
#'   x
#'
#'   x[[2]] <- NULL
#'   x
#'
#'   x$age <- NULL
#'   x
#' }
`[.datatagr` <- function(x, i, j, drop = FALSE) {
  # Strategy for subsetting
  #
  # Subsetting is done using the next method in line, and making post-hoc checks
  # on two things:
  #
  # 1. that the subsetted object is still a `data.frame` or a `tibble`; if not,
  # we automatically drop the `datatagr` class and tags
  # 2. if the output is going to be a `datatagr` we need to restore previous
  # tags with the appropriate behaviour in case of missing tagged variables
  #
  # Note that the [ operator's implementation is messy and does not seem to pass
  # the drop argument well when using NextMethod(); also it does not allow extra
  # args, in case we wanted to use them; so declassing the object instead using
  # the drop_datatagr() function

  lost_action <- get_lost_tags_action()

  # Handle the corner case where only 1 arg is passed (x[i]) to subset by column
  n_args <- nargs() - !missing(drop)

  if (n_args <= 2L) {
    # Avoid "'drop' argument will be ignored" warning in [.data.frame() from our
    # default value. When we subset this way, drop is always considered to be
    # TRUE. We let warnings from user-specified drop values surface.
    if (missing(drop)) {
      out <- drop_datatagr(x)[i]
    } else {
      out <- drop_datatagr(x)[i, drop = drop]
    }
  } else {
    out <- drop_datatagr(x)[i, j, drop = drop]
  }

  # Case 1
  if (is.null(ncol(out))) {
    return(out)
  }

  # Case 2
  old_tags <- tags(x, show_null = TRUE)
  out <- restore_tags(out, old_tags, lost_action)

  out
}

#' @export
#'
#' @rdname sub_datatagr

`[<-.datatagr` <- function(x, i, j, value) {
  lost_action <- get_lost_tags_action()
  out <- NextMethod()
  old_tags <- tags(x, show_null = TRUE)
  out <- restore_tags(out, old_tags, lost_action)
  out
}

#' @export
#'
#' @rdname sub_datatagr

`[[<-.datatagr` <- function(x, i, j, value) {
  lost_action <- get_lost_tags_action()
  out <- NextMethod()
  old_tags <- tags(x, show_null = TRUE)
  out <- restore_tags(out, old_tags, lost_action)
  out
}

#' @export
#'
#' @rdname sub_datatagr
`$<-.datatagr` <- function(x, name, value) {
  lost_action <- get_lost_tags_action()
  out <- NextMethod()
  old_tags <- tags(x, show_null = TRUE)
  out <- restore_tags(out, old_tags, lost_action)
  out
}
