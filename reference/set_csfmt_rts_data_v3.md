# Convert a data.table to csfmt_rts_data_v3 (clean csfmt; explicit healing)

Same unified columns as
[`set_csfmt_rts_data_v2`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
but without the self-healing `[` override (healing is explicit) and with
a content-hash `time_series_id`.

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

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)
