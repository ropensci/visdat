
library(rlang)

expect_frame <- function(data, expect){
  my_fun <- purrr::as_mapper(expect)

  purrr::map_dfc(data, my_fun)

}

expect_frame(airquality, ~.x == 5.1) %>%
  visdat:::vis_gather_()

expect_frame2 <- function(data, ...){
  funs <- purrr::map(quos(...), lang)
  funs_mod <- purrr::map(data, ~ purrr::map(funs, lang_modify, .))

  purrr::map_dfc(funs_mod, ~ unlist(purrr::map(., eval_tidy), recursive = FALSE, use.names = FALSE))

}

expect_frame2(airquality, function(x) x == -1, function(x) x == 2)

expect_frame3 <- function(data, ...) {
  mappers <- purrr::map(quos(...), purrr::as_mapper)
  funs_mod <- purrr::map(data, ~ purrr::map(mappers, lang_modify, .))
  return(funs_mod)
}

x <- expect_frame3(airquality, ~ .x == -1, ~ .x == 2)
x[[1]](airquality)
dvis_expect(iris,
           "ones" =  ~.x == -1,
           "twos" = ~.x == 2)

purrr::map_dfc(iris, ~.x == -1)


