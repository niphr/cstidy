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

## Deprecated

This lookup is deprecated along with the `csfmt_rts_data_v1` format it
serves. Nothing warns at run time and nothing has been removed; the mark
is a signpost for new work.
[`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md)
replaces it. The two take the same three arguments, v2 accepts every
`granularity_time` this function accepts ("date", "isoyearweek",
"isoyear") plus "season", and v2 can also return `isoquarter` and
`isoyearquarter`. See
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
for the format itself.

## See also

No vignette covers this function.
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
calls it while healing a csfmt_rts_data_v1.

Other time healing lookups:
[`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md)

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
