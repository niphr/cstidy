# Provides corresponding healed times

Looks up the time columns (such as isoyear, isoweek, isoquarter, season,
and date) that correspond to a vector of dates, isoyearweeks, seasons,
or isoyears, returning them as a data.table restricted to the requested
columns.

## Usage

``` r
heal_time_csfmt_rts_data_v2(x, cols, granularity_time = "date")
```

## Arguments

- x:

  A vector containing dates, isoyearweek, season, or isoyear.

- cols:

  Columns to restrict the output to.

- granularity_time:

  One of "date", "isoyearweek", "season", or "isoyear", matching the
  values contained in x.

## Value

data.table, a dataset with time columns corresponding to the values
given in x.

## Examples

``` r
cstidy::heal_time_csfmt_rts_data_v2(
  c("2022-01", "2022-02"),
  cols = c("isoyear", "isoweek", "season", "date"),
  granularity_time = "isoyearweek"
)
#>    isoyear isoweek    season       date
#>      <int>   <int>    <char>     <Date>
#> 1:    2022       1 2021/2022 2022-01-09
#> 2:    2022       2 2021/2022 2022-01-16
```
