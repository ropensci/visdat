#' Visualises a data.frame to tell you what it contains.
#'
#' `vis_dat` gives you an at-a-glance ggplot object of what is inside a
#'   dataframe. Cells are coloured according to what class they are and whether
#'   the values are missing. As `vis_dat` returns a ggplot object, it is very
#'   easy to customize and change labels, and customize the plot
#'
#' @param x a data.frame object
#'
#' @param sort_type logical TRUE/FALSE. When TRUE (default), it sorts by the
#'   type in the column to make it easier to see what is in the data
#'
#' @param palette character "default", "qual" or "cb_safe". "default" (the
#'   default) provides the stock ggplot scale for separating the colours.
#'   "qual" uses an experimental qualitative colour scheme for providing
#'   distinct colours for each Type. "cb_safe" is a set of colours that are
#'   appropriate for those with colourblindness. "qual" and "cb_safe" are drawn
#'   from http://colorbrewer2.org/.
#'
#' @param warn_large_data logical default is TRUE
#'
#' @param large_data_size integer default is 900000, this can be changed.
#'
#' @return `ggplot2` object displaying the type of values in the data frame and
#'   the position of any missing values.
#'
#' @seealso [vis_miss()]
#'
#' @examples
#'
#' vis_dat(airquality)
#'
#' # experimental colourblind safe palette
#' vis_dat(airquality, palette = "cb_safe")
#' vis_dat(airquality, palette = "qual")
#'
#' @export
vis_dat <- function(x,
                    sort_type = TRUE,
                    palette = "default",
                    warn_large_data = TRUE,
                    large_data_size = 900000) {

  # add warning for large data
  if (ncol(x) * nrow(x) > large_data_size && warn_large_data){
    stop("Data exceeds recommended size for visualisation, please consider
         downsampling your data, or set argument 'warn_large_data' to FALSE.")
  }

  if (sort_type) {

    type_sort <- order(
      # get the class, if there are multiple classes, combine them together
      purrr::map_chr(.x = x,
                     .f = function(x) paste(class(x), collapse = "\n"))
    )
    # get the names of those columns
    type_order_index <- names(x)[type_sort]

  } else {
    # this means that the order remains the same as the dataframe.
    type_order_index <- names(x)

  }

  # reshape the dataframe ready for geom_raster
  d <- x %>%
    purrr::map_df(fingerprint) %>%
    vis_gather_() %>%
    # get the values here so plotly can make them visible
    dplyr::mutate(value = vis_extract_value_(x))

  # do the plotting
  vis_dat_plot <-
    # add the boilerplate
    vis_create_(d) +
    # change the limits etc.
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Type")) +
    # add info about the axes
    ggplot2::scale_x_discrete(limits = type_order_index,
                              position = "top") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0))

  # specify a palette ----------------------------------------------------------
  add_vis_dat_pal(vis_dat_plot, palette)

  } # close function
