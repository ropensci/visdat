context("vis_ly")

vis_miss_ly_plot <- vis_miss_ly(typical_data)

test_that("vis_miss_ly creates the right plot",{
  expect_is(vis_miss_ly_plot,"plotly")
})

# vis_dat_ly_plot <- vis_dat_ly(typical_data)
#
# test_that("vis_dat_ly creates the right plot",{
#   expect_is(vis_dat_ly_plot,"plotly")
# })
#
# vis_guess_ly_plot <- vis_guess_ly(typical_data)
#
# test_that("vis_guess_ly creates the right plot",{
#   expect_is(vis_guess_ly_plot,"plotly")
# })
#
# iris_diff <- iris
# iris_diff[1:10, 1:2] <- NA
#
# vis_compare_ly_plot <- vis_compare_ly(iris, iris_diff)
#
# test_that("vis_compare_ly creates the right plot",{
#   expect_is(vis_compare_ly_plot,"plotly")
# })
