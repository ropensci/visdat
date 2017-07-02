#' Visualise type guess in a data.frame
#'
#' `vis_guess` visualises the class of every single individual cell in a dataframe and displays it as ggplot object, similar to `vis_dat`. Cells are coloured according to what class they are and whether the values are missing. `vis_guess` estimates the class of individual elements using `readr::guess_parser`.  Currently it may be slow on larger datasets.
#'
#' @param x a data.frame object
#' @param palette character "default", "qual" or "cb_safe". "default" (the default) provides the stock ggplot scale for separating the colours. "qual" uses an experimental qualitative colour scheme for providing distinct colours for each Type. "cb_safe" is a set of colours that are appropriate for those with colourblindness. "qual" and "cb_safe" are drawn from http://colorbrewer2.org/.
#'
#' @return `ggplot2` object displaying the guess of the type of values in the data frame and the position of any missing values.
#'
#' @seealso [vis_miss()] [vis_dat()] [vis_miss_ly()] [vis_compare()]
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
                                limits = names(x))

  # specify a palette ----------------------------------------------------------
  add_vis_dat_pal(vis_plot, palette)

} # close function
