# Version 2026.8.4

Documentation only. The R files were also reformatted. Comparing the parsed
code against the previous version, every remaining difference is a brace added
around a single-statement body, so no function changed behaviour.

- **Runnable examples on the two help pages that had none.** They cover four
  exports: `set_csfmt_rts_data_v1()`, `csfmt_rts_data_v1()`,
  `set_csfmt_rts_data_v3()` and `csfmt_rts_data_v3()`. Each of the two examples
  runs the by-reference setter and the copying constructor side by side, so the
  difference between them is shown rather than described. The pipe operator's
  page still has no example; it is a re-export marked `@keywords internal`.
- **Every export now resolves to a help page carrying `\seealso`.** Where a
  vignette runs the function in a code chunk, the `\seealso` names that
  vignette. Where no vignette runs it, the `\seealso` says so plainly. No
  vignette runs `heal_time_csfmt_rts_data_v1()`,
  `heal_time_csfmt_rts_data_v2()`, `set_csfmt_rts_data_v1()`,
  `csfmt_rts_data_v1()`, `set_csfmt_rts_data_v3()`, `csfmt_rts_data_v3()` or
  `csfmt_rts_data_v2()`. The Benchmarks vignette names
  `set_csfmt_rts_data_v1()` in a heading, but it is precompiled and carries no
  runnable code.
- **Two new `@family` groups. Both are contractual, not topical**, so the
  members really are interchangeable at a call site.
  - `csfmt format converters` — `set_csfmt_rts_data_v1()`,
    `set_csfmt_rts_data_v2()`, `set_csfmt_rts_data_v3()`. All three take
    `(x, create_unified_columns = TRUE, heal = TRUE)`, stop unless `x` is a
    `data.table`, and return `x` invisibly with that version's class prepended.
  - `time healing lookups` — `heal_time_csfmt_rts_data_v1()` and
    `heal_time_csfmt_rts_data_v2()`. Both take
    `(x, cols, granularity_time = "date")` and return a `data.table`. They are
    not identical: v1 accepts a `granularity_time` of "date", "isoyearweek" or
    "isoyear", while v2 accepts those plus "season" and can also return
    `isoquarter` and `isoyearquarter`.

  The constructor/setter pairing (`csfmt_rts_data_v3()` against
  `set_csfmt_rts_data_v3()`) was considered and rejected. The two share formals
  and return class but not semantics: the setter modifies its argument, the
  constructor leaves it untouched. Swapping one for the other silently changes
  whether the caller's table is rewritten. They already share one help page.
- **Corrections to help pages that described the code wrongly.** Each was
  checked by running the function.
  - `generate_test_data()` was documented as returning a `csfmt_rts_data_v2`.
    It returns a plain `data.table`; you pass it to a setter yourself.
  - `expand_time_to()` was documented as returning a `csfmt_rts_data_v2`. The
    class is dropped from the result.
  - `remove_class_csfmt_rts_data()` was documented as having no return value.
    It returns `x` invisibly, which is what lets two vignettes use it inside a
    pipe.
  - `set_csfmt_rts_data_v1()` and `set_csfmt_rts_data_v2()` each carried two
    contradictory `\value` paragraphs, one of them claiming no return value.
    The false paragraph is gone from both.
  - The v1 and v2 help pages said the copying constructor accepts a
    `data.frame`. It does not; both stop unless `x` is a `data.table`.
  - `csfmt_rts_data_v2` was described as having 16 unified columns while
    listing 18. It has 18.
  - `csfmt_rts_data_v3` was described as having the same unified columns as
    `csfmt_rts_data_v2`. It has 11 of that format's 18.
- **`heal` now says it needs `granularity_time`** on
  `set_csfmt_rts_data_v1()` and `set_csfmt_rts_data_v2()`. Time healing reads
  `granularity_time` to decide which time column the others derive from, so a
  table carrying `isoyearweek` but no `granularity_time` comes back with its
  time columns still `NA`. `set_csfmt_rts_data_v3()` is weekly-only and does
  not need it.
- `pkgdown/` and `Rplots.pdf` added to `.Rbuildignore`.

# Version 2026.7.1

