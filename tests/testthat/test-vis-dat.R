context("vis_dat")

# try out all the options
vis_dat_plot <- vis_dat(typical_data)
vis_dat_plot_sort_type <- vis_dat(typical_data, sort_type = FALSE)
vis_dat_plot_pal_qual <- vis_dat(typical_data, palette = "qual")
vis_dat_plot_pal_cb <- vis_dat(typical_data, palette = "cb_safe")

test_that("vis_dat creates the right plot",{
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  skip_on_gh_actions()
  ver <- as.character(gdtools::version_freetype())
  cat(sprintf("FreeType version: %s\n", ver))
  vdiffr::expect_doppelganger("vis_dat vanilla",
                              vis_dat_plot)
  vdiffr::expect_doppelganger("vis_dat sort_type",
                              vis_dat_plot_sort_type)
  vdiffr::expect_doppelganger("vis_dat qualitative palette",
                              vis_dat_plot_pal_qual)
  vdiffr::expect_doppelganger("vis_dat colourblind safe palette",
                              vis_dat_plot_pal_cb)
})

test_that("vis_dat doesn't fail when using diamonds",{
  msg <- paste0(packageVersion("ggplot2"))
  cat(msg)
  expect_is(vis_dat(ggplot2::diamonds), "gg")
})

test_that("vis_dat fails when the wrong palette is provided",{
  ver <- as.character(gdtools::version_freetype())
  cat(sprintf("FreeType version: %s\n", ver))
  expect_error(vis_dat(typical_data, palette = "wat"))
})

test_that("vis_dat fails when an object of the wrong class is provided", {
  testthat::expect_error(vis_dat(AirPassengers))
})
