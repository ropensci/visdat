## testing for miss_guide_label
test_that("miss_guide_label works for exactly 0.1% missing", {

  # 1 missing in 1000.
  test_miss_1 <- c(1:999, NA)

  expect_equal(miss_guide_label(test_miss_1)$p_miss_lab,
               glue::as_glue("Missing \n(0.1%)"))

  expect_equal(miss_guide_label(test_miss_1)$p_pres_lab,
               glue::as_glue("Present \n(99.9%)"))

})

test_that("miss_guide_label works for < 0.1% missing", {

  # 1 missing in 10,000. This should produce Missing < 0.1
  test_miss_2 <- c(1:10000, NA)

  expect_equal(miss_guide_label(test_miss_2)$p_miss_lab, "Missing (< 0.1%)")
  expect_equal(miss_guide_label(test_miss_2)$p_pres_lab, "Present (> 99.9%)")

})

test_that("miss_guide_label works for no missing", {

  # no missings
  test_miss_3 <- c(1:10)

  expect_equal(miss_guide_label(test_miss_3)$p_miss_lab, "No Missing Values")
  expect_equal(miss_guide_label(test_miss_3)$p_pres_lab, "Present (100%)")

})

test_that("miss_guide_label works for some missings", {

  #
  test_miss_4 <- c(1:10,NA)

  expect_equal(
    readr::parse_number(miss_guide_label(test_miss_4)$p_miss_lab),
    round(mean(is.na(test_miss_4))*100, 1)
    )
  expect_equal(
    readr::parse_number(miss_guide_label(test_miss_4)$p_pres_lab),
    100 - round(mean(is.na(test_miss_4))*100, 1)
    )

})
