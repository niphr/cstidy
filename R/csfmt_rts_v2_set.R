# The constructors and the summary method for the csfmt_rts_data_v2
# format.
#
# The format definition is in "csfmt_rts_v2.R". See that file for the load
# order this directory needs.

#' Convert data.table to csfmt_rts_data_v2 (deprecated)
#'
#' @description
#' \code{set_csfmt_rts_data_v2} converts a \code{data.table} to \code{csfmt_rts_data_v2} by reference.
#' \code{csfmt_rts_data_v2} creates a new \code{csfmt_rts_data_v2} (not by reference) from a \code{data.table}.
#' Both stop with an error when \code{x} is not a \code{data.table}; call \code{data.table::setDT()} first.
#'
#' @section Smart assignment:
#' \code{csfmt_rts_data_v2} contains the smart assignment feature for time and geography.
#'
#' When the **variables in bold** are assigned using `:=`, the listed variables are automatically re-derived from it. This is deterministic derivation from a calendar and a geography lookup, not statistical imputation.
#'
#' **location_code**:
#' - granularity_geo
#' - country_iso3
#'
#' **isoyear**:
#' - granularity_time
#' - isoweek
#' - isoyearweek
#' - isoquarter
#' - isoyearquarter
#' - season
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#' - date
#'
#' **isoyearweek**:
#' - granularity_time
#' - isoyear
#' - isoweek
#' - isoquarter
#' - isoyearquarter
#' - season
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#' - date
#'
#' **season**:
#' - granularity_time
#' - isoyear
#' - isoweek
#' - isoyearweek
#' - isoquarter
#' - isoyearquarter
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#' - date
#'
#' **date**:
#' - granularity_time
#' - isoyear
#' - isoweek
#' - isoyearweek
#' - isoquarter
#' - isoyearquarter
#' - season
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#'
#' @section Unified columns:
#' \code{csfmt_rts_data_v2} contains 18 unified columns:
#' - granularity_time
#' - granularity_geo
#' - country_iso3
#' - location_code
#' - border
#' - age
#' - sex
#' - isoyear
#' - isoweek
#' - isoyearweek
#' - isoquarter
#' - isoyearquarter
#' - season
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#' - date
#'
#' @details
#' For more details see the vignette:
#' \code{vignette("csfmt_rts_data_v2", package = "cstidy")}
#'
#' @return An extended \code{data.table}, which has been modified by reference and returned (invisibly).
#'
#' @param x The data.table to be converted to csfmt_rts_data_v2
#' @param create_unified_columns Do you want it to create unified columns?
#' @param heal Derive the missing time and geography columns on creation? These are deterministically looked up from the time and location columns you supply (see `cstime` and `csdata`). Nothing is statistically imputed and no count is invented. Time healing reads `granularity_time` to decide which time column the others are derived from, so supply it.
#' @examples
#' # Create some fake data as data.table
#' d <- cstidy::generate_test_data(fmt = "csfmt_rts_data_v2")
#' d <- d[1:5]
#'
#' # convert to csfmt_rts_data_v2 by reference
#' cstidy::set_csfmt_rts_data_v2(d, create_unified_columns = TRUE)
#'
#' #
#' d[1, isoyearweek := "2021-01"]
#' d
#' d[2, isoyear := 2019]
#' d
#' d[3, date := as.Date("2020-01-01")]
#' d
#' d[4, c("isoyear", "isoyearweek") := .(2021, "2021-01")]
#' d
#' d[5, c("location_code") := .("norge")]
#' d
#'
#' # Investigating the data structure of one column inside a dataset
#' cstidy::generate_test_data() |>
#'   cstidy::set_csfmt_rts_data_v2() |>
#'   cstidy::identify_data_structure("deaths_n") |>
#'   plot()
#' # Investigating the data structure via summary
#' cstidy::generate_test_data() |>
#'   cstidy::set_csfmt_rts_data_v2() |>
#'   summary()
#' @section Deprecated:
#' `csfmt_rts_data_v2` is deprecated as a direction of travel, not because a
#' finished replacement exists. The format still works, nothing warns at run
#' time, and nothing has been removed. \code{\link{set_csfmt_rts_data_v3}()} is
#' what new work should target, subject to three limits that were measured
#' rather than estimated.
#'
#' First, v3 derives fewer columns than v2, but drops none. Counted on the
#' unified set, v2 derives 18 columns and v3 derives 11. The unified set is
#' \code{names(attr(x, "format_unified"))}, the columns each format creates when
#' the input lacks them. The seven columns in v2's unified set and not in v3's
#' are `granularity_time`, `border`, `isoquarter`, `isoyearquarter`, `calyear`,
#' `calmonth` and `calyearmonth`. Deriving and keeping are different things.
#' \code{\link{set_csfmt_rts_data_v3}()} removes no column. An existing v2
#' object converted to v3 keeps every column it had, `granularity_time` and
#' `border` included. v3 healing still refreshes `isoquarter` and
#' `isoyearquarter` when the columns are present. What a move to v3 costs is
#' the guarantee. A v3 table built from an input that lacks those columns will
#' not have them, where the same input under v2 would.
#'
#' Second, v3 is weekly-only, and that is what costs you the calendar columns.
#' \code{heal.csfmt_rts_data_v3()} derives from `isoyearweek` alone. The
#' isoyearweek lookup holds no calendar values at all. `calyear`, `calmonth`
#' and `calyearmonth` are NA for all 7829 rows of the isoyearweek lookup, under
#' v2 as much as under v3. So no v3 table can populate them. Heal from `date`
#' under v2 if you aggregate by calendar month or calendar year. A daily table
#' converted to v3 keeps its `date` values and gets nothing else healed.
#'
#' Third, `csdb` cannot CHECK a v3 table, though it can store one. `csdb`
#' exports `validator_field_types_csfmt_rts_data_v1()` and
#' `validator_field_types_csfmt_rts_data_v2()` and has no v3 equivalent, so a v3
#' column set fails both. The validator is an ordinary argument to
#' `csdb::DBTable_v9$new()`: pass `validator_field_types_blank()`, or a function
#' of your own, and the table writes. What you lose is the column check, not the
#' ability to store.
#'
#' So continue with v2 in any of these three cases:
#'
#' - The data covers a granularity other than isoyearweek.
#' - The data must derive a calendar or quarterly column that the input does
#'   not carry.
#' - `csdb` must validate the shape of the data on the way in.
#' @family csfmt_rts_data
#' @family csfmt format converters
#' @seealso Two vignettes run \code{set_csfmt_rts_data_v2()} in a code chunk:
#' \code{vignette("cstidy", package = "cstidy")} and
#' \code{vignette("csfmt_rts_data_v2", package = "cstidy")}. Neither of them
#' runs \code{csfmt_rts_data_v2()}.
#' @export
set_csfmt_rts_data_v2 <- function(
  x,
  create_unified_columns = TRUE,
  heal = TRUE
) {
  if (!is.data.table(x)) {
    stop("x must be data.table. Run setDT('x').")
  }

  fmt <- formats$csfmt_rts_data_v2$unified
  setattr(x, "format_unified", fmt)
  setattr(x, "class", unique(c("csfmt_rts_data_v2", class(x))))

  if (create_unified_columns) {
    create_unified_columns.csfmt_rts_data_v2(x)
  }

  if (heal) {
    heal.csfmt_rts_data_v2(x)
  }

  return(invisible(x))
}

