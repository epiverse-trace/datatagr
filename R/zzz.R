.onLoad <- function(libname, pkgname) {
  lost_tags_action(Sys.getenv("DATATAGR_LOST_ACTION", "warning"), quiet = TRUE)
}
