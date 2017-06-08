context("vis_dat")

# try out all the options
vis_dat_plot <- vis_dat(airquality)
vis_dat_plot_sort_type <- vis_dat(airquality, sort_type = FALSE)
vis_dat_plot_pal_qual <- vis_dat(airquality, palette = "qual")
vis_dat_plot_pal_qual <- vis_dat(airquality, palette = "cb_safe")

test_that("vis_dat creates the right plot",{
  vdiffr::expect_doppelganger("vis_dat vanilla", vis_dat_plot)
  vdiffr::expect_doppelganger("vis_dat sort_type", vis_dat_plot)
  vdiffr::expect_doppelganger("vis_dat qualitative palette", vis_dat_plot)
  vdiffr::expect_doppelganger("vis_dat colourblind safe palette", vis_dat_plot)
})
