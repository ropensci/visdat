#' vis_miss
#'
#' \code{vis_miss} visualises a data.frame to display missingness.
#'
#' @description \code{vis_miss} gives you an at-a-glance ggplot of the missingness inside a dataframe, colouring cells according to missingness. As it returns a ggplot object, it is very easy to customize and change labels, etc.
#'
#' @param x a data.frame object
#'
#' @export
vis_miss <- function(x){

  x %>%
    is.na %>%
    as.data.frame %>%
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
    # change the colour, so that missing is grey, present is black
    scale_fill_grey(name = "",
                    labels = c("Present",
                               "Missing")) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45,
                                     vjust = 0.5)) +
    labs(x = "Variables in Dataset",
         y = "Rows / observations")

}
