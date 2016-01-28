#' vis_dat
#'
#' \code{vis_dat} visualises a data.frame to tell you what it contains.
#'
#' @description \code{vis_dat} gives you an at-a-glance ggplot of what is inside a dataframe, colouring cells according to what class they are and whether the values are missing. As it returns a ggplot object, it is very easy to customize and change labels, etc.
#'
#' @param x a data.frame object
#'
#' @importFrom tidyr gather
#' @import dplyr
#' @import ggplot2
#'
#' @export
vis_dat <- function(x){

  # apply the fingerprint to every column in the dataframe
  lapply(x, fingerprint) %>%
    # coerce it to a dataframe...there's probably a better way
    as_data_frame %>%
    # create a new column that is numbered from 1 to the number of rows
    # this assists in the gathering of rows together
    mutate(rows = 1:n()) %>%
    # gather the variables together for plotting
    # here we now have a column of the row number (row), then the variable(variables), then the contents of that variable (value)
    gather(key = variables,
           value = value,
           -rows) %>%
    # then we plot it
    ggplot(data = .,
           aes(x = variables,
               y = rows)) +
    geom_raster(aes(fill = value)) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) +
    labs(x = "Variables in Dataset",
         y = "Rows / observations")

}
