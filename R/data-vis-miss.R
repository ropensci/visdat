#' Return data used to create vis_miss plot
#'
#' @param x data.frame
#' @param ... extra arguments (currently unused)
#'
#' @return data frame
#' @name data-vis-miss
#' @export
#'
#' @examples
#' data_vis_miss(airquality)
#'
#' \dontrun{
#' #return vis_dat data for each group
#' library(dplyr)
#' airquality %>%
#'   group_by(Month) %>%
#'   data_vis_miss()
#' }
data_vis_miss <- function(x, ...){
  UseMethod("data_vis_miss")
}

#' @rdname data-vis-miss
#' @export
data_vis_miss.default <- function(x, ...){
  data_vis_class_not_implemented("vis_miss")
}

#' Create a tidy dataframe of missing data suitable for plotting
#'
#' @param x data.frame
#' @param cluster logical - whether to cluster missingness. Default is FALSE.
#'
#' @return tidy dataframe of missing data
#'
#' @examples
#' data_vis_miss(airquality)
#'
#' @rdname data-vis-miss
#' @export
data_vis_miss.data.frame <- function(x, cluster = FALSE, ...){

  x.na <- x %>%
    purrr::map_df(~fingerprint(.x) %>% is.na)

  # switch for creating the missing clustering
  if (cluster){

    # this retrieves a row order of the clustered missingness
    row_order_index <-
      stats::dist(x.na*1) %>%
      stats::hclust(method = "mcquitty") %>%
      stats::as.dendrogram() %>%
      stats::order.dendrogram()

  } else {
    row_order_index <- seq_len(nrow(x))
  } # end else

  # Arranged data by dendrogram order index

  # gather the variables together for plotting
  # here we now have a column of the row number (row),
  # then the variable(variables),
  # then the contents of that variable (value)
  vis_miss_data <- as.data.frame(x.na[row_order_index , ])

  vis_miss_data %>%
    vis_gather_() %>%
    # add info for plotly mousover
    dplyr::mutate(value = vis_extract_value_(vis_miss_data))

}

#' @rdname data-vis-miss
#' @export
data_vis_miss.grouped_df <- function(x, ...){
  group_by_fun(x, data_vis_miss)
}
