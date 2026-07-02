# Tests for csfmt_rts_data_v3: the clean, weekly-only csfmt with explicit healing
# and a content-hash time_series_id (R/csfmt_rts_v3.R).

library(data.table)

make_input <- function()
  data.table(
    location_code = "norge",
    isoyearweek   = c("2024-01", "2024-40"),
    age           = "total",
    sex           = "total",
    value         = c(10, 20))

test_that("set_csfmt_rts_data_v3 heals time columns from isoyearweek", {
  x <- csfmt_rts_data_v3(make_input())
  expect_s3_class(x, "csfmt_rts_data_v3")
  # isoyear / isoweek parsed straight off isoyearweek
  expect_equal(x$isoyear, c(2024L, 2024L))
  expect_equal(x$isoweek, c(1L, 40L))
  # season / seasonweek derived (week 1 falls in the prior autumn's season)
  expect_equal(x$season, c("2023/2024", "2024/2025"))
  expect_equal(x$seasonweek, c(19, 6))
  # date is a real Date, one per week, never NA
  expect_s3_class(x$date, "Date")
  expect_false(anyNA(x$date))
})

test_that("geo columns are healed from location_code", {
  x <- csfmt_rts_data_v3(make_input())
  expect_equal(unique(x$granularity_geo), "nation")
  expect_equal(unique(x$country_iso3), "nor")
})

test_that("the unified column set is exactly the 11 weekly columns, value appended", {
  x <- csfmt_rts_data_v3(make_input())
  weekly <- c("granularity_geo", "country_iso3", "location_code", "age", "sex",
              "isoyear", "isoweek", "isoyearweek", "season", "seasonweek", "date")
  # unified columns come first, in the canonical order, then extra value columns
  expect_equal(head(names(x), length(weekly)), weekly)
  expect_true("value" %in% names(x))
  # v3 is weekly-only: none of v2's quarterly/monthly/border columns leak in
  expect_false(any(c("isoquarter", "isoyearquarter", "calmonth", "border",
                     "granularity_time") %in% names(x)))
})

test_that("csfmt_rts_data_v3() copies; set_csfmt_rts_data_v3() is by-reference", {
  d <- make_input()
  y <- csfmt_rts_data_v3(d)                 # copy constructor
  expect_false("isoyear" %in% names(d))     # original untouched
  expect_true("isoyear" %in% names(y))

  d2 <- make_input()
  set_csfmt_rts_data_v3(d2)                  # by reference
  expect_true("isoyear" %in% names(d2))
  expect_s3_class(d2, "csfmt_rts_data_v3")
})

test_that("heal requires an isoyearweek column", {
  d <- data.table(location_code = "norge", age = "total", sex = "total", value = 1)
  # no isoyearweek -> explicit heal path errors rather than silently guessing
  expect_error(heal.csfmt_rts_data_v3(d), "isoyearweek")
})

test_that("unique_time_series assigns a content-hash time_series_id", {
  x <- csfmt_rts_data_v3(make_input())
  u <- unique_time_series(x)
  expect_true("time_series_id" %in% names(u))
  expect_type(u$time_series_id, "character")
  # one identity here (single location/age/sex), so one time series
  expect_equal(nrow(u), 1L)
})

test_that("time_series_id is content-derived: stable across objects and subsets", {
  x1 <- csfmt_rts_data_v3(make_input())
  # a second object with the SAME identity columns but different values/row order
  d2 <- make_input()[, value := c(999, 1)][2:1]
  x2 <- csfmt_rts_data_v3(d2)

  id1 <- unique_time_series(x1)$time_series_id
  id2 <- unique_time_series(x2)$time_series_id
  expect_identical(id1, id2)   # hash depends on identity, not values or order

  # a different location yields a different id
  d3 <- make_input()[, location_code := "county03"]
  id3 <- unique_time_series(csfmt_rts_data_v3(d3))$time_series_id
  expect_false(identical(id1, id3))
})

test_that("set_time_series_id writes the id back onto the data", {
  x <- csfmt_rts_data_v3(make_input())
  unique_time_series(x, set_time_series_id = TRUE)
  expect_true("time_series_id" %in% names(x))
  expect_equal(uniqueN(x$time_series_id), 1L)
})
