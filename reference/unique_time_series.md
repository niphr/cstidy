# Unique time series

Attempts to identify the unique time series that exist in this dataset.

A time series is defined as a unique combination of:

- granularity_time

- granularity_geo

- country_iso3

- location_code

- border

- age

- sex

- \*\_id

- \*\_tag

## Usage

``` r
unique_time_series(x, set_time_series_id = FALSE, ...)
```

## Arguments

- x:

  An object of type
  [`csfmt_rts_data_v2`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)

- set_time_series_id:

  If TRUE, then `x` will have a new column called 'time_series_id'

- ...:

  Not used.

## Value

data.table, a dataset that lists all the unique time series in x.

## See also

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
