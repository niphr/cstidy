formats$csfmt_rts_data_v1 <- list()
formats$csfmt_rts_data_v1$unified <- list()
formats$csfmt_rts_data_v1$unified$granularity_time <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = c("date", "isoyearweek", "isoyear"),
  class = "character"
)

# csdata::nor_locations_names()
formats$csfmt_rts_data_v1$unified$granularity_geo <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = unique(csdata::nor_locations_names()$granularity_geo),
  class = "character"
)

formats$csfmt_rts_data_v1$unified$country_iso3 <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = c("nor", "den", "swe", "fin"),
  class = "character"
)

formats$csfmt_rts_data_v1$unified$location_code <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v1$unified$border <- list(
  NA_allowed = FALSE,
  NA_class = NA_integer_,
  values_allowed = 2020,
  class = "integer"
)

formats$csfmt_rts_data_v1$unified$age <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v1$unified$sex <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v1$unified$isoyear <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v1$unified$isoweek <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v1$unified$isoyearweek <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v1$unified$season <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v1$unified$seasonweek <- list(
  NA_allowed = TRUE,
  NA_class = NA_real_,
  values_allowed = NULL,
  class = "numeric"
)

formats$csfmt_rts_data_v1$unified$calyear <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v1$unified$calmonth <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v1$unified$calyearmonth <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v1$unified$date <- list(
  NA_allowed = FALSE,
  NA_class = as.Date(NA),
  values_allowed = NULL,
  class = "Date"
)

# print.csfmt_rts_data_v1 <- function(x, ...) {
#   # https://cran.r-project.org/web/packages/data.table/vignettes/datatable-faq.html#ok-thanks.-what-was-so-difficult-about-the-result-of-dti-col-value-being-returned-invisibly
#   if (!data.table::shouldPrint(x)) {
#     return(invisible(x))
#   }
#   # this function is recursive, so that
#   dots <- list(...)
#   print_dots_before_row <- 999999999999999
#   if (nrow(x) == 0) {
#     cat(glue::glue("csfmt_rts_data_v1 with {ncol(x)} columns and 0 rows"))
#     cat(names(x))
#     return(invisible(x))
#   } else if (nrow(x) > 100) {
#     row_numbers <- c(1:nrow(x))[c(1:5, (nrow(x) - 4):nrow(x))]
#     to_print <- x[c(1:5, (.N - 4):.N)]
#     print_dots_before_row <- 6
#   } else {
#     row_numbers <- 1:nrow(x)
#     to_print <- copy(x)
#   }
#
#   # unified vs context
#   format_unified <- attr(to_print, "format_unified")
#   variable_types <- rep("[context]", ncol(to_print))
#   for (i in seq_along(variable_types)) {
#     pos <- which(names(format_unified) %in% names(to_print))
#     # if(length(pos))
#   }
#   names(to_print)
#   names(format_unified)
#   variable_types <- dplyr::case_when(
#     names(to_print) %in% names(format_unified) ~ "[unified]",
#     TRUE ~ "[context]"
#   )
#
#   # classes
#   variable_classes <- paste0("<", unlist(lapply(to_print, class)), ">")
#   variable_names <- names(to_print)
#   row_numbers <- formatC(row_numbers, width = max(nchar(row_numbers))) %>%
#     paste0(":", sep = "")
#   row_number_spacing <- formatC("", width = max(nchar(row_numbers)))
#
#   # round numeric so it isnt too big
#   vars_to_round <- variable_names[variable_classes=="<numeric>"]
#   for(i in vars_to_round){
#     to_print[,(i) := round(get(i), 4)]
#   }
#
#   # missing
#   na_percent <- rep("X", ncol(to_print))
#   na_percent_red <- rep(FALSE, ncol(to_print))
#   for(i in seq_along(na_percent)){
#     var = names(x)[i]
#     val <- x[,.(val = mean(is.na(get(var))))]$val
#     na_percent[i] <- glue::glue("NA={format_nor_perc_0(val*100)}")
#     if(val>0){
#       na_percent_red[i] <- TRUE
#     }
#   }
#
#   width_char <- apply(to_print, 2, nchar, keepNA = F) %>%
#     rbind(nchar(variable_types)) %>%
#     rbind(nchar(variable_classes)) %>%
#     rbind(nchar(na_percent)) %>%
#     rbind(nchar(variable_names)) %>%
#     apply(2, max)
#
#   max_width <- getOption("width") - 5
#   cum_width <- nchar(row_number_spacing) + cumsum(width_char + 3)
#   breaks <- floor(cum_width / max_width)
#
#   if (!"recursive" %in% names(dots)) {
#     # if this is the first time the function is run, then it just acts
#     # as the brain, and determines how many times the function needs to be called
#     for (i in unique(breaks)) {
#       print(x[, names(breaks)[breaks == i], with = F], recursive = TRUE)
#       cat("\n")
#     }
#     return(invisible(x))
#   } else {
#     # we are in the recursive level, so we actually print things!
#     for (i in -3:nrow(to_print)) {
#       if (i == print_dots_before_row) {
#         for (j in seq_len(max(cum_width))) cat(".")
#         cat("\n")
#       }
#
#       if (i <= 0) {
#         cat(row_number_spacing)
#       } else {
#         cat(row_numbers[i])
#       }
#       for (j in 1:ncol(to_print)) {
#         cat("   ")
#
#         if (i == -3) {
#           cat(formatC(variable_types[j], width = width_char[j]))
#         } else if (i == -2) {
#           cat(formatC(variable_classes[j], width = width_char[j]))
#         } else if (i == -1) {
#           if(na_percent_red[j] == TRUE){
#             cat(crayon::red(formatC(na_percent[j], width = width_char[j])))
#           } else {
#             cat(formatC(na_percent[j], width = width_char[j]))
#           }
#         } else if (i == 0) {
#           cat(crayon::bold(formatC(variable_names[j], width = width_char[j])))
#         } else {
#           cat(formatC(as.character(to_print[i][[j]]), width = width_char[j]))
#         }
#       }
#       cat("\n")
#     }
#     return(invisible(x))
#   }
# }

