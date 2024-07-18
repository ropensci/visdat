# vis_dat fails when the wrong palette is provided

    Code
      vis_dat(typical_data, palette = "wat")
    Condition
      Error in `add_vis_dat_pal()`:
      ! Palette arguments need to be one of: 'qual', 'cb_safe', or 'default'
      You palette argument was: `wat`

# vis_dat fails when an object of the wrong class is provided

    Code
      vis_dat(AirPassengers)
    Condition
      Error in `test_if_dataframe()`:
      ! `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

# data_vis_dat gets the data properly

    Code
      the_vis_dat_data
    Output
      # A tibble: 918 x 4
          rows variable valueType value
         <int> <chr>    <chr>     <chr>
       1     1 Day      integer   41   
       2     1 Month    integer   190  
       3     1 Ozone    integer   7.4  
       4     1 Solar.R  integer   67   
       5     1 Temp     integer   5    
       6     1 Wind     numeric   1    
       7     2 Day      integer   36   
       8     2 Month    integer   118  
       9     2 Ozone    integer   8    
      10     2 Solar.R  integer   72   
      # i 908 more rows

# data_vis_dat gets the data properly for groups

    Code
      the_vis_dat_data_month
    Output
      # A tibble: 765 x 5
      # Groups:   Month [5]
         Month  rows variable valueType value
         <int> <int> <chr>    <chr>     <chr>
       1     5     1 Day      integer   41   
       2     5     1 Ozone    integer   190  
       3     5     1 Solar.R  integer   7.4  
       4     5     1 Temp     integer   67   
       5     5     1 Wind     numeric   1    
       6     5     2 Day      integer   36   
       7     5     2 Ozone    integer   118  
       8     5     2 Solar.R  integer   8    
       9     5     2 Temp     integer   72   
      10     5     2 Wind     numeric   2    
      # i 755 more rows

