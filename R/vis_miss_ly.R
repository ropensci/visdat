#' Interactive plot of missingness in plotly
#'
#' This is a basic implementation of vis_miss in plotly, some work is still
#'   needed to fix the legend, but it is several (read, about 3000x) faster
#'   than doing `ggplotly(vis_miss(data))`.
#'
#' @param x a dataframe
#'
#' @return `plotly` interactive plot, similar in appearance to `vis_miss`
#'
#' @seealso [vis_miss()] [vis_dat()] [vis_guess()] [vis_compare()]
#'
#' @export
#'
#' @examples
#'
#' vis_miss_ly(airquality)
#' plotly::ggplotly(vis_dat(airquality))
#'
vis_miss_ly <- function(x){

  x.na <- is.na(x)
  d <- x.na
  n <- nrow(x)
  # printing for row numbers and column names
  rows <- rep(1:n,ncol(x))
  vars <- rep(colnames(x), each = n)

  categories <- sort(unique(c(d)))
  m <- matrix(match(d, categories), nrow = n)
  txt <- matrix(paste(sprintf("value = %s", as.matrix(x)),
                      sprintf("variables = %s", vars),
                      sprintf("rows = %s", rows),
                      sep = "<br />"),
                nrow = n)

  plotly::plot_ly(z = m,
                  x = names(x),
                  text = txt,
                  hoverinfo = "text",
                  type = "heatmap",
                  colorscale = discretize_colorscale(c("#cccccc","#333333"))) %>%
    plotly::colorbar(tickmode = "array",
                     ticktext = c("Present","Missing"),
                     tickvals = 1:2,
                     len = 0) %>%
    plotly::layout(
      xaxis = list(side = "top"),
      yaxis = list(autorange = "reversed"),
      legend = list(orientation = 'h'))

}

discretize_colorscale <- function(palette, granularity = 4) {
  n <- length(palette)
  colorscale <- data.frame(range= seq_len(n*granularity))
  colorscale$range <- seq(0, 1, length.out = n*granularity)
  colorscale$color <- rep(palette, each = granularity)
  setNames(colorscale, NULL)
}

