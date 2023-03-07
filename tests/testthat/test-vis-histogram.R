vis_histogram_plot <- vis_histogram(airquality)

test_that("vis_histogram creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_histogram vanilla",
    vis_histogram_plot)

})

test_that("vis_histogram sends an error when used with the wrong data",{
  expect_snapshot_error(
    vis_histogram(iris)
  )
})
