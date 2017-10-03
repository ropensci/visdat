# visdat 0.2.2 (2017/10/03)

- Added `vis_cor` to visualise correlations in a dataframe

# visdat 0.2.1 (2017/08/18)

- Updated the `paper.md` for JOSS
- Updated some old links in doco

# visdat 0.2.0.9000 (2017/08/01)

- visdat is now under the rOpenSci github repository
- Added Sean Hughes and Mara Averick to the DESCRIPTION with `ctb`.

## New features

- `vis_compare()` for comparing two dataframes of the same dimensions
- `vis_guess()` for displaying the likely type for each cell in a dataframe

Interactive, `plotly` versions for each of the `vis_*` family

- `vis_dat_ly()`
- `vis_miss_ly()`
- `vis_guess_ly()`
- `vis_compare_ly()`

## Minor Changes

- Minor changes to the paper for JOSS

# visdat 0.1.0 (2017/07/03)

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
- `vis_dat` gains a "palette" argument in line with [issue 26](https://github.com/njtierney/visdat/issues/26), drawn from http://colorbrewer2.org/, there are currently three arguments, "default", "qual", and "cb_safe". "default" provides the ggplot defaults, "qual" uses some colour blind **unfriendly** colours, and "cb_safe" provides some colours friendly for colour blindness.

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
