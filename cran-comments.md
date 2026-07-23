## Submission

Update to version 2026.7.1.

This release adds `csfmt_rts_data_v3`: a slim, weekly-only clean format (11
columns) with an explicit `heal` step and a content-hash `time_series_id`, plus
a test suite covering it. See NEWS.md for the full list of changes.

## Test environments

* local Windows 11, R 4.4.2 (`R CMD check --no-manual --as-cran`)
* GitHub Actions, ubuntu-latest, R release (`--no-manual --as-cran`)

## R CMD check results

0 errors | 0 warnings | 0 notes

The local run additionally reports "unable to verify current time". That is the
offline clock check on a network without access to the time service, not a
package problem; it does not appear on CI.

## Downstream dependencies

One: `csalert` (2024.6.24 on CRAN) imports `cstidy`. It uses
`csfmt_rts_data_v1`, `set_csfmt_rts_data_v1`, `expand_time_to`,
`unique_time_series` and `nor_covid19_icu_and_hospitalization_csfmt_rts_v1`.
All five are unchanged in this release: everything added here is the new
`csfmt_rts_data_v3` format, and the only diffs to the v1 code path since
2025.10.27 are roxygen documentation. `csalert` is therefore unaffected.
