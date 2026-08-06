# Convert data.table to csfmt_rts_data_v2 (deprecated)

`set_csfmt_rts_data_v2` converts a `data.table` to `csfmt_rts_data_v2`
by reference. `csfmt_rts_data_v2` creates a new `csfmt_rts_data_v2` (not
by reference) from a `data.table`. Both stop with an error when `x` is
not a `data.table`; call
[`data.table::setDT()`](https://rdrr.io/pkg/data.table/man/setDT.html)
first.

## Usage

``` r
set_csfmt_rts_data_v2(x, create_unified_columns = TRUE, heal = TRUE)

csfmt_rts_data_v2(x, create_unified_columns = TRUE, heal = TRUE)
```

## Arguments

- x:

  The data.table to be converted to csfmt_rts_data_v2

- create_unified_columns:

  Do you want it to create unified columns?

- heal:

  Derive the missing time and geography columns on creation? These are
  deterministically looked up from the time and location columns you
  supply (see `cstime` and `csdata`). Nothing is statistically imputed
  and no count is invented. Time healing reads `granularity_time` to
  decide which time column the others are derived from, so supply it.

## Value

An extended `data.table`, which has been modified by reference and
returned (invisibly).

Returns a duplicated csfmt_rts_data_v2.

## Details

For more details see the vignette:
[`vignette("csfmt_rts_data_v2", package = "cstidy")`](https://niphr.github.io/cstidy/articles/csfmt_rts_data_v2.md)

## Smart assignment

`csfmt_rts_data_v2` contains the smart assignment feature for time and
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

- isoquarter

- isoyearquarter

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

- isoquarter

- isoyearquarter

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

- date

**season**:

- granularity_time

- isoyear

- isoweek

- isoyearweek

- isoquarter

- isoyearquarter

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

- isoquarter

- isoyearquarter

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

## Unified columns

`csfmt_rts_data_v2` contains 18 unified columns:

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

- isoquarter

- isoyearquarter

- season

- seasonweek

- calyear

- calmonth

- calyearmonth

- date

## Deprecated

`csfmt_rts_data_v2` is deprecated as a direction of travel, not because
a finished replacement exists. The format still works, nothing warns at
run time, and nothing has been removed.
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
is what new work should target, subject to three limits that were
measured rather than estimated.

First, v3 derives fewer columns than v2, but drops none. Counted on the
unified set, v2 derives 18 columns and v3 derives 11. The unified set is
`names(attr(x, "format_unified"))`, the columns each format creates when
the input lacks them. The seven columns in v2's unified set and not in
v3's are `granularity_time`, `border`, `isoquarter`, `isoyearquarter`,
`calyear`, `calmonth` and `calyearmonth`. Deriving and keeping are
different things.
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
removes no column. An existing v2 object converted to v3 keeps every
column it had, `granularity_time` and `border` included. v3 healing
still refreshes `isoquarter` and `isoyearquarter` when the columns are
present. What a move to v3 costs is the guarantee. A v3 table built from
an input that lacks those columns will not have them, where the same
input under v2 would.

Second, v3 is weekly-only, and that is what costs you the calendar
columns. `heal.csfmt_rts_data_v3()` derives from `isoyearweek` alone.
The isoyearweek lookup holds no calendar values at all. `calyear`,
`calmonth` and `calyearmonth` are NA for all 7829 rows of the
isoyearweek lookup, under v2 as much as under v3. So no v3 table can
populate them. Heal from `date` under v2 if you aggregate by calendar
month or calendar year. A daily table converted to v3 keeps its `date`
values and gets nothing else healed.

Third, `csdb` cannot CHECK a v3 table, though it can store one. `csdb`
exports `validator_field_types_csfmt_rts_data_v1()` and
`validator_field_types_csfmt_rts_data_v2()` and has no v3 equivalent, so
a v3 column set fails both. The validator is an ordinary argument to
`csdb::DBTable_v9$new()`: pass `validator_field_types_blank()`, or a
function of your own, and the table writes. What you lose is the column
check, not the ability to store.

So continue with v2 in any of these three cases:

- The data covers a granularity other than isoyearweek.

- The data must derive a calendar or quarterly column that the input
  does not carry.

- `csdb` must validate the shape of the data on the way in.

## See also

Two vignettes run `set_csfmt_rts_data_v2()` in a code chunk:
[`vignette("cstidy", package = "cstidy")`](https://niphr.github.io/cstidy/articles/cstidy.md)
and
[`vignette("csfmt_rts_data_v2", package = "cstidy")`](https://niphr.github.io/cstidy/articles/csfmt_rts_data_v2.md).
Neither of them runs `csfmt_rts_data_v2()`.

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)

Other csfmt format converters:
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)

## Examples

``` r
# Create some fake data as data.table
d <- cstidy::generate_test_data(fmt = "csfmt_rts_data_v2")
d <- d[1:5]

# convert to csfmt_rts_data_v2 by reference
cstidy::set_csfmt_rts_data_v2(d, create_unified_columns = TRUE)

#
d[1, isoyearweek := "2021-01"]
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:      isoyearweek          county          nor  county_nor32     NA   <NA>
#> 3:      isoyearweek          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 3:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 4:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         21      NA       NA         <NA> 2022-01-23        4
#> 3:         21      NA       NA         <NA> 2022-01-23        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:      isoyearweek          county          nor  county_nor32     NA   <NA>
#> 3:      isoyearweek          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 3:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 4:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         21      NA       NA         <NA> 2022-01-23        4
#> 3:         21      NA       NA         <NA> 2022-01-23        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d[2, isoyear := 2019]
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:      isoyearweek          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 4:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         21      NA       NA         <NA> 2022-01-23        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:      isoyearweek          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 4:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         21      NA       NA         <NA> 2022-01-23        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d[3, date := as.Date("2020-01-01")]
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:             date          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2020       1     2020-01          1        2020-Q1 2019/2020
#> 4:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         19    2020        1     2020-M01 2020-01-01        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:             date          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2020       1     2020-01          1        2020-Q1 2019/2020
#> 4:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         19    2020        1     2020-M01 2020-01-01        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d[4, c("isoyear", "isoyearweek") := .(2021, "2021-01")]
#> Warning: Multiple time variables specified. Smart-assignment disabled.
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:             date          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2020       1     2020-01          1        2020-Q1 2019/2020
#> 4:   <NA>    2021       3     2021-01          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         19    2020        1     2020-M01 2020-01-01        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:             date          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          county          nor  county_nor34     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2020       1     2020-01          1        2020-Q1 2019/2020
#> 4:   <NA>    2021       3     2021-01          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         19    2020        1     2020-M01 2020-01-01        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d[5, c("location_code") := .("norge")]
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:             date          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          nation          nor         norge     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2020       1     2020-01          1        2020-Q1 2019/2020
#> 4:   <NA>    2021       3     2021-01          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         19    2020        1     2020-M01 2020-01-01        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5
d
#>    granularity_time granularity_geo country_iso3 location_code border    age
#>              <char>          <char>       <char>        <char>  <int> <char>
#> 1:      isoyearweek          county          nor  county_nor42     NA   <NA>
#> 2:          isoyear          county          nor  county_nor32     NA   <NA>
#> 3:             date          county          nor  county_nor33     NA   <NA>
#> 4:      isoyearweek          county          nor  county_nor56     NA   <NA>
#> 5:      isoyearweek          nation          nor         norge     NA   <NA>
#>       sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>    <char>   <int>   <int>      <char>      <int>         <char>    <char>
#> 1:   <NA>    2021       1     2021-01          1        2021-Q1 2020/2021
#> 2:   <NA>    2019      52     2019-52          1        2022-Q1      <NA>
#> 3:   <NA>    2020       1     2020-01          1        2020-Q1 2019/2020
#> 4:   <NA>    2021       3     2021-01          1        2022-Q1 2021/2022
#> 5:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>    seasonweek calyear calmonth calyearmonth       date deaths_n
#>         <num>   <int>    <int>       <char>     <Date>    <int>
#> 1:         19      NA       NA         <NA> 2021-01-10        7
#> 2:         NA      NA       NA         <NA> 2019-12-29        4
#> 3:         19    2020        1     2020-M01 2020-01-01        5
#> 4:         21      NA       NA         <NA> 2022-01-23        4
#> 5:         21      NA       NA         <NA> 2022-01-23        5

# Investigating the data structure of one column inside a dataset
cstidy::generate_test_data() %>%
  cstidy::set_csfmt_rts_data_v2() %>%
  cstidy::identify_data_structure("deaths_n") %>%
  plot()

# Investigating the data structure via summary
cstidy::generate_test_data() %>%
  cstidy::set_csfmt_rts_data_v2() %>%
  summary()
#> 
#> granularity_time
#> ✅ No errors
#> 
#> granularity_geo
#> ✅ No errors
#> 
#> country_iso3
#> ✅ No errors
#> 
#> location_code
#> ✅ No errors
#> 
#> border
#> ❌ Errors:
#> - NA exists (not allowed)
#> 
#> age
#> ✅ No errors
#> 
#> sex
#> ✅ No errors
#> 
#> isoyear
#> ✅ No errors
#> 
#> isoweek
#> ✅ No errors
#> 
#> isoyearweek
#> ✅ No errors
#> 
#> isoquarter
#> ✅ No errors
#> 
#> isoyearquarter
#> ✅ No errors
#> 
#> season
#> ✅ No errors
#> 
#> seasonweek
#> ✅ No errors
#> 
#> calyear
#> ✅ No errors
#> 
#> calmonth
#> ✅ No errors
#> 
#> calyearmonth
#> ✅ No errors
#> 
#> date
#> ✅ No errors
#> granularity_time (character):
#>  - isoyearweek (n = 45)
#> granularity_geo (character):
#>  - county (n = 45)
#> country_iso3 (character):
#>  - nor (n = 45)
#> location_code (character)
#> border (integer):
#>  - <NA> (n = 45)
#> age (character):
#>  - 000_005 (n = 15)
#>  - <NA>    (n = 15)
#>  - total   (n = 15)
#> sex (character):
#>  - <NA>  (n = 15)
#>  - total (n = 30)
#> isoyear (integer):
#>  - 2022 (n = 45)
#> isoweek (integer)
#> isoyearweek (character)
#> isoquarter (integer)
#> isoyearquarter (character)
#> season (character):
#>  - 2021/2022 (n = 45)
#> seasonweek (numeric)
#> calyear (integer)
#> calmonth (integer)
#> calyearmonth (character)
#> date (Date)
#> deaths_n (integer)
#> 
```
