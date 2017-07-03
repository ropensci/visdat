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
                            died)
use_data(typical_data)
