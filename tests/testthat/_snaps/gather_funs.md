# vis_gather_ works

    Code
      vis_gather_(airquality)
    Output
      # A tibble: 918 x 3
          rows variable valueType
         <int> <chr>    <chr>    
       1     1 Day      1        
       2     1 Month    5        
       3     1 Ozone    41       
       4     1 Solar.R  190      
       5     1 Temp     67       
       6     1 Wind     7.4      
       7     2 Day      2        
       8     2 Month    5        
       9     2 Ozone    36       
      10     2 Solar.R  118      
      # i 908 more rows

---

    Code
      vis_gather_(typical_data)
    Output
      # A tibble: 45,000 x 3
          rows variable   valueType
         <int> <chr>      <chr>    
       1     1 Age        <NA>     
       2     1 Died       FALSE    
       3     1 Height(cm) 175.9    
       4     1 ID         0001     
       5     1 IQ         110      
       6     1 Income     4334.29  
       7     1 Race       Black    
       8     1 Sex        Male     
       9     1 Smokes     FALSE    
      10     2 Age        25       
      # i 44,990 more rows

