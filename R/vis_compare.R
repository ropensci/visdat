#' compare two dataframes and see where they are different.
#'
#' \code{vis_compare}, like the other vis_* families, gives an at-a-glance ggplot of a dataset, but in this case hones in on visualising **two** different dataframes, which currently need to be exactly the same dimension. This function has not been implemented yet, but this serves as a note of how it might work. It would be very similar to vis_miss, where you basically colouring cells according to "match" and "non-match". The code for this would be pretty crazy simple. `x <- 1:10; y <- c(1:5, 10:14) ;x == y` returns ` [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE` Here black could indicate a match, and white a non match. One of the challenges with this would be cases where the datasets are different dimensions. One option could be to return as a message the columns that are not in the same dataset. Matching rows could be done by row number, and just lopping off the trailing ones and spitting out a note. Then, if the user wants, it could use an ID/key to match by.
#'
#' @param df1 the first dataframe to compare to
#'
#' @param df2 the second dataframe to compare to
#'
#' @examples
#'
#' # make a new dataset of iris that contains some NA values
#' iris_diff <- iris
#' iris_diff[1:10, 1:2] <- NA
#'
#' library(visdat)
#'
#' vis_compare(iris, iris_diff)
#'
#' @export

vis_compare <- function(df1,
                        df2){

  warning("vis_compare is still in BETA! If you have suggestions or errors, post an issue at https://github.com/njtierney/visdat/issues")

  # could add a parameter, "sort_match", to help with
  # sort_match logical TRUE/FALSE. TRUE arranges the columns in order of most matches.

  # make a TRUE/FALSE matrix of the data.
  # This tells us whether it is the same (true) as the other dataset, or not (false)

  if (dim(df1) != dim(df2)){
    stop("Dimensions of df1 and df2 are not the same! Unfortunately at this stage vis_compare only handles dataframes of the exact same dimension. Sorry!")
  }


  v_identical <- Vectorize(identical)

  df_diff <- purrr::map2(df1, df2, v_identical) %>%
    dplyr::as_data_frame()

  d <-
  df_diff %>%
    as.data.frame() %>%
    purrr::dmap(compare_print) %>%
    dplyr::mutate(rows = 1:nrow(.)) %>%
    # gather the variables together for plotting
    # here we now have a column of the row number (row),
    # then the variable(variables),
    # then the contents of that variable (value)
    tidyr::gather_(key_col = "variables",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])

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
