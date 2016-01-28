<!-- README.md is generated from README.Rmd. Please edit that file -->
visdat
======

This package is the second iteration of my attempt at cloning the super cool and way sexier "csv-fingerprint" from flowing data - see [here](https://github.com/setosa/csv-fingerprint) and [here](https://flowingdata.com/2014/08/14/csv-fingerprint-spot-errors-in-your-data-at-a-glance/). Initially I had named the package "footprintr", to keep in spirit with the name "csv-fingerprint". However, after a little more thought and usage, I felt that "footprintr" didn't actually describe what was going on with the pacakge, and what it does, and so "visdat" was born.

What does it do?
================

visdat is a small r package that visualises a dataframe, displaying missing data and variable classes with different colours. Future work will allow for each cell to be colored according to its type (e.g., strings, factors, integers, decimals, dates, missing data). It would also be really cool to get this function to "intelligently" read in data types.

Part of the name suggests that it could be integrated with testdat and testthat. The idea being that first you visualise your data, then you run tests to fix them.

How to install
==============

``` r
# install.packages("devtools")

library(devtools)

install_github("tierneyn/footprintr")
```

Example
=======

Let's explore the missing data

``` r
library(visdat)

vis_miss(airquality)
```

![](README-vis_miss-1.png)<!-- -->

Let's see what's inside airquality

``` r
vis_dat(airquality)
```

![](README-vis_dat-1.png)<!-- -->

Known Issues.
=============

**Individual cells do not have an individual class** Due to the fact that R coerces a vector to be the same type, this means that you cannot have something like c("a", 1L, 10.555) together as a vector, as it will just convert this to `[1] "a"      "1"      "10.555"`. This means that you don't get the ideal feature of picking up on nuances such as individuals cells that are different classes in the dataframe. Perhaps there is a way to read in a csv as a list so that these features are preserved?

**Missing Data not listed in legend**

When running the example below, the gray bars indicate missing values, but these are currently not specified as missing values.
