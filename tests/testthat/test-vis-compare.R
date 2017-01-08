context("comparing vis")

# make a new dataset of iris that contains some NA values

iris_diff <- iris
iris_diff[1:10, 1:2] <- NA

vis_compare_plot <- vis_compare(iris, iris_diff)

vdiffr::expect_doppelganger("vis_compare vanilla", vis_compare_plot)

iris_add <- iris
iris_add$extra <- 1

test_that("vis_compare will not accept two dataframes of differing dims",{
  expect_error(
    vis_compare(iris, iris_add))
})

  # stop("Dimensions of df1 and df2 are not the same. Unfortunately vis_compare
  #      does not handles dataframes of the exact same dimension.")
