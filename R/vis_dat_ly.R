#' Interactive plot of data in plotly
#'
#' This makes `vis_dat` interactive using plotly. At the moment this is an
#'   initial implementation that just wraps `plotly::ggplotly()` around
#'   `vis_dat`.
#'
#' @param x a data.frame object
#'
#' @param sort_type logical TRUE/FALSE. When TRUE (default), it sorts by the
#'   type in the column to make it easier to see what is in the data
#'
#' @param palette character "default", "qual" or "cb_safe". "default" (the
#'   default) provides the stock ggplot scale for separating the colours.
#'   "qual" uses an experimental qualitative colour scheme for providing
#'   distinct colours for each Type. "cb_safe" is a set of colours that are
#'   appropriate for those with colourblindness. "qual" and "cb_safe" are drawn
#'   from http://colorbrewer2.org/.
#'
#' @return `plotly` interactive plot, similar in appearance to `vis_dat`
#'
#' @seealso [vis_dat()] [vis_miss()] [vis_miss_ly()] [vis_guess()] [vis_compare()]
#'
#' @export
#'
#' @examples
#'
#' vis_dat_ly(airquality)
#'
vis_dat_ly <- function(x,
                       sort_type = TRUE,
                       palette = "default"){

  plotly::ggplotly(vis_dat(x, sort_type, palette))

}
