#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
#' @seealso \code{magrittr::\link[magrittr:pipe]{\%>\%}} for the operator itself.
#' Two vignettes use it in a code chunk to pipe cstidy calls together:
#' \code{vignette("cstidy", package = "cstidy")} and
#' \code{vignette("csfmt_rts_data_v2", package = "cstidy")}.
NULL
