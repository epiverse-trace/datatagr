.onLoad <- function(libname, pkgname) {
  lost_labels_action(Sys.getenv("DATATAGR_LOST_ACTION", "warning"),
                     quiet = TRUE)
}
