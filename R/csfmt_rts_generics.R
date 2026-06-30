
#' Hash the data structure of a dataset for a given column
#'
#' @description
#' Summarises the data structure of a single column inside a dataset. For each
#' combination of granularity_time, granularity_geo, age, and sex it records
#' whether the column is structurally missing, only NA, only data, or a mix of
#' data and NA. The result can be passed to `plot()` for a visual overview.
#'
#' @param x An object of type \code{\link{csfmt_rts_data_v2}}.
#' @param col Column name (character) whose data structure is summarised.
#' @param ... Arguments passed to or from other methods.
#' @examples
#' cstidy::generate_test_data() %>%
#'   cstidy::set_csfmt_rts_data_v2() %>%
#'   cstidy::identify_data_structure("deaths_n") %>%
#'   plot()
#' @family csfmt_rts_data
#' @returns csfmt_rts_data_structure_hash_v2, a summary object that can be plotted.
#' @rdname identify_data_structure
#' @export
identify_data_structure <- function(x, col, ...) {
  UseMethod("identify_data_structure", x)
}


#' Unique time series
#'
#' @description
#' Attempts to identify the unique time series that exist in this dataset.
#'
#' A time series is defined as a unique combination of:
#' - granularity_time
#' - granularity_geo
#' - country_iso3
#' - location_code
#' - border
#' - age
#' - sex
#' - *_id
#' - *_tag
#'
#' @param x An object of type \code{\link{csfmt_rts_data_v2}}
#' @param set_time_series_id If TRUE, then `x` will have a new column called 'time_series_id'
#' @param ... Not used.
#' @returns data.table, a dataset that lists all the unique time series in x.
#' @examples
#' x <- cstidy::generate_test_data() %>%
#'   cstidy::set_csfmt_rts_data_v2()
#' cstidy::unique_time_series(x)
#' @family csfmt_rts_data
#' @export
unique_time_series <- function(x, set_time_series_id = FALSE, ...) {
  UseMethod("unique_time_series", x)
}

#' Expand time to
#'
#' @description
#' Attempts to expand the dataset to include more time
#'
#' A time series is defined as a unique combination of:
#' - granularity_time
#' - granularity_geo
#' - country_iso3
#' - location_code
#' - border
#' - age
#' - sex
#' - *_id
#' - *_tag
#'
#' @param x An object of type \code{\link{csfmt_rts_data_v2}}
#' @param max_isoyear Maximum isoyear to expand each isoyear time series up to.
#' @param max_isoyearweek Maximum isoyearweek to expand each isoyearweek time series up to.
#' @param max_date Maximum date to expand each daily time series up to.
#' @param ... Not used.
#' @returns csfmt_rts_data_v2, a larger dataset that includes more rows corresponding to more time.
#' @examples
#' x <- cstidy::generate_test_data() %>%
#'   cstidy::set_csfmt_rts_data_v2()
#' cstidy::expand_time_to(x, max_isoyearweek = "2022-10")
#' @family csfmt_rts_data
#' @export
expand_time_to <- function(x, max_isoyear = NULL, max_isoyearweek = NULL, max_date = NULL, ...) {
  UseMethod("expand_time_to", x)
}

expand_time_to_max_isoyear <- function(x, max_isoyear = NULL, ...) {
  UseMethod("expand_time_to_max_isoyear", x)
}

expand_time_to_max_isoyearweek <- function(x, max_isoyearweek = NULL, ...) {
  UseMethod("expand_time_to_max_isoyearweek", x)
}

expand_time_to_max_date <- function(x, max_date = NULL, ...) {
  UseMethod("expand_time_to_max_date", x)
}

validate <- function(x) {
  new_hash <- digest::digest(attr(x, ".internal.selfref"), "md5")
  old_hash <- attr(x, "hash")

  # data hasnt changed since last validation
  if (identical(new_hash, old_hash)) {
    # return(invisible())
  }
  status <- attr(x, "status")
  if (is.null(status)) status <- list()

  fmt <- attr(x, "format_unified")
  for (i in names(fmt)) {
    fmt_i <- fmt[[i]]
    status_i <- list()
    status_i$errors <- "\U274C Errors:"

    # variable doesn't exist
    if (!i %in% names(x)) {
      status_i$errors <- paste0(status_i$errors, "\n- Variable doesn't exist")
    } else {
      # check for NAs allowed
      if (fmt_i$NA_allowed == FALSE & sum(is.na(x[[i]])) > 0) {
        status_i$errors <- paste0(status_i$errors, "\n- NA exists (not allowed)")
      }
      # if(!is.null())

      if (status_i$errors == "\U274C Errors:") status_i$errors <- "\U2705 No errors"
    }
    status[[i]] <- status_i
  }

  setattr(x, "status", status)
  setattr(x, "hash", new_hash)
}

assert_classes <- function(x, ...) {
  UseMethod("assert_classes", x)
}

create_unified_columns <- function(x, ...) {
  UseMethod("create_unified_columns", x)
}

heal <- function(x, ...) {
  UseMethod("heal", x)
}

#' Remove class csfmt_rts_data_*
#' @param x data.table
#' @examples
#' x <- cstidy::generate_test_data() %>%
#'   cstidy::set_csfmt_rts_data_v2()
#' class(x)
#' cstidy::remove_class_csfmt_rts_data(x)
#' class(x)
#' @family csfmt_rts_data
#' @returns No return value, called for the side effect of removing the csfmt_rts_data class from x.
#' @export
remove_class_csfmt_rts_data <- function(x) {
  classes <- class(x)
  classes <- classes[!stringr::str_detect(classes, "^csfmt_rts_data_")]
  setattr(x, "class", classes)
  return(invisible(x))
}


#' Generate test data
#'
#' @description
#' Generates some test data
#'
#' @param fmt Data format (\code{csfmt_rts_data_v2})
#' @examples
#' cstidy::generate_test_data("csfmt_rts_data_v2")
#' @returns csfmt_rts_data_v2, a dataset containing fake data.
#' @export
generate_test_data <- function(fmt = "csfmt_rts_data_v2") {
  granularity_geo <- NULL
  granularity_time <- NULL
  isoyearweek <- NULL
  deaths_n <- NULL
  isoyear <- NULL
  age <- NULL
  sex <- NULL

  stopifnot(fmt %in% c("csfmt_rts_data_v2"))

  if (fmt == "csfmt_rts_data_v2") {
    d1 <- data.table(location_code = csdata::nor_locations_names()[granularity_geo == "county"]$location_code)
    d1[, granularity_time := "isoyearweek"]
    d1[, isoyearweek := "2022-03"]
    d1[, deaths_n := stats::rpois(.N, 5)]

    d2 <- copy(d1)
    d2[, isoyear := 2022]
    d2[, age := "total"]
    d2[, sex := "total"]

    d3 <- copy(d1)
    d3[, isoyear := 2022]
    d3[, age := "000_005"]
    d3[, sex := "total"]

    d <- rbind(d1, d2, d3, fill = T)
  }
  return(d)
}
