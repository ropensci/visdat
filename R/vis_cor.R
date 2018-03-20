#' Create a correlation heatmap ggplot of all of the data
#'
#' This provides a simple approach to visualising correlations amongst variables
#'
#' @param data data.frame
#' @param cor_method correlation method to use, from `cor`: "a character
#'   string indicating which correlation coefficient (or covariance) is to be
#'   computed. One of "pearson" (default), "kendall", or "spearman": can be
#'   abbreviated."
#' @param use_op  what to do in the presence of missings? can be
#'   "everything", "all.obs", "complete.obs", "na.or.complete", or
#'   "pairwise.complete.obs" (default).
#' @param ... extra arguments you may want to pass
#'
#' @return ggplot2 object
#'
#' @export
#'
#' @examples
#' vis_cor(airquality)
#' vis_cor(mtcars)
#' \dontrun{
#' vis_cor(iris)
#' }
vis_cor <- function(data,
                    cor_method = "pearson",
                    use_op = "pairwise.complete.obs",
                    ...){

  if (!all_numeric(data)) {
    stop("data input can only contain numeric values, please subset the data to the numeric values you would like.")
  } else {

  gather_cor(data,
             cor_method,
             use_op) %>%
      ggplot2::ggplot(data,
                      ggplot2::aes(x = row_1,
                                   y = row_2,
                                   fill = value)) +
        ggplot2::geom_raster() +
        ggplot2::scale_fill_gradient2(low = "steelblue",
                                      mid = "white",
                                      high = "salmon") +
        ggplot2::theme_minimal() +
        ggplot2::scale_x_discrete(position = "top") +
        ggplot2::labs(x = "",
                      y = "") +
        ggplot2::guides(fill = ggplot2::guide_legend(title = "correlation")) +
        ggplot2::labs(title = "Correlation heatmap using",
                      subtitle = paste0(cor_method))
    # note: add an option using the internatl function `translate cor use`
    # to provide information about the correlation types used
  }
  }
