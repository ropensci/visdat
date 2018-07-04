context("Test names with spaces")

library(visdat)

messy_names <- tibble::tibble(`Sepal Width` = iris$Sepal.Width,
                              `Sepal Length` = iris$Sepal.Length,
                              `Petal Length` = iris$Petal.Length,
                              `Species Names` = iris$Species)


test_that("vis_dat works on dataframes with irregular variable names", {
  expect_is(vis_dat(messy_names), "ggplot")
})
