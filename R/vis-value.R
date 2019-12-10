#' Visualise the value of data values
#'
#' Visualise all of the values in the data on a 0 to 1 scale. Only works on
#'   numeric data - see examples for how to subset to only numeric data.
#'
#' @param data a data.frame
#' @param na_colour a character vector of length one describing what colour
#'   you want the NA values to be. Default is "grey90"
#' @param viridis_option A character string indicating the colormap option to
#'   use. Four options are available: "magma" (or "A"), "inferno" (or "B"),
#'   "plasma" (or "C"), "viridis" (or "D", the default option) and "cividis"
#'   (or "E").
#'
#' @return a ggplot plot of the values
#' @export
#'
#' @examples
#'
#' vis_value(airquality)
#' vis_value(airquality, viridis_option = "A")
#' vis_value(airquality, viridis_option = "B")
#' vis_value(airquality, viridis_option = "C")
#' vis_value(airquality, viridis_option = "E")
#' \dontrun{
#' library(dplyr)
#' diamonds %>%
#'   select_if(is.numeric) %>%
#'   vis_value()
#'}
vis_value <- function(data,
                      na_colour = "grey90",
                      viridis_option = "D") {

  test_if_all_numeric(data)

  purrr::map_dfr(data, scale_01) %>%
    vis_gather_() %>%
    dplyr::mutate(value = vis_extract_value_(data)) %>%
    vis_create_() +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    # add info about the axes
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0)) +
    ggplot2::scale_fill_viridis_c(option = viridis_option,
                                  na.value = na_colour)

}