#' @rdname set_csfmt_rts_data_v2
#' @returns Returns a duplicated csfmt_rts_data_v2.
#' @export
csfmt_rts_data_v2 <- function(x, create_unified_columns = TRUE, heal = TRUE) {
  y <- copy(x)
  set_csfmt_rts_data_v2(
    y,
    create_unified_columns,
    heal
  )

  return(y)
}

#' @section Deprecated:
#' This method is deprecated along with the `csfmt_rts_data_v2` format it
#' dispatches on. Nothing warns at run time. See
#' \code{\link{set_csfmt_rts_data_v2}()}.
#' @method summary csfmt_rts_data_v2
#' @returns No return value, called for side effect of printing a summary of the object.
#' @export
summary.csfmt_rts_data_v2 <- function(object, ...) {
  . <- NULL
  val <- NULL
  len <- NULL
  max_len <- NULL
  n <- NULL
  dicsay <- NULL
  time_series_id <- NULL

  # validate
  validate(object)
  status <- attr(object, "status")

  for (i in names(status)) {
    status_i <- status[[i]]

    cat("\n", crayon::underline(i), "\n", sep = "")
    cat(status_i$errors, "\n", sep = "")
  }

  # details
  for (i in seq_len(ncol(object))) {
    var <- names(object)[i]
    details <- ""
    if (
      var %in%
        c(
          "granularity_time",
          "granularity_geo",
          "country_iso3",
          # "location_code",
          "border",
          "age",
          "sex",

          "isoyear",
          #"isoweek",
          #"isoyearweek",
          "season"
        ) |
        stringr::str_detect(var, "_tag$") |
        stringr::str_detect(var, "_status$")
    ) {
      details <- object[, .(n = .N), keyby = .(get(var))] |>
        remove_class_csfmt_rts_data()
      setnames(details, "get", "val")
      details[is.na(val), val := "<NA>"]

      # manually specify some ordering requirements
      levels <- sort(details$val)
      extra_levels <- c(
        "nation",
        "county",
        "notmainlandcounty",
        "missingcounty",
        "municip",
        "notmainlandmunicip",
        "missingmunicip",
        "wardoslo",
        "wardbergen",
        "wardstavanger",
        "wardtrondheim",
        "extrawardoslo",
        "missingwardbergen",
        "missingwardoslo",
        "missingwardstavanger",
        "missingwardtrondheim",
        "baregion",
        "region",
        "faregion"
      )
      reordered_levels <- unique(c(extra_levels, levels))
      reordered_levels <- reordered_levels[reordered_levels %in% levels]
      details[, val := factor(val, levels = reordered_levels)]
      setorder(details, val)

      # create dicsay (n + padding)
      details[, len := stringr::str_length(val)]
      details[, max_len := max(len)]
      details[, val := stringr::str_pad(val, max_len, side = "right")]

      details[, n := format_nor(n)]
      details[, len := stringr::str_length(n)]
      details[, max_len := max(len)]
      details[, n := stringr::str_pad(n, max_len, side = "left")]

      details[, dicsay := paste0(val, " (n = ", n, ")")]
      details <- details$dicsay

      for (j in seq_along(details)) {
        details[j] <- paste0("\n\t- ", paste0(details[j], collapse = ""))
      }
      details <- paste0(details, collapse = "")
      details <- paste0(":", details)
    }
    cat(
      names(object)[i],
      " (",
      class(object[[i]]),
      ")",
      details,
      "\n",
      sep = ""
    )
  }
  cat("\n")
}
