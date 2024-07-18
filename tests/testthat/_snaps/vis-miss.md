# vis_miss fails when an object of the wrong class is provided

    Code
      vis_miss(AirPassengers)
    Condition
      Error in `test_if_dataframe()`:
      ! `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

# vis_miss correctly see missings in columns labels

    Code
      x_labs
    Output
      # A tibble: 10 x 1
         x_lab           
         <glue>          
       1 height (7%)     
       2 mass (32%)      
       3 hair_color (6%) 
       4 birth_year (51%)
       5 sex (5%)        
       6 gender (5%)     
       7 homeworld (11%) 
       8 species (5%)    
       9 vehicles (87%)  
      10 starships (77%) 

# vis_miss correctly aggregate missings in legend

    Code
      legend_lab
    Output
      # A tibble: 2 x 1
        x_lab              
        <chr>              
      1 "Present \n(71.5%)"
      2 "Missing \n(28.5%)"

# data_vis_miss gets the data properly

    Code
      the_vis_miss_data
    Output
      # A tibble: 918 x 4
          rows variable valueType value
         <int> <chr>    <chr>     <chr>
       1     1 Day      FALSE     FALSE
       2     1 Month    FALSE     FALSE
       3     1 Ozone    FALSE     FALSE
       4     1 Solar.R  FALSE     FALSE
       5     1 Temp     FALSE     FALSE
       6     1 Wind     FALSE     FALSE
       7     2 Day      FALSE     FALSE
       8     2 Month    FALSE     FALSE
       9     2 Ozone    FALSE     FALSE
      10     2 Solar.R  FALSE     FALSE
      # i 908 more rows

# data_vis_miss gets the data properly for groups

    Code
      the_vis_miss_data_month
    Output
      # A tibble: 765 x 5
      # Groups:   Month [5]
         Month  rows variable valueType value
         <int> <int> <chr>    <chr>     <chr>
       1     5     1 Day      FALSE     FALSE
       2     5     1 Ozone    FALSE     FALSE
       3     5     1 Solar.R  FALSE     FALSE
       4     5     1 Temp     FALSE     FALSE
       5     5     1 Wind     FALSE     FALSE
       6     5     2 Day      FALSE     FALSE
       7     5     2 Ozone    FALSE     FALSE
       8     5     2 Solar.R  FALSE     FALSE
       9     5     2 Temp     FALSE     FALSE
      10     5     2 Wind     FALSE     FALSE
      # i 755 more rows

