#' Visualise binary values
#'
#' @param data a data.frame
#'
#' @return a ggplot plot of the binary values
#' @export
#'
#' @examples
#' vis_binary(dat_bin)
vis_binary <- function(data) {

  test_if_all_binary(data)

  data %>%
    vis_gather_() %>%
    dplyr::mutate(value = vis_extract_value_(data)) %>%
    dplyr::mutate(valueType = as.factor(valueType),
           value = as.factor(value)) %>%
    vis_create_() +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    # add info about the axes
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0)) +
    ggplot2::scale_fill_manual(values = c("salmon",
                                          "steelblue2"))
}
