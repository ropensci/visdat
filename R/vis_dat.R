#' Visualises a data.frame to tell you what it contains.
#'
#' \code{vis_dat} gives you an at-a-glance ggplot object of what is inside a dataframe. Cells are coloured according to what class they are and whether the values are missing. As \code{vis_dat} returns a ggplot object, it is very easy to customize and change labels, and customize the plot
#'
#' @param x a data.frame object
#'
#' @param sort_type logical TRUE/FALSE. When TRUE (default), it sorts by the type in the column to make it easier to see what is in the data
#'
#' @param palette character "default", "qual" or "cb_safe". "default" (the default) provides the stock ggplot scale for separating the colours. "qual" uses an experimental qualitative colour scheme for providing distinct colours for each Type. "cb_safe" is a set of colours that are appropriate for those with colourblindness. "qual" and "cb_safe" are drawn from http://colorbrewer2.org/.
#'
#' @examples
#'
#' library(visdat)
#'
#' vis_dat(airquality)
#'
#' # experimental colourblind safe pallete
#' vis_dat(airquality, palette = "cb_safe")
#'
#' @export
vis_dat <- function(x,
                    sort_type = TRUE,
                    palette = "default") {

  # x  = airquality
  if (sort_type == TRUE) {

    # arrange by the columns with the highest missingness
    # code inspired from https://r-forge.r-project.org/scm/viewvc.php/pkg/R/missing.pattern.plot.R?view=markup&root=mi-dev
    # get the order of columns with highest missingness

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
    # mutate_each_(funs(fingerprint), tbl_vars(.)) %>%
    purrr::dmap(fingerprint) %>%
    dplyr::mutate(rows = 1:nrow(.)) %>%
    tidyr::gather_(key_col = "variables",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])

  # get the values here so plotly can make them visible
  d$value <- tidyr::gather_(x, "variables", "value", names(x))$value

  # do the plotting
  vis_dat_plot <-
    ggplot2::ggplot(data = d,
                    ggplot2::aes_string(x = "variables",
                    y = "rows",
                    # text assists with plotly mouseover
                    text = "value")) +
    ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                     vjust = 1,
                                     hjust = 1)) +
    ggplot2::labs(x = "Variables in Dataset",
         y = "Observations") +
    ggplot2::scale_x_discrete(limits = type_order_index) +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Type"))

   if (palette == "qual"){

     # qualitative, 6 colours
       vis_dat_palette <- c("#e41a1c", # red
                            "#ffff33", # yellow
                            "#ff7f00", # Orange
                            "#377eb8", # blue
                            "#4daf4a", # Green
                            "#984ea3") # Purple

       vis_dat_plot +
         ggplot2::scale_fill_manual(limits = c("character",
                                      "date",
                                      "factor",
                                      "integer",
                                      "logical",
                                      "numeric"),
                           breaks = c("character", # red
                                      "date", # orange
                                      "factor", # yellow
                                      "integer", # light blue
                                      "logical", # mid blue
                                      "numeric"), # dark blue
                           values = vis_dat_palette,
                           na.value = "grey")
       # continue reading here:
       # http://docs.ggplot2.org/current/discrete_scale.html

   } else if (palette == "cb_safe"){

       # # diverging, 6 colours, colour-blind safe
       vis_dat_palette <- c('#d73027', # red
                            '#fc8d59', # orange
                            '#fee090', # yellow
                            '#e0f3f8', # light blue
                            '#91bfdb', # mid blue
                            '#4575b4') # dark blue

     vis_dat_plot +
       ggplot2::scale_fill_manual(limits = c("character",
                                    "date",
                                    "factor",
                                    "integer",
                                    "logical",
                                    "numeric"),
                         breaks = c("character", # red
                                    "date", # orange
                                    "factor", # yellow
                                    "integer", # light blue
                                    "logical", # mid blue
                                    "numeric"), # dark blue
                         values = vis_dat_palette,
                         na.value = "grey")
     # continue reading here:
     # http://docs.ggplot2.org/current/discrete_scale.html

   } else if (palette == "default"){

     # regular palette
     vis_dat_plot

   }

}
