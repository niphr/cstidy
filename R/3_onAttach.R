#' @import data.table ggplot2
.onAttach <- function(libname, pkgname) {
  version <- tryCatch(
    utils::packageDescription("cstidy", fields = "Version"),
    warning = function(w) {
      1
    }
  )

  packageStartupMessage(paste0(
    "cstidy ",
    version,
    "\n",
    "https://niphr.github.io/cstidy/"
  ))
}

dummy_function <- function() {
  cstime::isoyearweek_to_isoweek_c("2021-01")
}
