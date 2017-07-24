context("vis_miss")

# try out all the options
vis_miss_plot <- vis_miss(typical_data)
vis_miss_plot_cluster <- vis_miss(typical_data, cluster = TRUE)
vis_miss_plot_sort_rows <- vis_miss(typical_data, sort_miss = TRUE)
vis_miss_plot_show_perc <- vis_miss(typical_data, show_perc = FALSE)
vis_miss_plot_show_perc_col <- vis_miss(typical_data, show_perc_col = FALSE)

test_that("vis_miss creates the right plot",{
  skip_on_cran()
  ver <- as.character(gdtools::version_freetype())
  cat(sprintf("FreeType version: %s\n", ver))
  vdiffr::expect_doppelganger("vis_miss vanilla", vis_miss_plot)
  vdiffr::expect_doppelganger("vis_miss cluster", vis_miss_plot_cluster)
  vdiffr::expect_doppelganger("vis_miss sort rows", vis_miss_plot_sort_rows)
  vdiffr::expect_doppelganger("vis_miss show percent", vis_miss_plot_show_perc)
  vdiffr::expect_doppelganger("vis_miss show percent in columns", vis_miss_plot_show_perc_col)
})
