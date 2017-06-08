#' Visualise a data.frame to display missingness.
#'
#' `vis_miss` provides an at-a-glance ggplot of the missingness inside a dataframe, colouring cells according to missingness, where black indicates a missing cell and grey indicates a present cell. As it returns a ggplot object, it is very easy to customize and change labels.
#'
#' @param x a data.frame
#'
#' @param cluster logical. TRUE specifies that you want to use hierarchical clustering (mcquitty method) to arrange rows according to missingness. FALSE specifies that you want to leave it as is
#'
#' @param sort_miss logical. TRUE arranges the columns in order of missingness
#'
#' @param show_perc logical. TRUE now adds in the \% of missing/complete data in the whole dataset into the legend. Default value is TRUE
#'
#'@param show_perc_col logical. TRUE adds in the \% missing data in a given column into the x axis. Can be disabled if
#'
#' @return `ggplot2` object displaying the position of missing values in the dataframe, and the percentage of values missing and present.
#'
#' @seealso [vis_miss_ly()] [vis_dat()] [vis_guess()] [vis_compare()]
#'
#' @examples
#'
#' vis_miss(airquality)
#'
#' vis_miss(airquality, cluster = TRUE)
#'
#' vis_miss(airquality, sort_miss = TRUE)
#'
#' @export
vis_miss <- function(x,
                     cluster = FALSE,
                     sort_miss = FALSE,
                     show_perc = TRUE,
                     show_perc_col = TRUE){
  # make a TRUE/FALSE matrix of the data.
  # This tells us whether it is missing (true) or not (false)
  x.na <- is.na(x)

  # switch for creating the missing clustering
  if (cluster){

    # this retrieves a row order of the clustered missingness
    row_order_index <-
      stats::dist(x.na*1) %>%
      stats::hclust(method = "mcquitty") %>%
      stats::as.dendrogram() %>%
      stats::order.dendrogram()

  } else {
    row_order_index <- seq_len(nrow(x))
  } # end else

  if (sort_miss) {

    # arrange by the columns with the highest missingness
    # code inspired from https://r-forge.r-project.org/scm/viewvc.php/ ...
    # pkg/R/missing.pattern.plot.R?view=markup&root=mi-dev
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

    # gather the variables together for plotting
    # here we now have a column of the row number (row),
    # then the variable(variables),
    # then the contents of that variable (value)
  dat_pre_vis <- as.data.frame(x.na[row_order_index , ])

  d <-
    # x.na[row_order_index , ] %>%
    # as.data.frame %>%
    dat_pre_vis %>%
    vis_gather_() %>%
    # add info for plotly mousover
    dplyr::mutate(value = vis_extract_value_(dat_pre_vis))

  # d$value <- tidyr::gather_(x, "variables", "value", names(x))$value

  # calculate the overall % missingness to display in legend ------------

  if (show_perc){

    temp <- miss_guide_label(x)

    p_miss_lab <- temp$p_miss_lab

    p_pres_lab <- temp$p_pres_lab

    # else if show_perc FALSE
  } else {

    p_miss_lab <- "Missing"

    p_pres_lab <- "Present"

  }

    # then we plot it
  vis_miss_plot <- vis_create_(d) +
      ggplot2::scale_fill_manual(name = "",
                        values = c("grey80",
                                   "grey20"),
                        labels = c(p_pres_lab,
                                     p_miss_lab)) +
      ggplot2::guides(fill = ggplot2::guide_legend(reverse = TRUE)) +
    ggplot2::theme(legend.position = "bottom")

  # add the missingness column labels
  if (show_perc_col){

    # flip the axes, add the info about limits
    vis_miss_plot +
      ggplot2::scale_x_discrete(position = "top",
                                limits = col_order_index,
                                labels = label_col_missing_pct(x,
                                                               col_order_index)) +
      # fix up the location of the text
      ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.2))
  } else {
    vis_miss_plot +
    ggplot2::scale_x_discrete(position = "top",
                              limits = col_order_index)
  }

      # guides(fill = guide_legend(title = "Type"))
  # Thanks to
# http://www.markhneedham.com/blog/2015/02/27/rggplot-controlling-x-axis-order/
  # For the tip on using scale_x_discrete

} # end of function
