# context("Guess type")
#
#
# test_that("guess_element correctly identifies individual elements", {
#   expect_equal(guess_type(TRUE), "logical")
#   expect_equal(guess_type(T), "logical")
#   expect_equal(guess_type("TRUE"), "logical")
#   expect_equal(guess_type("T"), "logical")
#   expect_equal(guess_type("01/01/01"), "date")
#   expect_equal(guess_type("01/01/2001"), "date")
#   expect_equal(guess_type(NA), NA)
#   expect_equal(guess_type("NA"), NA)
#   expect_equal(guess_type("10"), "integer")
#   expect_equal(guess_type(10), "integer")
#   expect_equal(guess_type("10.1"), "double")
#   expect_equal(guess_type(10.1), "double")
#   expect_equal(guess_type("abc"), "character")
#   expect_equal(guess_type("$%TG"), "character")
# })
#
# messy_vector <- c(TRUE,
#                   T,
#                   "TRUE",
#                   "T",
#                   "01/01/01",
#                   "01/01/2001",
#                   NA,
#                   NaN,
#                   "NA",
#                   "Na",
#                   "na",
#                   "10",
#                   10,
#                   "10.1",
#                   10.1,
#                   "abc",
#                   "$%TG")
#
# expected_vector <- c("logical",
#                      "logical",
#                      "logical",
#                      "logical",
#                      "date",
#                      "date",
#                      NA,
#                      NA,
#                      NA,
#                      NA,
#                      NA,
#                      "integer",
#                      "integer",
#                      "double",
#                      "double",
#                      "character",
#                      "character")
#
# messy_list <- list(TRUE,
#                    T,
#                    "TRUE",
#                    "T",
#                    "01/01/01",
#                    "01/01/2001",
#                    NA,
#                    NaN,
#                    "NA",
#                    "Na",
#                    "na",
#                    "10",
#                    10,
#                    "10.1",
#                    10.1,
#                    "abc",
#                    "$%TG")
#
# test_that("guess_vector correctly identifies a single vector", {
#   expect_equal(guess_vector(messy_vector),
#                expected_vector)
# })
#
# #
# # don't need to get this to work on dataframes anymore.
# #
# # messy_df <- data.frame(x = messy_vector,
# #                        y = messy_vector,
# #                        z = messy_vector)
# #
# # expected_df <- data.frame(x = expected_vector,
# #                           y = expected_vector,
# #                           z = expected_vector)
# #
# # test_that("guess_df correctly identifies elements in a dataframe", {
# #   expect_equal(guess_df(messy_df),
# #                expected_df)
# # })
#
# # guess_type(NA)
# # guess_type("10.1")
# #
# # guess_type(messy_vector)
# #
# # purrr::map(messy_vector, guess_type)
# # purrr::map_chr(messy_vector, guess_type)
# #
# # purrr::by_row(iris, mean)
# #
# # # for vector
# # purrr::map_chr(x, guess_type)
# #
# # # for dataframe
# # purrr::dmap(x, ~purrr::map_chr(., guess_type))
# #
# # messy_vector
# #
# # guess_type(messy_vector)
# #
# # readr:::collectorGuess("01/01/01",
# #                        locale_ = readr::locale())
# #
# # readr:::collectorGuess(messy_vector,
# #                        locale_ = readr::locale())
# #
# #
