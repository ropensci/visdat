# vis_cor sends an error when used with the wrong data

    Code
      vis_cor(iris)
    Error <rlang_error>
      Data input can only contain numeric values
      Please subset the data to the numeric values you would like.
      `dplyr::select(<data>, where(is.numeric))`
      Can be helpful here!

# vis_cor fails when an object of the wrong class is provided

    Code
      vis_cor(AirPassengers)
    Error <rlang_error>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

# data_vis_cor gets the data properly

    Code
      the_vis_cor_data
    Output
      # A tibble: 36 x 3
         row_1   row_2     value
         <chr>   <chr>     <dbl>
       1 Ozone   Ozone    1     
       2 Ozone   Solar.R  0.348 
       3 Ozone   Wind    -0.602 
       4 Ozone   Temp     0.698 
       5 Ozone   Month    0.165 
       6 Ozone   Day     -0.0132
       7 Solar.R Ozone    0.348 
       8 Solar.R Solar.R  1     
       9 Solar.R Wind    -0.0568
      10 Solar.R Temp     0.276 
      # i 26 more rows

# data_vis_cor gets the data properly for groups

    Code
      the_vis_cor_data_month
    Output
      # A tibble: 125 x 4
      # Groups:   Month [5]
         Month row_1   row_2     value
         <int> <chr>   <chr>     <dbl>
       1     5 Ozone   Ozone    1     
       2     5 Ozone   Solar.R  0.243 
       3     5 Ozone   Wind    -0.374 
       4     5 Ozone   Temp     0.554 
       5     5 Ozone   Day      0.302 
       6     5 Solar.R Ozone    0.243 
       7     5 Solar.R Solar.R  1     
       8     5 Solar.R Wind    -0.227 
       9     5 Solar.R Temp     0.455 
      10     5 Solar.R Day     -0.0644
      # i 115 more rows

