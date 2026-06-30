# Generate test data

Generates some test data

## Usage

``` r
generate_test_data(fmt = "csfmt_rts_data_v2")
```

## Arguments

- fmt:

  Data format (`csfmt_rts_data_v2`)

## Value

csfmt_rts_data_v2, a dataset containing fake data.

## Examples

``` r
cstidy::generate_test_data("csfmt_rts_data_v2")
#>     location_code granularity_time isoyearweek deaths_n isoyear     age    sex
#>            <char>           <char>      <char>    <int>   <num>  <char> <char>
#>  1:  county_nor42      isoyearweek     2022-03        3      NA    <NA>   <NA>
#>  2:  county_nor32      isoyearweek     2022-03        4      NA    <NA>   <NA>
#>  3:  county_nor33      isoyearweek     2022-03        2      NA    <NA>   <NA>
#>  4:  county_nor56      isoyearweek     2022-03        4      NA    <NA>   <NA>
#>  5:  county_nor34      isoyearweek     2022-03       10      NA    <NA>   <NA>
#>  6:  county_nor15      isoyearweek     2022-03        4      NA    <NA>   <NA>
#>  7:  county_nor18      isoyearweek     2022-03        6      NA    <NA>   <NA>
#>  8:  county_nor03      isoyearweek     2022-03        6      NA    <NA>   <NA>
#>  9:  county_nor11      isoyearweek     2022-03        3      NA    <NA>   <NA>
#> 10:  county_nor40      isoyearweek     2022-03       10      NA    <NA>   <NA>
#> 11:  county_nor55      isoyearweek     2022-03        6      NA    <NA>   <NA>
#> 12:  county_nor50      isoyearweek     2022-03        2      NA    <NA>   <NA>
#> 13:  county_nor39      isoyearweek     2022-03        5      NA    <NA>   <NA>
#> 14:  county_nor46      isoyearweek     2022-03        6      NA    <NA>   <NA>
#> 15:  county_nor31      isoyearweek     2022-03        6      NA    <NA>   <NA>
#> 16:  county_nor42      isoyearweek     2022-03        3    2022   total  total
#> 17:  county_nor32      isoyearweek     2022-03        4    2022   total  total
#> 18:  county_nor33      isoyearweek     2022-03        2    2022   total  total
#> 19:  county_nor56      isoyearweek     2022-03        4    2022   total  total
#> 20:  county_nor34      isoyearweek     2022-03       10    2022   total  total
#> 21:  county_nor15      isoyearweek     2022-03        4    2022   total  total
#> 22:  county_nor18      isoyearweek     2022-03        6    2022   total  total
#> 23:  county_nor03      isoyearweek     2022-03        6    2022   total  total
#> 24:  county_nor11      isoyearweek     2022-03        3    2022   total  total
#> 25:  county_nor40      isoyearweek     2022-03       10    2022   total  total
#> 26:  county_nor55      isoyearweek     2022-03        6    2022   total  total
#> 27:  county_nor50      isoyearweek     2022-03        2    2022   total  total
#> 28:  county_nor39      isoyearweek     2022-03        5    2022   total  total
#> 29:  county_nor46      isoyearweek     2022-03        6    2022   total  total
#> 30:  county_nor31      isoyearweek     2022-03        6    2022   total  total
#> 31:  county_nor42      isoyearweek     2022-03        3    2022 000_005  total
#> 32:  county_nor32      isoyearweek     2022-03        4    2022 000_005  total
#> 33:  county_nor33      isoyearweek     2022-03        2    2022 000_005  total
#> 34:  county_nor56      isoyearweek     2022-03        4    2022 000_005  total
#> 35:  county_nor34      isoyearweek     2022-03       10    2022 000_005  total
#> 36:  county_nor15      isoyearweek     2022-03        4    2022 000_005  total
#> 37:  county_nor18      isoyearweek     2022-03        6    2022 000_005  total
#> 38:  county_nor03      isoyearweek     2022-03        6    2022 000_005  total
#> 39:  county_nor11      isoyearweek     2022-03        3    2022 000_005  total
#> 40:  county_nor40      isoyearweek     2022-03       10    2022 000_005  total
#> 41:  county_nor55      isoyearweek     2022-03        6    2022 000_005  total
#> 42:  county_nor50      isoyearweek     2022-03        2    2022 000_005  total
#> 43:  county_nor39      isoyearweek     2022-03        5    2022 000_005  total
#> 44:  county_nor46      isoyearweek     2022-03        6    2022 000_005  total
#> 45:  county_nor31      isoyearweek     2022-03        6    2022 000_005  total
#>     location_code granularity_time isoyearweek deaths_n isoyear     age    sex
#>            <char>           <char>      <char>    <int>   <num>  <char> <char>
```
