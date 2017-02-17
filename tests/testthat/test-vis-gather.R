context("internals")

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
