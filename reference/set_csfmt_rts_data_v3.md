# Convert a data.table to csfmt_rts_data_v3 (clean csfmt; explicit healing)

Eleven unified columns, taken from the 18 of
[`set_csfmt_rts_data_v2`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md):
granularity_geo, country_iso3, location_code, age, sex, isoyear,
isoweek, isoyearweek, season, seasonweek and date. It drops the
self-healing `[` override (healing is explicit) and gives
`time_series_id` a content hash.

## Usage

``` r
set_csfmt_rts_data_v3(x, create_unified_columns = TRUE, heal = TRUE)

csfmt_rts_data_v3(x, create_unified_columns = TRUE, heal = TRUE)
```

## Arguments

- x:

  The data.table to convert (by reference).

- create_unified_columns:

  Create the unified columns?

- heal:

  Derive the missing time and geography columns on creation? These are
  deterministically looked up from `isoyearweek` and `location_code`;
  nothing is statistically imputed and no count is invented.

## Value

x, modified by reference, invisibly.

A new csfmt_rts_data_v3 (not by reference).

## See also

No vignette covers csfmt_rts_data_v3. The data-format vignette documents
the csfmt_rts_data_v2 columns that this format takes its own from:
[`vignette("csfmt_rts_data_v2", package = "cstidy")`](https://niphr.github.io/cstidy/articles/csfmt_rts_data_v2.md).

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)

Other csfmt format converters:
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)

## Examples

``` r
# v3 is weekly-only: the other time columns come from isoyearweek alone.
d <- data.table::data.table(
  isoyearweek = c("2020-34", "2020-35"),
  location_code = "nation_nor",
  deaths_n = c(1L, 2L)
)

# set_csfmt_rts_data_v3() converts d in place and returns it invisibly.
cstidy::set_csfmt_rts_data_v3(d)
d[]
#>    granularity_geo country_iso3 location_code    age    sex isoyear isoweek
#>             <char>       <char>        <char> <char> <char>   <int>   <int>
#> 1:          nation          nor    nation_nor   <NA>   <NA>    2020      34
#> 2:          nation          nor    nation_nor   <NA>   <NA>    2020      35
#>    isoyearweek    season seasonweek       date deaths_n
#>         <char>    <char>      <num>     <Date>    <int>
#> 1:     2020-34 2019/2020         52 2020-08-23        1
#> 2:     2020-35 2020/2021          1 2020-08-30        2
class(d)
#> [1] "csfmt_rts_data_v3" "data.table"        "data.frame"       

# csfmt_rts_data_v3() copies instead, so e is left as it was.
e <- data.table::data.table(
  isoyearweek = c("2020-34", "2020-35"),
  location_code = "nation_nor",
  deaths_n = c(1L, 2L)
)
y <- cstidy::csfmt_rts_data_v3(e)
class(y)
#> [1] "csfmt_rts_data_v3" "data.table"        "data.frame"       
class(e)
#> [1] "data.table" "data.frame"
names(e)
#> [1] "isoyearweek"   "location_code" "deaths_n"     
```
