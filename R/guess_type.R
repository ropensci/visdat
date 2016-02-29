#' guess_type
#'
#' @param x a vector of values you want to guess
#'
#' @return a character describing the suspected class. e.g., "10" is an integer, "20.11" is a double, "text" is character, etc.
#' @export
#'
guess_type <- function(x){

  # since
  # readr:::collectorGuess(NA,
  #                        locale_ = readr::locale())
  #
  # returns "character", use an ifelse to identify NAs

  ifelse(is.na(x),
         # yes? Leave as is NA
         yes = NA,
         # no? have a guess at the type of data it is using readr
         no = readr:::collectorGuess(x,
                                     locale_ = readr::locale())
  )
}

# > foo <- c(NA, "10", "10.1", "10/01/2001")
# > guess_type(foo)
# [1] NA          "character" "character"
# [4] "character"
#
# > purrr::map_chr(foo, guess_type)
# [1] NA          "integer"   "double"
# [4] "character"
#
# foo_bar <- dplyr::data_frame(x1 = c(NA, "10", "10.1", "10/01/2001"),
#                              x2 = c(NA, "10.1", NA, "FALSE"))
#
# purrr:::map(foo_bar, guess_type)
#
# $x1
# [1] NA          "character" "character"
# [4] "character"
#
# $x2
# [1] NA          "character" NA
# [4] "character"
#
# purrr:::map_chr(foo_bar$x1, guess_type)
#
# [1] NA          "integer"   "double"
# [4] "character"
