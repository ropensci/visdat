library(dplyr)
assign_na <- function(x, size){
  x[sample(length(x), size = size)] <- NA
  x
}

dat_bin <- tibble(x = sample(x = c(0L, 1L), size = 100, replace = TRUE),
              y = sample(x = c(0L, 1L), size = 100, replace = TRUE),
              z = sample(x = c(0L, 1L), size = 100, replace = TRUE)) %>%
  mutate_at(vars(x,y),
            assign_na,
            10)

usethis::use_data(dat_bin, overwrite = TRUE)
