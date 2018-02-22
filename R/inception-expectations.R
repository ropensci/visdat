
library(rlang)

expect_frame <- function(data, expect){
  my_fun <- rlang::as_function(expect)

  print(my_fun)

  purrr::map_dfc(data, my_fun)

}

expect_frame(airquality, ~.x == 5.1) %>%
  visdat:::vis_gather_()

expect_frame2 <- function(data, ...){
  funs <- purrr::map(quos(...), lang)
  lst_cols <- purrr::map2(data, seq_along(data), ~ .x[[.y]])
  purrr::map(funs, ~ purrr::map2(data, seq_along(data), ~ .x[[.y]]))
  funs_mod <- purrr::map(funs, lang_modify, data)

  purrr::map(funs_mod, eval_tidy)
  # return(eval_tidy(funs_mod))

  # purrr::map(funs, function(x) x(airquality[[1]]))
  # purrr::map(data,  function(x) purrr::map(funs, ~ .(x)))

}

expect_frame2(airquality, is.integer)
jvis_expect(iris,
           "ones" =  ~.x == -1,
           "twos" = ~.x == 2)

purrr::map_dfc(iris, ~.x == -1)
