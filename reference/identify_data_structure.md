# Hash the data structure of a dataset for a given column

Summarises the data structure of a single column inside a dataset. For
each combination of granularity_time, granularity_geo, age, and sex it
records whether the column is structurally missing, only NA, only data,
or a mix of data and NA. The result can be passed to
[`plot()`](https://rdrr.io/r/graphics/plot.default.html) for a visual
overview.

## Usage

``` r
identify_data_structure(x, col, ...)

# S3 method for class 'csfmt_rts_data_v2'
identify_data_structure(x, col, ...)

# S3 method for class '`tbl_Microsoft SQL Server`'
identify_data_structure(x, col, ...)
```

## Arguments

- x:

  An object of type
  [`csfmt_rts_data_v2`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md).

- col:

  Column name (character) whose data structure is summarised.

- ...:

  Arguments passed to or from other methods.

## Value

csfmt_rts_data_structure_hash_v2, a summary object that can be plotted.

## See also

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)

## Examples

``` r
cstidy::generate_test_data() %>%
  cstidy::set_csfmt_rts_data_v2() %>%
  cstidy::identify_data_structure("deaths_n") %>%
  plot()
```
