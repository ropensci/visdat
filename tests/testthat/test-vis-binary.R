context("vis_binary")

vis_binary_plot <- vis_binary(dat_bin)

test_that("vis_binary creates the right plot",{
  skip_on_cran()
  skip_on_appveyor()
  skip_on_travis()
  skip_on_gh_actions()
  vdiffr::expect_doppelganger("vis_binary vanilla",
                              vis_binary_plot)

})

test_that("vis_binary sends an error when used with the wrong data",{
  testthat::expect_error(vis_binary(iris))
})
