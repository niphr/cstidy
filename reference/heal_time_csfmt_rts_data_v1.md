# Provides corresponding healed times (deprecated)

Looks up the time columns (such as isoyear, isoweek, season, and date)
that correspond to a vector of dates, isoyearweeks, or isoyears,
returning them as a data.table restricted to the requested columns.

## Usage

``` r
heal_time_csfmt_rts_data_v1(x, cols, granularity_time = "date")
```

## Arguments

- x:

  A vector containing either dates, isoyearweek, or isoyear.

- cols:

  Columns to restrict the output to.

- granularity_time:

  date, isoyearweek, or isoyear, depending on the values contained in x.

## Value

data.table, a dataset with time columns corresponding to the values
given in x.

## Examples

``` r
cstidy::heal_time_csfmt_rts_data_v1(
  as.Date(c("2022-01-01", "2022-06-15")),
  cols = c("isoyear", "isoyearweek", "date"),
  granularity_time = "date"
)
#>    isoyear isoyearweek
#>      <int>      <char>
#> 1:    2021     2021-52
#> 2:    2022     2022-24
```
