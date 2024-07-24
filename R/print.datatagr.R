#' Printing method for datatagr objects
#'
#' This function prints datatagr objects.
#'
#' @param x a `datatagr` object
#'
#' @param ... further arguments to be passed to 'print'
#'
#' @return Invisibly returns the object.
#'
#' @export
#'
#' @examples
#' if (require(outbreaks)) {
#'   ## dataset we'll create a datatagr from
#'   measles_hagelloch_1861
#'
#'   ## create datatagr
#'   x <- make_datatagr(measles_hagelloch_1861,
#'     id = "case_ID",
#'     date_onset = "date_of_prodrome",
#'     age = "age",
#'     gender = "gender"
#'   )
#'
#'   ## print object - using only the first few entries
#'   head(x)
#'
#'   # version with a tibble
#'   if (require(tibble) && require(magrittr)) {
#'     measles_hagelloch_1861 %>%
#'       tibble() %>%
#'       make_datatagr(
#'         id = "case_ID",
#'         date_onset = "date_of_prodrome",
#'         age = "age",
#'         gender = "gender"
#'       )
#'   }
#' }
print.datatagr <- function(x, ...) {
  cat("\n// datatagr object\n")
  print(drop_datatagr(x, remove_tags = TRUE))
  tags_txt <- paste(names(tags(x)), unlist(tags(x)), sep = ":", collapse = ", ")
  if (tags_txt == "") {
    tags_txt <- "[no tagged variable]"
  }
  cat("\n// tags:", tags_txt, "\n")
  invisible(x)
}
