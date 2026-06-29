# Provides corresponding healed times

Provides corresponding healed times

## Usage

``` r
heal_time_csfmt_rts_data_v2(x, cols, granularity_time = "date")
```

## Arguments

- x:

  A vector containing either dates, isoyearweek, or isoyear.

- cols:

  Columns to restrict the output to.

- granularity_time:

  date, isoyearweek, or isoyear, depending on the values contained in x.

## Value

data.table, a dataset with time columns corresponding to the values
given in x.
