d_old <- typical_data |>
  fingerprint_df() |>
  vis_gather_()

suppressWarnings({
  d_old$value <- tidyr::gather_(
    typical_data,
    "variables",
    "value",
    names(typical_data)
  )$value

  d_old <- d_old |> dplyr::arrange(value)
})

d_new <-
  typical_data |>
  fingerprint_df() |>
  vis_gather_() |>
  dplyr::mutate(value = vis_extract_value_(typical_data)) |>
  dplyr::arrange(value)
# get the values here so plotly can make them visible

test_that("vis_extract_value performs the same as old method", {
  expect_identical(d_old$value, d_new$value)
})

test_that("any_numeric returns TRUE for numeric dataframes and FALSE for \\
          dataframes containing non-numeric values", {
  expect_true(all_numeric(airquality))
  expect_false(all_numeric(iris))
})
test_that("fingerprint can deal with complete-cases list columns", {
  expect_false(all(fingerprint(dplyr::starwars$films) |> is.na()))
})

test_that("fingerprint can count n/a in list columns", {
  expect_identical(sum(fingerprint(dplyr::starwars$vehicles) |> is.na()), 76L)
})
