# try out all the options
vis_miss_plot <- vis_miss(typical_data)
vis_miss_plot_cluster <- vis_miss(typical_data, cluster = TRUE)
vis_miss_plot_sort_rows <- vis_miss(typical_data, sort_miss = TRUE)
vis_miss_plot_show_perc <- vis_miss(typical_data, show_perc = FALSE)
vis_miss_plot_show_perc_col <- vis_miss(typical_data, show_perc_col = FALSE)
vis_miss_plot_show_perc_col_t <- vis_miss(typical_data, show_perc_col = TRUE)

test_that("vis_miss creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_miss vanilla", vis_miss_plot)
  vdiffr::expect_doppelganger("vis_miss cluster", vis_miss_plot_cluster)
  vdiffr::expect_doppelganger("vis_miss sort rows", vis_miss_plot_sort_rows)
  vdiffr::expect_doppelganger("vis_miss show percent", vis_miss_plot_show_perc)
  vdiffr::expect_doppelganger("vis_miss show percent in columns", vis_miss_plot_show_perc_col)
  vdiffr::expect_doppelganger("vis_miss no show percent in columns", vis_miss_plot_show_perc_col_t)
})

test_that("vis_miss fails when an object of the wrong class is provided", {
  expect_snapshot(
    error = TRUE,
    vis_miss(AirPassengers)
    )
})

library(dplyr)
star_wars_missings <- starwars %>%
  select(-name, -skin_color, -eye_color, -films)
vis_miss_list <- vis_miss(star_wars_missings)
vis_miss_list_sort_rows <- vis_miss(starwars, sort_miss = TRUE)

test_that("vis_miss manage missings in list columns",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_miss list", vis_miss_list)
  vdiffr::expect_doppelganger("vis_miss list sort rows", vis_miss_list_sort_rows)
})

test_that("vis_miss correctly see missings in columns labels",{
  x_labs <- tibble::tibble(x_lab = vis_miss_list$scales$scales[[3]]$labels)
  expect_snapshot(x_labs)
})

test_that("vis_miss correctly aggregate missings in legend",{
  legend_lab <- tibble::tibble(x_lab = vis_miss_list$scales$scales[[2]]$labels)
  expect_snapshot(legend_lab)
})

vis_miss_facet <- vis_miss(airquality, facet = Month)
vis_miss_facet_no_pct <- vis_miss(airquality, facet = Month, show_perc = FALSE)

test_that("vis_miss works with facets",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_miss_facet", vis_miss_facet)
  vdiffr::expect_doppelganger("vis_miss_facet_no_pct", vis_miss_facet_no_pct)
})

the_vis_miss_data <- data_vis_miss(airquality)
the_vis_miss_data_month <- airquality %>% group_by(Month) %>% data_vis_miss()

test_that("data_vis_miss gets the data properly", {
  expect_type(the_vis_miss_data, "list")
  expect_s3_class(the_vis_miss_data, "data.frame")
  expect_snapshot(the_vis_miss_data)
})

test_that("data_vis_miss gets the data properly for groups", {
  expect_type(the_vis_miss_data_month, "list")
  expect_s3_class(the_vis_miss_data_month, "data.frame")
  expect_snapshot(the_vis_miss_data_month)
})

