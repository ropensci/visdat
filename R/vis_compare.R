#' Visually compare two dataframes and see where they are different.
#'
#' `vis_compare`, like the other `vis_*` families, gives an at-a-glance ggplot of a dataset, but in this case, hones in on visualising **two** different dataframes of the same dimension.
#'
#' @param df1 The first dataframe to compare
#'
#' @param df2 The second dataframe to compare to the first.
#'
#' @return `ggplot2` object displaying which values in each data frame are present in each other.
#'
#' @seealso [vis_miss()] [vis_dat()] [vis_miss_ly()] [vis_compare()]
#'
#' @examples
#'
#' # make a new dataset of iris that contains some NA values
#' iris_diff <- iris
#' iris_diff[1:10, 1:2] <- NA
#'
#' vis_compare(iris, iris_diff)
#' @export
vis_compare <- function(df1,
                        df2){

  message("vis_compare is in BETA! If you have suggestions or errors\npost an issue at https://github.com/njtierney/visdat/issues")

  # could add a parameter, "sort_match", to help with
  # sort_match logical TRUE/FALSE.
  # TRUE arranges the columns in order of most matches.

  # make a TRUE/FALSE matrix of the data.
  # Tells us whether it is the same (true) as the other dataset, or not (false)

  if (!identical(dim(df1), dim(df2))){
    stop("Dimensions of df1 and df2 are not the same. Unfortunately vis_compare
          does not handles dataframes of the exact same dimension.")
  }

  v_identical <- Vectorize(identical)

  df_diff <- purrr::map2(df1, df2, v_identical) %>%
    dplyr::as_data_frame()

  d <-
  df_diff %>%
    as.data.frame() %>%
    purrr::map_df(compare_print) %>%
    dplyr::mutate(rows = seq_len(nrow(.))) %>%
    # gather the variables together for plotting
    # here we now have a column of the row number (row),
    # then the variable(variables),
    # then the contents of that variable (value)
    tidyr::gather_(key_col = "variables",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])
    purrr::map_df(compare_print) %>%
    vis_gather_()

  d$value_df1 <- tidyr::gather_(df1, "variables", "value", names(df1))$value
  d$value_df2 <- tidyr::gather_(df2, "variables", "value", names(df2))$value

  # then we plot it
  ggplot2::ggplot(data = d,
                  ggplot2::aes_string(x = "variables",
                    y = "rows",
                    # text assists with plotly mouseover
                    text = c("value_df1", "value_df2"))) +
    ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
    # change the colour, so that missing is grey, present is black
    # scale_fill_discrete(name = "",
    #                     labels = c("Different",
    #                                "Missing",
    #                                "Same")) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                     vjust = 1,
                                     hjust = 1)) +
    ggplot2::labs(x = "Variables in Data",
         y = "Observations",
         fill = "Cell Type") +
    ggplot2::scale_x_discrete(limits = names(df_diff)) +
    ggplot2::scale_fill_manual(limits = c("same",
                                 "different"),
                      breaks = c("same", # red
                                 "different"), # dark blue
                      values = c("#ff7f00", # Orange
                                 "#377eb8"), # blue
                      na.value = "grey")
}
