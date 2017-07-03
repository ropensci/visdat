#' visdat
#'
#' visdat is a package that helps with the preliminary visualisation of data.
#'   visdat makes it easy to visualise your whole dataset so that you can
#'   visually identify problems.
#'
#' @seealso
#'
#' It's main functions are:
#' \itemize{
#'   \item [vis_dat()]
#'   \item [vis_miss()]
#' }
#'
#' Learn more about visdat at \url{www.njtierney.com/visdat/articles/using_visdat.html}
#' @name visdat
#' @docType package
#' @importFrom magrittr %>%
NULL

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
globalVariables(c("valueGuess"))
