#' Visualise correlations amongst variables in your data as a heatmap
#'
#' Visualise correlations amongst variables in your data as a heatmap
#'
#' @param data data.frame
#' @param cor_method correlation method to use, from `cor`: "a character
#'   string indicating which correlation coefficient (or covariance) is to be
#'   computed. One of "pearson" (default), "kendall", or "spearman": can be
#'   abbreviated."
#' @param na_action The method for computing covariances when there are missing
#'   values present. This can be "everything", "all.obs", "complete.obs",
#'   "na.or.complete", or "pairwise.complete.obs" (default). This option is
#'   taken from the `cor` function argument `use`.,
#' @param facet bare unqoted variable to use for facetting
#' @param ... extra arguments you may want to pass to `cor`
#'
#' @return ggplot2 object
#'
#' @export
#'
#' @examples
#' vis_cor(airquality)
#' vis_cor(airquality, facet = Month)
#' vis_cor(mtcars)
#' \dontrun{
#' # this will error
#' vis_cor(iris)
#' }
vis_cor <- function(data,
                    cor_method = "pearson",
                    na_action = "pairwise.complete.obs",
                    facet,
                    ...){

  test_if_dataframe(data)
  test_if_all_numeric(data)

  if (!missing(facet)){
    data <- dplyr::group_by(data, {{ facet }})
  }

    cor_data <- data_vis_cor(data,
                           cor_method,
                           na_action)

    vis_cor_plot <- vis_cor_create(cor_data)

    if (!missing(facet)){
      vis_cor_plot <- vis_cor_plot +
        ggplot2::facet_wrap(facets = dplyr::vars({{ facet }}))
    }

    vis_cor_plot
}

vis_cor_create <- function(data){
  ggplot2::ggplot(data = data,
                  ggplot2::aes(x = row_1,
                               y = row_2,
                               fill = value)) +
    ggplot2::geom_raster() +
    # colours from scico::scico(3, palette = "vik")
    ggplot2::scale_fill_gradient2(low = "#001260",# blue
                                  mid = "#EAEDE9", # white
                                  high = "#601200", # red
                                  breaks = c(-1, -0.5, 0, 0.5, 1),
                                  limits = c(-1, 1)) +
    ggplot2::theme_minimal() +
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::labs(x = "",
                  y = "") +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Correlation")) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                                       hjust = 0))
}
