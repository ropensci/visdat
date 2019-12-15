#' Take the fingerprint of a data.frame - find the class or return NA
#'
#' `fingerprint` is an internal function that takes the "fingerprint" of a
#'   dataframe, and currently replaces the contents (x) with the class of a
#'   given object, unless it is missing (coded as `NA`), in which case it leaves
#'   it as `NA`. The name "fingerprint" is taken from the csv-fingerprint, of
#'   which the package, `visdat`, is based upon
#'
#' @param x a vector
#'
fingerprint <- function(x){

  # is the data missing?
  ifelse(is.na(x),
         # yes? Leave as is NA
         yes = NA,
         # no? make that value no equal to the class of this cell.
         no = glue::glue_collapse(class(x),
                                  sep = "\n")
  )
} # end function


#' (Internal) Gather rows into a format appropriate for grid visualisation
#'
#' @param x a dataframe
#'
#' @return data.frame gathered to have columns "variables", "valueType", and a
#'   row id called "rows".
#'
vis_gather_ <- function(x){
  x %>%
  dplyr::mutate(rows = dplyr::row_number()) %>%
    tidyr::gather_(key_col = "variable",
                   value_col = "valueType",
                   gather_cols = names(.)[-length(.)])
}

#' (Internal) Add values of each row as a column
#'
#' This adds information about each row, so that when called by plotly, the
#'   values are made visible on hover. Warnings are suppressed because `tidyr`
#'   gives a warning about type coercion, which is fine.
#'
#' @param x dataframe created from `vis_gather_`
#'
#' @return the x dataframe with the added column `value`.
#'
vis_extract_value_ <- function(x){

  suppressWarnings(
    tidyr::gather_(x,
                   "variable",
                   "value",
                   names(x))$value
  )

}

#' (Internal) Create a boilerplate for visualisations of the `vis_` family
#'
#' @param x a dataframe in longformat as transformed by `vis_gather_` and
#'   `vis_extract_value`.
#'
#' @return a ggplot object
#'
vis_create_ <- function(x){

  ggplot2::ggplot(data = x,
                  ggplot2::aes_string(x = "variable",
                                      y = "rows",
                                    # text assists with plotly mouseover
                                    text = "value")) +
  ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
  ggplot2::theme_minimal() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                                     vjust = 1,
                                                     hjust = 1)) +
  ggplot2::labs(x = "",
                y = "Observations") +
    # flip the axes
    ggplot2::scale_y_reverse() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.5))

}

#' (Internal) Add a specific palette to a visdat plot
#'
#' @param vis_plot visdat plot created using `vis_gather_`, `vis_extract_value`
#'   and `vis_create_`
#' @param palette character "default", "qual" or "cb_safe". "default" (the
#'   default) provides the stock ggplot scale for separating the colours. "qual"
#'   uses an experimental qualitative colour scheme for providing distinct
#'   colours for each Type. "cb_safe" is a set of colours that are appropriate
#'   for those with colourblindness. "qual" and "cb_safe" are drawn from
#'   http://colorbrewer2.org/.
#'
#' @return a visdat plot with a particular palette
#'
#' @examples
#'
#' \dontrun{
#' # see internal use inside vis_guess and vis_dat
#' }
#'
add_vis_dat_pal <- function(vis_plot, palette){

  # palette options: http://docs.ggplot2.org/current/discrete_scale.html
# qualitative, 6 colours --------------------------------------------------
vis_pal_qual <- c("#e41a1c", # red
                      "#ffff33", # yellow
                      "#ff7f00", # Orange
                      "#377eb8", # blue
                      "#4daf4a", # Green
                      "#984ea3") # Purple

# diverging, 6 colours, colour-blind safe -------------------------------
vis_pal_cb_safe <- c('#d73027', # red
                         '#fc8d59', # orange
                         '#fee090', # yellow
                         '#e0f3f8', # light blue
                         '#91bfdb', # mid blue
                         '#4575b4') # dark blue

if (palette == "default"){

  vis_plot

} else if (palette == "qual") {

  vis_plot +
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
                               values = vis_pal_qual,
                               na.value = "grey")


} else if (palette == "cb_safe") {

  vis_plot +
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
                               values = vis_pal_cb_safe,
                               na.value = "grey")

} else  {
  stop("palette arguments need to be either 'qual' 'cb_safe' or 'default'")
} # close else brace

} # close the function

