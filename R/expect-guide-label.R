#' Label the legend with the percent of missing data
#'
#' `miss_guide_label` is an internal function for vis_miss to label the legend.
#'
#' @param x is a dataframe passed from vis_miss(x).
#'
#' @return a data_frame with two columns `p_miss_lab` and `p_pres_lab`,
#'   containing the labels to use for present and missing. A dataframe is
#'   returned because I think it is a good style habit compared to a list.
#'
#'
expect_guide_label <- function(x) {

  p_expect <- (mean(as.matrix(x), na.rm = TRUE) * 100)

  if (p_expect == 0) {

    p_expect_false_lab <- "No Expectations True"

    p_expect_true_lab <- "Present (100%)"

  } else if (p_expect < 0.1) {

    p_expect_false_lab <- "TRUE (< 0.1%)"

    p_expect_true_lab <- "FALSE (> 99.9%)"

  } else {

    # calculate rounded percentages
    p_expect_false <- round(p_expect, 1)
    p_expect_true <- 100 - p_expect

    # create the labels
    p_expect_false_lab <- paste("Expectation FALSE \n(",
                                p_expect_false,
                                "%)",
                                sep = "")

    p_expect_true_lab <- paste("Expectation TRUE \n(",
                               p_expect_true,
                               "%)",
                               sep = "")
  }

  label_frame <- dplyr::data_frame(p_expect_false_lab = paste(p_expect_false_lab),
                                   p_expect_true_lab = paste(p_expect_true_lab))

  return(label_frame)


}
