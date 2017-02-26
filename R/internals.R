#' (Internal) Gather rows into a format appropriate for grid visualisation
#'
#' @param x a dataframe
#'
#' @return data.frame gathered to have columns "variables", "valueType", and a row id called "rows".
#'
vis_gather_ <- function(x){
  x %>%
  dplyr::mutate(rows = seq_len(nrow(x))) %>%
    tidyr::gather_(key_col = "variables",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])
}


#' (Internal) Add values of each row as a column
#'
#' This adds information about each row, so that when called by plotly, the values are made visible on hover. Warnings are suppressed because tidyr gives a warning about type coercion, which is fine.
#'
#' @param x dataframe created from `vis_gather_`
#'
#' @return the x dataframe with the added column `value`.
#'
vis_extract_value_ <- function(x){

  suppressWarnings(
    tidyr::gather_(x,
                   "variables",
                   "value",
                   names(x))$value
  )

}

#' (Internal) Create a boilerploate for visualisations of the vis_ family
#'
#' @param x a dataframe in longformat as transformed by `vis_gather_` and `vis_extract_value`.
#'
#' @return a ggplot object
#'
vis_create_ <- function(x){

  ggplot2::ggplot(data = x,
                  ggplot2::aes_string(x = "variables",
                                      y = "rows",
                                    # text assists with plotly mouseover
                                    text = "value")) +
  ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
  ggplot2::theme_minimal() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                                     vjust = 1,
                                                     hjust = 1)) +
  ggplot2::labs(x = "Variables in Dataset",
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
           "\n",
           .)

}
