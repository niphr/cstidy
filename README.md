# cstidy <a href="https://niphr.github.io/cstidy/"><img src="man/figures/logo.png" align="right" width="120" /></a>

[![CRAN status](https://www.r-pkg.org/badges/version/cstidy)](https://cran.r-project.org/package=cstidy)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/cstidy)](https://cran.r-project.org/package=cstidy)

## Overview

[cstidy](https://niphr.github.io/cstidy/) puts aggregated disease-surveillance
data into one standard panel format, and derives the time and geography columns
that format needs.

You give it a table of counts that already has a time column (for example
`isoyearweek`) and a location column (`location_code`). It returns the same
table with a standard set of columns filled in — `isoyear`, `isoweek`, `season`,
`seasonweek`, `date`, `granularity_time`, `granularity_geo` — and a class that
keeps those columns consistent when you edit the data afterwards.

cstidy does **not** aggregate individual-level records into counts. Aggregate
first, then hand the result to cstidy.

## Who this is for

cstidy is written and used by **Core Surveillance**, a team at the Norwegian
Institute of Public Health (NIPH; in Norwegian, Folkehelseinstituttet, FHI). It
is one of a family of R packages that share this data format: `cstime` for time
conversions, `csdata` for Norwegian geography, `csalert` for outbreak detection,
`csstyle` for figures.

That is where the names come from. The `cs` prefix on every package is **C**ore
**S**urveillance. The format class `csfmt_rts_data_v3` reads as **c**ore
**s**urveillance **f**or**m**a**t**, **r**eal-**t**ime **s**urveillance data,
version 3.

The format follows NIPH conventions, and the clearest example is the
surveillance season. A season runs from **ISO week 35 to ISO week 34** of the
following year, which is the NIPH standard for respiratory-disease surveillance.
Geography codes come from `csdata` and are Norwegian. You can use cstidy with
data from elsewhere, but you will be adopting NIPH conventions when you do.

## Getting started

Read the introduction vignette
[here](https://niphr.github.io/cstidy/articles/cstidy.html), or run
`help(package = "cstidy")`.
