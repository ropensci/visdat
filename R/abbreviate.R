#' Abbreviate all variables in a data frame
#'
#' It can be useful to abbreviate variable names in a data set to make them
#'   easier to plot. This function takes in a data set and some minimum length
#'   to abbreviate the data to.
#'
#' @param data data.frame
#' @param min_length minimum number of characters to abbreviate down to
#'
#' @return data frame with abbreviated variable names
#'
#' @examples
#' long_data <- data.frame(
#'   really_really_long_name = c(NA, NA, 1:8),
#'   very_quite_long_name = c(-1:-8, NA, NA),
#'   this_long_name_is_something_else = c(NA, NA,
#'                                        seq(from = 0, to = 1, length.out = 8))
#' )
#'
#' vis_miss(long_data)
#' long_data %>% abbreviate_vars() %>% vis_miss()
#' @export
abbreviate_vars <- function(data, min_length = 10){

  test_if_dataframe(data)

  dplyr::rename_with(
    data,
    .fn = ~abbreviate(.x,
                      minlength = min_length,
                      method = "both"),
    # this didn't work with ncar_over for some reason?
    .cols = dplyr::everything()
  )
}
