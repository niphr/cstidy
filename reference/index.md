# Package index

## Format — set and remove the csfmt_rts_data class

Convert a data.table to a versioned csfmt_rts_data object, or strip the
class back off.

- [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  [`csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  : Convert data.table to csfmt_rts_data_v1 (deprecated)
- [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
  [`csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
  : Convert data.table to csfmt_rts_data_v2
- [`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md)
  : Remove class csfmt_rts_data\_\*

## Time-series helpers

Expand, heal, and deduplicate time series within a csfmt_rts_data
object.

- [`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md)
  : Expand time to
- [`heal_time_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v1.md)
  : Provides corresponding healed times (deprecated)
- [`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md)
  : Provides corresponding healed times
- [`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md)
  : Unique time series

## Inspect and diagnose

Summarise or fingerprint the structure of a dataset.

- [`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md)
  : Hash the data structure of a dataset for a given column

## Example datasets

Bundled real-world and synthetic datasets for examples and testing.

- [`nor_covid19_cases_by_time_location_csfmt_rts_v1`](https://niphr.github.io/cstidy/reference/nor_covid19_cases_by_time_location_csfmt_rts_v1.md)
  : Covid-19 data for PCR-confirmed cases in Norway (nation and county)
- [`nor_covid19_icu_and_hospitalization_csfmt_rts_v1`](https://niphr.github.io/cstidy/reference/nor_covid19_icu_and_hospitalization_csfmt_rts_v1.md)
  : Norwegian Covid-19 data for ICU and hospitalization
- [`generate_test_data()`](https://niphr.github.io/cstidy/reference/generate_test_data.md)
  : Generate test data
