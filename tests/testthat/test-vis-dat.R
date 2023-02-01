# try out all the options
vis_dat_plot <- vis_dat(typical_data)
vis_dat_plot_sort_type <- vis_dat(typical_data, sort_type = FALSE)
vis_dat_plot_pal_qual <- vis_dat(typical_data, palette = "qual")
vis_dat_plot_pal_cb <- vis_dat(typical_data, palette = "cb_safe")

test_that("vis_dat creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_dat vanilla",
                              vis_dat_plot)
  vdiffr::expect_doppelganger("vis_dat sort_type",
                              vis_dat_plot_sort_type)
  vdiffr::expect_doppelganger("vis_dat qualitative palette",
                              vis_dat_plot_pal_qual)
  vdiffr::expect_doppelganger("vis_dat colourblind safe palette",
                              vis_dat_plot_pal_cb)
})

test_that("vis_dat doesn't fail when using diamonds",{
  expect_s3_class(vis_dat(ggplot2::diamonds), "gg")
})

test_that("vis_dat fails when the wrong palette is provided",{
  expect_snapshot(
    error = TRUE,
    vis_dat(typical_data, palette = "wat")
    )
})

test_that("vis_dat fails when an object of the wrong class is provided", {
  expect_snapshot(
    error = TRUE,
    vis_dat(AirPassengers)
    )
})

vis_dat_facet <- vis_dat(airquality, facet = Month)

test_that("vis_dat works with facetting", {
  skip_on_ci()
  skip_on_cran()
  vdiffr::expect_doppelganger("vis_dat_facet", vis_dat_facet)
})

library(dplyr)
the_vis_dat_data <- data_vis_dat(airquality)
the_vis_dat_data_month <- airquality %>% group_by(Month) %>% data_vis_dat()

test_that("data_vis_dat gets the data properly", {
  expect_type(the_vis_dat_data, "list")
  expect_s3_class(the_vis_dat_data, "data.frame")
  expect_snapshot(the_vis_dat_data)
})

test_that("data_vis_dat gets the data properly for groups", {
  expect_type(the_vis_dat_data_month, "list")
  expect_s3_class(the_vis_dat_data_month, "data.frame")
  expect_snapshot(the_vis_dat_data_month)
})
