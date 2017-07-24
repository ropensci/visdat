#' (Internal) Gather rows into a format appropriate for grid visualisation
#'
#' @param x a dataframe
#'
#' @return data.frame gathered to have columns "variables", "valueType", and a
#'   row id called "rows".
#'
vis_gather_ <- function(x){
  x %>%
  dplyr::mutate(rows = seq_len(nrow(x))) %>%
    tidyr::gather_(key_col = "variable",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])
}


#' (Internal) Add values of each row as a column
#'
#' This adds information about each row, so that when called by plotly, the
#'   values are made visible on hover. Warnings are suppressed because tidyr
#'   gives a warning about type coercion, which is fine.
#'
#' @param x dataframe created from `vis_gather_`
#'
#' @return the x dataframe with the added column `value`.
#'
vis_extract_value_ <- function(x){

  suppressWarnings(
    tidyr::gather_(x,
                   "variable",
                   "value",
                   names(x))$value
  )

}

#' (Internal) Create a boilerplate for visualisations of the vis_ family
#'
#' @param x a dataframe in longformat as transformed by `vis_gather_` and
#'   `vis_extract_value`.
#'
#' @return a ggplot object
#'
vis_create_ <- function(x){

  ggplot2::ggplot(data = x,
                  ggplot2::aes_string(x = "variable",
                                      y = "rows",
                                    # text assists with plotly mouseover
                                    text = "value")) +
  ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
  ggplot2::theme_minimal() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                                     vjust = 1,
                                                     hjust = 1)) +
  ggplot2::labs(x = "",
                y = "Observations") +
    # flip the axes
    ggplot2::scale_y_reverse() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.5))

}

#' (Internal) Create labels for the columns containing the \% missing data
#'
#' @param x data.frame
#' @param col_order_index the order of the columns
#'
#' @return data.frame containing the missingness percent down to 0.1 percent
#'
#' @export
label_col_missing_pct <- function(x,
                                  col_order_index){

  # present everything in the right order
  purrr::map_df(x, ~round(mean(is.na(.))*100,1))[col_order_index] %>%
    purrr::map_chr(function(x){
      dplyr::case_when(
        x == 0 ~  "0%",
        x > 0.1 ~ paste0(x,"%"),
        x < 0.1 ~ "<0.1%"
      )
    }) %>%
    paste0(col_order_index,
           " (",
           .,
           ")")

}

#' Add a specific palette to a visdat plot
#'
#' @param vis_plot visdat plot created using vis_gather_, vis_extract_value
#'   and vis_create_
#' @param palette character "default", "qual" or "cb_safe". "default" (the
#'   default) provides the stock ggplot scale for separating the colours. "qual"
#'   uses an experimental qualitative colour scheme for providing distinct
#'   colours for each Type. "cb_safe" is a set of colours that are appropriate
#'   for those with colourblindness. "qual" and "cb_safe" are drawn from
#'   http://colorbrewer2.org/.
#'
#' @return a visdat plot with a particular palette
#'
#' @examples
#'
#' \dontrun{
#' # see internal use inside vis_guess and vis_dat
#' }
#'
add_vis_dat_pal <- function(vis_plot, palette){

  # palette options: http://docs.ggplot2.org/current/discrete_scale.html
# qualitative, 6 colours --------------------------------------------------
vis_pal_qual <- c("#e41a1c", # red
                      "#ffff33", # yellow
                      "#ff7f00", # Orange
                      "#377eb8", # blue
                      "#4daf4a", # Green
                      "#984ea3") # Purple

# diverging, 6 colours, colour-blind safe -------------------------------
vis_pal_cb_safe <- c('#d73027', # red
                         '#fc8d59', # orange
                         '#fee090', # yellow
                         '#e0f3f8', # light blue
                         '#91bfdb', # mid blue
                         '#4575b4') # dark blue

if (palette == "default"){

  vis_plot

} else if (palette == "qual") {

  vis_plot +
    ggplot2::scale_fill_manual(limits = c("character",
                                          "date",
                                          "factor",
                                          "integer",
                                          "logical",
                                          "numeric"),
                               breaks = c("character", # red
                                          "date", # orange
                                          "factor", # yellow
                                          "integer", # light blue
                                          "logical", # mid blue
                                          "numeric"), # dark blue
                               values = vis_pal_qual,
                               na.value = "grey")


} else if (palette == "cb_safe") {

  vis_plot +
    ggplot2::scale_fill_manual(limits = c("character",
                                          "date",
                                          "factor",
                                          "integer",
                                          "logical",
                                          "numeric"),
                               breaks = c("character", # red
                                          "date", # orange
                                          "factor", # yellow
                                          "integer", # light blue
                                          "logical", # mid blue
                                          "numeric"), # dark blue
                               values = vis_pal_cb_safe,
                               na.value = "grey")

} else  {
  stop("palette arguments need to be either 'qual' 'cb_safe' or 'default'")
} # close else brace

} # close the function
