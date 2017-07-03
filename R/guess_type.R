#' Guess the type of each individual cell in a dataframe
#'
#' `guess_type` is used by vis_guess to guess cell elements, like `fingerprint`.
#'
#' @param x is a vector of values you want to guess
#'
#' @return a character vector that describes the suspected class. e.g., "10" is
#'   an integer, "20.11" is a double, "text" is character, etc.
#'
#' @examples
#' \dontrun{
#' guess_type(1)
#'
#' guess_type("x")
#'
#' guess_type(c("1", "0L"))
#'
#' purrr::map_df(iris, guess_type)
#' }
guess_type <- function(x){

  # since
  # readr::collector_guess(NA,
  #                        locale_ = readr::locale())
  #
  # returns "character", use an ifelse to identify NAs
  #
  # Basically, this is fast way to check individual elements of a vector
  # I'd like to use purrr::map for this but I couldn't get it to work without
  # writing more function calls, which slowed it down, by a factor of about 3.
  # So this is faster, for the moment.

  output <- character(length(x))
  nas <- is.na(x)

  output[!nas] <- vapply(FUN = readr::guess_parser,
                         X = x[!nas],
                         FUN.VALUE = character(1))
  output[nas] <- NA
  output

}
#'
#' all.equal(guess_df_1(iris), guess_df_2(iris))
#'
#' iris %>%
#'   gather %>%
#'   guess_vector()
#'
#' messy_df %>%
#'
#' mb_df <-
#' microbenchmark::microbenchmark(
#'   guess_df_1(iris),
#'   guess_df_2(iris)
#'   )
#'
#' # then do this:
#' #
#' #     new_function <- function(x) purrr::dmap(x, ~purrr::map_chr(., guess_type))
#' #
#' #     or maybe make it an S3 method?
#' #
#' # guess.data.frame
#'
#' # > foo <- c(NA, "10", "10.1", "10/01/2001")
#' # > guess_type(foo)
#' # [1] NA          "character" "character"
#' # [4] "character"
#' #
#' # > purrr::map_chr(foo, guess_type)
#' # [1] NA          "integer"   "double"
#' # [4] "character"
#' #
#' # foo_bar <- dplyr::data_frame(x1 = c(NA, "10", "10.1", "10/01/2001"),
#' #                              x2 = c(NA, "10.1", NA, "FALSE"))
#' #
#' # purrr:::map(foo_bar, guess_type)
#' #
#' # $x1
#' # [1] NA          "character" "character"
#' # [4] "character"
#' #
#' # $x2
#' # [1] NA          "character" NA
#' # [4] "character"
#' #
#' # purrr:::map_chr(foo_bar$x1, guess_type)
#' #
#' # [1] NA          "integer"   "double"
#' # [4] "character"
#'
#'
#'
#' # ------------------ perhaps rename guess_type to do this: purrr::map_chr(messy_vector, guess_type).
#'
