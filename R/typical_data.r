#' A small toy dataset of imaginary people
#'
#' A dataset containing information about some randomly generated people, created using the excellent \code{wakefield} package. It is created as deliberately messy dataset.
#'
#' @format A data frame with 5000 rows and 11 variables:
#' \describe{
#'   \item{ID}{Unique identifier for each individual, a sequential character vector of zero-padded identification numbers (IDs). see ?wakefield::id for more info}
#'   \item{Race}{Race for each individual, "Black", "White", "Hispanic", "Asian", "Other", "Bi-Racial", "Native", and "Hawaiin", see ?wakefield::race for more info}
#'   \item{Age}{Age of each individual, see ?wakefield::age for more info}
#'   \item{Sex}{Male or female, see ?wakefield::sex for more info}
#'   \item{Height(cm)}{Height in centimeters, see ?wakefield::height for more info}
#'   \item{IQ}{vector of intelligence quotients (IQ), see ?wakefield::iq for more info}
#'   \item{Smokes}{whether or not this person smokes, see ?wakefield::smokes for more info}
#'   \item{Income}{Yearly income in dollars, see ?wakefield::income for more info}
#'   \item{Died}{Whether or not this person has died yet., see ?wakefield::died for more info}
#' }
#'
#' @note the following code was used to create this data
#' library(wakefield)
#'
#' set.seed(1145)
#'
#' typical_data <- r_data_frame(n = 5000,
#'                              id,
#'                              race,
#'                              age,
#'                              sex,
#'                              height_cm,
#'                              iq,
#'                              smokes,
#'                              income,
#'                              died)
#'
#'
"typical_data"
