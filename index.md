cstidy puts aggregated disease-surveillance counts into one standard
panel format, and derives the time and geography columns that format
needs. Give it a table with a time column and a `location_code`; get
back the same table with `isoyear`, `isoweek`, `season`, `seasonweek`,
`date` and the granularity columns filled in. It does not aggregate
individual-level records — aggregate first, then use cstidy.

cstidy is built by **Core Surveillance**, a team at the Norwegian
Institute of Public Health (NIPH; Folkehelseinstituttet, FHI), alongside
`cstime`, `csdata`, `csalert` and `csstyle`. The `cs` prefix is Core
Surveillance; the format class `csfmt_rts_data_v3` is core surveillance
format, real-time surveillance data, version 3. Defaults follow NIPH
convention — a surveillance season runs from ISO week 35 to ISO week 34,
and geography codes are Norwegian.

Features

01

### Standard data format

Apply
[`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
for the slim weekly format, or
[`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
for the older 18-column format that also covers daily and yearly data.

02

### Smart assignment

Assigning `isoyear`, `isoyearweek`, `date`, or `location_code` with `:=`
automatically re-derives all dependent time and geography columns.

03

### Panel inspection

Check completeness with
[`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md),
extend to a future time point with
[`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
and plot column structure with
[`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md).
