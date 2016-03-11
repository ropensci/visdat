#' vis_guess
#'
#' \code{vis_guess} visualises a data.frame like vis_dat, but takes a guess at to telling you what it contains.
#'
#' @description \code{vis_guess} just like vis_dat, vis_guess gives you an at-a-glance ggplot object of what is inside a dataframe. Except this time, vis_guess uses `readr` to help it guess what the individual cells are. These cells are coloured according to what class they are and whether the values are missing. As \code{vis_guess} returns a ggplot object, it is very easy to customize. Currently very slow.
#'
#' @param x a data.frame object
#'
#' @examples
#' library(dplyr)
#' library(tidyr)
#' library(visdat)
#'
#' vis_guess(example2)
#'
#' dat_messy <-
#'   example2 %>%
#'   mutate(capacity = ifelse(capacity <= 60500,
#'                            yes = "2010/10/10",
#'                            no = capacity))
#'
#' vis_guess(dat_messy)
#'
#' @export
vis_guess <- function(x){

  d <- x %>%
    mutate(rows = row_number()) %>%
    tidyr::gather_(key_col = "variables",
                   value_col = "valueGuess",
                   gather_cols = names(.)[-length(.)]) %>%
    mutate(guess = guess_type(valueGuess)) %>%
    # drop Valueguess....
    select(-valueGuess)

  # value for plotly mouseover
  d$value <- tidyr::gather_(x, "variables", "value", names(x))$value

    ggplot(data = d,
           aes_string(x = "variables",
                      y = "rows",
                      # text assist with plotly mouseover
                      text = "value")) +
    geom_raster(aes_string(fill = "guess")) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45,
                                     vjust = 1,
                                     hjust = 1)) +
    labs(x = "Variables in Dataset",
         y = "Observations") +
    scale_x_discrete(limits = names(x))

} #end function
