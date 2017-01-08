context("vis_guess")

# try out all the options
vis_guess_plot <- vis_guess(airquality)

vdiffr::expect_doppelganger("vis_guess vanilla", vis_guess_plot)
