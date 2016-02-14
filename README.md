<!-- README.md is generated from README.Rmd. Please edit that file -->
visdat
======

What does visdat do?
====================

Initially inspired by [`csv-fingerprint`](https://github.com/setosa/csv-fingerprint), `vis_dat` helps you visualise a dataframe and "get a look at the data" by displaying the variable classes in a dataframe as a plot with `vis_dat`, and getting a brief look into missing data patterns `vis_miss`.

The name `visdat` was chosen as I think in the future it could be integrated with R packages `testdat` and `testthat`. The idea being that first you visualise your data (`visdat`), then you run tests from `testdat` or `testthat` to fix them.

There are currently two main commands: `vis_dat` and `vis_miss`.

-   `vis_dat` visualises a dataframe showing you what the classes of the columns are, and also displaying the missing data.

`v- is_miss` visualises the missing data, and allows for missingness to be clustered and columns rearranged. `vis_miss` is similar to `missing.pattern.plot` from the `mi` package. Unfortunately `missing.pattern.plot` is no longer in the `mi` package (well, at 14/02/2016).

How to install
==============

``` r
# install.packages("devtools")

library(devtools)

install_github("tierneyn/visdat")
```

Example
=======

Let's see what's inside the dataset `airquality`

``` r
library(visdat)

vis_dat(airquality)
```

![](README-vis_dat-1.png)

The classes are represented on the legend, and missing data represented by grey. This tells us

We can explore the missing data further using `vis_miss`

``` r

vis_miss(airquality)
```

![](README-vis_miss-1.png)

You can further cluster the missingness and arrange the columns by missingness by setting `cluster = TRUE` and `sort_cols = TRUE`.

``` r

vis_miss(airquality, 
         cluster = TRUE,
         sort_cols = TRUE)
```

![](README-vis_miss-cluster-1.png)

Future work
===========

In the future I am keen to explore how to allow for each cell to be colored according to its type (e.g., strings, factors, integers, decimals, dates, missing data). It would also be really cool to get this function to "intelligently" read in data types.

`vis_datly`. `vis_dat` could include an interactive version of the plots (similar to csv-fingerprint), so that you can

Thank yous
==========

Thank you to @jennbc, whose [tweet](https://twitter.com/JennyBryan/status/679011378414268416) got me thinking about this, and for her code contributions.

Thanks also to Noam Ross for his suggestions on using plotly with visdat.

Known Issues.
=============

**Individual cells do not have an individual class** Due to the fact that R coerces a vector to be the same type, this means that you cannot have something like c("a", 1L, 10.555) together as a vector, as it will just convert this to `[1] "a"      "1"      "10.555"`. This means that you don't get the ideal feature of picking up on nuances such as individuals cells that are different classes in the dataframe. Perhaps there is a way to read in a csv as a list so that these features are preserved?

**Missing Data not listed in legend**

When running the example below, the gray bars indicate missing values, but these are currently not specified as missing values.
