# the following code was used to create this data
library(wakefield)
set.seed(1214)
typical_data_large <- r_data_theme(n = 300, data_theme = "the_works")

typical_data_large <- typical_data_large %>%
  mutate(Income = as.factor(Income),
         Age = as.character(Age))

use_data(typical_data_large)
