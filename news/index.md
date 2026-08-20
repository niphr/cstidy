# Changelog

## Version 2026.8.20

### Development

- `R/csfmt_rts_v2.R` held 1091 code lines, and the shared CI workflow
  fails any `R/*.R` file over 1000. The methods now live in four sibling
  files: `csfmt_rts_v2_heal.R`, `csfmt_rts_v2_set.R`,
  `csfmt_rts_v2_structure.R` and `csfmt_rts_v2_expand_time.R`.
- The split moved whole top-level expressions and changed none of them.
  `csfmt_rts_v2.R` keeps the format definition. `csfmt_rts_v3.R` reads
  `formats$csfmt_rts_data_v2$unified` while it loads, and R sources `R/`
  in C collation order.

## Version 2026.8.6

### Licensing

- The copyright holder is now **Folkehelseinstituttet**. It read “Core
  Surveillance”, which names the package family rather than a legal
  entity.
- `DESCRIPTION` `Authors@R` now declares that holder with
  `role = "cph"`. It declared no copyright holder at all, and neither
  did any other package in the fleet. Nothing in `R CMD check` reports
  that.
- The copyright year is now 2026. It read 2023.
- `CLAUDE.md` now carries a Licensing section, so the year gets checked
  rather than silently ageing.

Documentation only. No executable line changed. `vignettes/cstidy.Rmd`
holds the pkgdown “Get started” slot, and it opened on a
`# csfmt_rts_data_v2` heading, so the package’s front door taught the
deprecated format first. An overview now sits in front of that heading.
Every existing section is unchanged and unmoved.

- **All repository prose now follows the house technical-prose
  standard** (ASD-STE100, Simplified Technical English). Sentences over
  25 words are now zero in `R/`, zero in `README.md`, zero in
  `index.md`, zero in `NEWS.md` and zero in the three vignettes. No
  claim changed. Two garbled sentences in this file were repaired
  without changing what they claim. The first read “So v3 is an analysis
  storable but unvalidated by csdb”. The second read “has no v3
  equivalent, so The validator is an ordinary argument”. The three
  measured v2 and v3 claims keep their bases. Counted on the unified
  set, v2 derives 18 columns and v3 derives 11. v3 is weekly-only.
  `csdb` can store a v3 table and cannot check one.
- **The overview names v3 first, and calls v1 and v2 deprecated before
  the reader reaches them.** 378 words of prose across five sections:
  what cstidy is for, which format to use, three things to know before
  moving to v3, where cstidy sits, and where to read next. Three
  runnable chunks carry every number, so the vignette rebuild
  re-measures each claim on every check.
