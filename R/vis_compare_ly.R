#' Interactive vis_compare compare two dataframes to find differences.s
#'
#' `vis_compare_ly`, like the other `vis_*_ly` families, gives an at-a-glance
#'    interactive plotly plot of a dataset, using the `*` method. In thi case,
#'    an interactive version of `vis_compare`, which is used to visualise and
#'    compare **two** different dataframes of the same dimension, and so takes
#'    two dataframes as arguments.
#'
#' @param df1 The first dataframe to compare
#'
#' @param df2 The second dataframe to compare to the first.
#'
#' @return `plotly` interactive plot, similar in appearance to `vis_compare`
#'
#' @seealso [vis_dat()] [vis_miss()] [vis_miss_ly()] [vis_dat_ly()]
#'   [vis_compare()] [vis_guess()]
#'
#' @examples
#'
#' # make a new dataset of iris that contains some NA values
#' iris_diff <- iris
#' iris_diff[1:10, 1:2] <- NA
#'
#' vis_compare_ly(iris, iris_diff)
#' @export
vis_compare_ly <- function(df1,
                           df2){

  plotly::ggplotly(vis_compare(df1, df2))

}
