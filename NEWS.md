# visdat 0.6.0 (2023/02/01) "Superman, Lazlo Bane"

## New Feature

* `vis_value()` for visualising all values in a dataset. It rescales values to be between 0 and 1. See #100
* `vis_binary()` for visualising datasets with binary values - similar to `vis_value()`, but just for binary data (0, 1, NA). See #125. Thank you to Trish Gilholm for her suggested use case for this.
* Implemented facetting in `vis_dat()` and `vis_cor()`, and `vis_miss()` see (#78). The next release will implement facetting for `vis_value()`, `vis_binary()`, `vis_compare()`, `vis_expect()`, and `vis_guess()`.
* Implemented data methods for plots with `data_vis_dat()`, `data_vis_cor()`, and `data_vis_miss()` see (#78).
* `vis_dat()` `vis_miss()` and `vis_guess()` now render missing values in list-columns (@cregouby #138)
* Added `abbreviate_vars()` function to assist with abbreviating data names (#140)
* Percentage missing in columns for `vis_miss()` is now rounding to integers - for more accurate representation of missingness summaries please use the `naniar` R package.
* A new vignette on customising colour palettes in visdat, "Customising colour palettes in visdat".

## Bug Fix

* no longer use old version of `gather_` (#141)
* resolve bug where `vis_value()` displayed constant values as NA values (#128) - these constant values are now shown as 1.
* removed use of the now deprecated "aes_string" from ggplot2
* output of plot in `vis_expect` would reorder columns ([#133](https://github.com/ropensci/visdat/issues/133)), fixed in [#143](https://github.com/ropensci/visdat/pull/134) by [@muschellij2](https://github.com/muschellij2).

## Misc

* No longer uses gdtools for testing (#145)
* Use `cli` internally for error messages.
* Speed up some internal functions in visdat

# visdat 0.5.3 (2019/02/04) "The Legend of LoFi"

## Minor Change

* Update `vis_cor()` to use perceptually uniform colours from `scico` package, using `scico::scico(3, palette = "vik")`.
* Update `vis_cor()` to have fixed legend values from -1 to +1 (#110) using options `breaks` and `limits`. Special thanks to [this SO thread for the answer](https://stackoverflow.com/questions/24265652/label-minimum-and-maximum-of-scale-fill-gradient-legend-with-text-ggplot2)
* Uses `glue` and `glue_collapse()` instead of `paste` and `paste0`
* adds WORDLIST for spelling thanks to `usethis::use_spell_check()`

# visdat 0.5.2 (2018/12/06) "Youth, The Midnight, Kids"

## Minor Change

* Internal error message has been improved by [Nic](https://github.com/thisisnic) in [#102](https://github.com/ropensci/visdat/pull/102)

## Bug Fix

* [Jim Hester](https://github.com/jimhester) fixed recent changes in readr 1.2.0 in PR [#103](https://github.com/ropensci/visdat/pull/103), which changes the default behavior of the `guess_parser`, to not
guess integer types by default. To opt-into the current behavior you
need to pass `guess_integer = TRUE.`

# visdat 0.5.1 (2018/07/02) "The Northern Lights Moonwalker"

## New Feature

* `vis_compare()` for comparing two dataframes of the same dimensions
* `vis_expect()` for visualising where certain values of expectations occur in the data
    * Added NA colours to `vis_expect`
    * Added `show_perc` arg to `vis_expect` to show the percentage of expectations that are TRUE. #73
* `vis_cor` to visualise correlations in a dataframe
* `vis_guess()` for displaying the likely type for each cell in a dataframe
* Added draft `vis_expect` to make it easy to look at certain appearances of numbers in your data.
* visdat is now under the rOpenSci github repository

## Minor Changes

* added CITATION for visdat to cite the JOSS article
* updated options for `vis_cor` to use argument `na_action` not `use_op`.
* cleaned up the organisation of the files and internal functions
* Added appropriate legend and x axis for `vis_miss_ly` - thanks to Stuart Lee
* Updated the `paper.md` for JOSS
* Updated some old links in doco
* Added Sean Hughes and Mara Averick to the DESCRIPTION with `ctb`.
* Minor changes to the paper for JOSS

## Bug Fixes

* Fix bug reported in [#75](https://github.com/ropensci/visdat/issues/75) 
  where `vis_dat(diamonds)` errored `seq_len(nrow(x))` inside internal 
  function `vis_gather_`, used to calculate the row numbers. Using 
  `mutate(rows = dplyr::row_number())` solved the issue.

* Fix bug reported in [#72](https://github.com/ropensci/visdat/issues/72)
  where `vis_miss` errored when one column was given to it. This was an issue
  with using `limits` inside `scale_x_discrete` - which is used to order the
  columns of the data. It is not necessary to order one column of data, so I
  created an if-else to avoid this step and return the plot early.

* Fix visdat x axis alignment when show_perc_col = FALSE - [#82](https://github.com/ropensci/visdat/issues/82)

* fix visdat x axis alignment - [issue 57](https://github.com/ropensci/visdat/issues/57)
* fix bug where the column percentage missing would print to be NA when it was exactly equal to 0.1% missing. - [issue 62](https://github.com/ropensci/visdat/issues/62)
* `vis_cor` didn't gather variables for plotting appropriately - now fixed

# visdat 0.1.0 (2017/07/03) ("JOSS")

- lightweight CRAN submission - will only contain functions `vis_dat` and `vis_miss`

# visdat 0.0.7.9100 (2017/07/03)

## New Features

- `add_vis_dat_pal()` (internal) to add a palette for `vis_dat` and `vis_guess`
- `vis_guess` now gets a palette argument like `vis_dat`
- Added protoype/placeholder functions for `plotly` vis_*_ly interactive graphs:
  - `vis_guess_ly()`
  - `vis_dat_ly()`
  - `vis_compare_ly()`
  These simply wrap `plotly::ggplotly(vis_*(data))`. In the future they will
  be written in `plotly` so that they can be generated much faster

## Minor improvements

- corrected testing for `vis_*` family
- added .svg graphics for correct vdiffr testing
- improved hover print method for plotly.

# visdat 0.0.6.9000 (2017/02/26)

## New Features

- axes in `vis_` family are now flipped by default
- `vis_miss` now shows the % missingness in a column, can be disabled by setting `show_perc_col` argument to FALSE
- removed `flip` argument, as this should be the default 

## Minor Improvements

- added internal functions to improve extensibility and debugging - `vis_create_`, `vis_gather_` and `vis_extract_value_`.
- suppress unneeded warnings arising from compiling factors

# visdat 0.0.5.9000 (2017/01/09)

## Minor Improvements

- Added testing for visualisations with `vdiffr`. Code coverage is now at 99%
- Fixed up suggestions from `goodpractice::gp()`
- Submitted to rOpenSci onboarding
- `paper.md` written and submitted to JOSS

# visdat 0.0.4.9999 (2017/01/08)

## New Feature

- Added feature `flip = TRUE`, to `vis_dat` and `vis_miss`. This flips the x axis and the ordering of the rows. This more closely resembles a dataframe.
- `vis_miss_ly` is a new function that uses plotly to plot missing data, like `vis_miss`, but interactive, without the need to call `plotly::ggplotly` on it. It's fast, but at the moment it needs a bit of love on the legend front to maintain the style and features (clustering, etc) of current `vis_miss`.
- `vis_miss` now gains a `show_perc` argument, which displays the % of missing and complete data. This is switched on by default and addresses issue #19.

## New Feature (under development)

- `vis_compare` is a new function that allows you to compare two dataframes of the same dimension. It gives a fairly ugly warning if they are not of the same dimension.
- `vis_dat` gains a "palette" argument in line with [issue 26](https://github.com/ropensci/visdat/issues/26), drawn from http://colorbrewer2.org/, there are currently three arguments, "default", "qual", and "cb_safe". "default" provides the ggplot defaults, "qual" uses some colour blind **unfriendly** colours, and "cb_safe" provides some colours friendly for colour blindness.

## Minor Improvements

- All lines are < 80 characters long
- removed all instances of `1:rnow(x)` and replaced with `seq_along(nrow(x))`.
- Updated documentation, improved legend and colours for `vis_miss_ly`.
- removed export for `vis_dat_ly`, as it currently does not work.
- Removed a lot of unnecessary @importFrom tags, included magrittr in this, and added magrittr to Imports
- Changes ALL CAPS Headers in news to Title Case
- Made it clear that `vis_guess()` and `vis_compare` are very beta
- updated documentation in README and `vis_dat()`, `vis_miss()`, `vis_compare()`, and `vis_guess()`
- updated pkgdown docs
- updated DESCRIPTION URL and bug report
- Changed the default colours of `vis_compare` to be different to the ggplot2 standards.
- `vis_miss` legend labels are created using the internal function `miss_guide_label`. `miss_guide_label` will check if data is 100% missing or 100% present and display this in the figure. Additionally, if there is less than 0.1% missing data, "<0.1% missingness" will also be displayed. This sort of gets around issue #18 for the moment.
- tests have been added for the `miss_guide_label` legend labels function.
- Changed legend label for `vis_miss`, `vis_dat`, and `vis_guess`. 
- updated README
- Added vignette folder (but not vignettes added yet)
- Added appveyor-CI and travis-CI, addressing issues #22 and #23


## Bug Fixes

- Update `vis_dat()` to use `purrr::dmap(fingerprint)` instead of `mutate_each_()`. This solves issue #3 where `vis_dat` couldn't take variables with spaces in their name.

# visdat 0.0.3.9000
=========================

## New Features

- Interactivity with `plotly::ggplotly`! Funcions `vis_guess()`, `vis_dat()`, and `vis_miss` were updated so that you can make them all interactive using the latest dev version of `plotly` from Carson Sievert.


# visdat 0.0.2.9000
=========================

## New Features

- Introducing `vis_guess()`, a function that uses the unexported function `collectorGuess` from `readr`.


# visdat 0.0.1.9000
=========================

## New Features

- `vis_miss()` and `vis_dat` actually run
