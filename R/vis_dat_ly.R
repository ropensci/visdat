#' Produces an interactive visualisation of a data.frame to tell you what it contains.
#'
#' \code{vis_dat_ly} uses plotly to provide an interactive version of vis_dat, providing an at-a-glance plotly object of what is inside a dataframe. Cells are coloured according to what class they are and whether the values are missing.
#'
#' @param x a \code{data.frame}
#'
#' @return a \code{plotly} object
#'
#' @examples
#'
#' \dontrun{
#' # currently does not work, some problems with palletes and other weird messages.
#' vis_dat_ly(airquality)
#'
#'}
#'
#'
vis_dat_ly <- function(x) {

  # x = data.frame(x = 1L:10L,
  #                y = letters[1:10],
  #                z = runif(10))

  # apply the fingerprint function to get the class
  d <- x %>% purrr::dmap(fingerprint) %>% as.matrix()

  # heatmap fails due to not being a numeric matrix
  # heatmap(d)

  # plotly fails due to the number of colours being too many?
  plotly::plot_ly(z = d,
                  type = "heatmap")


}
