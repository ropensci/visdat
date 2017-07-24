context("vis_guess")

# try out all the options
vis_guess_plot <- vis_guess(airquality)

test_that("vis_miss_ly creates the right plot",{
  skip_on_cran()
  vdiffr::expect_doppelganger("vis_guess vanilla", vis_guess_plot)
})
