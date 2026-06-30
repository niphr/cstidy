# Norwegian Covid-19 data for ICU and hospitalization

This data was extracted on 2022-05-04.

## Usage

``` r
nor_covid19_icu_and_hospitalization_csfmt_rts_v1
```

## Format

A csfmt_rts_data_v1 with 919 rows and 18 variables:

- granularity_time:

  day/isoweek

- granularity_geo:

  nation

- country_iso3:

  nor

- location_code:

  norge

- border:

  2020

- age:

  total

- isoyear:

  Isoyear of event

- isoweek:

  Isoweek of event

- isoyearweek:

  Isoyearweek of event

- season:

  Season of event

- seasonweek:

  Seasonweek of event

- calyear:

  Calyear of event

- calmonth:

  Calmonth of event

- calyearmonth:

  Calyearmonth of event

- date:

  Date of event

- icu_with_positive_pcr_n:

  Number of new admissions to the ICU with a positive PCR test

- hospitalization_with_covid19_as_primary_cause_n:

  Number of new hospitalizations with Covid-19 as the primary cause

## Source

<https://github.com/folkehelseinstituttet/surveillance_data/blob/master/covid19/_DOCUMENTATION_data_covid19_hospital_by_time.txt>

## Examples

``` r
head(cstidy::nor_covid19_icu_and_hospitalization_csfmt_rts_v1)
```
