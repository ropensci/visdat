#' vis_miss_ly
#'
#' basic implementation of vis_miss in plotly. Still need to fix the legend. this is handy when you want to interactively explore your data.
#'
#' @param x a dataframe
#'
#' @return a plotly interactive plot.
#' @export
#'
#' @examples
#'
#' library(visdat)
#' vis_miss_ly(airquality)
#'
vis_miss_ly <- function(x){

  x.na <- is.na(x)
  d <- x.na
  n <- nrow(x)

  categories <- sort(unique(c(d)))
  m <- matrix(match(d, categories), nrow = n)
  txt <- matrix(paste(as.matrix(x), "<br />", d), nrow = n)

  plotly::plot_ly(z = m,
          x = names(x),
          text = txt,
          hoverinfo = "text",
          type = "heatmap",
          colorbar = list(ticktext = categories,
                          tickvals = seq_along(categories))
  ) %>% plotly::layout(xaxis = list(title = ""))

}


