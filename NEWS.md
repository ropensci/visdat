# visdat 0.0.4.9500 (2016/05/31)
=========================

## NEW FEATURE (under development)

- `vis_dat` gains a "palette" argument in line with [issue 26](https://github.com/njtierney/visdat/issues/26), drawn from http://colorbrewer2.org/, there are currently three arguments, "default", "qual", and "cb_safe". "default" provides the ggplot defaults, "qual" uses some colour blind **unfriendly** colours, and "cb_safe" provides some colours friendly for colour blindness.


# visdat 0.0.4.9400 (2016/05/30)
=========================

## MINOR IMPROVEMENTS

- `vis_miss` legend labels are created using the internal function `miss_guide_label`. `miss_guide_label` will check if data is 100% missing or 100% present and display this in the figure. Additionally, if there is less than 0.1% missing data, "<0.1% missingness" will also be displayed. This sort of gets around issue #18 for the moment.

- tests have been added for the `miss_guide_label` legend labels function.

- Changed legend label for `vis_miss`, `vis_dat`, and `vis_guess`. 

- updated README

- Added vignette folder (but not vignettes added yet)

# visdat 0.0.4.9100 (2016/05/12)
=========================

## NEW FEATURE

- `vis_miss` now gains a `show_perc` argument, which displays the % of missing and complete data. This is switched on by default and addresses issue #19.

## MINOR IMPROVEMENTS

- Added appveyor-CI and travis-CI, addressing issues #22 and #23


# visdat 0.0.4.9000 (2016/04/20)
=========================

## BUG FIXES

- Update `vis_dat()` to use `purrr::dmap(fingerprint)` instead of `mutate_each_()`. This solves issue #3 where `vis_dat` couldn't take variables with spaces in their name.

# visdat 0.0.3.9000
=========================

## NEW FEATURES

- Interactivity with `plotly::ggplotly`! Funcions `vis_guess()`, `vis_dat()`, and `vis_miss` were updated so that you can make them all interactive using the latest dev version of `plotly` from Carson Sievert.


# visdat 0.0.2.9000
=========================

## NEW FEATURES

- Introducing `vis_guess()`, a function that uses the unexported function `collectorGuess` from `readr`.


# visdat 0.0.1.9000
=========================

## NEW FEATURES

- `vis_miss()` and `vis_dat` actually run

