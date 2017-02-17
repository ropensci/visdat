context("Internals")

test_vis_gather_ <- airquality %>%
  as.data.frame %>%
  vis_gather_()

test_old_gather <- airquality %>%
  as.data.frame %>%
  dplyr::mutate(rows = seq_len(nrow(.))) %>%
  tidyr::gather_(key_col = "variables",
                 value_col = "valueType",
                 gather_cols = names(.)[-length(.)])

test_that("vis_gather_ returns the same as previous",{

  expect_equal(test_vis_gather_,
               test_old_gather)

})

d_old <-
  airquality %>%
  purrr::map_df(fingerprint) %>%
  vis_gather_()

d_old$value <-  tidyr::gather_(airquality,
                               "variables",
                               "value", names(airquality))$value

d_new <-
  airquality %>%
  purrr::map_df(fingerprint) %>%
  vis_gather_() %>%
  dplyr::mutate(value = vis_extract_value_(airquality))
# get the values here so plotly can make them visible

test_that("vis_extract_value performs the same as old method",{
  expect_equal(d_old,d_new)
})
