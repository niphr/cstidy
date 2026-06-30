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

  Maximum isoyear to expand each isoyear time series up to.

- max_isoyearweek:

  Maximum isoyearweek to expand each isoyearweek time series up to.

- max_date:

  Maximum date to expand each daily time series up to.

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

## Examples

``` r
x <- cstidy::generate_test_data() %>%
  cstidy::set_csfmt_rts_data_v2()
cstidy::expand_time_to(x, max_isoyearweek = "2022-10")
#>      granularity_time granularity_geo country_iso3 location_code border     age
#>                <char>          <char>       <char>        <char>  <int>  <char>
#>   1:      isoyearweek          county          nor  county_nor42     NA    <NA>
#>   2:      isoyearweek          county          nor  county_nor42     NA    <NA>
#>   3:      isoyearweek          county          nor  county_nor42     NA    <NA>
#>   4:      isoyearweek          county          nor  county_nor42     NA    <NA>
#>   5:      isoyearweek          county          nor  county_nor42     NA    <NA>
#>  ---                                                                           
#> 356:      isoyearweek          county          nor  county_nor31     NA 000_005
#> 357:      isoyearweek          county          nor  county_nor31     NA 000_005
#> 358:      isoyearweek          county          nor  county_nor31     NA 000_005
#> 359:      isoyearweek          county          nor  county_nor31     NA 000_005
#> 360:      isoyearweek          county          nor  county_nor31     NA 000_005
#>         sex isoyear isoweek isoyearweek isoquarter isoyearquarter    season
#>      <char>   <int>   <int>      <char>      <int>         <char>    <char>
#>   1:   <NA>    2022       3     2022-03          1        2022-Q1 2021/2022
#>   2:   <NA>    2022       4     2022-04          1        2022-Q1 2021/2022
#>   3:   <NA>    2022       5     2022-05          1        2022-Q1 2021/2022
#>   4:   <NA>    2022       6     2022-06          1        2022-Q1 2021/2022
#>   5:   <NA>    2022       7     2022-07          1        2022-Q1 2021/2022
#>  ---                                                                       
#> 356:  total    2022       6     2022-06          1        2022-Q1 2021/2022
#> 357:  total    2022       7     2022-07          1        2022-Q1 2021/2022
#> 358:  total    2022       8     2022-08          1        2022-Q1 2021/2022
#> 359:  total    2022       9     2022-09          1        2022-Q1 2021/2022
#> 360:  total    2022      10     2022-10          1        2022-Q1 2021/2022
#>      seasonweek calyear calmonth calyearmonth       date deaths_n
#>           <num>   <int>    <int>       <char>     <Date>    <int>
#>   1:         21      NA       NA         <NA> 2022-01-23        2
#>   2:         22      NA       NA         <NA> 2022-01-30       NA
#>   3:         23      NA       NA         <NA> 2022-02-06       NA
#>   4:         24      NA       NA         <NA> 2022-02-13       NA
#>   5:         25      NA       NA         <NA> 2022-02-20       NA
#>  ---                                                             
#> 356:         24      NA       NA         <NA> 2022-02-13       NA
#> 357:         25      NA       NA         <NA> 2022-02-20       NA
#> 358:         26      NA       NA         <NA> 2022-02-27       NA
#> 359:         27      NA       NA         <NA> 2022-03-06       NA
#> 360:         28      NA       NA         <NA> 2022-03-13       NA
```
