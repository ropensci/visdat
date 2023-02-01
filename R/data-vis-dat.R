#' Return data used to create vis_dat plot
#'
#' @param x data.frame
#' @param ... extra arguments (currently unused)
#'
#' @return data frame
#' @name data-vis-dat
#' @export
#'
#' @examples
#' data_vis_dat(airquality)
#'
#' \dontrun{
#' #return vis_dat data for each group
#' library(dplyr)
#' airquality %>%
#'   group_by(Month) %>%
#'   data_vis_dat()
#' }
data_vis_dat <- function(x, ...){
  UseMethod("data_vis_dat")
}

#' @rdname data-vis-dat
#' @export
data_vis_dat.default <- function(x, ...){
  data_vis_class_not_implemented("vis_dat")
}

#' @rdname data-vis-dat
#' @export
data_vis_dat.data.frame <- function(x, ...){
  x %>%
    fingerprint_df() %>%
    vis_gather_() %>%
    # get the values here so plotly can make them visible
    dplyr::mutate(value = vis_extract_value_(x))
}

#' @rdname data-vis-dat
#' @export
data_vis_dat.grouped_df <- function(x, ...){
  group_by_fun(x, data_vis_dat)
}


