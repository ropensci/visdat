context("vis_expect")

dat_test <- tibble::tribble(
           ~x, ~y,
           -1,  "A",
           0,  "B",
           1,  "C"
           )


# try out all the options
vis_expect_plot <- vis_expect(dat_test, ~ .x == -1)
vis_expect_plot_show_perc_true <- vis_expect(dat_test,
                                             ~ .x == -1,
                                             show_perc = FALSE)

test_that("vis_expect creates the right plot",{
  skip_on_cran()
  ver <- as.character(gdtools::version_freetype())
  cat(sprintf("FreeType version: %s\n", ver))
  vdiffr::expect_doppelganger("vis_expect vanilla",
                              vis_expect_plot)
  vdiffr::expect_doppelganger("vis_expect show perc true",
                              vis_expect_plot_show_perc_true)
})

