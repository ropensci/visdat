# try out all the options
vis_cor_plot <- vis_cor(airquality)

test_that("vis_cor creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_cor vanilla",
                              vis_cor_plot)

})

test_that("vis_cor sends an error when used with the wrong data",{
  expect_snapshot(
    error = TRUE,
    vis_cor(iris)
    )
})

test_that("vis_cor fails when an object of the wrong class is provided", {
  expect_snapshot(
    error = TRUE,
    vis_cor(AirPassengers)
    )
})

vis_cor_facet <- vis_cor(airquality, facet = Month)

test_that("vis_cor works with facetting", {
  skip_on_ci()
  skip_on_cran()
  vdiffr::expect_doppelganger("vis_cor_facet", vis_cor_facet)
})

library(dplyr)
the_vis_cor_data <- data_vis_cor(airquality)
the_vis_cor_data_month <- airquality %>% group_by(Month) %>% data_vis_cor()

test_that("data_vis_cor gets the data properly", {
  expect_type(the_vis_cor_data, "list")
  expect_s3_class(the_vis_cor_data, "data.frame")
  expect_snapshot(the_vis_cor_data)
})

test_that("data_vis_cor gets the data properly for groups", {
  expect_type(the_vis_cor_data_month, "list")
  expect_s3_class(the_vis_cor_data_month, "data.frame")
  expect_snapshot(the_vis_cor_data_month)
})

