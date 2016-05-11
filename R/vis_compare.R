#' vis_compare
#'
#' \code{vis_compare} compare two dataframes and see where they are different.
#'
#' @description \code{vis_compare}, like the other vis_* families, gives an at-a-glance ggplot of a particular feature. In this case, it is the difference between two dataframes. This function has not been implemented yet, but this serves as a note of how it might work. It would be very similar to vis_miss, where you basically colouring cells according to "match" and "non-match". The code for this would be pretty crazy simple. `x <- 1:10; y <- c(1:5, 10:14) ;x == y` returns ` [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE` Here black could indicate a match, and white a non match. One of the challenges with this would be cases where the datasets are different dimensions. One option could be to return as a message the columns that are not in the same dataset. Matching rows could be done by row number, and just lopping off the trailing ones and spitting out a note. Then, if the user wants, it could use an ID/key to match by.
#'
#' @param x a data.frame
#'
#' @param sort_match logical TRUE/FALSE. TRUE arranges the columns in order of most matches.
#'
#'

# NOTE: This function is not yet complete, and is unexported as it is still mostly in the idea phase

vis_compare <- function(x,
                        sort_match = FALSE){
  # make a TRUE/FALSE matrix of the data.
  # This tells us whether it is missing (true) or not (false)
  x.na <- is.na(x)

  # But we would want some sort of equivalent function where it

  if (sort_match == TRUE) {

    # arrange by the columns with the highest missingness
    # code inspired from https://r-forge.r-project.org/scm/viewvc.php/pkg/R/missing.pattern.plot.R?view=markup&root=mi-dev
    # get the order of columns with highest missingness
    na_sort <- order(colSums(is.na(x)), decreasing = TRUE)

    # get the names of those columns
    col_order_index <- names(x)[na_sort]

    # original code was a bit slower:
    #
    # col_order_index <-
    #   x.na %>%
    #   as.data.frame %>%
    #   dplyr::summarise_each(funs(mean)) %>%
    #   names

  } else {

    col_order_index <- names(x)

  }

  # Arranged data by dendrogram order index

  d <- x.na %>%
    as.data.frame %>%
    mutate(rows = row_number()) %>%
    # gather the variables together for plotting
    # here we now have a column of the row number (row),
    # then the variable(variables),
    # then the contents of that variable (value)
    tidyr::gather_(key_col = "variables",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])

  d$value <- tidyr::gather_(x, "variables", "value", names(x))$value

  # then we plot it
  ggplot(data = d,
         aes_string(x = "variables",
                    y = "rows",
                    # text assists with plotly mouseover
                    text = "value")) +
    geom_raster(aes_string(fill = "valueType")) +
    # change the colour, so that missing is grey, present is black
    scale_fill_grey(name = "",
                    labels = c("Present",
                               "Missing")) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45,
                                     vjust = 1,
                                     hjust = 1)) +
    labs(x = "Variables in Data",
         y = "Observations") +
    scale_x_discrete(limits = col_order_index)
  # Thanks to http://www.markhneedham.com/blog/2015/02/27/rggplot-controlling-x-axis-order/
  # For the tip on using scale_x_discrete

}
