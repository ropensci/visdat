dat_test <- tibble::tribble(
           ~x, ~y,
           -1,  "A",
           0,  "B",
           1,  "C",
           NA, NA
           )


# try out all the options
vis_expect_plot <- vis_expect(dat_test, ~ .x == -1)
vis_expect_plot_show_perc_true <- vis_expect(dat_test,
                                             ~ .x == -1,
                                             show_perc = FALSE)

test_that("vis_expect creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_expect vanilla",
                              vis_expect_plot)
  vdiffr::expect_doppelganger("vis_expect show perc true",
                              vis_expect_plot_show_perc_true)
})

test_that("vis_expect fails when an object of the wrong class is provided", {
  expect_snapshot(
    error = TRUE,
    vis_expect(AirPassengers, ~.x < 20)
    )
})
