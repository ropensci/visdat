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
#' vis_cor(iris)
vis_cor <- function(data,
                    cor_method = "pearson",
                    use_op = "pairwise.complete.obs",
                    ...){

  vis_gather_cor(data,
                 cor_method,
                 use_op) %>%
    vis_create_cor()

}
