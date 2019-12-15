context("vis_value")

vis_value_plot <- vis_value(airquality)

test_that("vis_value creates the right plot",{
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  skip_on_gh_actions()
  vdiffr::expect_doppelganger("vis_value vanilla",
                              vis_value_plot)

})

test_that("vis_value sends an error when used with the wrong data",{
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  skip_on_gh_actions()
  testthat::expect_error(vis_value(iris))
})
