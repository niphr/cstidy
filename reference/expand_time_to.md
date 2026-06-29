# Expand time to

Attempts to expand the dataset to include more time

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
expand_time_to(
  x,
  max_isoyear = NULL,
  max_isoyearweek = NULL,
  max_date = NULL,
  ...
)
```

## Arguments

- x:

  An object of type
  [`csfmt_rts_data_v2`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)

- max_isoyear:

  Maximum isoyear

- max_isoyearweek:

  Maximum isoyearweek

- max_date:

  Maximum date

- ...:

  Not used.

## Value

csfmt_rts_data_v2, a larger dataset that includes more rows
corresponding to more time.

## See also

Other csfmt_rts_data:
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)
