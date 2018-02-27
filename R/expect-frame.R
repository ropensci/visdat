#' Title
#'
#' @param data
#' @param ...
#'
#' @return
#'
#' @export
#'
#' @examples
#' expect_frame4(airquality, ~ .x == -1, ~ .x == 2)
#'
#' expect_frame4(iris,
#'               "ones" =  ~.x == -1,
#'               "twos" = ~.x == 2)
expect_frame <- function(data, ...) {
  dots <- rlang::quos(...)
  mappers <- purrr::map(dots,
                        function(x) {
                          purrr::map(data,
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
