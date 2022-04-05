# vis_gather_ works

    Code
      vis_gather_(airquality)
    Output
      # A tibble: 918 x 3
          rows variable valueType
         <int> <chr>    <chr>    
       1     1 Ozone    41       
       2     1 Solar.R  190      
       3     1 Wind     7.4      
       4     1 Temp     67       
       5     1 Month    5        
       6     1 Day      1        
       7     2 Ozone    36       
       8     2 Solar.R  118      
       9     2 Wind     8        
      10     2 Temp     72       
      # ... with 908 more rows

---

    Code
      vis_gather_(typical_data)
    Output
      # A tibble: 45,000 x 3
          rows variable   valueType
         <int> <chr>      <chr>    
       1     1 ID         0001     
       2     1 Race       Black    
       3     1 Age        <NA>     
       4     1 Sex        Male     
       5     1 Height(cm) 175.9    
       6     1 IQ         110      
       7     1 Smokes     FALSE    
       8     1 Income     4334.29  
       9     1 Died       FALSE    
      10     2 ID         0002     
      # ... with 44,990 more rows

