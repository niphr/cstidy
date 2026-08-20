# The healing and subset methods for the csfmt_rts_data_v2 format.
#
# The format definition is in "csfmt_rts_v2.R". See that file for the load
# order this directory needs.

#' Provides corresponding healed times (deprecated)
#'
#' @description
#' Looks up the time columns (such as isoyear, isoweek, isoquarter, season and
#' date) that correspond to a vector of dates, isoyearweeks, seasons or
#' isoyears. Returns them as a data.table restricted to the requested columns.
#'
#' @param x A vector containing dates, isoyearweek, season, or isoyear.
#' @param cols Columns to restrict the output to.
#' @param granularity_time One of "date", "isoyearweek", "season", or "isoyear", matching the values contained in x.
#' @returns data.table, a dataset with time columns corresponding to the values given in x.
#' @examples
#' cstidy::heal_time_csfmt_rts_data_v2(
#'   c("2022-01", "2022-02"),
#'   cols = c("isoyear", "isoweek", "season", "date"),
#'   granularity_time = "isoyearweek"
#' )
#' @section Deprecated:
#' This lookup is deprecated as a public entry point, along with the
#' `csfmt_rts_data_v2` format it was written for. Nothing warns at run time, and
#' it is not going away. \code{heal.csfmt_rts_data_v3()} calls it to derive v3's
#' time columns. It is still the healing engine behind
#' \code{\link{set_csfmt_rts_data_v3}()}. See
#' \code{\link{set_csfmt_rts_data_v2}()} for what replaces the format, and for
#' the three limits of that replacement.
#' @family time healing lookups
#' @seealso No vignette covers this function.
#' \code{\link{set_csfmt_rts_data_v2}()} and \code{\link{set_csfmt_rts_data_v3}()}
#' both call it while healing.
#' @export
heal_time_csfmt_rts_data_v2 <- function(x, cols, granularity_time = "date") {
  ..columns <- NULL
  rm("..columns")
  . <- NULL

  stopifnot(granularity_time %in% c("date", "season", "isoyearweek", "isoyear"))
  if (granularity_time == "date") {
    columns <- c(
      "granularity_time",
      "isoyear",
      "isoweek",
      "isoyearweek",
      "isoquarter",
      "isoyearquarter",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth"
    )
    columns <- columns[columns %in% cols]
    return(
      csfmt_rts_data_v2_date_to[
        .(x),
        ..columns
      ]
    )
  } else if (granularity_time == "season") {
    columns <- c(
      "granularity_time",
      "isoyear",
      "isoweek",
      "isoyearweek",
      "isoquarter",
      "isoyearquarter",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    )
    columns <- columns[columns %in% cols]
    return(
      csfmt_rts_data_v2_season_to[
        .(x),
        ..columns
      ]
    )
  } else if (granularity_time == "isoyearweek") {
    columns <- c(
      "granularity_time",
      "isoyear",
      "isoweek",
      "isoquarter",
      "isoyearquarter",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    )
    columns <- columns[columns %in% cols]
    return(
      csfmt_rts_data_v2_isoyearweek_to[
        .(x),
        ..columns
      ]
    )
  } else if (granularity_time == "isoyear") {
    columns <- c(
      "granularity_time",
      "isoweek",
      "isoyearweek",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    )
    columns <- columns[columns %in% cols]
    return(
      csfmt_rts_data_v2_isoyear_to[
        .(x),
        ..columns
      ]
    )
  }
}