- **The `season` boundary now matches `cstime`.** The internal healing tables
  put the season cut-point at isoweek 30; `cstime` puts it at isoweek 35
  (`cstime::isoyearweek_to_season_c("2020-34")` is `2019/2020`, `"2020-35"` is
  `2020/2021`). The tables have been regenerated, so about five weeks per year
  change season: `2020-30` heals to `2019/2020` where it previously gave
  `2020/2021`. This affects `set_csfmt_rts_data_v2()` and, through
  `heal_time_csfmt_rts_data_v2()`, the new `set_csfmt_rts_data_v3()`. Anyone
  upgrading from 2025.10.27 should expect season-grouped results (seasonal
  baselines, by-season summaries) to shift accordingly.
- **The version string 2025.10.27 is ambiguous about this.** The regeneration
  landed two days after that version was submitted to CRAN, and the version was
  not bumped at the time. So a 2025.10.27 installed from CRAN uses the isoweek-30
  boundary, while a 2025.10.27 installed from GitHub main after 2025-10-29 uses
  isoweek 35, and `packageVersion()` cannot tell them apart. If you need to know
  which one you have, test it rather than trust the version:
  `cstidy::set_csfmt_rts_data_v3(data.table::data.table(isoyearweek = "2020-34",
  location_code = "nation_nor"))$season` returns `2019/2020` under the current
  (isoweek 35) boundary and `2020/2021` under the old one.

- Inclusion of `csfmt_rts_data_v3`: a slim, weekly-only clean csfmt format (11
  columns) with an explicit `heal` step and a content-hash `time_series_id`.
  `isoyear`, `isoweek`, `season`, `seasonweek`, `date`, `granularity_geo` and
  `country_iso3` are all healed from `isoyearweek`. This is the format that
  csalert's `collapse(heal = TRUE)` targets.

# Version 2025.10.27

- Updating csfmt_rts_data_v2 to be in line with the newest cstime version 2025.10.13

# Version 2024.6.13

- Inclusion of season in csfmt_rts_data_v2

# Version 2023.12.28

- Inclusion of isoquarter and isoyearquarter in csfmt_rts_data_v2

# Version 2023.5.22

- CRAN Submission.

# Version 2023.5.16

- Removing `print.csfmt_rts_data_v1`.

# Version 2023.4.26

- `cstidy::set_csfmt_rts_data_v1` is now 1.5x faster due to using the upgraded `cstime` package that now uses binary searches. An 80 million row dataset is now processed in 2 minutes, instead of 3.

# Version 2023.4.25

- `cstidy::set_csfmt_rts_data_v1` is now 6x faster due to using the upgraded `cstime` package that now uses `csutil::apply_fn_via_hash_table`. An 80 million row dataset is now processed in 3 minutes, instead of 20.

# Version 2022.1.17

- Dataset norway_covid19_cases_by_time_location renamed to nor_covid19_cases_by_time_location_csfmt_rts_v1.
- Dataset norway_covid19_icu_and_hospitalization renamed to nor_covid19_icu_and_hospitalization_csfmt_rts_v1.

# Version 2022.5.31

- In csfmt_rts_v1, age now uses underscores instead of hyphens so that valid variable names are generated when converting to wide-format.

# Version 2022.5.25

- Dataset covid19_msis_cases_by_time_location renamed to norway_covid19_cases_by_time_location.
- In csfmt_rts_v1, the granularity_time for "an ongoing event" was changed from event_\*_9999_01_01 to event_\*_9999_09_09. This was done because isoyear for 9999-01-01 is 9998 (which is confusing), while isoyear for 9999-09-09 is 9999 (which makes sense).
- In csfmt_rts_v1, the missing value for sex and age was changed to "missing" instead of NA_character_. This was chosen because NA_character_ requires special manipulation functions (is.na) which makes post-processing of data less efficient for the end-user.
- In csfmt_rts_v1, cstidy::heal now works when granularity_time=='event_*'

# Version 2022.5.19

- Dataset covid19_msis_cases_by_time_location included, containing number of Covid19 cases from MSIS registry. The locations are for both national and county level. The percentage per 100.000 population is included. The time period is between 2020-02-21 and 2022-05-03 (data extracted on 2022-05-04).

# Version 2022.5.5

- Dataset norway_covid19_icu_and_hospitalization included, containing admissions to the ICU with a positive PCR test and number of new hospitalizations with Covid-19 as the primary cause between 2020-02-21 and 2022-05-03 (data extracted 2022-05-04).

# Version 2022.4.26

- save_cs, read_cs functions to save/read data efficiently, allowing passwordless encryption.

# Version 2022.4.22

- print.csfmt_rts_data_v1 now automatically rounds numerics to 4 decimal places

# Version 2022.4.7

- unique_time_series function added.
