.onLoad <- function(libname, pkgname) {
  lost_labels_action(Sys.getenv("SAFEFRAME_LOST_ACTION", "warning"),
    quiet = TRUE
  )
}
