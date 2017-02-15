#' visdat
#'
#' visdat is a package that helps with the preliminary visualisation of data. visdat makes it easy to visualise your whole dataset so that you can visually identify problems. It's main functions are:

#' \itemize{
#'   \item [vis_dat()]
#'   \item [vis_miss()]
#'   \item [vis_guess()]
#'   \item [vis_compare()]
#'   \item [vis_miss_ly()]
#' }
#'
#' @name visdat
#' @docType package
#' @importFrom magrittr %>%
NULL

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
globalVariables(c("valueGuess"))
