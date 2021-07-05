# try out all the options
vis_guess_plot <- vis_guess(typical_data)
vis_guess_plot_cb_safe <- vis_guess(typical_data, palette = "cb_safe")
vis_guess_plot_qual <- vis_guess(typical_data, palette = "qual")
vis_guess_plot_default <- vis_guess(typical_data, palette = "default")

test_that("vis_guess creates the right plot",{
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_guess vanilla", vis_guess_plot)
  vdiffr::expect_doppelganger("vis_guess cb safe", vis_guess_plot_cb_safe)
  vdiffr::expect_doppelganger("vis_guess qual", vis_guess_plot_qual)
  vdiffr::expect_doppelganger("vis_guess default", vis_guess_plot_default)
})

test_that("vis_guess fails when the wrong palette is provided",{
  expect_snapshot(
    error = TRUE,
    vis_guess(typical_data, palette = "wat")
    )
})

test_that("vis_guess fails when an object of the wrong class is provided", {
  expect_snapshot(
    error = TRUE,
    vis_guess(AirPassengers)
    )
})
