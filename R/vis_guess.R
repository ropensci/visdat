#' Visualise a data.frame like vis_dat, but takes a guess at to telling you what it contains.
#'
#' \code{vis_guess} just like vis_dat, vis_guess gives you an at-a-glance ggplot object of what is inside a dataframe. Except this time, vis_guess uses `readr` to help it guess what the individual cells are. These cells are coloured according to what class they are and whether the values are missing. As \code{vis_guess} returns a ggplot object, it is very easy to customize. Currently very slow.
#'
#' @param x a data.frame object
#'
#' @examples
#'
#' library(tidyr)
#' library(readr) # to load the `readr:::collectorGuess` function
#' library(dplyr)
#' library(visdat)
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
#'
#' @export
vis_guess <- function(x){

  warning("vis_guess is still in BETA! If you have suggestions or errors, post an issue at https://github.com/njtierney/visdat/issues")


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
      scale_x_discrete(limits = names(x))  +
      guides(fill = guide_legend(title = "Type"))

} #end function
