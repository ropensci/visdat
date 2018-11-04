context("vis_value")

vis_value_plot <- vis_value(airquality)

test_that("vis_value creates the right plot",{
  skip_on_cran()
  vdiffr::expect_doppelganger("vis_value vanilla",
                              vis_value_plot)

})

test_that("vis_value sends an error when used with the wrong data",{
  testthat::expect_error(vis_value(iris))
})
