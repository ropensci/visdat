#' Return data used to create vis_cor plot
#'
#' @param x data.frame
#' @param ... extra arguments (currently unused)
#'
#' @return data frame
#' @name data-vis-cor
#' @export
#'
#' @examples
#' data_vis_cor(airquality)
#'
#' \dontrun{
#' #return vis_dat data for each group
#' library(dplyr)
#' airquality %>%
#'   group_by(Month) %>%
#'   data_vis_cor()
#' }
data_vis_cor <- function(x, ...){
  UseMethod("data_vis_cor")
}

#' @rdname data-vis-cor
#' @export
data_vis_cor.default <- function(x, ...){
  data_vis_class_not_implemented("vis_cor")
}

#' Create a tidy dataframe of correlations suitable for plotting
#'
#' @param x data.frame
#' @param cor_method correlation method to use, from `cor`: "a character
#'   string indicating which correlation coefficient (or covariance) is to be
#'   computed. One of "pearson" (default), "kendall", or "spearman": can be
#'   abbreviated."
#' @param na_action The method for computing covariances when there are missing
#'   values present. This can be "everything", "all.obs", "complete.obs",
#'   "na.or.complete", or "pairwise.complete.obs" (default). This option is
#'   taken from the `cor` function argument `use`.
#'
#' @return tidy dataframe of correlations
#'
#' @examples
#' data_vis_cor(airquality)
#'
#' @rdname data-vis-cor
#' @export
data_vis_cor.data.frame <- function(x,
                                    cor_method = "pearson",
                                    na_action = "pairwise.complete.obs",
                                    ...){

  stats::cor(x,
             method = cor_method,
             use = na_action) %>%
    as.data.frame() %>%
    tibble::rownames_to_column() %>%
    tidyr::pivot_longer(
      cols = -rowname,
      names_to = "key",
      values_to = "value"
    ) %>%
    purrr::set_names(c("row_1", "row_2", "value"))

}

#' @rdname data-vis-cor
#' @export
data_vis_cor.grouped_df <- function(x, ...){
  group_by_fun(x, data_vis_cor)
}
