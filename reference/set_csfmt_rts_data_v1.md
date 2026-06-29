# Convert data.table to csfmt_rts_data_v1 (deprecated)

`set_csfmt_rts_data_v1` converts a `data.table` to `csfmt_rts_data_v1`
by reference. `csfmt_rts_data_v1` creates a new `csfmt_rts_data_v1` (not
by reference) from either a `data.table` or `data.frame`.

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

  Do you want to impute missing values on creation?

## Value

An extended `data.table`, which has been modified by reference and
returned (invisibly).

No return value, called for side effect of replacing the current
data.table with a csfmt_rts_data_v1 in place.

Returns a duplicated csfmt_rts_data_v1.

## Smart assignment

`csfmt_rts_data_v1` contains the smart assignment feature for time and
geography.

When the **variables in bold** are assigned using `:=`, the listed
variables will be automatically imputed.

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

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)
