context("Guess type")


test_that("guess_element correctly identifies individual elements", {
  expect_equal(guess_type(TRUE), "logical")
  expect_equal(guess_type(T), "logical")
  expect_equal(guess_type("TRUE"), "logical")
  expect_equal(guess_type("T"), "logical")
  expect_equal(guess_type("10"), "integer")
  expect_equal(guess_type(10), "integer")
  expect_equal(guess_type("10.1"), "double")
  expect_equal(guess_type(10.1), "double")
  expect_equal(guess_type("abc"), "character")
  expect_equal(guess_type("$%TG"), "character")
})
