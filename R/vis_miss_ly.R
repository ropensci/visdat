#' Interactive plot of missingness in plotly
#'
#' This is a basic implementation of vis_miss in plotly, some work is still needed to fix the legend, but it is several (read, about 3000x) faster than doing \code{ggplotly(vis_miss(data))}.
#'
#' @param x a dataframe
#'
#' @seealso vis_miss
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
          colors = c("grey80", "grey20"),
          colorbar = list(ticktext = c("Present","Missing"),
                          tickvals = seq_along(categories))
  ) %>% plotly::layout(xaxis = list(title = ""))

}


