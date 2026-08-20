# The data structure identification for the csfmt_rts_data_v2 format, and
# the plot method for the structure hash.
#
# The format definition is in "csfmt_rts_v2.R". See that file for the load
# order this directory needs.

identify_data_structure_internal <- function(summarized, col) {
  . <- NULL
  num_valid <- NULL
  num_na <- NULL
  category <- NULL
  age <- NULL
  sex <- NULL
  granularity_geo <- NULL
  # we expect a data.table with columns:
  # - granularity_time
  # - granularity_geo
  # - age
  # - sex
  # - num_valid
  # - num_na

  skeleton <- CJ(
    granularity_time = c("isoyear", "isoyearweek", "date"),
    granularity_geo = unique(csdata::nor_locations_names()$granularity_geo),
    age = unique(summarized$age),
    sex = unique(summarized$sex)
  )
  skeleton[
    summarized,
    on = c("granularity_time", "granularity_geo", "age", "sex"),
    c("num_valid", "num_na") := .(num_valid, num_na)
  ]
  skeleton[is.na(num_valid), num_valid := 0]
  skeleton[is.na(num_na), num_na := 0]

  skeleton[,
    category := dplyr::case_when(
      num_valid == 0 & num_na == 0 ~ "structurally_missing",
      num_valid == 0 & num_na > 0 ~ "only_na",
      num_valid > 0 & num_na == 0 ~ "only_data",
      num_valid > 0 & num_na > 0 ~ "data_and_na",
    )
  ]
  skeleton[is.na(age), age := "missing"]
  skeleton[is.na(sex), sex := "missing"]

  skeleton[, num_valid := NULL]
  skeleton[, num_na := NULL]
  skeleton[,
    granularity_geo := factor(
      granularity_geo,
      levels = unique(csdata::nor_locations_names()$granularity_geo)
    )
  ]

  # check if can merge together age groups
  skeleton_wide <- dcast.data.table(
    skeleton,
    granularity_time + granularity_geo + sex ~ age,
    value.var = "category"
  )

  equality <- diag(ncol(skeleton_wide) - 3)
  colnames(equality) <- names(skeleton_wide)[4:ncol(skeleton_wide)]
  rownames(equality) <- names(skeleton_wide)[4:ncol(skeleton_wide)]
  for (i in 4:ncol(skeleton_wide)) {
    for (j in 4:ncol(skeleton_wide)) {
      if (sum(skeleton_wide[[i]] != skeleton_wide[[j]]) == 0) {
        equality[i - 3, j - 3] <- 1
      }
    }
  }
  while (nrow(equality) > 0) {
    if (sum(equality[1, ]) > 1) {
      names_to_sum <- colnames(equality)[equality[1, ] == 1]
      end_name <- paste0(names_to_sum, collapse = ",")
      skeleton_wide[, (end_name) := get(names_to_sum[1])]
      for (i in names_to_sum) {
        # delete the data in the skeleton
        skeleton_wide[, (i) := NULL]
        # delete the data in the equality matrix
        equality <- equality[-which(rownames(equality) == i), , drop = FALSE]
      }
    } else {
      equality <- equality[-1, , drop = FALSE]
    }
  }

  skeleton <- melt.data.table(
    skeleton_wide,
    id.vars = c("granularity_time", "granularity_geo", "sex"),
    variable.factor = FALSE,
    variable.name = "age",
    value.name = "category"
  )

  skeleton_wide <- dcast.data.table(
    skeleton,
    granularity_time + age + sex ~ granularity_geo,
    value.var = "category"
  )

  # delete columns that are just structurally_missing and furthest to the right
  for (i in rev(names(skeleton_wide))) {
    if (i == "municip") {
      break()
    } else if (
      sum(skeleton_wide[[i]] != "structurally_missing", na.rm = T) == 0
    ) {
      skeleton_wide[, (i) := NULL]
    } else {
      break()
    }
  }

  skeleton_long <- melt.data.table(
    skeleton_wide,
    id.vars = c("granularity_time", "age", "sex"),
    variable.factor = FALSE,
    variable.name = "granularity_geo",
    value.name = "category"
  )

  setattr(
    skeleton_long,
    "class",
    unique(c("csfmt_rts_data_structure_hash_v2", class(skeleton_long)))
  )

  return(invisible(skeleton_long))
}

