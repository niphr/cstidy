# Convert data.table to csfmt_rts_data_v1 (deprecated)

`set_csfmt_rts_data_v1` converts a `data.table` to `csfmt_rts_data_v1`
by reference. `csfmt_rts_data_v1` creates a new `csfmt_rts_data_v1` (not
by reference) from a `data.table`. Both stop with an error when `x` is
not a `data.table`; call
[`data.table::setDT()`](https://rdrr.io/pkg/data.table/man/setDT.html)
first.

## Usage

``` r
set_csfmt_rts_data_v1(x, create_unified_columns = TRUE, heal = TRUE)

csfmt_rts_data_v1(x, create_unified_columns = TRUE, heal = TRUE)
```

## Arguments

- x:

  The data.table to be converted to csfmt_rts_data_v1

- create_unified_columns:

  Do you want it to create unified columns?

- heal:

  Derive the missing time and geography columns on creation? These are
  deterministically looked up from the time and location columns you
  supply (see `cstime` and `csdata`); nothing is statistically imputed
  and no count is invented. Time healing reads `granularity_time` to
  decide which time column the others are derived from, so supply it.

## Value

An extended `data.table`, which has been modified by reference and
returned (invisibly).

Returns a duplicated csfmt_rts_data_v1.

## Smart assignment

`csfmt_rts_data_v1` contains the smart assignment feature for time and
geography.

When the **variables in bold** are assigned using `:=`, the listed
variables are automatically re-derived from it. This is deterministic
derivation from a calendar and a geography lookup, not statistical
imputation.

**location_code**:

- granularity_geo

- country_iso3

**isoyear**:

- granularity_time

- isoweek

- isoyearweek

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

- date

**isoyearweek**:

- granularity_time

- isoyear

- isoweek

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

- date

**date**:

- granularity_time

- isoyear

- isoweek

- isoyearweek

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

## Unified columns

`csfmt_rts_data_v1` contains 16 unified columns:

- granularity_time

- granularity_geo

- country_iso3

- location_code

- border

- age

- sex

- isoyear

- isoweek

- isoyearweek

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

- date

## See also

No vignette runs this function. The benchmarks vignette reports its run
time, but that vignette is precompiled and carries no runnable code:
[`vignette("benchmarks", package = "cstidy")`](https://niphr.github.io/cstidy/articles/benchmarks.md).
This format is deprecated.
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
accepts every `granularity_time` this format accepts, plus "season". Use
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
for weekly-only data.

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)

Other csfmt format converters:
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)

## Examples

``` r
# granularity_time names the time column that the others are derived from.
d <- data.table::data.table(
  granularity_time = "isoyearweek",
  isoyearweek = c("2022-01", "2022-02"),
  location_code = "county_nor03",
  deaths_n = c(3L, 5L)
)

# set_csfmt_rts_data_v1() converts d in place and returns it invisibly.
cstidy::set_csfmt_rts_data_v1(d)
d[]
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor03     NA   <NA>
#> 2:      isoyearweek          county          nor  county_nor03     NA   <NA>
#>       sex isoyear isoweek isoyearweek    season seasonweek calyear calmonth
#>    <char>   <int>   <int>      <char>    <char>      <num>   <int>    <int>
#> 1:   <NA>    2022       1     2022-01 2021/2022         24      NA       NA
#> 2:   <NA>    2022       2     2022-02 2021/2022         25      NA       NA
#>    calyearmonth       date deaths_n
#>          <char>     <Date>    <int>
#> 1:         <NA> 2022-01-09        3
#> 2:         <NA> 2022-01-16        5
class(d)
#> [1] "csfmt_rts_data_v1" "data.table"        "data.frame"       

# csfmt_rts_data_v1() copies instead, so e is left as it was.
e <- data.table::data.table(
  granularity_time = "isoyearweek",
  isoyearweek = c("2022-01", "2022-02"),
  location_code = "county_nor03",
  deaths_n = c(3L, 5L)
)
y <- cstidy::csfmt_rts_data_v1(e)
class(y)
#> [1] "csfmt_rts_data_v1" "data.table"        "data.frame"       
class(e)
#> [1] "data.table" "data.frame"
names(e)
#> [1] "granularity_time" "isoyearweek"      "location_code"    "deaths_n"        
```
