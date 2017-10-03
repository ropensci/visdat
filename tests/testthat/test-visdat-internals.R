context("Internals")

test_vis_gather_ <- suppressWarnings(vis_gather_(typical_data))

suppressWarnings(
  test_old_gather <- typical_data %>%
    dplyr::mutate(rows = seq_len(nrow(.))) %>%
    tidyr::gather_(key_col = "variable",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])
)

test_that("vis_gather_ returns the same as previous",{

  expect_equal(test_vis_gather_,
               test_old_gather)

})

d_old <- typical_data %>%
  purrr::map_df(fingerprint) %>%
  vis_gather_()

suppressWarnings(
  d_old$value <-  tidyr::gather_(typical_data,
                                 "variables",
                                 "value", names(typical_data))$value
)

d_new <-
  typical_data %>%
  purrr::map_df(fingerprint) %>%
  vis_gather_() %>%
  dplyr::mutate(value = vis_extract_value_(typical_data))
# get the values here so plotly can make them visible

test_that("vis_extract_value performs the same as old method",{
  expect_equal(d_old,d_new)
})

test_that("any_numeric returns TRUE for numeric dataframes and FALSE for dataframes containing non-numeric values",{

  testthat::expect_equal(all_numeric(airquality),TRUE)
  testthat::expect_equal(all_numeric(iris),FALSE)

})
