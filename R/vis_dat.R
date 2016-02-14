#' vis_dat
#'
#' \code{vis_dat} visualises a data.frame to tell you what it contains.
#'
#' @description \code{vis_dat} gives you an at-a-glance ggplot object of what is inside a dataframe. Cells are coloured according to what class they are and whether the values are missing. As \code{vis_dat} returns a ggplot object, it is very easy to customize and change labels, and customize the plot
#'
#' @param x a data.frame object
#'
#' @export
vis_dat <- function(x) {

  x %>%
    mutate_each_(funs(fingerprint), tbl_vars(.)) %>%
    mutate(rows = row_number()) %>%
    tidyr::gather_(key_col = "variables",
                   value_col = "value",
                   gather_cols = names(.)[-length(.)]) %>%
    ggplot(aes_string(x = "variables", y = "rows")) +
    geom_raster(aes_string(fill = "value")) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) +
    labs(x = "Variables in Dataset",
         y = "Observations")

}
