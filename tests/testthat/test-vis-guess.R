context("vis_guess")

# try out all the options
vis_guess_plot <- vis_guess(airquality)
vis_guess_plot_cb_safe <- vis_guess(airquality, palette = "cb_safe")
vis_guess_plot_qual <- vis_guess(airquality, palette = "qual")
vis_guess_plot_default <- vis_guess(airquality, palette = "default")

test_that("vis_guess creates the right plot",{
  vdiffr::expect_doppelganger("vis_guess vanilla", vis_guess_plot)
  vdiffr::expect_doppelganger("vis_guess cb safe", vis_guess_plot_cb_safe)
  vdiffr::expect_doppelganger("vis_guess qual", vis_guess_plot_qual)
  vdiffr::expect_doppelganger("vis_guess default", vis_guess_plot_default)
})

test_that("vis_guess fails when the wrong palette is provided",{
  testthat::expect_error(vis_guess(airquality, palette = "wat"))
})
