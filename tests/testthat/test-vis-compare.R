context("comparing vis")

# make a new dataset of iris that contains some NA values

iris_diff <- iris
iris_diff[1:10, 1:2] <- NA

vis_compare_plot <- vis_compare(iris, iris_diff)

test_that("vis_compare works",{
  skip_on_cran()
vdiffr::expect_doppelganger("vis_compare vanilla", vis_compare_plot)
})

iris_add <- iris
iris_add$extra <- 1

test_that("vis_compare will not accept two dataframes of differing dims",{
  expect_error(
    vis_compare(iris, iris_add))
})

test_that("vis_compare fails when an object of the wrong class is provided", {
  testthat::expect_error(vis_compare(iris, AirPassengers))
  testthat::expect_error(vis_compare(AirPassengers, iris))
  testthat::expect_error(vis_compare(AirPassengers, AirPassengers))
})
