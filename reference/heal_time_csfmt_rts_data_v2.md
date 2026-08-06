# Provides corresponding healed times (deprecated)

Looks up the time columns (such as isoyear, isoweek, isoquarter, season
and date) that correspond to a vector of dates, isoyearweeks, seasons or
isoyears. Returns them as a data.table restricted to the requested
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

## Deprecated

This lookup is deprecated as a public entry point, along with the
`csfmt_rts_data_v2` format it was written for. Nothing warns at run
time, and it is not going away. `heal.csfmt_rts_data_v3()` calls it to
derive v3's time columns. It is still the healing engine behind
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md).
See
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
for what replaces the format, and for the three limits of that
replacement.

## See also

No vignette covers this function.
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
and
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
both call it while healing.

Other time healing lookups:
[`heal_time_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v1.md)

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
