context("test-vis-dat-one-col")

# try out all the options, but for one column
df <- data.frame(a = c(1:1000, rep(NA, 100)))

# try out all the options
one_vis_miss_plot <- vis_miss(df)
one_vis_miss_plot_cluster <- vis_miss(df, cluster = TRUE)
one_vis_miss_plot_sort_rows <- vis_miss(df, sort_miss = TRUE)
one_vis_miss_plot_show_perc <- vis_miss(df, show_perc = FALSE)
one_vis_miss_plot_show_perc_col <- vis_miss(df, show_perc_col = FALSE)
one_vis_miss_plot_show_perc_col_t <- vis_miss(df, show_perc_col = TRUE)

test_that("vis_miss creates the right plot when one column is presented",{
  skip_on_cran()
  ver <- as.character(gdtools::version_freetype())
  cat(sprintf("FreeType version: %s\n", ver))
  vdiffr::expect_doppelganger("vis_miss with one col vanilla",
                              one_vis_miss_plot)
  vdiffr::expect_doppelganger("vis_miss with one col cluster",
                              one_vis_miss_plot_cluster)
  vdiffr::expect_doppelganger("vis_miss with one col sort rows",
                              one_vis_miss_plot_sort_rows)
  vdiffr::expect_doppelganger("vis_miss with one col show pct",
                              one_vis_miss_plot_show_perc)
  vdiffr::expect_doppelganger("vis_miss with one col show pct in columns",
                              one_vis_miss_plot_show_perc_col)
  vdiffr::expect_doppelganger("vis_miss with one col no show pct in columns",
                              one_vis_miss_plot_show_perc_col_t)
})
