#' Create a dataframe to help visualise 'expected' values
#'
#' @param data data.frame
#' @param expectation unquoted function calls - conditions or "expectations" to test
#'
#' @return data.frames where expectation are true
#' @author Stuart Lee and Earo Wang
#'
#' @examples
#'
#' \dontrun{
#' dat_test <- tibble::tribble(
#'             ~x, ~y,
#'             -1,  "A",
#'             0,  "B",
#'             1,  "C"
#'             )
#'
#' expect_frame(dat_test,
#'              ~ .x == -1)
#' }
expect_frame <- function(data, expectation){

  my_fun <- purrr::as_mapper(expectation)

  purrr::map_dfc(data, my_fun)

}

#' Visualise whether a value is in a data frame
#'
#' vis_expect visualises certain conditions or values in your data. For example,
#'   If you are not sure whether to expect -1 in your data, you could write:
#'   `vis_expect(data, ~.x == -1)`, and you can see if there are times where
#'   the values in your data are equal to -1. You could also, for example,
#'   explore a set of bad strings, or possible NA values and visualise where
#'   they are using \code{vis_expect(data, ~.x \%in\% bad_strings)} where
#'   `bad_strings` is a character vector containing bad strings  like `N A`
#'   `N/A` etc.
#'
#' @param data a data.frame
#' @param expectation a formula following the syntax: `~.x {condition}`.
#'   For example, writing `~.x < 20` would mean "where a variable value is less
#'   than 20, replace with NA", and \code{~.x \%in\% {vector}} would mean "where a
#'   variable has values that are in that vector".
#' @param show_perc logical. TRUE now adds in the \% of expectations are
#'   TRUE or FALSE in the whole dataset into the legend. Default value is TRUE.
#' @return a ggplot2 object
#' @export
#'
#' @examples
#'
#' dat_test <- tibble::tribble(
#'             ~x, ~y,
#'             -1,  "A",
#'             0,  "B",
#'             1,  "C",
#'             NA, NA
#'             )
#'
#' vis_expect(dat_test,
#'            ~ .x == -1)

#' vis_expect(airquality,
#'            ~ .x == 5.1)
#'
#' # explore some common NA strings
#'
#' common_nas <- c(
#' "NA",
#' "N A",
#' "N/A",
#' "na",
#' "n a",
#' "n/a"
#' )
#'
#' dat_ms <- tibble::tribble(~x,  ~y,    ~z,
#'                          1,   "A",   -100,
#'                          3,   "N/A", -99,
#'                          NA,  NA,    -98,
#'                          "N A", "E",   -101,
#'                          "na", "F",   -1)
#'
#' vis_expect(dat_ms, ~.x %in% common_nas)
#'
vis_expect <- function(data, expectation, show_perc = TRUE){

  data_expect <- expect_frame(data, expectation)

  # calculate the overall % expecations to display in legend -------------------

  if (show_perc) {

    temp <- expect_guide_label(data_expect)

    p_expect_true_lab <- temp$p_expect_false_lab

    p_expect_false_lab <- temp$p_expect_true_lab

    # else if show_perc FALSE (do nothing)
  } else {

    p_expect_true_lab <- "TRUE"

    p_expect_false_lab <- "FALSE"

  }

  vis_expect_plot <- data_expect %>%
    # expect_frame(expectation) %>%
    dplyr::mutate(rows = 1:n()) %>%
    tidyr::gather_(key_col = "variable",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)]) %>%
    ggplot2::ggplot(ggplot2::aes_string(x = "variable",
                                        y = "rows")) +
    ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                                       vjust = 1,
                                                       hjust = 1)) +
    ggplot2::labs(x = "",
                  y = "Observations") +
  # flip the axes
    ggplot2::scale_y_reverse() +
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::scale_fill_manual(name = "",
                               values = c("#998ec3", # purple
                                          "#f1a340", # orange
                                          "grey"),
                               labels = c(p_expect_false_lab,
                                          p_expect_true_lab),
                               na.value = "#E5E5E5") + # light gray
    ggplot2::guides(fill = ggplot2::guide_legend(reverse = TRUE)) +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Expectation")) +
    # add info about the axes
    ggplot2::theme(legend.position = "bottom") +
    # ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))

  vis_expect_plot

}