#' @section Deprecated:
#' This method is deprecated along with the `csfmt_rts_data_v2` format it
#' dispatches on. Nothing warns at run time. See
#' \code{\link{set_csfmt_rts_data_v2}()}.
#' @method [ csfmt_rts_data_v2
#' @returns No return value, called for side effect of assigning values in a column.
#' @export
"[.csfmt_rts_data_v2" <- function(x, ...) {
  # original call
  modified_call <- orig_call <- sys.calls()[[sys.nframe() - 1]]
  healing_calls <- list()
  # print(orig_call)

  # variable_in_sys_call <- orig_call[[2]]
  # if(!variable_in_sys_call %in% ls(parent.frame(1:2))){
  #   stop(glue::glue("{variable_in_sys_call} is not in parent.frame(1:2)"))
  # }
  # if(!is.data.table(get(variable_in_sys_call, envir = parent.frame(1:2)))){
  #   stop(glue::glue("{variable_in_sys_call} is not data.table"))
  #   x$.internal.selfref
  # }

  # smart-assignment
  # try to find which part uses :=
  first_call <- lapply(orig_call, function(x) {
    if (length(x) > 1) deparse(x[[1]])
  })
  i <- as.numeric(which(first_call == ":="))
  if (length(i) == 0) {
    # no assignment
    remove_class_csfmt_rts_data(x)
    on.exit(set_csfmt_rts_data_v2(
      x,
      create_unified_columns = FALSE,
      heal = FALSE
    ))

    y <- eval(parse(text = deparse(modified_call)), envir = parent.frame(1:2))
    set_csfmt_rts_data_v2(y, create_unified_columns = FALSE, heal = FALSE)
    return(invisible(y))
  } else if (length(i) == 1) {
    # smart-assignment for time ----
    # identify_data_structure if a time variable is mentioned
    lhs <- unlist(lapply(orig_call[[i]][[2]], function(x) {
      deparse(x)
    }))
    time_vars <- c("isoyear", "isoyearweek", "season", "date")
    time_vars_with_quotes <- c(time_vars, paste0("\"", time_vars, "\""))
    time_var_modified_index <- which(lhs %in% time_vars_with_quotes)

    if (length(time_var_modified_index) > 1) {
      warning("Multiple time variables specified. Smart-assignment disabled.")
    } else if (length(time_var_modified_index) == 1) {
      modified_time <- TRUE
      # one date thing is modified
      # find out which type
      time_var_modified <- stringr::str_replace_all(
        lhs[time_var_modified_index],
        "\"",
        ""
      )

      if (length(lhs) == 1) {
        # only one thing on the left
        # need to turn this call into a "multiple assignment" call
        modified_call[[i]][[2]] <- substitute(
          c(x, "x_modified_timevar_97531"),
          list(x = deparse(orig_call[[i]][[2]]))
        )
        modified_call[[i]][[3]] <- substitute(
          .(x, y),
          list(x = orig_call[[i]][[3]], y = time_var_modified)
        )
      } else {
        # multiple things on the left
        # just need to add x_modified_timevar_97531 to the right most of the multiple assignments
        modified_call[[i]][[2]][[length(lhs) + 1]] <- "x_modified_timevar_97531"
        modified_call[[i]][[3]][[length(lhs) + 1]] <- time_var_modified
      }

      if (time_var_modified == "isoyear") {
        healing_options <- names(heal_time_csfmt_rts_data_v2(
          2020,
          names(x),
          granularity_time = "isoyear"
        ))
        healing_function <- glue::glue(
          'cstidy::heal_time_csfmt_rts_data_v2(isoyear, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"isoyear\")'
        )
      } else if (time_var_modified == "isoyearweek") {
        healing_options <- names(heal_time_csfmt_rts_data_v2(
          "2020-01",
          names(x),
          granularity_time = "isoyearweek"
        ))
        healing_function <- glue::glue(
          'cstidy::heal_time_csfmt_rts_data_v2(isoyearweek, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"isoyearweek\")'
        )
      } else if (time_var_modified == "season") {
        healing_options <- names(heal_time_csfmt_rts_data_v2(
          "2020/2021",
          names(x),
          granularity_time = "season"
        ))
        healing_function <- glue::glue(
          'cstidy::heal_time_csfmt_rts_data_v2(season, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"season\")'
        )
      } else if (time_var_modified == "date") {
        healing_options <- names(heal_time_csfmt_rts_data_v2(
          as.Date("2020-01-01"),
          names(x),
          granularity_time = "date"
        ))
        healing_function <- glue::glue(
          'cstidy::heal_time_csfmt_rts_data_v2(date, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"date\")'
        )
      } else {
        healing_options <- NULL
        healing_function <- NULL
      }

      if (!is.null(healing_options)) {
        healing_calls[[length(healing_calls) + 1]] <- glue::glue(
          '{orig_call[[2]]}[!is.na(x_modified_timevar_97531),
          c("{paste0(healing_options, collapse="\\",\\"")}")
          :=
          {healing_function}
          ]'
        )
      }

      healing_calls[[length(healing_calls) + 1]] <- glue::glue(
        "{orig_call[[2]]}[, x_modified_timevar_97531 := NULL]"
      )
    }

    # smart-assignment for geo ----
    # our smart-assignment code always starts off with orig_call = modified_code
    orig_call <- modified_call
    # identify_data_structure if a geo variable is mentioned
    lhs <- unlist(lapply(orig_call[[i]][[2]], function(x) {
      deparse(x)
    }))
    geo_vars <- c("granularity_geo", "location_code", "country_iso3")
    geo_vars_with_quotes <- c(geo_vars, paste0("\"", geo_vars, "\""))
    geo_var_modified_index <- which(lhs %in% geo_vars_with_quotes)

    if (length(geo_var_modified_index) > 1) {
      warning("Multiple geo variables specified. Smart-assignment disabled.")
    } else if (length(geo_var_modified_index) == 1) {
      modified_geo <- TRUE
      # one date thing is modified
      # find out which type
      geo_var_modified <- stringr::str_replace_all(
        lhs[geo_var_modified_index],
        "\"",
        ""
      )

      if (length(lhs) == 1) {
        # only one thing on the left
        # need to turn this call into a "multiple assignment" call
        modified_call[[i]][[2]] <- substitute(
          c(x, "x_modified_geovar_97531"),
          list(x = deparse(orig_call[[i]][[2]]))
        )
        modified_call[[i]][[3]] <- substitute(
          .(x, y),
          list(x = orig_call[[i]][[3]], y = geo_var_modified)
        )
      } else {
        # multiple things on the left
        # just need to add x_modified_geovar_97531 to the right most of the multiple assignments
        modified_call[[i]][[2]][[length(lhs) + 1]] <- "x_modified_geovar_97531"
        modified_call[[i]][[3]][[length(lhs) + 1]] <- geo_var_modified
      }

      if (geo_var_modified == "location_code") {
        healing_options <- list(
          "granularity_geo" = "csdata::location_code_to_granularity_geo(location_code)",
          "country_iso3" = "csdata::location_code_to_iso3(location_code)"
        )
      } else {
        healing_options <- NULL
      }

      if (!is.null(healing_options)) {
        healing_options <- healing_options[names(healing_options) %in% names(x)]
        if (length(healing_options) > 0) {
          healing_calls[[length(healing_calls) + 1]] <- glue::glue(
            '{orig_call[[2]]}[!is.na(x_modified_geovar_97531),
            c("{paste0(names(healing_options), collapse="\\",\\"")}")
            :=
            .({paste0(healing_options, collapse=",")})
            ]'
          )
        }
      }

      healing_calls[[length(healing_calls) + 1]] <- glue::glue(
        "{orig_call[[2]]}[, x_modified_geovar_97531 := NULL]"
      )
    }
    # print(orig_call)
    # print(modified_call)
    # print(healing_calls)

    remove_class_csfmt_rts_data(x)
    on.exit(set_csfmt_rts_data_v2(
      x,
      create_unified_columns = FALSE,
      heal = FALSE
    ))

    eval(parse(text = deparse(modified_call)), envir = parent.frame(1:2))
    for (i in seq_along(healing_calls)) {
      eval(parse(text = healing_calls[[i]]), envir = parent.frame(1:2))
    }

    return(invisible(x))
  }
}