- **The three classes are siblings, shown rather than asserted.**
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
  and
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
  each on its own copy of
  [`generate_test_data()`](https://niphr.github.io/cstidy/reference/generate_test_data.md),
  give `c("csfmt_rts_data_vN", "data.table", "data.frame")` for N = 1, 2
  and 3. `inherits(d3, "csfmt_rts_data_v2")` is FALSE. No format
  inherits from another.
- **Fewer derived columns, and no column removed. Two different bases,
  both stated.** Counted on the unified set,
  `length(attr(x, "format_unified"))`, v2 is 18 and v3 is 11. Counted on
  an object, a
  [`generate_test_data()`](https://niphr.github.io/cstidy/reference/generate_test_data.md)
  table set to v2 has 19 columns and still has 19 after
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
  with nothing lost and nothing gained. What a move to v3 costs is the
  guarantee, not the data.
- **That chunk calls
  [`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md)
  before the v3 setter, and the comment says why.**
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
  applied to a table that still carries the `csfmt_rts_data_v2` class
  returns a `csfmt_rts_data_v2`: healing calls `[`, no
  `[.csfmt_rts_data_v3` exists, so `[.csfmt_rts_data_v2` runs and
  re-asserts its own class. Measured, not changed — no file in `R/` was
  touched. With `create_unified_columns = FALSE, heal = FALSE` no `[`
  runs and the class stacks as
  `c("csfmt_rts_data_v3", "csfmt_rts_data_v2", "data.table", "data.frame")`.
- **Weekly-only, shown on two tables.** A two-row `isoyearweek` table
  set to v3 comes back with `isoyear`, `isoweek`, `season`, `seasonweek`
  and `date` all filled. A two-row daily table carrying
  `granularity_time = "date"` set to v3 keeps both `date` values and
  gets NA in `isoyear`, `isoweek`, `isoyearweek`, `season` and
  `seasonweek`. The same daily input set to v2 derives all of them.
- **The database limit is prose, not code, because it has to be.**
  `csdb` is neither an Import nor a Suggest of cstidy, so no vignette
  chunk may call it. Checked against `csdb` at commit 7b4f7cc: its
  NAMESPACE exports `validator_field_types_csfmt_rts_data_v1()`,
  `validator_field_types_csfmt_rts_data_v2()`,
  `validator_field_contents_csfmt_rts_data_v1()` and
  `validator_field_contents_csfmt_rts_data_v2()`, and the string
  `csfmt_rts_data_v3` appears nowhere in that repository. So a v3 table
  is storable by csdb but unvalidated by it. That is the main limit on
  the direction.
- **`csalert` is named as the downstream consumer, verified by running
  it.** `csalert::ens_collapse(ens, probs = 0.5, heal = TRUE)` returns
  class `c("csfmt_rts_data_v3", "data.table", "data.frame")`; the same
  call with `heal = FALSE` returns a plain `data.table`.
- **The overview says “no deprecation warning”, not “no warning”.** The
  wider claim is false and the vignette proves it a few sections further
  down: `R/` contains four
  [`warning()`](https://rdrr.io/r/base/warning.html) calls, and the
  smart-assignment section deliberately triggers one of them by setting
  two time columns at once. Two things are true, and both are written.
  No [`.Deprecated()`](https://rdrr.io/r/base/Deprecated.html),
  [`.Defunct()`](https://rdrr.io/r/base/Defunct.html) or
  [`lifecycle::deprecate_warn()`](https://lifecycle.r-lib.org/reference/deprecate_soft.html)
  appears anywhere in `R/`.
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  and
  [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
  on a
  [`generate_test_data()`](https://niphr.github.io/cstidy/reference/generate_test_data.md)
  table emit no warning and no message.

## Version 2026.8.5

Documentation only. No executable line changed. `csfmt_rts_data_v3` is
now the target format, so `csfmt_rts_data_v1` and `csfmt_rts_data_v2`
are marked deprecated in roxygen.

- **The mark is a signpost, not an alarm.** No
  [`.Deprecated()`](https://rdrr.io/r/base/Deprecated.html), no
  [`lifecycle::deprecate_warn()`](https://lifecycle.r-lib.org/reference/deprecate_soft.html),
  no [`warning()`](https://rdrr.io/r/base/warning.html), no
  [`message()`](https://rdrr.io/r/base/message.html), and no new
  dependency. Every deprecated function behaves exactly as it did in
  2026.8.4 and prints nothing extra. `norsyss.cs9` runs on
  `csfmt_rts_data_v2` nightly; a run-time warning would flood its logs
  for something nobody can act on yet.

- **What carries the mark.** One `@section Deprecated:` block, worded
  the same way throughout, on:
  [`csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`heal_time_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v1.md),
  [`csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
  [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
  [`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md),
  and the v1 and v2 S3 methods for `[`,
  [`summary()`](https://rdrr.io/r/base/summary.html),
  [`unique_time_series()`](https://niphr.github.io/cstidy/reference/unique_time_series.md),
  [`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md),
  [`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md)
  and [`plot()`](https://rdrr.io/r/graphics/plot.default.html). Two
  titles gained a “(deprecated)” suffix: `set_csfmt_rts_data_v2` and
  `heal_time_csfmt_rts_data_v2`. They match the two v1 titles that
  already had one, so the reference index reads the same way down the
  list.

- **Nothing on v3 is deprecated**:
  [`csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
  `unique_time_series.csfmt_rts_data_v3()` and
  [`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md)
  are unmarked. The
  [`identify_data_structure()`](https://niphr.github.io/cstidy/reference/identify_data_structure.md)
  generic and its `tbl_Microsoft SQL Server` method are unmarked too;
  only the `csfmt_rts_data_v2` method carries the note, and the note
  says so.

- **v1 to v2 is lossless on the two properties measured.** All 16 of
  v1’s unified columns are among v2’s 18, the extra two being
  `isoquarter` and `isoyearquarter`.
  [`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md)
  accepts every `granularity_time`
  [`heal_time_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v1.md)
  accepts (“date”, “isoyearweek”, “isoyear”) and “season” as well.
  `csdb` exports a field-type validator for both formats.

- **v2 to v3 has limits, and the v2 note states each one with the base
  it was measured on.** Three caveats, all measured:

  1.  **v3 derives fewer columns than v2, but drops none.** Counted on
      the unified set, v2 derives 18 columns and v3 derives 11. The
      unified set is `names(attr(x, "format_unified"))`, the columns
      each format creates when the input lacks them. The seven columns
      in v2’s unified set and not in v3’s are `granularity_time`,
      `border`, `isoquarter`, `isoyearquarter`, `calyear`, `calmonth`
      and `calyearmonth`. Deriving is not dropping.
      [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
      removes no column. An existing v2 object converted to v3 keeps
      every column it had, `granularity_time` and `border` included. v3
      healing still refreshes `isoquarter` and `isoyearquarter` when the
      columns are present. The next base is an object, not the unified
      set. A v2 table with one value column, whose input carried
      `granularity_time` and `border`, has 19 columns. Its v3 conversion
      has 19 too. The same input without those two columns gives 19
      under v2 and 12 under v3. What a move to v3 costs is the
      guarantee, not the data.
  2.  **v3 is weekly-only, and that is what costs the calendar
      columns.** `heal.csfmt_rts_data_v3()` derives from `isoyearweek`
      alone, and the isoyearweek lookup holds no calendar values at all.
      `calyear`, `calmonth` and `calyearmonth` are NA for all 7829 rows
      of the isoyearweek lookup, under v2 as much as under v3. Only the
      `date` lookup carries them, in all 54789 of its rows. So
      aggregation by calendar month or calendar year needs a v2 table
      healed on `date`. A daily table converted to v3 keeps its `date`
      values and gets nothing else healed.
  3.  **`csdb` cannot CHECK a v3 table, though it can store one.**
      `csdb` exports `validator_field_types_csfmt_rts_data_v1()` and
      `validator_field_types_csfmt_rts_data_v2()`, and has no v3
      equivalent. The validator is an ordinary argument to
      `csdb::DBTable_v9$new()`, so passing
      `validator_field_types_blank()` stores a v3 fine. What is missing
      is the column check, not the storage.

  So v2 is deprecated as a direction of travel, not because a finished
  replacement exists. Continue with v2 in any of these three cases:

  - The data is written to the database.
  - The data covers a granularity other than isoyearweek.
  - The data must derive a calendar or quarterly column that the input
    does not already carry.

- **[`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md)
  is deprecated as a public entry point only.**
  `heal.csfmt_rts_data_v3()` calls it to derive v3’s time columns, so it
  is still the healing engine behind
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md).
  Its note says that rather than implying it is on the way out.

## Version 2026.8.4

Documentation only. The R files were also reformatted. Comparing the
parsed code against the previous version, every remaining difference is
a brace added around a single-statement body, so no function changed
behaviour.

- **Runnable examples on the two help pages that had none.** They cover
  four exports:
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
  and
  [`csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md).
  Each of the two examples runs the by-reference setter and the copying
  constructor side by side. The example shows the difference between
  them. It does not just describe it. The pipe operator’s page still has
  no example; it is a re-export marked `@keywords internal`.
- **Every export now resolves to a help page carrying `\seealso`.**
  Where a vignette runs the function in a code chunk, the `\seealso`
  names that vignette. Where no vignette runs it, the `\seealso` says so
  plainly. No vignette runs
  [`heal_time_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v1.md),
  [`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md),
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md),
  [`csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
  or
  [`csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md).
  The Benchmarks vignette names
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  in a heading, but it is precompiled and carries no runnable code.
- **Two new `@family` groups. Both are contractual, not topical**, so
  the members really are interchangeable at a call site.
  - `csfmt format converters` —
    [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md),
    [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md),
    [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md).
    All three take `(x, create_unified_columns = TRUE, heal = TRUE)`,
    stop unless `x` is a `data.table`, and return `x` invisibly with
    that version’s class prepended.
  - `time healing lookups` —
    [`heal_time_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v1.md)
    and
    [`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md).
    Both take `(x, cols, granularity_time = "date")` and return a
    `data.table`. They are not identical: v1 accepts a
    `granularity_time` of “date”, “isoyearweek” or “isoyear”, while v2
    accepts those plus “season” and can also return `isoquarter` and
    `isoyearquarter`.

  The constructor/setter pairing
  ([`csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
  against
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md))
  was considered and rejected. The two share formals and return class
  but not semantics: the setter modifies its argument, the constructor
  leaves it untouched. Swapping one for the other silently changes
  whether the caller’s table is rewritten. They already share one help
  page.
- **Corrections to help pages that described the code wrongly.** Each
  was checked by running the function.
  - [`generate_test_data()`](https://niphr.github.io/cstidy/reference/generate_test_data.md)
    was documented as returning a `csfmt_rts_data_v2`. It returns a
    plain `data.table`; you pass it to a setter yourself.
  - [`expand_time_to()`](https://niphr.github.io/cstidy/reference/expand_time_to.md)
    was documented as returning a `csfmt_rts_data_v2`. The class is
    dropped from the result.
  - [`remove_class_csfmt_rts_data()`](https://niphr.github.io/cstidy/reference/remove_class_csfmt_rts_data.md)
    was documented as having no return value. It returns `x` invisibly,
    which is what lets two vignettes use it inside a pipe.
  - [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
    and
    [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
    each carried two contradictory `\value` paragraphs, one of them
    claiming no return value. The false paragraph is gone from both.
  - The v1 and v2 help pages said the copying constructor accepts a
    `data.frame`. It does not; both stop unless `x` is a `data.table`.
  - `csfmt_rts_data_v2` was described as having 16 unified columns while
    listing 18. It has 18.
  - `csfmt_rts_data_v3` was described as having the same unified columns
    as `csfmt_rts_data_v2`. It has 11 of that format’s 18.
- **`heal` now says it needs `granularity_time`** on
  [`set_csfmt_rts_data_v1()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  and
  [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md).
  Time healing reads `granularity_time` to decide which time column the
  others derive from. A table carrying `isoyearweek` but no
  `granularity_time` comes back with its time columns still `NA`.
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md)
  is weekly-only and does not need it.
- `pkgdown/` and `Rplots.pdf` added to `.Rbuildignore`.

## Version 2026.7.1

- **The `season` boundary now matches `cstime`.** The internal healing
  tables put the season cut-point at isoweek 30; `cstime` puts it at
  isoweek 35 (`cstime::isoyearweek_to_season_c("2020-34")` is
  `2019/2020`, `"2020-35"` is `2020/2021`). The tables have been
  regenerated, so about five weeks per year change season: `2020-30`
  heals to `2019/2020` where it previously gave `2020/2021`. This
  affects
  [`set_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v2.md)
  and, through
  [`heal_time_csfmt_rts_data_v2()`](https://niphr.github.io/cstidy/reference/heal_time_csfmt_rts_data_v2.md),
  the new
  [`set_csfmt_rts_data_v3()`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v3.md).
  Anyone upgrading from 2025.10.27 should expect season-grouped results
  (seasonal baselines, by-season summaries) to shift accordingly.

- **The version string 2025.10.27 is ambiguous about this.** The
  regeneration landed two days after that version was submitted to CRAN,
  and the version was not bumped at the time. So a 2025.10.27 installed
  from CRAN uses the isoweek-30 boundary. A 2025.10.27 installed from
  GitHub main after 2025-10-29 uses isoweek 35.
  [`packageVersion()`](https://rdrr.io/r/utils/packageDescription.html)
  cannot tell them apart. If you need to know which one you have, test
  it rather than trust the version:
  `cstidy::set_csfmt_rts_data_v3(data.table::data.table(isoyearweek = "2020-34", location_code = "nation_nor"))$season`
  returns `2019/2020` under the current (isoweek 35) boundary and
  `2020/2021` under the old one.

- Inclusion of `csfmt_rts_data_v3`: a slim, weekly-only clean csfmt
  format (11 columns) with an explicit `heal` step and a content-hash
  `time_series_id`. `isoyear`, `isoweek`, `season`, `seasonweek`,
  `date`, `granularity_geo` and `country_iso3` are all healed from
  `isoyearweek`. This is the format that csalert’s
  `collapse(heal = TRUE)` targets.

## Version 2025.10.27

CRAN release: 2025-10-27

- Updating csfmt_rts_data_v2 to be in line with the newest cstime
  version 2025.10.13

## Version 2024.6.13

- Inclusion of season in csfmt_rts_data_v2

## Version 2023.12.28

- Inclusion of isoquarter and isoyearquarter in csfmt_rts_data_v2

## Version 2023.5.22

- CRAN Submission.

## Version 2023.5.16

- Removing `print.csfmt_rts_data_v1`.

## Version 2023.4.26

- [`cstidy::set_csfmt_rts_data_v1`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  is now 1.5x faster due to using the upgraded `cstime` package that now
  uses binary searches. An 80 million row dataset is now processed in 2
  minutes, instead of 3.

## Version 2023.4.25

- [`cstidy::set_csfmt_rts_data_v1`](https://niphr.github.io/cstidy/reference/set_csfmt_rts_data_v1.md)
  is now 6x faster due to using the upgraded `cstime` package that now
  uses `csutil::apply_fn_via_hash_table`. An 80 million row dataset is
  now processed in 3 minutes, instead of 20.

## Version 2022.1.17

- Dataset norway_covid19_cases_by_time_location renamed to
  nor_covid19_cases_by_time_location_csfmt_rts_v1.
- Dataset norway_covid19_icu_and_hospitalization renamed to
  nor_covid19_icu_and_hospitalization_csfmt_rts_v1.

## Version 2022.5.31

- In csfmt_rts_v1, age now uses underscores instead of hyphens so that
  valid variable names are generated when converting to wide-format.

## Version 2022.5.25

- Dataset covid19_msis_cases_by_time_location renamed to
  norway_covid19_cases_by_time_location.
- In csfmt_rts_v1, the granularity_time for “an ongoing event” was
  changed from event\_\**9999_01_01 to event*\*\_9999_09_09. This was
  done because isoyear for 9999-01-01 is 9998 (which is confusing),
  while isoyear for 9999-09-09 is 9999 (which makes sense).
- In csfmt_rts_v1, the missing value for sex and age was changed to
  “missing” instead of NA_character\_. This was chosen because
  NA_character\_ requires special manipulation functions (is.na) which
  makes post-processing of data less efficient for the end-user.
- In csfmt_rts_v1, cstidy::heal now works when
  granularity_time==’event\_\*’

## Version 2022.5.19

- Dataset covid19_msis_cases_by_time_location included, containing
  number of Covid19 cases from MSIS registry. The locations are for both
  national and county level. The percentage per 100.000 population is
  included. The time period is between 2020-02-21 and 2022-05-03 (data
  extracted on 2022-05-04).

## Version 2022.5.5

- Dataset norway_covid19_icu_and_hospitalization included. It holds
  admissions to the ICU with a positive PCR test, and the number of new
  hospitalizations with Covid-19 as the primary cause. The range is
  2020-02-21 to 2022-05-03, extracted 2022-05-04.

## Version 2022.4.26

- save_cs, read_cs functions to save/read data efficiently, allowing
  passwordless encryption.

## Version 2022.4.22

- print.csfmt_rts_data_v1 now automatically rounds numerics to 4 decimal
  places

## Version 2022.4.7

- unique_time_series function added.
