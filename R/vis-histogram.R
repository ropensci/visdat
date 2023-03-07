#' Visualise histogram of numeric columns in a data.frame
#'
#' `vis_histogram` visualises the distribution of every numeric column in a
#'   dataframe and displays it using a faceted ggplot object.
#'
#' @param x a data.frame
#' @param ... Other arguments are passed as geom_histogram arguments.
#'
#' @return `ggplot2` object displaying the guess of the type of values in the
#'   data frame and the position of any missing values.
#'
#' @examples
#'
#' vis_histogram(airquality, bins = 30)
#'s
#' @export
vis_histogram <- function(data, ...) {
  test_if_dataframe(data)
  test_if_all_numeric(data)

  vis_histogram_plot <- vis_histogram_create(data, ...)

  vis_histogram_plot
}

vis_histogram_create <- function(data, ...) {
  data %>%
    dplyr::mutate(rows = dplyr::row_number()) %>%
    tidyr::pivot_longer(cols = -rows) %>%
    dplyr::filter(!is.na(value)) %>%
    ggplot2::ggplot(ggplot2::aes(value)) +
    ggplot2::facet_wrap(~ name, scales = "free") +
    ggplot2::geom_histogram(...) +
    ggplot2::theme_minimal() +
    ggplot2::labs(x = "", y = "") +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Histogram")) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 0.1)
    )
}