heal.csfmt_rts_data_v2 <- function(x, ...) {
  granularity_time <- NULL
  original_granularity_time_32423432 <- NULL
  . <- NULL

  assert_classes.csfmt_rts_data_v2(x)

  # making sure that granularity_time is taken care of
  # if granularity_time doesn't exist, then make it exist
  # and try to imput it straight away
  # granularity_time is a special case because it is very
  # difficult to identify_data_structure which of the time-variables
  # takes precedence over the others (without using granularity_time)
  if (!"granularity_time" %in% names(x)) {
    x[, granularity_time := NA_character_]
    on.exit(x[, granularity_time := NULL])
  }

  # identify if there are any granularity_time=='^event'
  # if so, set date to the last date in event, and treat as
  # granularity_time=='day'
  if ("granularity_time" %in% names(x)) {
    x[, original_granularity_time_32423432 := granularity_time]
    x[
      stringr::str_detect(granularity_time, "^event"),
      c(
        "granularity_time",
        "date"
      ) := .(
        "date",
        as.Date(
          stringr::str_replace_all(
            stringr::str_extract(
              granularity_time,
              "[0-9][0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]$"
            ),
            "_",
            "-"
          )
        )
      )
    ]
  }
  time_vars <- c(
    "isoyear",
    "isoweek",
    "isoyearweek",
    "isoquarter",
    "isoyearquarter",
    "season",
    "seasonweek",
    "calyear",
    "calmonth",
    "calyearmonth",
    "date"
  )
  time_vars <- time_vars[time_vars %in% names(x)]
  time_vars_to_loop_through <- time_vars[
    time_vars %in% c("isoyear", "isoyearweek", "season", "date")
  ]
  for (i in time_vars_to_loop_through) {
    other_time_vars <- time_vars[time_vars != i]
    time_var_as_granularity_geo <- i

    if (length(other_time_vars) >= 1) {
      txt <- glue::glue(
        '
            x[!is.na({i}) & is.na({paste0(other_time_vars, collapse=") & is.na(")}), granularity_time := "{time_var_as_granularity_geo}"]
            '
      )
    } else {
      txt <- glue::glue(
        '
            x[!is.na({i}), granularity_time := "{time_var_as_granularity_geo}"]
            '
      )
    }
    eval(parse(text = txt))
  }
  if ("granularity_time" %in% names(x)) {
    x[, granularity_time := original_granularity_time_32423432]
    x[, original_granularity_time_32423432 := NULL]
  }

  # granularity_time = mandatory
  imputing_vars_geo <- list(
    "location_code" = c("granularity_geo", "country_iso3")
  )

  imputing_vars_time <- list(
    "isoyear" = c(
      "isoweek",
      "isoyearweek",
      "isoquarter",
      "isoyearquarter",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    ),
    "isoyearweek" = c(
      "isoyear",
      "isoweek",
      "isoquarter",
      "isoyearquarter",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    ),
    "season" = c(
      "isoyear",
      "isoweek",
      "isoyearweek",
      "isoquarter",
      "isoyearquarter",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    ),
    "date" = c(
      "isoyear",
      "isoweek",
      "isoyearweek",
      "isoquarter",
      "isoyearquarter",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth"
    )
  )

  for (type in c("geo", "time")) {
    if (type == "geo") {
      imputing_vars <- imputing_vars_geo
    } else if (type == "time") {
      imputing_vars <- imputing_vars_time
    } else {
      stop("")
    }

    for (i in seq_along(imputing_vars)) {
      imputed_from <- names(imputing_vars)[i]
      to_be_imputed <- imputing_vars[[i]]
      to_be_imputed <- to_be_imputed[to_be_imputed %in% names(x)]

      if (type == "geo") {
        extra_restriction <- ''
      } else if (type == "time") {
        time_var_as_granularity_time <- imputed_from
        extra_restriction <- glue::glue(
          'granularity_time==\"{time_var_as_granularity_time}" &'
        )
      } else {
        stop("")
      }

      if (imputed_from %in% names(x) & length(to_be_imputed) > 0) {
        txt <- glue::glue(
          '
          x[{extra_restriction} !is.na({imputed_from}) & (is.na({paste0(to_be_imputed, collapse=")|is.na(")})), {imputed_from} := {imputed_from}]
          '
        )
        eval(parse(text = txt))
      }
    }
  }

  # allows us to print
  data.table::shouldPrint(x)

  return(invisible(x))
}

