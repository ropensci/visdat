#' Visualise binary values
#'
#'
#' @param data a data.frame
#' @param col_zero colour for zeroes, default is "salmon"
#' @param col_one colour for ones, default is "steelblue2"
#' @param col_na colour for NA, default is "grey90"
#' @param order optional character vector of the order of variables
#'
#' @return a ggplot plot of the binary values
#'
#' @examples
#' vis_binary(dat_bin)
#'
#' # changing order of variables
#' # create numeric names
#' df <-  setNames(dat_bin, c("1.1", "10.4", "8.9"))
#' df
#' vis_binary(df)
#' # specify the original order
#' vis_binary(df, order = names(df))
#' @export
vis_binary <- function(data,
                       col_zero = "salmon",
                       col_one = "steelblue2",
                       col_na = "grey90",
                       order = NULL) {

  test_if_all_binary(data)

  data %>%
    vis_gather_() %>%
    dplyr::mutate(value = vis_extract_value_(data)) %>%
    dplyr::mutate(valueType = forcats::as_factor(valueType),
                  value = forcats::as_factor(value),
                  variable = forcats::fct_relevel(variable, order)) %>%
    vis_create_() +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Value")) +
    # add info about the axes
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0)) +
    ggplot2::scale_fill_manual(values = c(col_zero, # zero
                                          col_one), # one
                               na.value = col_na)
}
