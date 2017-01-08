context("vis_miss")

# try out all the options
vis_miss_plot <- vis_miss(airquality)
vis_miss_plot_cluster <- vis_miss(airquality, cluster = TRUE)
vis_miss_plot_sort_rows <- vis_miss(airquality, sort_miss = TRUE)
vis_miss_plot_show_perc <- vis_miss(airquality, show_perc = FALSE)
vis_miss_plot_show_flip <- vis_miss(airquality, flip = TRUE)

vdiffr::expect_doppelganger("vis_miss vanilla", vis_miss_plot)
vdiffr::expect_doppelganger("vis_miss cluster", vis_miss_plot_cluster)
vdiffr::expect_doppelganger("vis_miss sort rows", vis_miss_plot_sort_rows)
vdiffr::expect_doppelganger("vis_miss show percent", vis_miss_plot_show_perc)
vdiffr::expect_doppelganger("vis_miss show flip", vis_miss_plot_show_flip)
