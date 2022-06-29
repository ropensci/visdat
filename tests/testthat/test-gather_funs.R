test_that("vis_gather_ works", {
  expect_snapshot(
    vis_gather_(airquality)
  )
  expect_snapshot(
    vis_gather_(typical_data)
  )
})
