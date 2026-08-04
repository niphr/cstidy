# Pipe operator

See `magrittr::%>%` for details.

## Usage

``` r
lhs %>% rhs
```

## Arguments

- lhs:

  A value or the magrittr placeholder.

- rhs:

  A function call using the magrittr semantics.

## Value

The result of calling `rhs(lhs)`.

## See also

`magrittr::%>%` for the operator itself. Two vignettes use it in a code
chunk to pipe cstidy calls together:
[`vignette("cstidy", package = "cstidy")`](https://niphr.github.io/cstidy/articles/cstidy.md)
and
[`vignette("csfmt_rts_data_v2", package = "cstidy")`](https://niphr.github.io/cstidy/articles/csfmt_rts_data_v2.md).
