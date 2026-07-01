Features

01

### Standard data format

Apply
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
to stamp a dataset with the 18-column panel format used across Core
Surveillance real-time pipelines.

02

### Smart assignment

Assigning `isoyear`, `isoyearweek`, `date`, or `location_code` with `:=`
automatically fills all dependent time and geography columns.

03

### Panel inspection

Check completeness with
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md),
extend to a future time point with
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
and plot column structure with
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md).