create_unified_columns.csfmt_rts_data_v2 <- function(x, ...) {
  fmt <- attr(x, "format_unified")
  for (i in names(fmt)) {
    if (!i %in% names(x)) {
      # create empty columns
      x[, (i) := fmt[[i]]$NA_class]
    }
  }
  setcolorder(x, names(fmt))

  # heal it
  heal.csfmt_rts_data_v2(x)

  # allows us to print
  data.table::shouldPrint(x)

  return(invisible(x))
}


assert_classes.csfmt_rts_data_v2 <- function(x, ...) {
  fmt <- attr(x, "format_unified")
  classes_real <- lapply(x, class)
  classes_wanted <- lapply(fmt, function(x) {
    x$class
  })
  # just take the ones that are intersected
  classes_wanted <- classes_wanted[
    names(classes_wanted) %in% names(classes_real)
  ]
  classes_real <- classes_real[names(classes_real) %in% names(classes_wanted)]
  for (i in names(classes_real)) {
    if (classes_real[[i]] != classes_wanted[[i]]) {
      # force class
      if (classes_wanted[[i]] == "Date") {
        x[, (i) := as.Date(get(i))]
      } else {
        x[, (i) := methods::as(get(i), classes_wanted[[i]])]
      }
    }
  }

  # allows us to print
  data.table::shouldPrint(x)

  return(invisible(x))
}
