vis_binary_plot <- vis_binary(dat_bin)

test_that("vis_binary creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_binary vanilla",
                              vis_binary_plot)

})

test_that("vis_binary sends an error when used with the wrong data",{
  expect_snapshot(
    error = TRUE,
    vis_binary(iris)
    )
})
