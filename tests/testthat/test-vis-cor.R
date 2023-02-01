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
