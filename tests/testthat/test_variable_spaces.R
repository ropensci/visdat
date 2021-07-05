messy_names <- tibble::tibble(`Sepal Width` = iris$Sepal.Width,
                              `Sepal Length` = iris$Sepal.Length,
                              `Petal Length` = iris$Petal.Length,
                              `Species Names` = iris$Species)


test_that("vis_dat works on dataframes with irregular variable names", {
  expect_s3_class(vis_dat(messy_names), "gg")
})
