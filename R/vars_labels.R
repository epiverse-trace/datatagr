#' Internal printing function for variables and labels
#'
#' @param vars a `character` vector of variable names
#' @param labels a `character` vector of labels
vars_labels <- function(vars, labels) {
  paste(vars,
    labels,
    sep = " - ",
    collapse = "\n "
  )
}
