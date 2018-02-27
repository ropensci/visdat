context("vis_cor")

# try out all the options
vis_cor_plot <- vis_cor(airquality)

test_that("vis_cor creates the right plot",{
  skip_on_cran()
  vdiffr::expect_doppelganger("vis_cor vanilla",
                              vis_cor_plot)

})

test_that("vis_cor sends an error when used with the wrong data",{
  testthat::expect_error(vis_cor(iris))
})
