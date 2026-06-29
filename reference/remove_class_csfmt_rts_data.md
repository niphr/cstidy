# Remove class csfmt_rts_data\_\*

Remove class csfmt_rts_data\_\*

## Usage

``` r
remove_class_csfmt_rts_data(x)
```

## Arguments

- x:

  data.table

## Value

No return value, called for the side effect of removing the
csfmt_rts_data class from x.

## See also

Other csfmt_rts_data:
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md),
[`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)

## Examples

``` r
x <- cstidy::generate_test_data() %>%
  cstidy::set_csfmt_rts_data_v2()
class(x)
#> [1] "csfmt_rts_data_v2" "data.table"        "data.frame"       
cstidy::remove_class_csfmt_rts_data(x)
class(x)
#> [1] "data.table" "data.frame"
```
