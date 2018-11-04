#' Visualise the value of data values
#'
#' Visualise all of the values in the data on a 0 to 1 scale.
#'
#' @param data a data.frame
#' @param na_colour a character vector of length one describing what colour you want the NA values to be. Default is "grey90"
#'
#' @return a ggplot plot of the values
#' @export
#'
#' @examples
#'
#' vis_value(airquality)
#'
vis_value <- function(data, na_colour = "grey90") {
  scale_01 <- function(x) {
    (x - min(x, na.rm = TRUE)) / diff(range(x, na.rm = TRUE))
  }

  purrr::map_dfr(data, scale_01) %>%
    vis_gather_() %>%
    dplyr::mutate(value = vis_extract_value_(data)) %>%
    vis_create_() +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    # add info about the axes
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0)) +
    ggplot2::scale_fill_viridis_c(option = "D",
                                  na.value = na_colour)

}
