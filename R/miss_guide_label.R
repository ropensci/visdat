#' Label the legend with the percent of missing data
#'
#' `miss_guide_label` is an internal function for vis_miss to label the legend.
#'
#' @param x is a dataframe passed from vis_miss(x).
#'
#' @return a data_frame with two columns `p_miss_lab` and `p_pres_lab`, containing the labels to use for present and missing. A dataframe is returned because I think it is a good style habit compared to a list.
#'
#'
miss_guide_label <- function(x) {

    p_miss <- (mean(is.na(x)) * 100)

    if (p_miss == 0) {

      p_miss_lab <- "No Missing Values"

      p_pres_lab <- "Present (100%)"

    } else if (p_miss < 0.1) {

      p_miss_lab <- "Missing (< 0.1%)"

      p_pres_lab <- "Present (> 99.9%)"

    } else {

      # calculate rounded percentages
      p_miss <- round(p_miss, 1)
      p_pres <- 100 - p_miss

    # create the labels
    p_miss_lab <- paste("Missing (",
                        p_miss,
                        "%)",
                        sep = "")

    p_pres_lab <- paste("Present (",
                        p_pres,
                        "%)",
                        sep = "")
    }

    label_frame <- dplyr::data_frame(p_miss_lab = paste(p_miss_lab),
                                     p_pres_lab = paste(p_pres_lab))

    return(label_frame)


}
