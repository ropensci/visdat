#' Visualise a data.frame to display missingness.
#'
#' \code{vis_miss} provides an at-a-glance ggplot of the missingness inside a dataframe, colouring cells according to missingness, where black indicates a present cell and grey indicates a missing cell. As it returns a ggplot object, it is very easy to customize and change labels, and so on.
#'
#' @param x a data.frame
#'
#' @param cluster logical TRUE/FALSE. TRUE specifies that you want to use hierarchical clustering (mcquitty method) to arrange rows according to missingness. FALSE specifies that you want to leave it as is
#'
#' @param sort_miss logical TRUE/FALSE. TRUE arranges the columns in order of missingness
#'
#' @param show_perc logical TRUE/FALSE. TRUE now adds in the \% of missing/complete data in the whole dataset into the legend. Default value is TRUE
#'
#'
#' @export
vis_miss <- function(x,
                     cluster = FALSE,
                     sort_miss = FALSE,
                     show_perc = TRUE){
  # make a TRUE/FALSE matrix of the data.
  # This tells us whether it is missing (true) or not (false)
  x.na <- is.na(x)

  # switch for creating the missing clustering
  if (cluster == TRUE){

    # this retrieves a row order of the clustered missingness
    row_order_index <-
      dist(x.na*1) %>%
      hclust(method = "mcquitty") %>%
      as.dendrogram %>%
      order.dendrogram

  } else {
    row_order_index <- 1:nrow(x)
  } # end else

  if (sort_miss == TRUE) {

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

  d <- x.na[row_order_index , ] %>%
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

  # calculate the overall % missingness to display in legend ------------

  if (show_perc == TRUE){

    temp <- miss_guide_label(x)

    p_miss_lab <- temp$p_miss_lab

    p_pres_lab <- temp$p_pres_lab

    # # x <- example2
    # p_miss <- (mean(is.na(x)) * 100)
    # p_miss <- round(p_miss, 1)
    #
    # # calculate % present
    # p_pres <- 100-p_miss
    #
    # # create the labels
    # p_miss_lab <- paste("Missing (",
    #                     p_miss,
    #                     "%)",
    #                     sep = "")
    #
    # p_pres_lab <- paste("Present (",
    #                     p_pres,
    #                     "%)",
    #                     sep = "")

    # else if show_perc FALSE
  } else {

    p_miss_lab <- "Missing"

    p_pres_lab <- "Present"

  }

    # then we plot it
    ggplot(data = d,
           aes_string(x = "variables",
                      y = "rows",
                      # text assists with plotly mouseover
                      text = "value")) +
      geom_raster(aes_string(fill = "valueType")) +
      # change the colour, so that missing is grey, present is black
      scale_fill_grey(name = "",
                      labels = c(p_pres_lab,
                                 p_miss_lab)) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45,
                                       vjust = 1,
                                       hjust = 1)) +
      labs(x = "Variables in Data",
           y = "Observations") +
      scale_x_discrete(limits = col_order_index)
      # guides(fill = guide_legend(title = "Type"))
  # Thanks to http://www.markhneedham.com/blog/2015/02/27/rggplot-controlling-x-axis-order/
  # For the tip on using scale_x_discrete

} # end of function
