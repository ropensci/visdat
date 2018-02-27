#' Create a dataframe to help visualise 'expected' values
#'
#' @param data data.frame
#' @param ... unquoted function calls - conditions or "expectations" to test
#'
#' @return list of data.frames where conditions are true
#' @author Stuart Lee
#'
#' @examples
#'
#' # show me where airquality has -1 and -2
#' expect_frame(airquality,
#'              ~.x == -1,
#'              ~.x == 2)
#'
#' # now show me where iris has -1 and 2, but now produce named lists
#' expect_frame(iris,
#'              "ones" =  ~.x == -1,
#'              "twos" = ~.x == 2)
#'
#' dat_test <- tibble::tribble(
#'             ~x, ~y,
#'             -1,  "A",
#'             0,  "B",
#'             1,  "C"
#'             )
#'
#' expect_frame(dat_test, ~ .x == -1, ~ .x == 1) %>%
#'   dplyr::bind_rows(.id = "name")
#'
#' expect_frame(airquality, ~ .x == -1, ~ .x == 2)
#'
#' expect_frame(iris,
#'               "ones" =  ~.x == -1,
#'               "twos" = ~.x == 2) %>%
#'   dplyr::bind_rows(.id = "name")
#'
expect_frame <- function(data, ...){
  dots <- rlang::quos(...)
  mappers <- purrr::map(
    dots,
    function(x){
      purrr::map(
        data,
        function(y) {
          if (rlang::is_formula(rlang::quo_get_expr(x))) {
            fn <- rlang::new_formula(lhs = NULL,
                                     rhs = rlang::f_rhs(rlang::quo_get_expr(x)))
            fn <- rlang::as_function(fn)
            return(rlang::call2(fn,
                                rlang::splice(list(.x = y, . = y))))
            } else {
              return(rlang::call2(x, rlang::splice(list(y))))
              }
          })
      })
  names(mappers) <- names(dots)
  purrr::map(mappers, ~ purrr::map_dfc(., rlang::eval_tidy))
}
