# visdat: Visualising whole data frames
01 August 2017  

# Summary

Reading in a new dataset means looking at the data to get a sense of what it contains, and potential problems and challenges with the data to get it analysis ready. "Looking at the data" can mean different things. Often times you look at the first six rows of data, the head of the data:


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

Or you can `glimpse` the data, using the `dplyr` package [@dplyr]


```r
dplyr::glimpse(iris)
```

```
## Observations: 150
## Variables: 5
## $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9,...
## $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1,...
## $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5,...
## $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1,...
## $ Species      <fctr> setosa, setosa, setosa, setosa, setosa, setosa, ...
```

This shows that there are 150 observations, and 5 variables, which are doubles and a factor, along with some of the values in the data. However, we usually don't have data like the canonical iris dataset. Let's take a look at some data that might be a bit more typical of "messy" data.


```r
library(visdat)
dplyr::glimpse(typical_data)
```

```
## Observations: 5,000
## Variables: 9
## $ ID         <chr> "0001", "0002", "0003", "0004", "0005", NA, "0007",...
## $ Race       <fctr> White, Hispanic, White, Black, White, Hispanic, Hi...
## $ Age        <int> 34, 25, 35, NA, NA, NA, 26, 31, 20, 26, NA, NA, 21,...
## $ Sex        <fctr> Female, Male, Male, Female, Male, Male, Male, Fema...
## $ Height(cm) <dbl> 181.6, 174.3, 171.9, 188.4, 171.1, 179.5, 175.8, 17...
## $ IQ         <dbl> 100, 100, 104, 116, 106, 105, 95, 98, 88, NA, 96, 1...
## $ Smokes     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FAL...
## $ Income     <dbl> 33873.82, 38799.39, 7235.28, 29629.44, 19990.00, 69...
## $ Died       <lgl> TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, ...
```

Looking at this, you might then ask: "Isn't it odd that Income is a factor? And Age is a character?". And you might start to wonder what else is different, what else changed? It might be a bit unclear where to go from there. Do you do some exploratory plots of the data? What if the plot looks weird because the data has strange types? What if the data has other strange features? 

There is a need for a tool to do preliminary data visualisation, to identify these problems early. The `visdat` package provides this, creating visualisations of an entire dataframe at once. Initially inspired by [`csv-fingerprint`](https://github.com/setosa/csv-fingerprint), `visdat` provides tools to create heatmap-like visualisations of an entire dataframe. `visdat` is an R [@Rcore] package provides 2 main functions `vis_dat` and `vis_miss`.

`vis_dat()` helps explore the data class structure and missingness, by displaying the class for each variable and the missing data, and presenting the plot in an intuitive way - it reads top down as the data would. The columns are grouped by similar class as well, to put similarly classified data types together.


```r
vis_dat(typical_data)
```

![](paper_files/figure-html/load-data-1.png)<!-- -->

`vis_miss()` focuses on just displaying the present and missing data, again reading top down, but also displaying the percent of missing data in each column, and overall.


```r
vis_miss(typical_data)
```

![](paper_files/figure-html/vis-miss-1.png)<!-- -->

These functions provide useful tools to help "get a look at the data", using preliminary visualisation techniques. The plots are built using ggplot2 [@ggplot2], which provides a consistent and powerful framework for visualisations. This means that users can customise and extend graphics from visdat very easily.

# References
