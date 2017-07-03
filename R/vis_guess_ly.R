#' Visualise guess in a data.frame
#'
#' `vis_guess_ly`, like the other `vis_*_ly` families, gives an at-a-glance
#'    interactive plotly plot of a dataset, using the `*` method. In this case,
#'    an interactive version of `vis_guess`.
#'
#' @param x a data.frame object
#'
#' @param palette character "default", "qual" or "cb_safe". "default" (the
#'   default) provides the stock ggplot scale for separating the colours.
#'   "qual" uses an experimental qualitative colour scheme for providing
#'   distinct colours for each Type. "cb_safe" is a set of colours that are
#'   appropriate for those with colourblindness. "qual" and "cb_safe" are drawn
#'   from http://colorbrewer2.org/.
#'
#' @return `plotly` interactive plot, similar in appearance to `vis_guess`
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
#' vis_guess_ly(messy_df)
#'
#' @export

vis_guess_ly <- function(x, palette = "default"){

  plotly::ggplotly(vis_guess(x, palette))

}
