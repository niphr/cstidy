# csfmt_rts_data_v3: the clean csfmt.
#
# Same unified format as v2 (16 time/geo columns), and it REUSES v2's healing
# machinery -- but it drops the two things that make v2 painful:
#   1. NO self-healing `[` override. v2 intercepts every subset/assignment and
#      runs deparse + regex + glue + eval(parse()) codegen to re-derive time/geo
#      columns. v3 has no `[` method, so `:=` keeps the class with zero healing
#      cost, and a subset returns a plain data.table (re-class explicitly). Healing
#      is EXPLICIT: call set_csfmt_rts_data_v3() / heal() when you want it. (As a
#      bonus, v3's own heal is faster, since its internal `[` calls no longer
#      trigger the codegen recursively.)
#   2. POSITIONAL time_series_id. v2's unique_time_series assigns 1:.N; v3 uses a
#      content hash (xxhash64 of the identity columns) -- stable across objects
#      and subsets.

formats$csfmt_rts_data_v3 <- list()
# Weekly-only column set: v2 minus the quarterly/monthly columns (isoquarter,
# isoyearquarter, calyear, calmonth, calyearmonth), the vestigial `border`, and
# `granularity_time` (always "isoyearweek" here -- the class carries that).
formats$csfmt_rts_data_v3$unified <- formats$csfmt_rts_data_v2$unified[c(
  "granularity_geo", "country_iso3", "location_code", "age", "sex",
  "isoyear", "isoweek", "isoyearweek", "season", "seasonweek", "date"
)]

#' @method heal csfmt_rts_data_v3
#' @export
heal.csfmt_rts_data_v3 <- function(x, ...) {
  location_code <- granularity_geo <- country_iso3 <- NULL

  # v3 is WEEKLY-ONLY: one heal path, isoyearweek -> derived time columns.
  # (Daily/monthly/etc. data stays on csfmt_rts_data_v2; coexistence by design.)
  if (!"isoyearweek" %in% names(x)) stop("csfmt_rts_data_v3 requires an isoyearweek column")

  idx <- which(!is.na(x$isoyearweek))
  if (length(idx)) {
    derived <- heal_time_csfmt_rts_data_v2(x$isoyearweek[idx], names(x),
                                           granularity_time = "isoyearweek")
    for (cc in names(derived)) if (cc %in% names(x))
      data.table::set(x, i = idx, j = cc, value = derived[[cc]])
  }

  # geo columns from location_code
  if ("location_code" %in% names(x)) {
    if ("granularity_geo" %in% names(x))
      x[!is.na(location_code),
        granularity_geo := csdata::location_code_to_granularity_geo(location_code)]
    if ("country_iso3" %in% names(x))
      x[!is.na(location_code),
        country_iso3 := csdata::location_code_to_iso3(location_code)]
  }

  data.table::shouldPrint(x)
  invisible(x)
}

#' @method assert_classes csfmt_rts_data_v3
#' @export
assert_classes.csfmt_rts_data_v3 <- function(x, ...) {
  assert_classes.csfmt_rts_data_v2(x, ...)
}

#' @method create_unified_columns csfmt_rts_data_v3
#' @export
create_unified_columns.csfmt_rts_data_v3 <- function(x, ...) {
  fmt <- attr(x, "format_unified")
  for (i in names(fmt)) if (!i %in% names(x)) x[, (i) := fmt[[i]]$NA_class]
  data.table::setcolorder(x, names(fmt))
  heal.csfmt_rts_data_v3(x)
  data.table::shouldPrint(x)
  invisible(x)
}

#' Convert a data.table to csfmt_rts_data_v3 (clean csfmt; explicit healing)
#'
#' Same unified columns as \code{\link{set_csfmt_rts_data_v2}}, but without the
#' self-healing `[` override (healing is explicit) and with a content-hash
#' \code{time_series_id}.
#' @param x The data.table to convert (by reference).
#' @param create_unified_columns Create the unified columns?
#' @param heal Derive the missing time and geography columns on creation? These are deterministically looked up from `isoyearweek` and `location_code`; nothing is statistically imputed and no count is invented.
#' @returns x, modified by reference, invisibly.
#' @family csfmt_rts_data
#' @export
set_csfmt_rts_data_v3 <- function(x, create_unified_columns = TRUE, heal = TRUE) {
  if (!data.table::is.data.table(x)) stop("x must be data.table. Run setDT(x).")
  data.table::setattr(x, "format_unified", formats$csfmt_rts_data_v3$unified)
  data.table::setattr(x, "class", unique(c("csfmt_rts_data_v3", class(x))))
  if (create_unified_columns) create_unified_columns.csfmt_rts_data_v3(x)
  if (heal) heal.csfmt_rts_data_v3(x)
  invisible(x)
}

#' @rdname set_csfmt_rts_data_v3
#' @returns A new csfmt_rts_data_v3 (not by reference).
#' @export
csfmt_rts_data_v3 <- function(x, create_unified_columns = TRUE, heal = TRUE) {
  y <- data.table::copy(x)
  set_csfmt_rts_data_v3(y, create_unified_columns, heal)
  y
}

#' @method unique_time_series csfmt_rts_data_v3
#' @export
unique_time_series.csfmt_rts_data_v3 <- function(x, set_time_series_id = FALSE, ...) {
  time_series_id <- NULL
  ids <- unique(c(
    "granularity_time", "granularity_geo", "country_iso3", "location_code",
    "border", "age", "sex",
    stringr::str_subset(names(x), "_id$"),
    stringr::str_subset(names(x), "_tag$")
  ))
  ids <- ids[ids %in% names(x)]
  retval <- unique(remove_class_csfmt_rts_data(x[, ids, with = FALSE]))
  data.table::shouldPrint(retval)

  if ("time_series_id" %in% names(retval)) return(retval)

  key <- retval[, do.call(paste, c(.SD, sep = "")), .SDcols = ids]
  retval[, time_series_id := vapply(
    key, function(k) digest::digest(k, algo = "xxhash64"), character(1))]
  if (set_time_series_id) {
    x[retval, on = ids, time_series_id := time_series_id]
    data.table::shouldPrint(x)
  }
  retval
}
