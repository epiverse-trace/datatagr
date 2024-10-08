#' Type Selection Helper
#'
#' Function to swiftly provide access to generic categories of types within R.
#' These can be used to provide comprehensive typesetting when creating a
#' `datatagr` object.
#'
#' @param x Character indicating the desired type. Options include `date`,
#' `category`, `numeric`, `binary` at this time.
#'
#' @return A vector of classes
#' @export
#'
#' @examples
#' x <- make_datatagr(cars,
#'   speed = "Miles per hour",
#'   dist = "Distance in miles"
#' )
#'
#' validate_types(
#'   x,
#'   speed = type("numeric"),
#'   dist = "numeric"
#' )
#'
type <- function(x) {
  # ensure case insensitivity
  x <- tolower(x)

  checkmate::assert_string(x)
  checkmate::assert_choice(x,
    choices = c("date", "category", "numeric", "binary")
  )

  switch(x,
    date = c("integer", "numeric", "Date", "POSIXct", "POSIXlt"),
    category = c("character", "factor"),
    numeric = c("numeric", "integer"),
    binary = c("logical", "integer", "character", "factor")
  )
}
