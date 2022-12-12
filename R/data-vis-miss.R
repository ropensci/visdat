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
#'
#' @return tidy dataframe of missing data
#'
#' @examples
#' data_vis_miss(airquality)
#'
#' @rdname data-vis-miss
#' @export
data_vis_miss.data.frame <- function(x, ...){

}

#' @rdname data-vis-miss
#' @export
data_vis_miss.grouped_df <- function(x, ...){
  group_by_fun(x, data_vis_miss)
}