# heal_time_csfmt_rts_data_v1 <- function(x, cols, from){
#   print(x)
#   print(cols)
#   print(from)
#   csutil::apply_fn_via_hash_table(x, heal_time_csfmt_rts_data_v1_internal, cols=cols, from=from)
# }

#' Provides corresponding healed times (deprecated)
#'
#' @description
#' Looks up the time columns (such as isoyear, isoweek, season, and date) that
#' correspond to a vector of dates, isoyearweeks, or isoyears, returning them as
#' a data.table restricted to the requested columns.
#'
#' @param x A vector containing either dates, isoyearweek, or isoyear.
#' @param cols Columns to restrict the output to.
#' @param granularity_time date, isoyearweek, or isoyear, depending on the values contained in x.
#' @returns data.table, a dataset with time columns corresponding to the values given in x.
#' @examples
#' cstidy::heal_time_csfmt_rts_data_v1(
#'   as.Date(c("2022-01-01", "2022-06-15")),
#'   cols = c("isoyear", "isoyearweek", "date"),
#'   granularity_time = "date"
#' )
#' @export
heal_time_csfmt_rts_data_v1 <- function(x, cols, granularity_time = "date"){
  ..columns <- NULL
  rm("..columns")
  . <- NULL

  stopifnot(granularity_time %in% c("date", "isoyearweek", "isoyear"))
  if(granularity_time=="date"){
    columns <- c(
      "granularity_time",
      "isoyear",
      "isoweek",
      "isoyearweek",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth"
    )
    columns <- columns[columns %in% cols]
    return(
      csfmt_rts_data_v1_date_to[
        .(x),
        ..columns
      ]
    )
  } else if(granularity_time=="isoyearweek"){
    columns <- c(
      "granularity_time",
      "isoyear",
      "isoweek",
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth",
      "date"
    )
    columns <- columns[columns %in% cols]
    return(
      csfmt_rts_data_v1_isoyearweek_to[
        .(x),
        ..columns
      ]
    )
  } else if(granularity_time=="isoyear"){
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
      csfmt_rts_data_v1_isoyear_to[
        .(x),
        ..columns
      ]
    )
  }
}

