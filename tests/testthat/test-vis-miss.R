# try out all the options
vis_miss_plot <- vis_miss(typical_data)
vis_miss_plot_cluster <- vis_miss(typical_data, cluster = TRUE)
vis_miss_plot_sort_rows <- vis_miss(typical_data, sort_miss = TRUE)
vis_miss_plot_show_perc <- vis_miss(typical_data, show_perc = FALSE)
vis_miss_plot_show_perc_col <- vis_miss(typical_data, show_perc_col = FALSE)
vis_miss_plot_show_perc_col_t <- vis_miss(typical_data, show_perc_col = TRUE)

test_that("vis_miss creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  ver <- as.character(gdtools::version_freetype())
  cat(sprintf("FreeType version: %s\n", ver))
  vdiffr::expect_doppelganger("vis_miss vanilla", vis_miss_plot)
  vdiffr::expect_doppelganger("vis_miss cluster", vis_miss_plot_cluster)
  vdiffr::expect_doppelganger("vis_miss sort rows", vis_miss_plot_sort_rows)
  vdiffr::expect_doppelganger("vis_miss show percent", vis_miss_plot_show_perc)
  vdiffr::expect_doppelganger("vis_miss show percent in columns", vis_miss_plot_show_perc_col)
  vdiffr::expect_doppelganger("vis_miss no show percent in columns", vis_miss_plot_show_perc_col_t)
})

test_that("vis_miss fails when an object of the wrong class is provided", {
  expect_snapshot(
    error = TRUE,
    vis_miss(AirPassengers)
    )
})

# mixed list_column data with missings in each column
vis_miss_list <- vis_miss(dplyr::starwars %>% dplyr::select(-name, -skin_color, -eye_color, -films))
vis_miss_list_sort_rows <- vis_miss(dplyr::starwars, sort_miss = TRUE)

test_that("vis_miss manage missings in list columns",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_miss list", vis_miss_list)
  vdiffr::expect_doppelganger("vis_miss list sort rows", vis_miss_list_sort_rows)
})

test_that("vis_miss correctly see missings in columns labels",{
  # extract dataframe of columns computed missing percentage
  column <- data.frame(x_lab = vis_miss_list$scales$scales[[3]]$labels) %>%
    tidyr::separate(col = "x_lab",sep = "\\(", remove = TRUE, into = c("column","percent")) %>%
    dplyr::mutate(percent = percent %>% stringr::str_replace("%\\)", "") %>% as.numeric())
  expect_true(all(column$percent >0))

  vis_miss_scale_first_x_label <- vis_miss_list_sort_rows$scales$scales[[3]]$labels[[1]]
  expect_equal(vis_miss_scale_first_x_label,glue::glue("vehicles (87.36%)"))
})

test_that("vis_miss correctly aggregate missings in legend",{
  # extract dataframe of columns computed missing percentage
  global <- data.frame(x_lab = vis_miss_list$scales$scales[[2]]$labels) %>%
    tidyr::separate(col = "x_lab",sep = "\\(", remove = TRUE, into = c("column","percent")) %>%
    dplyr::mutate(percent = percent %>% stringr::str_replace("%\\)", "") %>% as.numeric())
  expect_gt(global["Missing \n","percent"] ,28)

  global <- data.frame(x_lab = vis_miss_list_sort_rows$scales$scales[[2]]$labels) %>%
    tidyr::separate(col = "x_lab",sep = "\\(", remove = TRUE, into = c("column","percent")) %>%
    dplyr::mutate(percent = percent %>% stringr::str_replace("%\\)", "") %>% as.numeric())
  expect_gt(global["Missing \n","percent"] ,20)
})
