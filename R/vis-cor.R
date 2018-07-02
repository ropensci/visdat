#' Create a correlation heatmap ggplot of all of the data
#'
#' This provides a simple approach to visualising correlations amongst variables
#'
#' @param data data.frame
#' @param cor_method correlation method to use, from `cor`: "a character
#'   string indicating which correlation coefficient (or covariance) is to be
#'   computed. One of "pearson" (default), "kendall", or "spearman": can be
#'   abbreviated."
#' @param na_action The method for computing covariances when there are missing
#'   values present. This can be "everything", "all.obs", "complete.obs",
#'   "na.or.complete", or "pairwise.complete.obs" (default). This option is
#'   taken from the `cor` function argument `use`.
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
                    na_action = "pairwise.complete.obs",
                    ...){

  if (!all_numeric(data)) {
    stop("data input can only contain numeric values, please subset the data to the numeric values you would like.")
  } else {

      gather_cor(data,
             cor_method,
             na_action) %>%
      ggplot2::ggplot(ggplot2::aes_string(x = "row_1",
                                          y = "row_2",
                                          fill = "value")) +
        ggplot2::geom_raster() +
        ggplot2::scale_fill_gradient2(low = "steelblue",
                                      mid = "white",
                                      high = "salmon") +
        ggplot2::theme_minimal() +
        ggplot2::scale_x_discrete(position = "top") +
        ggplot2::labs(x = "",
                      y = "") +
        ggplot2::guides(fill = ggplot2::guide_legend(title = "correlation"))
  }
  }

#' (Internal) create a tidy dataframe of correlations suitable for plotting
#'
#' @param data data.frame
#' @param cor_method correlation method to use, from `cor`: "a character
#'   string indicating which correlation coefficient (or covariance) is to be
#'   computed. One of "pearson" (default), "kendall", or "spearman": can be
#'   abbreviated."
#' @param na_action The method for computing covariances when there are missing
#'   values present. This can be "everything", "all.obs", "complete.obs",
#'   "na.or.complete", or "pairwise.complete.obs" (default). This option is
#'   taken from the `cor` function argument `use`.
#'
#'
#' @return tidy dataframe of correlations
#'
#' @examples
#' gather_cor(airquality)
#'
#' @export
gather_cor <- function(data,
                       cor_method = "pearson",
                       na_action = "pairwise.complete.obs"){

  stats::cor(data,
             method = cor_method,
             use = na_action) %>%
    as.data.frame() %>%
    tibble::rownames_to_column() %>%
    tidyr::gather(key = "key",
                  value = "value",
                  -rowname) %>%
    purrr::set_names(c("row_1", "row_2", "value"))

}
