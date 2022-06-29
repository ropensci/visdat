vis_value_plot <- vis_value(airquality)

test_that("vis_value creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_value vanilla",
                              vis_value_plot)

})

test_that("vis_value sends an error when used with the wrong data",{
  expect_snapshot_error(
    vis_value(iris)
    )
})
