#' Produces an interactive visualisation of a data.frame to tell you what it contains.
#'
#' \code{vis_datly} provides an interactive version of vis_dat, providing an at-a-glance plotly object of what is inside a dataframe. Cells are coloured according to what class they are and whether the values are missing.
#'
#' @param x a data.frame object
#'
#' @return a \code{plotly} object
#'
#' @export
vis_datly <- function(x) {

# currently removed the sort_type function

  x <- example2
  # reshape the dataframe ready for geom_raster
  d <- x %>%
    # mutate_each_(funs(fingerprint), tbl_vars(.)) %>%
    purrr::dmap(fingerprint) %>%
    mutate(rows = row_number()) %>%
    tidyr::gather_(key_col = "variables",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])

  # get the values here so plotly can make them visible
  d$value <- tidyr::gather_(x, "variables", "value", names(x))$value

  # do the plotly plotting
  # d_ly <- as.matrix(d[,c("rows", "variables", "valueType")])

#
#   d %>%
#     select(rows,
#            variables,
#            valueType) %>%
#     tidyr::spread(key = variables,
#                   value = valueType) %>%
#     as.matrix() %>%
#   plotly::plot_ly(z = ., type="heatmap")

}