#' @section Deprecated:
#' The `csfmt_rts_data_v2` method of `identify_data_structure()` is deprecated
#' along with the format it dispatches on. Nothing warns at run time. See
#' \code{\link{set_csfmt_rts_data_v2}()}. Neither the generic itself nor its
#' `tbl_Microsoft SQL Server` method is deprecated.
#' @method identify_data_structure csfmt_rts_data_v2
#' @rdname identify_data_structure
#' @export
identify_data_structure.csfmt_rts_data_v2 <- function(x, col, ...) {
  . <- NULL
  granularity_time <- NULL
  granularity_geo <- NULL
  age <- NULL
  sex <- NULL
  var <- NULL
  # col <-
  # Take in the data table
  # data <- data$cases
  # data <- data$vax

  summarized <- x[,
    .(
      num_valid = sum(!is.na(get(col))),
      num_na = sum(is.na(get(col)))
    ),
    keyby = .(
      granularity_time,
      granularity_geo,
      age,
      sex
    )
  ]

  identify_data_structure_internal(
    summarized,
    var
  )
}

#' @rdname identify_data_structure
#' @export
"identify_data_structure.tbl_Microsoft SQL Server" <- function(x, col, ...) {
  granularity_time <- NULL
  granularity_geo <- NULL
  age <- NULL
  sex <- NULL
  n <- NULL
  num_total <- NULL
  num_na <- NULL
  # col <-
  # Take in the data table
  # data <- data$cases
  # data <- data$vax

  summarized <- x %>%
    dplyr::rename(col = !!col) %>%
    dplyr::group_by(
      granularity_time,
      granularity_geo,
      age,
      sex
    ) %>%
    dplyr::summarize(
      num_total = n(),
      num_na = sum(as.numeric(is.na(col)))
    ) %>%
    dplyr::mutate(
      num_valid = num_total - num_na
    ) %>%
    dplyr::select(-num_total) %>%
    dplyr::collect() %>%
    as.data.table()

  identify_data_structure_internal(
    summarized,
    col
  )
}

#' @section Deprecated:
#' This method is deprecated along with the `csfmt_rts_data_v2` format whose
#' structure hash it plots. Nothing warns at run time. See
#' \code{\link{set_csfmt_rts_data_v2}()}.
#' @method plot csfmt_rts_data_structure_hash_v2
#' @export
plot.csfmt_rts_data_structure_hash_v2 <- function(x, y, ...) {
  granularity_geo <- NULL
  category <- NULL
  age <- NULL
  sex <- NULL

  # x <- generate_test_data() %>%
  #   set_csfmt_rts_data_v2() %>%
  #   identify_data_structure("deaths_n")

  pd <- copy(x)
  pd[,
    granularity_geo := factor(
      granularity_geo,
      levels = unique(csdata::nor_locations_names()$granularity_geo)
    )
  ]
  pd[,
    category := factor(
      category,
      levels = c("structurally_missing", "only_na", "data_and_na", "only_data")
    )
  ]

  pd[, age := paste0("age=", age)]
  pd[, sex := paste0("sex=", sex)]

  q <- ggplot(pd, aes(x = granularity_geo, y = age, fill = category))
  q <- q + geom_tile(color = "black")
  q <- q + facet_grid(sex ~ granularity_time)
  q <- q + scale_x_discrete(NULL)
  q <- q + scale_y_discrete(NULL)
  q <- q + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  q <- q + theme(legend.position = "bottom", legend.direction = "horizontal")
  q
}
