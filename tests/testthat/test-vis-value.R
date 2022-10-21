vis_value_plot <- vis_value(airquality)

test_that("vis_value creates the right plot",{
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_value vanilla",
                              vis_value_plot)

})

test_that("vis_value sends an error when used with the wrong data",{
  expect_snapshot_error(
    vis_value(iris)
    )
})

dat <- data.frame(
  constant = 34,
  regular = 1:5,
  sub_regular = c(NA, NA, 1, 2, 34)
)

vis_value_constant <- vis_value(dat, na_colour = "red")

test_that("vis_value works when there is data of constant value", {
  skip_on_cran()
  skip_on_ci()
  vdiffr::expect_doppelganger("vis_value constant",
                              vis_value_constant)

})