#' @method [ csfmt_rts_data_v1
#' @returns No return value, called for side effect of assigning values in a column.
#' @export
"[.csfmt_rts_data_v1" <- function(x, ...) {
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
    on.exit(set_csfmt_rts_data_v1(x, create_unified_columns = FALSE, heal = FALSE))

    y <- eval(parse(text = deparse(modified_call)), envir = parent.frame(1:2))
    set_csfmt_rts_data_v1(y, create_unified_columns = FALSE, heal = FALSE)
    return(invisible(y))
  } else if (length(i) == 1) {
    # smart-assignment for time ----
    # identify_data_structure if a time variable is mentioned
    lhs <- unlist(lapply(orig_call[[i]][[2]], function(x) {
      deparse(x)
    }))
    time_vars <- c("isoyear", "isoyearweek", "date")
    time_vars_with_quotes <- c(time_vars, paste0("\"", time_vars, "\""))
    time_var_modified_index <- which(lhs %in% time_vars_with_quotes)

    if (length(time_var_modified_index) > 1) {
      warning("Multiple time variables specified. Smart-assignment disabled.")
    } else if (length(time_var_modified_index) == 1) {
      modified_time <- TRUE
      # one date thing is modified
      # find out which type
      time_var_modified <- stringr::str_replace_all(lhs[time_var_modified_index], "\"", "")

      if (length(lhs) == 1) {
        # only one thing on the left
        # need to turn this call into a "multiple assignment" call
        modified_call[[i]][[2]] <- substitute(c(x, "x_modified_timevar_97531"), list(x = deparse(orig_call[[i]][[2]])))
        modified_call[[i]][[3]] <- substitute(.(x, y), list(x = orig_call[[i]][[3]], y = time_var_modified))
      } else {
        # multiple things on the left
        # just need to add x_modified_timevar_97531 to the right most of the multiple assignments
        modified_call[[i]][[2]][[length(lhs) + 1]] <- "x_modified_timevar_97531"
        modified_call[[i]][[3]][[length(lhs) + 1]] <- time_var_modified
      }

      if (time_var_modified == "isoyear") {
        healing_options <- names(heal_time_csfmt_rts_data_v1(2020, names(x), granularity_time="isoyear"))
        healing_function <- glue::glue('cstidy::heal_time_csfmt_rts_data_v1(isoyear, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"isoyear\")')
      } else if (time_var_modified == "isoyearweek") {
        healing_options <- names(heal_time_csfmt_rts_data_v1("2020-01", names(x), granularity_time="isoyearweek"))
        healing_function <- glue::glue('cstidy::heal_time_csfmt_rts_data_v1(isoyearweek, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"isoyearweek\")')
      } else if (time_var_modified == "date") {
        healing_options <- names(heal_time_csfmt_rts_data_v1(as.Date("2020-01-01"), names(x), granularity_time="date"))
        healing_function <- glue::glue('cstidy::heal_time_csfmt_rts_data_v1(date, c("{paste0(healing_options, collapse="\\",\\"")}"), granularity_time=\"date\")')
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
      geo_var_modified <- stringr::str_replace_all(lhs[geo_var_modified_index], "\"", "")

      if (length(lhs) == 1) {
        # only one thing on the left
        # need to turn this call into a "multiple assignment" call
        modified_call[[i]][[2]] <- substitute(c(x, "x_modified_geovar_97531"), list(x = deparse(orig_call[[i]][[2]])))
        modified_call[[i]][[3]] <- substitute(.(x, y), list(x = orig_call[[i]][[3]], y = geo_var_modified))
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
    on.exit(set_csfmt_rts_data_v1(x, create_unified_columns = FALSE, heal = FALSE))

    eval(parse(text = deparse(modified_call)), envir = parent.frame(1:2))
    for (i in seq_along(healing_calls)) {
      eval(parse(text = healing_calls[[i]]), envir = parent.frame(1:2))
    }

    return(invisible(x))
  }
}

heal.csfmt_rts_data_v1 <- function(x, ...) {
  granularity_time <- NULL
  original_granularity_time_32423432 <- NULL
  . <- NULL

  assert_classes.csfmt_rts_data_v1(x)

  # making sure that granularity_time is taken care of
  # if granularity_time doesn't exist, then make it exist
  # and try to imput it straight away
  # granularity_time is a special case because it is very
  # difficult to identify_data_structure which of the time-variables
  # takes precedence over the others (without using granularity_time)
  if(!"granularity_time" %in% names(x)){
    x[, granularity_time := NA_character_]
    on.exit(x[, granularity_time := NULL])
  }

  # identify if there are any granularity_time=='^event'
  # if so, set date to the last date in event, and treat as
  # granularity_time=='day'
  if("granularity_time" %in% names(x)){
    x[, original_granularity_time_32423432 := granularity_time]
    x[
      stringr::str_detect(granularity_time, "^event"),
      c(
        "granularity_time", "date"
      ) := .(
        "date",
        as.Date(
          stringr::str_replace_all(
            stringr::str_extract(granularity_time,"[0-9][0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]$"),
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
    "season",
    "seasonweek",
    "calyear",
    "calmonth",
    "calyearmonth",
    "date"
  )
  time_vars <- time_vars[time_vars %in% names(x)]
  time_vars_to_loop_through <- time_vars[time_vars %in% c("isoyear","isoyearweek","date")]
  for(i in time_vars_to_loop_through){
    other_time_vars <- time_vars[time_vars != i]
    time_var_as_granularity_geo <- i

    if(length(other_time_vars)>=1){
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
  if("granularity_time" %in% names(x)){
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
      "season",
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
      "season",
      "seasonweek",
      "calyear",
      "calmonth",
      "calyearmonth"
    )
  )

  for(type in c("geo", "time")){
    if(type=="geo"){
      imputing_vars <- imputing_vars_geo
    } else if(type=="time"){
      imputing_vars <- imputing_vars_time
    } else {
      stop("")
    }

    for (i in seq_along(imputing_vars)) {
      imputed_from <- names(imputing_vars)[i]
      to_be_imputed <- imputing_vars[[i]]
      to_be_imputed <- to_be_imputed[to_be_imputed %in% names(x)]

      if(type=="geo"){
        extra_restriction <- ''
      } else if(type=="time"){
        time_var_as_granularity_time <- imputed_from
        extra_restriction <- glue::glue('granularity_time==\"{time_var_as_granularity_time}" &')
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

create_unified_columns.csfmt_rts_data_v1 <- function(x, ...) {
  fmt <- attr(x, "format_unified")
  for (i in names(fmt)) {
    if (!i %in% names(x)) {
      # create empty columns
      x[, (i) := fmt[[i]]$NA_class]
    }
  }
  setcolorder(x, names(fmt))

  # heal it
  heal.csfmt_rts_data_v1(x)

  # allows us to print
  data.table::shouldPrint(x)

  return(invisible(x))
}

assert_classes.csfmt_rts_data_v1 <- function(x, ...) {
  fmt <- attr(x, "format_unified")
  classes_real <- lapply(x, class)
  classes_wanted <- lapply(fmt, function(x) {
    x$class
  })
  # just take the ones that are intersected
  classes_wanted <- classes_wanted[names(classes_wanted) %in% names(classes_real)]
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

#' Convert data.table to csfmt_rts_data_v1 (deprecated)
#'
#' @description
#' \code{set_csfmt_rts_data_v1} converts a \code{data.table} to \code{csfmt_rts_data_v1} by reference.
#' \code{csfmt_rts_data_v1} creates a new \code{csfmt_rts_data_v1} (not by reference) from either a \code{data.table} or \code{data.frame}.
#'
#' @section Smart assignment:
#' \code{csfmt_rts_data_v1} contains the smart assignment feature for time and geography.
#'
#' When the **variables in bold** are assigned using `:=`, the listed variables will be automatically imputed.
#'
#' **location_code**:
#' - granularity_geo
#' - country_iso3
#'
#' **isoyear**:
#' - granularity_time
#' - isoweek
#' - isoyearweek
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
#' - season
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
#' - season
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#'
#' @section Unified columns:
#' \code{csfmt_rts_data_v1} contains 16 unified columns:
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
#' - season
#' - seasonweek
#' - calyear
#' - calmonth
#' - calyearmonth
#' - date
#'
#' @return An extended \code{data.table}, which has been modified by reference and returned (invisibly).
#'
#' @param x The data.table to be converted to csfmt_rts_data_v1
#' @param create_unified_columns Do you want it to create unified columns?
#' @param heal Do you want to impute missing values on creation?
#' @family csfmt_rts_data
#' @returns No return value, called for side effect of replacing the current data.table with a csfmt_rts_data_v1 in place.
#' @export
set_csfmt_rts_data_v1 <- function(x, create_unified_columns = TRUE, heal = TRUE) {
  if (!is.data.table(x)) {
    stop("x must be data.table. Run setDT('x').")
  }

  fmt <- formats$csfmt_rts_data_v1$unified
  setattr(x, "format_unified", fmt)
  setattr(x, "class", unique(c("csfmt_rts_data_v1", class(x))))

  if (create_unified_columns) {
    create_unified_columns.csfmt_rts_data_v1(x)
  }

  if (heal) {
    heal.csfmt_rts_data_v1(x)
  }

  return(invisible(x))
}

#' @rdname set_csfmt_rts_data_v1
#' @returns Returns a duplicated csfmt_rts_data_v1.
#' @export
csfmt_rts_data_v1 <- function(x, create_unified_columns = TRUE, heal = TRUE) {
  y <- copy(x)
  set_csfmt_rts_data_v1(
    y,
    create_unified_columns,
    heal
  )

  return(y)
}

#' @method summary csfmt_rts_data_v1
#' @returns No return value, called for side effect of printing a summary of the object.
#' @export
summary.csfmt_rts_data_v1 <- function(object, ...) {
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
  for(i in seq_len(ncol(object))){
    var <- names(object)[i]
    details <- ""
    if(
      var %in% c(
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
    ){
      details <- object[, .(n=.N), keyby=.(get(var))] %>%
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

      details[, dicsay := paste0(val, " (n = ",n ,")")]
      details <- details$dicsay

      for(j in seq_along(details)) details[j] <- paste0("\n\t- ",paste0(details[j], collapse = ""))
      details <- paste0(details, collapse = "")
      details <- paste0(":", details)
    }
    cat(names(object)[i], " (", class(object[[i]]),")", details, "\n", sep = "")
  }
  cat("\n")
}



#' @method plot csfmt_rts_data_structure_hash_v1
#' @export
plot.csfmt_rts_data_structure_hash_v1 <- function(x, y, ...) {
  granularity_geo <- NULL
  category <- NULL
  age <- NULL
  sex <- NULL

  # x <- generate_test_data() %>%
  #   set_csfmt_rts_data_v1() %>%
  #   identify_data_structure("deaths_n")

  pd <- copy(x)
  pd[, granularity_geo := factor(granularity_geo, levels = unique(csdata::nor_locations_names()$granularity_geo))]
  pd[, category := factor(category, levels = c("structurally_missing", "only_na", "data_and_na", "only_data"))]

  pd[, age := paste0("age=", age)]
  pd[, sex := paste0("sex=", sex)]

  q <- ggplot(pd, aes(x = granularity_geo, y = age, fill = category))
  q <- q + geom_tile(color = "black")
  q <- q + facet_grid(sex ~ granularity_time)
  q <- q + scale_x_discrete(NULL)
  q <- q + scale_y_discrete(NULL)
  q <- q + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  q <- q + theme(legend.position = "bottom", legend.direction = "horizontal")
  q
}

#' @method unique_time_series csfmt_rts_data_v1
#' @export
unique_time_series.csfmt_rts_data_v1 <- function(x, set_time_series_id = FALSE, ...) {
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
  retval <- x[, ids, with=F] %>%
    unique() %>%
    remove_class_csfmt_rts_data()
  data.table::shouldPrint(retval)

  # don't do anything, if "time_series_id" already exists in x
  if("time_series_id" %in% names(retval)){
    return(retval)
  }

  retval[, time_series_id := 1:.N]
  if(set_time_series_id){
    x[retval, on = ids, time_series_id := time_series_id]
    data.table::shouldPrint(x)
  }

  return(retval)
}

#' @method expand_time_to csfmt_rts_data_v1
#' @export
expand_time_to.csfmt_rts_data_v1 <- function(x, max_isoyear = NULL, max_isoyearweek = NULL, max_date = NULL, ...) {
  if(is.null(max_isoyear) & is.null(max_isoyearweek) & is.null(max_date)){
    stop("At least one of max_isoyear, max_isoyearweek, max_date must be used")
  }
  d1 <- d2 <- d3 <- NULL
  if(!is.null(max_isoyear)){
    d1 <- expand_time_to_max_isoyear.csfmt_rts_data_v1(x, max_isoyear = max_isoyear)
  }
  if(!is.null(max_isoyearweek)){
    d2 <- expand_time_to_max_isoyearweek.csfmt_rts_data_v1(x, max_isoyearweek = max_isoyearweek)
  }
  if(!is.null(max_date)){
    d3 <- expand_time_to_max_date.csfmt_rts_data_v1(x, max_date = max_date)
  }
  retval <- rbindlist(list(d1,d2,d3), fill = T)

  # allows us to print
  data.table::shouldPrint(retval)

  return(retval)
}

expand_time_to_max_isoyear.csfmt_rts_data_v1 <- function(x, max_isoyear = NULL, ...) {
  granularity_time <- NULL
  time_series_id <- NULL
  isoyear <- NULL
  max_current_isoyear <- NULL
  . <- NULL

  d <- copy(x[granularity_time=="isoyear"])
  if(nrow(d) == 0) return(d)

  if(!"time_series_id" %in% names(d)){
    on.exit(d[, time_series_id := NULL])
    flag_to_remove_time_series_id <- TRUE
  } else {
    flag_to_remove_time_series_id <- FALSE
  }
  ids <- unique_time_series(d, set_time_series_id = TRUE)

  max_vals <- d[, .(max_isoyear = max(isoyear, na.rm=T)), by=.(time_series_id)]
  ids[max_vals, on="time_series_id", max_current_isoyear := max_isoyear]
  ids[, max_isoyear := max_isoyear]

  retval <- vector("list", length = nrow(ids))
  for(i in seq_along(retval)){
    if(ids$max_current_isoyear[i] >= ids$max_isoyear[i]){
      break()
    }
    new_isoyears <- c((ids$max_current_isoyear[i]+1):ids$max_isoyear[i])
    retval[[i]] <- copy(ids[rep(i,length(new_isoyears))])
    retval[[i]][, isoyear := new_isoyears]
  }

  retval <- rbindlist(retval)

  x <- rbindlist(list(d, retval), fill = T)
  cstidy::set_csfmt_rts_data_v1(x)
  setorder(x, time_series_id, date)

  if(flag_to_remove_time_series_id) x[, time_series_id := NULL]
  if("max_current_isoyear" %in% names(x)) x[, max_current_isoyear := NULL]
  if("max_isoyear" %in% names(x)) x[, max_isoyear := NULL]

  # allows us to print
  data.table::shouldPrint(x)

  return(x)
}

expand_time_to_max_isoyearweek.csfmt_rts_data_v1 <- function(x, max_isoyearweek = NULL, ...) {
  granularity_time <- NULL
  time_series_id <- NULL
  isoyearweek <- NULL
  max_current_isoyearweek <- NULL
  . <- NULL

  d <- copy(x[granularity_time=="isoyearweek"])
  if(nrow(d) == 0) return(NULL)

  if(!"time_series_id" %in% names(d)){
    on.exit(d[, time_series_id := NULL])
    flag_to_remove_time_series_id <- TRUE
  } else {
    flag_to_remove_time_series_id <- FALSE
  }
  ids <- unique_time_series(d, set_time_series_id = TRUE)

  max_vals <- d[, .(max_isoyearweek = max(isoyearweek, na.rm=T)), by=.(time_series_id)]
  ids[max_vals, on="time_series_id", max_current_isoyearweek := max_isoyearweek]
  ids[, max_isoyearweek := max_isoyearweek]

  retval <- vector("list", length = nrow(ids))
  for(i in seq_along(retval)){
    if(ids$max_current_isoyearweek[i] >= ids$max_isoyearweek[i]){
      break()
    }
    index_min <- which(cstime::dates_by_isoyearweek$isoyearweek == ids$max_current_isoyearweek[i])+1
    index_max <- which(cstime::dates_by_isoyearweek$isoyearweek == ids$max_isoyearweek[i])
    new_isoyearweeks <- cstime::dates_by_isoyearweek$isoyearweek[index_min:index_max]
    retval[[i]] <- copy(ids[rep(i,length(new_isoyearweeks))])
    retval[[i]][, isoyearweek := new_isoyearweeks]
  }

  retval <- rbindlist(retval)

  x <- rbindlist(list(d, retval), fill = T)
  cstidy::set_csfmt_rts_data_v1(x)
  setorder(x, time_series_id, date)

  if(flag_to_remove_time_series_id) x[, time_series_id := NULL]
  if("max_current_isoyearweek" %in% names(x)) x[, max_current_isoyearweek := NULL]
  if("max_isoyearweek" %in% names(x)) x[, max_isoyearweek := NULL]

  # allows us to print
  data.table::shouldPrint(x)

  return(x)
}

expand_time_to_max_date.csfmt_rts_data_v1 <- function(x, max_date = NULL, ...) {
  granularity_time <- NULL
  time_series_id <- NULL
  max_current_date <- NULL
  . <- NULL

  d <- copy(x[granularity_time=="date"])
  if(nrow(d) == 0) return(NULL)

  if(!"time_series_id" %in% names(d)){
    on.exit(d[, time_series_id := NULL])
    flag_to_remove_time_series_id <- TRUE
  } else {
    flag_to_remove_time_series_id <- FALSE
  }
  ids <- unique_time_series(d, set_time_series_id = TRUE)

  max_vals <- d[, .(max_date = max(date, na.rm=T)), by=.(time_series_id)]
  ids[max_vals, on="time_series_id", max_current_date := max_date]
  ids[, max_date := max_date]

  retval <- vector("list", length = nrow(ids))
  for(i in seq_along(retval)){
    if(ids$max_current_date[i] >= ids$max_date[i]){
      break()
    }
    new_dates <- seq.Date(as.Date(ids$max_current_date[i])+1, as.Date(ids$max_date[i]), by = 1)
    retval[[i]] <- copy(ids[rep(i,length(new_dates))])
    retval[[i]][, date := new_dates]
  }

  retval <- rbindlist(retval)

  x <- rbindlist(list(d, retval), fill = T)
  cstidy::set_csfmt_rts_data_v1(x)
  setorder(x, time_series_id, date)

  if(flag_to_remove_time_series_id) x[, time_series_id := NULL]
  if("max_current_date" %in% names(x)) x[, max_current_date := NULL]
  if("max_date" %in% names(x)) x[, max_date := NULL]

  # allows us to print
  data.table::shouldPrint(x)

  return(x)
}




# #' Epicurve
# #' @param x Dataset
# #' @param ... X
# #' @examples
# #' csstyle::plot_epicurve(cstidy::nor_covid19_cases_by_time_location_csfmt_rts_v1[location_code == "county03"], type = "single", var_y = "covid19_cases_testdate_n")
# #' @importFrom csstyle plot_epicurve
# #' @method plot_epicurve csfmt_rts_data_v1
# #' @export
# plot_epicurve.csfmt_rts_data_v1 <- function(
#   x,
#   ...
#   ) {
#
#   print("HELLO")
#
# }
#




