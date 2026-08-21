# The unique_time_series and expand_time_to methods for the
# csfmt_rts_data_v2 format.
#
# The format definition is in "csfmt_rts_v2.R". See that file for the load
# order this directory needs.

#' @section Deprecated:
#' This method is deprecated along with the `csfmt_rts_data_v2` format it
#' dispatches on. Nothing warns at run time. See
#' \code{\link{set_csfmt_rts_data_v2}()}. The `csfmt_rts_data_v3` method of
#' `unique_time_series()` is not deprecated.
#' @method unique_time_series csfmt_rts_data_v2
#' @export
unique_time_series.csfmt_rts_data_v2 <- function(
  x,
  set_time_series_id = FALSE,
  ...
) {
  time_series_id <- NULL

  ids <- unique(
    c(
      "granularity_time",
      "granularity_geo",
      "country_iso3",
      "location_code",
      "border",
      "age",
      "sex",
      stringr::str_subset(names(x), c("_id$")),
      stringr::str_subset(names(x), c("_tag$"))
    )
  )
  ids <- ids[ids %in% names(x)]
  retval <- x[, ids, with = F] |>
    unique() |>
    remove_class_csfmt_rts_data()
  data.table::shouldPrint(retval)

  # don't do anything, if "time_series_id" already exists in x
  if ("time_series_id" %in% names(retval)) {
    return(retval)
  }

  retval[, time_series_id := 1:.N]
  if (set_time_series_id) {
    x[retval, on = ids, time_series_id := time_series_id]
    data.table::shouldPrint(x)
  }

  return(retval)
}

#' @section Deprecated:
#' This method is deprecated along with the `csfmt_rts_data_v2` format it
#' dispatches on. Nothing warns at run time. See
#' \code{\link{set_csfmt_rts_data_v2}()}.
#' @method expand_time_to csfmt_rts_data_v2
#' @export
expand_time_to.csfmt_rts_data_v2 <- function(
  x,
  max_isoyear = NULL,
  max_isoyearweek = NULL,
  max_date = NULL,
  ...
) {
  if (is.null(max_isoyear) & is.null(max_isoyearweek) & is.null(max_date)) {
    stop("At least one of max_isoyear, max_isoyearweek, max_date must be used")
  }
  d1 <- d2 <- d3 <- NULL
  if (!is.null(max_isoyear)) {
    d1 <- expand_time_to_max_isoyear.csfmt_rts_data_v2(
      x,
      max_isoyear = max_isoyear
    )
  }
  if (!is.null(max_isoyearweek)) {
    d2 <- expand_time_to_max_isoyearweek.csfmt_rts_data_v2(
      x,
      max_isoyearweek = max_isoyearweek
    )
  }
  if (!is.null(max_date)) {
    d3 <- expand_time_to_max_date.csfmt_rts_data_v2(x, max_date = max_date)
  }
  retval <- rbindlist(list(d1, d2, d3), fill = T)

  # allows us to print
  data.table::shouldPrint(retval)

  return(retval)
}

expand_time_to_max_isoyear.csfmt_rts_data_v2 <- function(
  x,
  max_isoyear = NULL,
  ...
) {
  granularity_time <- NULL
  time_series_id <- NULL
  isoyear <- NULL
  max_current_isoyear <- NULL
  . <- NULL

  d <- copy(x[granularity_time == "isoyear"])
  if (nrow(d) == 0) {
    return(d)
  }

  if (!"time_series_id" %in% names(d)) {
    on.exit(d[, time_series_id := NULL])
    flag_to_remove_time_series_id <- TRUE
  } else {
    flag_to_remove_time_series_id <- FALSE
  }
  ids <- unique_time_series(d, set_time_series_id = TRUE)

  max_vals <- d[,
    .(max_isoyear = max(isoyear, na.rm = T)),
    by = .(time_series_id)
  ]
  ids[max_vals, on = "time_series_id", max_current_isoyear := max_isoyear]
  ids[, max_isoyear := max_isoyear]

  retval <- vector("list", length = nrow(ids))
  for (i in seq_along(retval)) {
    if (ids$max_current_isoyear[i] >= ids$max_isoyear[i]) {
      break()
    }
    new_isoyears <- c((ids$max_current_isoyear[i] + 1):ids$max_isoyear[i])
    retval[[i]] <- copy(ids[rep(i, length(new_isoyears))])
    retval[[i]][, isoyear := new_isoyears]
  }

  retval <- rbindlist(retval)

  x <- rbindlist(list(d, retval), fill = T)
  cstidy::set_csfmt_rts_data_v2(x)
  setorder(x, time_series_id, date)

  if (flag_to_remove_time_series_id) {
    x[, time_series_id := NULL]
  }
  if ("max_current_isoyear" %in% names(x)) {
    x[, max_current_isoyear := NULL]
  }
  if ("max_isoyear" %in% names(x)) {
    x[, max_isoyear := NULL]
  }

  # allows us to print
  data.table::shouldPrint(x)

  return(x)
}


