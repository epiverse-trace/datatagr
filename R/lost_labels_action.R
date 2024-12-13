#' Check and set behaviour for lost labels
#'
#' This function determines the behaviour to adopt when labelled variables of a
#' `safeframe` are lost for example through subsetting. This is achieved using
#' `options` defined for the `safeframe` package.
#'
#' @param action a `character` indicating the behaviour to adopt when labelled
#'   variables have been lost: "error" (default) will issue an error; "warning"
#'   will issue a warning; "none" will do nothing
#'
#' @param quiet a `logical` indicating if a message should be displayed; only
#'   used outside pipelines
#'
#' @return returns `NULL`; the option itself is set in `options("safeframe")`
#'
#' @details The errors or warnings generated by safeframe in case of labelled
#' variable loss has a custom class of `safeframe_error` and `safeframe_warning`
#' respectively.
#'
#' @export
#'
#' @rdname lost_labels_action
#'
#' @aliases lost_labels_action get_lost_labels_action
#'
#' @examples
#' # reset default - done automatically at package loading
#' lost_labels_action()
#'
#' # check current value
#' get_lost_labels_action()
#'
#' # change to issue errors when tags are lost
#' lost_labels_action("error")
#' get_lost_labels_action()
#'
#' # change to ignore when tags are lost
#' lost_labels_action("none")
#' get_lost_labels_action()
#'
#' # reset to default: warning
#' lost_labels_action()
#'
lost_labels_action <- function(action = c("warning", "error", "none"),
                               quiet = FALSE) {
  safeframe_options <- options("safeframe")$safeframe

  action <- match.arg(action)
  safeframe_options$lost_labels_action <- action
  options(safeframe = safeframe_options)
  if (!quiet) {
    if (action == "warning") msg <- "Lost labels will now issue a warning."
    if (action == "error") msg <- "Lost labels will now issue an error."
    if (action == "none") msg <- "Lost labels will now be ignored."
    message(msg)
  }
  return(invisible(NULL))
}



#' @export
#'
#' @rdname lost_labels_action

get_lost_labels_action <- function() {
  options("safeframe")$safeframe$lost_labels_action
}
