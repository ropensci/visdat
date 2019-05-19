#' Visualise type guess in a data.frame
#'
#' `vis_guess` visualises the class of every single individual cell in a
#'   dataframe and displays it as ggplot object, similar to `vis_dat`. Cells
#'   are coloured according to what class they are and whether the values are
#'   missing. `vis_guess` estimates the class of individual elements using
#'   `readr::guess_parser`.  It may be currently slow on larger datasets.
#'
#' @param x a data.frame
#' @param palette character "default", "qual" or "cb_safe". "default" (the
#'   default) provides the stock ggplot scale for separating the colours.
#'   "qual" uses an experimental qualitative colour scheme for providing
#'   distinct colours for each Type. "cb_safe" is a set of colours that are
#'   appropriate for those with colourblindness. "qual" and "cb_safe" are drawn
#'   from http://colorbrewer2.org/.
#'
#' @return `ggplot2` object displaying the guess of the type of values in the
#'   data frame and the position of any missing values.
#'
#' @seealso  [vis_miss()] [vis_dat()] [vis_expect()] [vis_cor()] [vis_compare()]
#'
#' @examples
#'
#' messy_vector <- c(TRUE,
#'                  "TRUE",
#'                  "T",
#'                  "01/01/01",
#'                  "01/01/2001",
#'                  NA,
#'                  NaN,
#'                  "NA",
#'                  "Na",
#'                  "na",
#'                  "10",
#'                  10,
#'                  "10.1",
#'                  10.1,
#'                  "abc",
#'                  "$%TG")
#' set.seed(1114)
#' messy_df <- data.frame(var1 = messy_vector,
#'                        var2 = sample(messy_vector),
#'                        var3 = sample(messy_vector))
#' vis_guess(messy_df)
#' @export
vis_guess <- function(x, palette = "default"){

# x = messy_df
  # suppress warnings here as this is just a note about combining classes
  d <- suppressWarnings(vis_gather_(x)) %>%
    dplyr::mutate(valueType = guess_type(valueType)) %>%
  # value for plotly mouseover
    dplyr::mutate(value = vis_extract_value_(x))

  # add the boilerplate information
  vis_plot <- vis_create_(d) +
      ggplot2::guides(fill = ggplot2::guide_legend(title = "Type")) +
      # flip the axes, add info for axes
      ggplot2::scale_x_discrete(position = "top",
                                limits = names(x)) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))

  # specify a palette ----------------------------------------------------------
  add_vis_dat_pal(vis_plot, palette)

} # close function

#' (Internal) Guess the type of each individual cell in a dataframe
#'
#' `vis_guess` uses `guess_type` to guess cell elements, like `fingerprint`.
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
  # This is a fast way to check individual elements of a vector.
  # `purrr::map` writes more function calls, slowing down things by a factor
  # of about 3. This is faster, for the moment.

  output <- character(length(x))
  nas <- is.na(x)

  output[!nas] <- vapply(FUN = readr::guess_parser,
                         X = x[!nas],
                         FUN.VALUE = character(1),
                         guess_integer = TRUE)
  output[nas] <- NA
  output

}
