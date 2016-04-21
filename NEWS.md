# visdat 0.1.1.9000

- update `vis_dat()` to use `purrr::dmap(fingerprint)` instead of `mutate_each_()`. This solves the problem where `vis_dat` couldn't take variables with spaces in their name.

# visdat 0.1.0.9000

- update `vis_guess()`, `vis_dat()`, and `vis_miss`, with a few small changes so that you can make them all interactive using the latest dev version of `plotly` from Carson Sievert.

# visdat 0.0.2.9000

- `vis_guess()` now works, by using unexported functions from `readr`

# visdat 0.0.1.9000

- `vis_miss()` and `vis_dat` work.


