# vis_miss fails when an object of the wrong class is provided

    Code
      vis_miss(AirPassengers)
    Error <rlang_error>
      `vis_dat()` requires a <data.frame>
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
      legend
    Output
      # A tibble: 2 x 1
        x_lab              
        <chr>              
      1 "Present \n(71.5%)"
      2 "Missing \n(28.5%)"

