# The csfmt_rts_data_v2 format definition.
#
# R sources this directory in C collation order. This name sorts after
# "1_env.R", which creates `formats`, and before "csfmt_rts_v3.R", which
# reads `formats$csfmt_rts_data_v2$unified` while it loads.

formats$csfmt_rts_data_v2 <- list()
formats$csfmt_rts_data_v2$unified <- list()
formats$csfmt_rts_data_v2$unified$granularity_time <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = c("date", "isoyearweek", "isoyear", "season"),
  class = "character"
)

# csdata::nor_locations_names()
formats$csfmt_rts_data_v2$unified$granularity_geo <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = unique(csdata::nor_locations_names()$granularity_geo),
  class = "character"
)

formats$csfmt_rts_data_v2$unified$country_iso3 <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = c("nor", "den", "swe", "fin"),
  class = "character"
)

formats$csfmt_rts_data_v2$unified$location_code <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$border <- list(
  NA_allowed = FALSE,
  NA_class = NA_integer_,
  values_allowed = 2020,
  class = "integer"
)

formats$csfmt_rts_data_v2$unified$age <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$sex <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$isoyear <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v2$unified$isoweek <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v2$unified$isoyearweek <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$isoquarter <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v2$unified$isoyearquarter <- list(
  NA_allowed = FALSE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$season <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$seasonweek <- list(
  NA_allowed = TRUE,
  NA_class = NA_real_,
  values_allowed = NULL,
  class = "numeric"
)

formats$csfmt_rts_data_v2$unified$calyear <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v2$unified$calmonth <- list(
  NA_allowed = TRUE,
  NA_class = NA_integer_,
  values_allowed = NULL,
  class = "integer"
)

formats$csfmt_rts_data_v2$unified$calyearmonth <- list(
  NA_allowed = TRUE,
  NA_class = NA_character_,
  values_allowed = NULL,
  class = "character"
)

formats$csfmt_rts_data_v2$unified$date <- list(
  NA_allowed = FALSE,
  NA_class = as.Date(NA),
  values_allowed = NULL,
  class = "Date"
)

# print.csfmt_rts_data_v2 <- function(x, ...) {
#   # https://cran.r-project.org/web/packages/data.table/vignettes/datatable-faq.html#ok-thanks.-what-was-so-difficult-about-the-result-of-dti-col-value-being-returned-invisibly
#   if (!data.table::shouldPrint(x)) {
#     return(invisible(x))
#   }
#   # this function is recursive, so that
#   dots <- list(...)
#   print_dots_before_row <- 999999999999999
#   if (nrow(x) == 0) {
#     cat(glue::glue("csfmt_rts_data_v2 with {ncol(x)} columns and 0 rows"))
#     cat(names(x))
#     return(invisible(x))
#   } else if (nrow(x) > 100) {
#     row_numbers <- c(1:nrow(x))[c(1:5, (nrow(x) - 4):nrow(x))]
#     to_print <- x[c(1:5, (.N - 4):.N)]
#     print_dots_before_row <- 6
#   } else {
#     row_numbers <- 1:nrow(x)
#     to_print <- copy(x)
#   }
#
#   # unified vs context
#   format_unified <- attr(to_print, "format_unified")
#   variable_types <- rep("[context]", ncol(to_print))
#   for (i in seq_along(variable_types)) {
#     pos <- which(names(format_unified) %in% names(to_print))
#     # if(length(pos))
#   }
#   names(to_print)
#   names(format_unified)
#   variable_types <- dplyr::case_when(
#     names(to_print) %in% names(format_unified) ~ "[unified]",
#     TRUE ~ "[context]"
#   )
#
#   # classes
#   variable_classes <- paste0("<", unlist(lapply(to_print, class)), ">")
#   variable_names <- names(to_print)
#   row_numbers <- formatC(row_numbers, width = max(nchar(row_numbers))) |>
#     paste0(":", sep = "")
#   row_number_spacing <- formatC("", width = max(nchar(row_numbers)))
#
#   # round numeric so it isnt too big
#   vars_to_round <- variable_names[variable_classes=="<numeric>"]
#   for(i in vars_to_round){
#     to_print[,(i) := round(get(i), 4)]
#   }
#
#   # missing
#   na_percent <- rep("X", ncol(to_print))
#   na_percent_red <- rep(FALSE, ncol(to_print))
#   for(i in seq_along(na_percent)){
#     var = names(x)[i]
#     val <- x[,.(val = mean(is.na(get(var))))]$val
#     na_percent[i] <- glue::glue("NA={format_nor_perc_0(val*100)}")
#     if(val>0){
#       na_percent_red[i] <- TRUE
#     }
#   }
#
#   width_char <- apply(to_print, 2, nchar, keepNA = F) |>
#     rbind(nchar(variable_types)) |>
#     rbind(nchar(variable_classes)) |>
#     rbind(nchar(na_percent)) |>
#     rbind(nchar(variable_names)) |>
#     apply(2, max)
#
#   max_width <- getOption("width") - 5
#   cum_width <- nchar(row_number_spacing) + cumsum(width_char + 3)
#   breaks <- floor(cum_width / max_width)
#
#   if (!"recursive" %in% names(dots)) {
#     # if this is the first time the function is run, then it just acts
#     # as the brain, and determines how many times the function needs to be called
#     for (i in unique(breaks)) {
#       print(x[, names(breaks)[breaks == i], with = F], recursive = TRUE)
#       cat("\n")
#     }
#     return(invisible(x))
#   } else {
#     # we are in the recursive level, so we actually print things!
#     for (i in -3:nrow(to_print)) {
#       if (i == print_dots_before_row) {
#         for (j in seq_len(max(cum_width))) cat(".")
#         cat("\n")
#       }
#
#       if (i <= 0) {
#         cat(row_number_spacing)
#       } else {
#         cat(row_numbers[i])
#       }
#       for (j in 1:ncol(to_print)) {
#         cat("   ")
#
#         if (i == -3) {
#           cat(formatC(variable_types[j], width = width_char[j]))
#         } else if (i == -2) {
#           cat(formatC(variable_classes[j], width = width_char[j]))
#         } else if (i == -1) {
#           if(na_percent_red[j] == TRUE){
#             cat(crayon::red(formatC(na_percent[j], width = width_char[j])))
#           } else {
#             cat(formatC(na_percent[j], width = width_char[j]))
#           }
#         } else if (i == 0) {
#           cat(crayon::bold(formatC(variable_names[j], width = width_char[j])))
#         } else {
#           cat(formatC(as.character(to_print[i][[j]]), width = width_char[j]))
#         }
#       }
#       cat("\n")
#     }
#     return(invisible(x))
#   }
# }

# heal_time_csfmt_rts_data_v2 <- function(x, cols, from){
#   print(x)
#   print(cols)
#   print(from)
#   csutil::apply_fn_via_hash_table(x, heal_time_csfmt_rts_data_v2_internal, cols=cols, from=from)
# }
