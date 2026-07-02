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
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)

## Examples

``` r
x <- cstidy::generate_test_data() %>%
  cstidy::set_csfmt_rts_data_v2()
cstidy::unique_time_series(x)
#>     granularity_time granularity_geo country_iso3 location_code border     age
#>               <char>          <char>       <char>        <char>  <int>  <char>
#>  1:      isoyearweek          county          nor  county_nor42     NA    <NA>
#>  2:      isoyearweek          county          nor  county_nor32     NA    <NA>
#>  3:      isoyearweek          county          nor  county_nor33     NA    <NA>
#>  4:      isoyearweek          county          nor  county_nor56     NA    <NA>
#>  5:      isoyearweek          county          nor  county_nor34     NA    <NA>
#>  6:      isoyearweek          county          nor  county_nor15     NA    <NA>
#>  7:      isoyearweek          county          nor  county_nor18     NA    <NA>
#>  8:      isoyearweek          county          nor  county_nor03     NA    <NA>
#>  9:      isoyearweek          county          nor  county_nor11     NA    <NA>
#> 10:      isoyearweek          county          nor  county_nor40     NA    <NA>
#> 11:      isoyearweek          county          nor  county_nor55     NA    <NA>
#> 12:      isoyearweek          county          nor  county_nor50     NA    <NA>
#> 13:      isoyearweek          county          nor  county_nor39     NA    <NA>
#> 14:      isoyearweek          county          nor  county_nor46     NA    <NA>
#> 15:      isoyearweek          county          nor  county_nor31     NA    <NA>
#> 16:      isoyearweek          county          nor  county_nor42     NA   total
#> 17:      isoyearweek          county          nor  county_nor32     NA   total
#> 18:      isoyearweek          county          nor  county_nor33     NA   total
#> 19:      isoyearweek          county          nor  county_nor56     NA   total
#> 20:      isoyearweek          county          nor  county_nor34     NA   total
#> 21:      isoyearweek          county          nor  county_nor15     NA   total
#> 22:      isoyearweek          county          nor  county_nor18     NA   total
#> 23:      isoyearweek          county          nor  county_nor03     NA   total
#> 24:      isoyearweek          county          nor  county_nor11     NA   total
#> 25:      isoyearweek          county          nor  county_nor40     NA   total
#> 26:      isoyearweek          county          nor  county_nor55     NA   total
#> 27:      isoyearweek          county          nor  county_nor50     NA   total
#> 28:      isoyearweek          county          nor  county_nor39     NA   total
#> 29:      isoyearweek          county          nor  county_nor46     NA   total
#> 30:      isoyearweek          county          nor  county_nor31     NA   total
#> 31:      isoyearweek          county          nor  county_nor42     NA 000_005
#> 32:      isoyearweek          county          nor  county_nor32     NA 000_005
#> 33:      isoyearweek          county          nor  county_nor33     NA 000_005
#> 34:      isoyearweek          county          nor  county_nor56     NA 000_005
#> 35:      isoyearweek          county          nor  county_nor34     NA 000_005
#> 36:      isoyearweek          county          nor  county_nor15     NA 000_005
#> 37:      isoyearweek          county          nor  county_nor18     NA 000_005
#> 38:      isoyearweek          county          nor  county_nor03     NA 000_005
#> 39:      isoyearweek          county          nor  county_nor11     NA 000_005
#> 40:      isoyearweek          county          nor  county_nor40     NA 000_005
#> 41:      isoyearweek          county          nor  county_nor55     NA 000_005
#> 42:      isoyearweek          county          nor  county_nor50     NA 000_005
#> 43:      isoyearweek          county          nor  county_nor39     NA 000_005
#> 44:      isoyearweek          county          nor  county_nor46     NA 000_005
#> 45:      isoyearweek          county          nor  county_nor31     NA 000_005
#>     granularity_time granularity_geo country_iso3 location_code border     age
#>               <char>          <char>       <char>        <char>  <int>  <char>
#>        sex time_series_id
#>     <char>          <int>
#>  1:   <NA>              1
#>  2:   <NA>              2
#>  3:   <NA>              3
#>  4:   <NA>              4
#>  5:   <NA>              5
#>  6:   <NA>              6
#>  7:   <NA>              7
#>  8:   <NA>              8
#>  9:   <NA>              9
#> 10:   <NA>             10
#> 11:   <NA>             11
#> 12:   <NA>             12
#> 13:   <NA>             13
#> 14:   <NA>             14
#> 15:   <NA>             15
#> 16:  total             16
#> 17:  total             17
#> 18:  total             18
#> 19:  total             19
#> 20:  total             20
#> 21:  total             21
#> 22:  total             22
#> 23:  total             23
#> 24:  total             24
#> 25:  total             25
#> 26:  total             26
#> 27:  total             27
#> 28:  total             28
#> 29:  total             29
#> 30:  total             30
#> 31:  total             31
#> 32:  total             32
#> 33:  total             33
#> 34:  total             34
#> 35:  total             35
#> 36:  total             36
#> 37:  total             37
#> 38:  total             38
#> 39:  total             39
#> 40:  total             40
#> 41:  total             41
#> 42:  total             42
#> 43:  total             43
#> 44:  total             44
#> 45:  total             45
#>        sex time_series_id
#>     <char>          <int>
```
