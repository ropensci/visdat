context("vis_miss_ly")

vis_miss_ly_plot <- vis_miss_ly(airquality)

test_that("vis_miss_ly creates the right plot",{
  skip_on_cran()
vdiffr::expect_doppelganger("vis_miss_ly",
                            vis_miss_ly_plot)
})
