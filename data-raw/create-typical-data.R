# the following code was used to create this data

library(wakefield)
set.seed(1145)
typical_data <- r_data_frame(n = 5000,
                            id,
                            race,
                            age,
                            sex,
                            height_cm,
                            iq,
                            smokes,
                            income,
                            died) %>%
  wakefield::r_na(cols = c(2,3,6,8),
                  prob = 0.1) %>%
mutate(Income = as.factor(Income),
       Age = as.character(Age))

use_data(typical_data, overwrite = TRUE)
