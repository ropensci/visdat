context("vis_cor")

# try out all the options
vis_cor_plot <- vis_cor(typical_data)

test_that("vis_cor creates the right plot",{
  skip_on_cran()

  vdiffr::expect_doppelganger("vis_cor vanilla",
                              vis_cor_plot)

})