expand_time_to_max_isoyearweek.csfmt_rts_data_v2 <- function(
  x,
  max_isoyearweek = NULL,
  ...
) {
  granularity_time <- NULL
  time_series_id <- NULL
  isoyearweek <- NULL
  max_current_isoyearweek <- NULL
  . <- NULL

  d <- copy(x[granularity_time == "isoyearweek"])
  if (nrow(d) == 0) {
    return(NULL)
  }

  if (!"time_series_id" %in% names(d)) {
    on.exit(d[, time_series_id := NULL])
    flag_to_remove_time_series_id <- TRUE
  } else {
    flag_to_remove_time_series_id <- FALSE
  }
  ids <- unique_time_series(d, set_time_series_id = TRUE)

  max_vals <- d[,
    .(max_isoyearweek = max(isoyearweek, na.rm = T)),
    by = .(time_series_id)
  ]
  ids[
    max_vals,
    on = "time_series_id",
    max_current_isoyearweek := max_isoyearweek
  ]
  ids[, max_isoyearweek := max_isoyearweek]

  retval <- vector("list", length = nrow(ids))
  for (i in seq_along(retval)) {
    if (ids$max_current_isoyearweek[i] >= ids$max_isoyearweek[i]) {
      break()
    }
    index_min <- which(
      cstime::dates_by_isoyearweek$isoyearweek == ids$max_current_isoyearweek[i]
    ) +
      1
    index_max <- which(
      cstime::dates_by_isoyearweek$isoyearweek == ids$max_isoyearweek[i]
    )
    new_isoyearweeks <- cstime::dates_by_isoyearweek$isoyearweek[
      index_min:index_max
    ]
    retval[[i]] <- copy(ids[rep(i, length(new_isoyearweeks))])
    retval[[i]][, isoyearweek := new_isoyearweeks]
  }

  retval <- rbindlist(retval)

  x <- rbindlist(list(d, retval), fill = T)
  cstidy::set_csfmt_rts_data_v2(x)
  setorder(x, time_series_id, date)

  if (flag_to_remove_time_series_id) {
    x[, time_series_id := NULL]
  }
  if ("max_current_isoyearweek" %in% names(x)) {
    x[, max_current_isoyearweek := NULL]
  }
  if ("max_isoyearweek" %in% names(x)) {
    x[, max_isoyearweek := NULL]
  }

  # allows us to print
  data.table::shouldPrint(x)

  return(x)
}

expand_time_to_max_date.csfmt_rts_data_v2 <- function(x, max_date = NULL, ...) {
  granularity_time <- NULL
  time_series_id <- NULL
  max_current_date <- NULL
  . <- NULL

  d <- copy(x[granularity_time == "date"])
  if (nrow(d) == 0) {
    return(NULL)
  }

  if (!"time_series_id" %in% names(d)) {
    on.exit(d[, time_series_id := NULL])
    flag_to_remove_time_series_id <- TRUE
  } else {
    flag_to_remove_time_series_id <- FALSE
  }
  ids <- unique_time_series(d, set_time_series_id = TRUE)

  max_vals <- d[, .(max_date = max(date, na.rm = T)), by = .(time_series_id)]
  ids[max_vals, on = "time_series_id", max_current_date := max_date]
  ids[, max_date := max_date]

  retval <- vector("list", length = nrow(ids))
  for (i in seq_along(retval)) {
    if (ids$max_current_date[i] >= ids$max_date[i]) {
      break()
    }
    new_dates <- seq.Date(
      as.Date(ids$max_current_date[i]) + 1,
      as.Date(ids$max_date[i]),
      by = 1
    )
    retval[[i]] <- copy(ids[rep(i, length(new_dates))])
    retval[[i]][, date := new_dates]
  }

  retval <- rbindlist(retval)

  x <- rbindlist(list(d, retval), fill = T)
  cstidy::set_csfmt_rts_data_v2(x)
  setorder(x, time_series_id, date)

  if (flag_to_remove_time_series_id) {
    x[, time_series_id := NULL]
  }
  if ("max_current_date" %in% names(x)) {
    x[, max_current_date := NULL]
  }
  if ("max_date" %in% names(x)) {
    x[, max_date := NULL]
  }

  # allows us to print
  data.table::shouldPrint(x)

  return(x)
}

# #' Epicurve
# #' @param x Dataset
# #' @param ... X
# #' @examples
# #' csstyle::plot_epicurve(cstidy::nor_covid19_cases_by_time_location_csfmt_rts_v2[location_code == "county03"], type = "single", var_y = "covid19_cases_testdate_n")
# #' @importFrom csstyle plot_epicurve
# #' @method plot_epicurve csfmt_rts_data_v2
# #' @export
# plot_epicurve.csfmt_rts_data_v2 <- function(
#   x,
#   ...
#   ) {
#
#   print("HELLO")
#
# }
#
