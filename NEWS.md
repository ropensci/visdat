
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