#' Create labels for the columns containing the percent missing data
#'
#' @param x data.frame
#' @param col_order_index the order of the columns
#' @note internal
#' @return data.frame containing the missingness percent down to 0.1 percent
#'
label_col_missing_pct <- function(x,
                                  col_order_index){

  # present everything in the right order

  labelled_pcts <-
  purrr::map_df(x, ~round(mean(is.na(.))*100,2))[col_order_index] %>%
    purrr::map_chr(function(x){
      dplyr::case_when(
        x == 0 ~  "0%",
        x >= 0.1 ~ as.character(glue::glue("{x}%")),
        x < 0.1 ~ "<0.1%"
      )
    })

    glue::glue("{col_order_index} ({labelled_pcts})")

}


#' Label the legend with the percent of missing data
#'
#' `miss_guide_label` is an internal function for vis_miss to label the legend.
#'
#' @param x is a dataframe passed from vis_miss(x).
#'
#' @return a tibble with two columns `p_miss_lab` and `p_pres_lab`,
#'   containing the labels to use for present and missing. A dataframe is
#'   returned because I think it is a good style habit compared to a list.
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
    p_miss_lab <- glue::glue("Missing \n({p_miss}%)")

    p_pres_lab <- glue::glue("Present \n({p_pres}%)")

    }

  label_frame <- tibble::tibble(p_miss_lab,
                                p_pres_lab)

  return(label_frame)

}


#' (Internal) Are they all numeric columns?
#'
#' @param x data.frame
#' @param ... optional extra inputs
#'
#' @return logical - TRUE means that there is a column with numerics, FALSE means that there is a column that is not numeric
#'
#' @examples
#'
#'\dontrun{
#' all_numeric(airquality) # TRUE
#' all_numeric(iris) # FALSE
#'}
#'
all_numeric <- function(x, ...){
  all(as.logical(lapply(x, is.numeric)))
}
# Can I capture moving from a value to NA, or, from NA to another value?

is_binary <- function(x) all(x %in% c(0L, 1L, NA))

all_binary <- function(x, ...){
  all(as.logical(lapply(x, is_binary)))
}

#' Test if input is a data.frame
#'
#' @param x object
#'
#' @return an error if input (x) is not a data.frame
#'
#' @examples
#' \dontrun{
#' # success
#' test_if_dataframe(airquality)
#' #fail
#' test_if_dataframe(AirPassengers)
#' }
#'
test_if_dataframe <- function(x){
  if (!inherits(x, "data.frame")) {
    stop("vis_dat requires a data.frame but the object I see has class/es: ",
         glue::glue_collapse(class(x),
                             sep = ", "),
         call. = FALSE)
  }
}

test_if_all_numeric <- function(data){
  if (!all_numeric(data)) {
    stop("data input can only contain numeric values, please subset the data to the numeric values you would like. dplyr::select_if(data, is.numeric) can be helpful here!")
    }
  }

test_if_all_binary <- function(data){
  if (!all_binary(data)) {
    stop("data input can only contain binary values - this means either 0 or 1, or NA. Please subset the data to be binary values, or see ?vis_value.")
  }
}

#' Scale a vector between 0 and one.
#'
#' @param x numeric vector
#'
#' @return numeric vector between 0 and 1
scale_01 <- function(x) {
  (x - min(x, na.rm = TRUE)) / diff(range(x, na.rm = TRUE))
}


skip_on_gh_actions <- function() {
  if (!identical(Sys.getenv("GITHUB_ACTIONS"), "true")) {
    return(invisible(TRUE))
  }
  testthat::skip("On GitHub Actions")
}
