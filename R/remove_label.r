#' Internal. Remove the "label" attribute from a specific variable in a data frame
#' 
#' @noRd
#' 
remove_label <- function(x, var) {
    attr(x[[var]], "label") <- NULL
  x
}