
library(rlang)

expect_frame <- function(data, expect){
  my_fun <- purrr::as_mapper(expect)

  purrr::map_dfc(data, my_fun)

}

#expect_frame(airquality, ~.x == 5.1) %>%
#  visdat:::vis_gather_()

expect_frame2 <- function(data, ...){
  funs <- purrr::map(quos(...), lang)
  funs_mod <- purrr::map(data, ~ purrr::map(funs, lang_modify, .))

  print(funs_mod)
  purrr::map_dfc(funs_mod, ~ unlist(purrr::map(., eval_tidy),
                                    recursive = FALSE, use.names = FALSE))
}

expect_frame2(airquality, function(x) x == -1, function(x) x == 2)

expect_frame3 <- function(data, ...) {
  mappers <- purrr::map(quos(...), purrr::as_mapper)
  print(mappers)
  funs_mod <- purrr::map(data, ~ purrr::map(mappers, lang_modify, .))
  return(funs_mod)
}

# now with more formula
expect_frame4 <- function(data, ...) {
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
expect_frame4(airquality, ~ .x == -1, ~ .x == 2)

expect_frame4(iris,
           "ones" =  ~.x == -1,
           "twos" = ~.x == 2)


