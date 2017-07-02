#' A small toy dataset of imaginary people
#'
#' A wider dataset than `typical_data` containing information about some
#' randomly generated people, created using the excellent `wakefield` package.
#' It is created as deliberately odd / eclectic dataset.
#'
#' @format A data frame with 300 rows and 49 variables:
#' \describe{
#'   \item{Age}{Age of each individual, see ?wakefield::age for more info}
#'   \item{Animal}{A vector of animals, see ?wakefield::animal}
#'   \item{Answer}{A vector of "Yes" or "No"}
#'   \item{Area}{A vector of living areas "Suburban", "Urban", "Rural"}
#'   \item{Car}{names of cars - see ?mtcars}
#'   \item{Children}{vector of number of children - see ?wakefield::children}
#'   \item{Coin}{character vector of "heads" and "tails"}
#'   \item{Color}{vector of vectors from "colors()"}
#'   \item{Date}{vector of "important" dates for an individual}
#'   \item{Death}{TRUE / FALSE for whether this person died}
#'   \item{Dice}{6 sided dice result}
#'   \item{DNA}{vector of GATC nucleobases}
#'   \item{DOB}{birth dates}
#'   \item{Dummy}{a 0/1 dummy var}
#'   \item{Education}{education attainment level}
#'   \item{Employment}{employee status}
#'   \item{Eye}{eye colour}
#'   \item{Grade}{percent grades}
#'   \item{Grade_Level}{favorite school grade}
#'   \item{Group}{control or treatment}
#'   \item{hair}{hair colours - "brown", "black", "blonde", or "red"}
#'   \item{Height}{height in cm}
#'   \item{Income}{yearly income}
#'   \item{Browser}{choice of internet browser}
#'   \item{IQ}{intelligence quotient}
#'   \item{Language}{random language of the world}
#'   \item{Level}{levels between 1 and 4}
#'   \item{Likert}{likert response - "strongly agree", "agree", and so on}
#'   \item{Lorem_Ipsum}{lorem ipsum text}
#'   \item{Marital}{marital status- "married", "divorced", "widowed",
#'     "separated", etc}
#'   \item{Military}{miliary branch they are in}
#'   \item{Month}{their favorite month}
#'   \item{Name}{their name}
#'   \item{Normal}{a random normal number}
#'   \item{Political}{their favorite political party}
#'   \item{Race}{their race}
#'   \item{Religion}{their religion}
#'   \item{SAT}{their SAT score}
#'   \item{Sentence}{an uttered sentence}
#'   \item{Sex_1}{sex of their first child}
#'   \item{Sex_2}{sex of their second child}
#'   \item{Smokes}{do they smoke}
#'   \item{Speed}{their median speed travelled in a car}
#'   \item{State}{the last state they visited in the USA}
#'   \item{String}{a random string they smashed out on the keyboard}
#'   \item{Upper}{the last key they hit in upper case}
#'   \item{Valid}{TRUE FALSE answer to a question}
#'   \item{Year}{significant year to that individuals}
#'   \item{Zip}{a zip code they have visited}
#' }
#'
#' @note the following code was used to create this data
#'
#' library(wakefield)
#'
#' set.seed(1214)
#' typical_larger_data <- r_data_theme(n = 300, data_theme = "the_works")
#'
#'
"typical_larger_data"
