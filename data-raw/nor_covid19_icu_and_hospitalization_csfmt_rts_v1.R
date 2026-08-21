## code to prepare `DATASET` dataset goes here
library(data.table)
devtools::load_all()

# import data
# daily, nation
d <- data.table::fread("data-raw/covid19_hospital.csv")
d[location_code=="norge", location_code := "nation_nor"]
d[, date:=as.Date(date)]
d[, date_of_publishing:=NULL]
d[, year:=NULL]
d[, week:=NULL]
d[, yrwk:=NULL]
d[, x:=NULL]
d[, granularity_time := "date"]


# set to csfmt
cstidy::set_csfmt_rts_data_v1(d)

# change variable names
setnames(
  d,
  c(
    "n_icu",
    "n_hospital_main_cause"
  ),
  c(
    "icu_with_positive_pcr_n",
    "hospitalization_with_covid19_as_primary_cause_n"
  )
)

d


# weekly aggregation
week <- d[,.(
  icu_with_positive_pcr_n = sum(icu_with_positive_pcr_n),
  hospitalization_with_covid19_as_primary_cause_n = sum(hospitalization_with_covid19_as_primary_cause_n),
  granularity_time = "isoyearweek"
  ),
  keyby=.(
    location_code,
    border,
    age,
    sex,
    isoyearweek
  )] |>
  cstidy::create_unified_columns()

week


# put daily and weekly together
nor_covid19_icu_and_hospitalization_csfmt_rts_v1 <- rbind(d, week)

# set to csfmt
cstidy::set_csfmt_rts_data_v1(nor_covid19_icu_and_hospitalization_csfmt_rts_v1)

# save the data into data folder in .rda format
usethis::use_data(nor_covid19_icu_and_hospitalization_csfmt_rts_v1, overwrite = TRUE)


# ?cstidy::norway_covid19_icu_and_hospitalization
